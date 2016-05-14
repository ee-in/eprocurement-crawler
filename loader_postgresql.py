#!/usr/bin/python
#  -*- coding: utf-8 -*-
""" Loader for Taiwan government e-procurement website"""

import os
import logging
import psycopg2
import extractor_awarded as eta
import extractor_declaration as etd
from datetime import datetime, date
from optparse import OptionParser

__author__ = "Yu-chun Huang"
__version__ = "1.0.0b"

logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)


def gen_insert_sql(table, data_dict):
    sql_template = u'INSERT INTO {} ({}) VALUES ({}) ON CONFLICT ON CONSTRAINT {} DO UPDATE SET {}'
    columns = ''
    values = ''
    dup_update = ''

    for k, v in data_dict.items():
        if v is not None:
            if values != '':
                columns += ','
                values += ','
                dup_update += ','

            columns += k

            if isinstance(v, str):
                vstr = '$STRTAG$' + str(v) + '$STRTAG$'
            elif isinstance(v, bool):
                vstr = '1' if v else '0'
            elif isinstance(v, datetime) or isinstance(v, date):
                vstr = '\'' + str(v) + '\''
            else:
                vstr = str(v)

            values += vstr
            dup_update += k + '=' + vstr

    sql_str = sql_template.format(table, columns, values, table + '_pkey', dup_update)
    logger.debug(sql_str)
    return sql_str


def load_declaration(cnx, file_name):
    primary_key, root_element = etd.init(file_name)
    if root_element is None or primary_key is None or primary_key == '':
        logger.error('Fail to extract data from file: ' + file_name)
        return

    logger.info('Updating database (primaryKey: {})'.format(primary_key))

    try:
        cur = cnx.cursor()

        data = etd.get_organization_info_dic(root_element)
        data.update(etd.get_procurement_info_dic(root_element))
        data.update(etd.get_declaration_info_dic(root_element))
        data.update(etd.get_attend_info_dic(root_element))
        data.update(etd.get_other_info_dic(root_element))
        data['primary_key'] = primary_key

        cur.execute(gen_insert_sql('tender_declaration_info', data))
        cnx.commit()
    except psycopg2.Error as e:
        outstr = 'Fail to update database (primary_key: {})\n\t{}'.format(primary_key, e)
        logger.warn(outstr)
        with open('load.err', 'a', encoding='utf-8') as err_file:
            err_file.write(outstr)
    except AttributeError as e:
        outstr = 'Corrupted content. Update skipped (primary_key: {})\n\t{}'.format(primary_key, e)
        logger.warn(outstr)
        with open('load.err', 'a', encoding='utf-8') as err_file:
            err_file.write(outstr)


def load_awarded(cnx, file_name):
    pk_atm_main, tender_case_no, root_element = eta.init(file_name)
    if root_element is None \
            or pk_atm_main is None or tender_case_no is None \
            or pk_atm_main == '' or tender_case_no == '':
        logger.error('Fail to extract data from file: ' + file_name)
        return

    pk = {'pk_atm_main': pk_atm_main, 'tender_case_no': tender_case_no}
    logger.info('Updating database (pkAtmMain: {}, tenderCaseNo: {})'.format(pk_atm_main, tender_case_no))

    try:
        cur = cnx.cursor()

        data = eta.get_organization_info_dic(root_element)
        data.update(pk)
        cur.execute(gen_insert_sql('organization_info', data))

        data = eta.get_procurement_info_dic(root_element)
        data.update(pk)
        cur.execute(gen_insert_sql('procurement_info', data))

        data = eta.get_tender_info_dic(root_element)
        for tender in data.values():
            tender.update(pk)
            cur.execute(gen_insert_sql('tender_info', tender))

        data = eta.get_tender_award_item_dic(root_element)
        for item in data.values():
            for tender in item.values():
                tender.update(pk)
                cur.execute(gen_insert_sql('tender_award_item', tender))

        data = eta.get_evaluation_committee_info_list(root_element)
        for committee in data:
            committee.update(pk)
            cur.execute(gen_insert_sql('evaluation_committee_info', committee))

        data = eta.get_award_info_dic(root_element)
        data.update(pk)

        cur.execute(gen_insert_sql('award_info', data))
        cnx.commit()
    except psycopg2.Error as e:
        logger.error(e)
        outstr = 'Fail to update database (pkAtmMain: {}, tenderCaseNo: {})\n\t{}'.format(pk_atm_main,
                                                                                          tender_case_no,
                                                                                          e)
        logger.warn(outstr)
        with open('load.err', 'a', encoding='utf-8') as err_file:
            err_file.write(outstr)
    except AttributeError as e:
        outstr = 'Corrupted content. Update skipped (pkAtmMain: {}, tenderCaseNo: {})\n\t{}'.format(pk_atm_main,
                                                                                                    tender_case_no,
                                                                                                    e)
        logger.warn(outstr)
        with open('load.err', 'a', encoding='utf-8') as err_file:
            err_file.write(outstr)


def parse_args():
    p = OptionParser()
    p.add_option('-f', '--filename', action='store',
                 dest='filename', type='string', default='')
    p.add_option('-d', '--directory', action='store',
                 dest='directory', type='string', default='')
    p.add_option('-u', '--user', action='store',
                 dest='user', type='string', default='')
    p.add_option('-p', '--password', action='store',
                 dest='password', type='string', default='')
    p.add_option('-i', '--host', action='store',
                 dest='host', type='string', default='')
    p.add_option('-b', '--database', action='store',
                 dest='database', type='string', default='')
    p.add_option('-o', '--port', action='store',
                 dest='port', type='string', default='5432')
    p.add_option("-a", '--declaration', action="store_true",
                 dest='is_declaration')

    return p.parse_args()


if __name__ == '__main__':
    options, remainder = parse_args()

    user = options.user.strip()
    password = options.password.strip()
    host = options.host.strip()
    port = options.port.strip()
    database = options.database.strip()
    is_declaration = options.is_declaration
    if user == '' or password == '' or host == '' or port == '' or database == '':
        logger.error('Database connection information is incomplete.')
        quit()

    try:
        db_connection = psycopg2.connect(database=database, user=user, password=password, host=host, port=port)
        db_connection.autocommit = False

        f = options.filename.strip()
        if f != '':
            if not os.path.isfile(f):
                logger.error('File not found: ' + f)
            else:
                if is_declaration:
                    load_declaration(db_connection, f)
                else:
                    load_awarded(db_connection, f)

        d = options.directory.strip()
        if d != '':
            if not os.path.isdir(d):
                logger.error('Directory not found: ' + d)
            else:
                for root, dirs, files in os.walk(d):
                    for f in files:
                        if is_declaration:
                            load_declaration(db_connection, os.path.join(root, f))
                        else:
                            load_awarded(db_connection, os.path.join(root, f))
    except psycopg2.Error as err:
        logger.error(err)
    else:
        db_connection.close()
