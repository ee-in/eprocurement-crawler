#!/usr/bin/python
#  -*- coding: utf-8 -*-
""" Downloader for Taiwan government e-procurement website
Modified from the source code provided by https://github.com/ywchiu/pythonetl"""

import os
import sys
import requests
import logging
import time
import re
from optparse import OptionParser
from bs4 import BeautifulSoup
from joblib import Parallel, delayed

__author__ = "Yu-chun Huang"
__version__ = "1.0.0b"

_ERRCODE_FILENAME = 3
_ERRCODE_DIR = 4

logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)


def parse_args():
    p = OptionParser()
    p.add_option('-f', '--list_filename', action='store',
                 dest='list_filename', type='string', default='')
    p.add_option('-d', '--directory', action='store',
                 dest='directory', type='string', default='bid_detail')
    p.add_option('-x', '--proxy', action='store',
                 dest='proxy', type='string', default='')
    p.add_option('-p', '--parallel', action='store',
                 dest='parallel', type='int', default=1)
    p.add_option('-s', '--sleep', action='store',
                 dest='sleep', type='int', default=1)
    return p.parse_args()


def do_download(list_filename, directory, page_link, proxies=None, sleep=0):
    m1 = re.match(r'([^ ]+)pkAtmMain=(?P<pkAtmMain>\w+)&tenderCaseNo=(?P<tenderCaseNo>[\w\-]+)', page_link)
    if m1 is None:
        m2 = re.match(r'([^ ]+)primaryKey=(?P<primaryKey>[\w\-]+)', page_link)
        if m2 is None:
            return
        else:
            primaryKey = m2.group('primaryKey')
            if primaryKey is None:
                return
            else:
                filename = primaryKey
    else:
        pkAtmMain = m1.group('pkAtmMain')
        tenderCaseNo = m1.group('tenderCaseNo')
        if pkAtmMain is None or tenderCaseNo is None:
            return
        else:
            filename = "%s_%s" % (pkAtmMain, tenderCaseNo)

    file_path = '{}/{}.txt'.format(directory, filename)
    if os.path.isfile(file_path) and os.path.getsize(file_path) > 0:
        logger.info('File already exists. Download skipped ({})'.format(file_path))
        return

    try:
        if proxies is None:
            request_get = requests.get(page_link)
        else:
            request_get = requests.get(page_link, proxies=proxies)
        response = request_get.text

        soup = BeautifulSoup(''.join(response), 'lxml')
        if m1 is not None:
            print_area = soup.find('div', {"id": "printArea"})
        else:
            print_area = soup.find('div', {"id": "print_area"})

        prettified = print_area.prettify()
        with open(file_path, 'w', encoding='utf-8') as bid_detail:
            bid_detail.write(prettified)
            if m1 is not None:
                bid_detail.write('<div class="pkAtmMain">' + pkAtmMain + '</div>\n')
                bid_detail.write('<div class="tenderCaseNo">' + tenderCaseNo + '</div>')
                logger.info(
                    'Writing bid detail (pkAtmMain: {}, tenderCaseNo: {})'.format(pkAtmMain, tenderCaseNo))
            else:
                bid_detail.write('<div class="primaryKey">' + primaryKey + '</div>\n')
                logger.info(
                    'Writing bid detail (primaryKey: {})'.format(primaryKey))
    except:
        e = sys.exc_info()[0]
        logger.warn("Warning: %s", e)
        with open(list_filename + '.download.err', 'a', encoding='utf-8') as err_file:
            err_file.write(page_link + '\n')

    time.sleep(sleep)  # Prevent from being treated as a DDOS attack


if __name__ == '__main__':
    options, remainder = parse_args()

    bid_list = options.list_filename.strip()
    if not bid_list:
        logger.error('Invalid bid list filename.')
        quit(_ERRCODE_FILENAME)

    dir = options.directory.strip()
    if dir:
        try:
            os.makedirs(dir)
        except OSError:
            if not os.path.isdir(dir):
                logger.error('Fail to create directory.')
                quit(_ERRCODE_DIR)

    proxy = None if not options.proxy.strip() else {'http': options.proxy.strip()}
    parallel = options.parallel
    sleep = options.sleep

    with open(bid_list, 'r', encoding='utf-8') as f:
        Parallel(n_jobs=parallel)(
            delayed(do_download)(bid_list, dir, line.strip(), proxies=proxy, sleep=sleep) for line in f.readlines())
