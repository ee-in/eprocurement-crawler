CREATE DATABASE TW_PROCUREMENT ENCODING 'UTF8';

CREATE TABLE organization_info (
  pk_atm_main varchar(45) NOT NULL,
  tender_case_no varchar(45) NOT NULL,
  org_id varchar(45) DEFAULT NULL,
  org_name varchar(45) DEFAULT NULL,
  unit_name varchar(50) DEFAULT NULL,
  org_address varchar(100) DEFAULT NULL,
  contact varchar(45) DEFAULT NULL,
  tel varchar(45) DEFAULT NULL,
  fax varchar(45) DEFAULT NULL,
  PRIMARY KEY (pk_atm_main,tender_case_no)
);

COMMENT ON COLUMN organization_info.pk_atm_main IS '採購網主鍵';
COMMENT ON COLUMN organization_info.tender_case_no IS '標案案號';
COMMENT ON COLUMN organization_info.org_id IS '機關代碼';
COMMENT ON COLUMN organization_info.org_name IS '機關名稱';
COMMENT ON COLUMN organization_info.unit_name IS '單位名稱';
COMMENT ON COLUMN organization_info.org_address IS '機關地址';
COMMENT ON COLUMN organization_info.contact IS '聯絡人';
COMMENT ON COLUMN organization_info.tel IS '聯絡電話';
COMMENT ON COLUMN organization_info.fax IS '傳真號碼';

CREATE TABLE procurement_info (
  pk_atm_main varchar(45) NOT NULL,
  tender_case_no varchar(45) NOT NULL,
  procurement_type varchar(100) DEFAULT NULL,
  awarding_type varchar(45) DEFAULT NULL,
  is_follow_law_64_2 char(1) DEFAULT NULL,
  num_transmit varchar(45) DEFAULT NULL,
  revision_sn varchar(10) DEFAULT NULL,
  is_follow_law_106_1_1 char(1) DEFAULT NULL,
  subject_of_procurement varchar(100) DEFAULT NULL,
  attr_of_awarding varchar(45) DEFAULT NULL,
  is_inter_ent_sup_contract char(1) DEFAULT NULL,
  is_joint_procurement char(1) DEFAULT NULL,
  is_multiple_award char(1) DEFAULT NULL,
  is_joint_tender char(1) DEFAULT NULL,
  attr_of_procurement varchar(100) DEFAULT NULL,
  is_design_build_contract char(1) DEFAULT NULL,
  is_engineer_cert_required char(1) DEFAULT NULL,
  opening_date timestamp DEFAULT NULL,
  original_publication_date date DEFAULT NULL,
  procurement_money_amt_lv varchar(45) DEFAULT NULL,
  conduct_procurement varchar(100) DEFAULT NULL,
  is_gpa varchar(45) DEFAULT NULL,
  is_anztec varchar(45) DEFAULT NULL,
  is_astep varchar(45) DEFAULT NULL,
  restricted_tendering_law varchar(300) DEFAULT NULL,
  is_budget_amount_public char(1) DEFAULT NULL,
  budget_amount decimal(10,0) DEFAULT NULL,
  is_org_subsidy char(1) DEFAULT NULL,
  fulfill_location varchar(200) DEFAULT NULL,
  fulfill_location_district varchar(300) DEFAULT NULL,
  is_special_budget char(1) DEFAULT NULL,
  project_type varchar(45) DEFAULT NULL,
  is_authorities_template char(1) DEFAULT NULL,
  PRIMARY KEY (pk_atm_main,tender_case_no)
);

COMMENT ON COLUMN procurement_info.pk_atm_main IS '採購網主鍵';
COMMENT ON COLUMN procurement_info.tender_case_no IS '標案案號';
COMMENT ON COLUMN procurement_info.procurement_type IS '招標方式';
COMMENT ON COLUMN procurement_info.awarding_type IS '決標方式';
COMMENT ON COLUMN procurement_info.is_follow_law_64_2 IS '是否依政府採購法施行細則第64條之2辦理';
COMMENT ON COLUMN procurement_info.num_transmit IS '新增公告傳輸次數';
COMMENT ON COLUMN procurement_info.revision_sn IS '公告更正序號';
COMMENT ON COLUMN procurement_info.is_follow_law_106_1_1 IS '是否依據採購法第106條第1項第1款辦理';
COMMENT ON COLUMN procurement_info.subject_of_procurement IS '標案名稱';
COMMENT ON COLUMN procurement_info.attr_of_awarding IS '決標資料類別';
COMMENT ON COLUMN procurement_info.is_inter_ent_sup_contract IS '是否屬共同供應契約採購';
COMMENT ON COLUMN procurement_info.is_joint_procurement IS '是否屬二以上機關之聯合採購(不適用共同供應契約規定)';
COMMENT ON COLUMN procurement_info.is_multiple_award IS '是否複數決標';
COMMENT ON COLUMN procurement_info.is_joint_tender IS '是否共同投標';
COMMENT ON COLUMN procurement_info.attr_of_procurement IS '標的分類';
COMMENT ON COLUMN procurement_info.is_design_build_contract IS '是否屬統包';
COMMENT ON COLUMN procurement_info.is_engineer_cert_required IS '是否應依公共工程專業技師簽證規則實施技師簽證';
COMMENT ON COLUMN procurement_info.opening_date IS '開標時間';
COMMENT ON COLUMN procurement_info.original_publication_date IS '原公告日期';
COMMENT ON COLUMN procurement_info.procurement_money_amt_lv IS '採購金額級距';
COMMENT ON COLUMN procurement_info.conduct_procurement IS '辦理方式';
COMMENT ON COLUMN procurement_info.is_gpa IS '是否適用WTO政府採購協定(GPA)：';
COMMENT ON COLUMN procurement_info.is_anztec IS '是否適用臺紐經濟合作協定(ANZTEC)：';
COMMENT ON COLUMN procurement_info.is_astep IS '是否適用臺星經濟夥伴協定(ASTEP)：';
COMMENT ON COLUMN procurement_info.restricted_tendering_law IS '限制性招標依據之法條';
COMMENT ON COLUMN procurement_info.is_budget_amount_public IS '預算金額是否公開';
COMMENT ON COLUMN procurement_info.budget_amount IS '預算金額';
COMMENT ON COLUMN procurement_info.is_org_subsidy IS '是否受機關補助';
COMMENT ON COLUMN procurement_info.fulfill_location IS '履約地點';
COMMENT ON COLUMN procurement_info.fulfill_location_district IS '履約地點（含地區）';
COMMENT ON COLUMN procurement_info.is_special_budget IS '是否含特別預算';
COMMENT ON COLUMN procurement_info.project_type IS '歸屬計畫類別';
COMMENT ON COLUMN procurement_info.is_authorities_template IS '本案採購契約是否採用主管機關訂定之範本';

CREATE TABLE tender_info (
  pk_atm_main varchar(45) NOT NULL,
  tender_case_no varchar(45) NOT NULL,
  tender_sn int NOT NULL,
  tenderer_id varchar(45) DEFAULT NULL,
  tenderer_name varchar(200) DEFAULT NULL,
  tenderer_name_eng varchar(200) DEFAULT NULL,
  is_awarded char(1) DEFAULT NULL,
  organization_type varchar(45) DEFAULT NULL,
  industry_type varchar(45) DEFAULT NULL,
  address varchar(1000) DEFAULT NULL,
  address_eng varchar(1000) DEFAULT NULL,
  tel varchar(45) DEFAULT NULL,
  award_price decimal(10,0) DEFAULT NULL,
  country varchar(45) DEFAULT NULL,
  is_sm_enterprise char(1) DEFAULT NULL,
  fulfill_date_start date DEFAULT NULL,
  fulfill_date_end date DEFAULT NULL,
  is_employee_over_100 char(1) DEFAULT NULL,
  num_employee int DEFAULT NULL,
  num_aboriginal int DEFAULT NULL,
  num_disability int DEFAULT NULL,
  PRIMARY KEY (pk_atm_main,tender_case_no,tender_sn)
);

COMMENT ON COLUMN tender_info.pk_atm_main IS '採購網主鍵';
COMMENT ON COLUMN tender_info.tender_case_no IS '標案案號';
COMMENT ON COLUMN tender_info.tender_sn IS '廠商流水號';
COMMENT ON COLUMN tender_info.tenderer_id IS '廠商代碼';
COMMENT ON COLUMN tender_info.tenderer_name IS '廠商名稱';
COMMENT ON COLUMN tender_info.tenderer_name_eng IS '廠商名稱(英)';
COMMENT ON COLUMN tender_info.is_awarded IS '是否得標';
COMMENT ON COLUMN tender_info.organization_type IS '組織型態';
COMMENT ON COLUMN tender_info.industry_type IS '廠商業別';
COMMENT ON COLUMN tender_info.address IS '廠商地址';
COMMENT ON COLUMN tender_info.address_eng IS '廠商地址(英)';
COMMENT ON COLUMN tender_info.tel IS '廠商電話';
COMMENT ON COLUMN tender_info.award_price IS '決標金額';
COMMENT ON COLUMN tender_info.country IS '得標廠商國別';
COMMENT ON COLUMN tender_info.is_sm_enterprise IS '是否為中小企業';
COMMENT ON COLUMN tender_info.fulfill_date_start IS '履約起日';
COMMENT ON COLUMN tender_info.fulfill_date_end IS '履約迄日';
COMMENT ON COLUMN tender_info.is_employee_over_100 IS '雇用員工總人數是否超過100人';
COMMENT ON COLUMN tender_info.num_employee IS '僱用員工總人數';
COMMENT ON COLUMN tender_info.num_aboriginal IS '已僱用原住民人數';
COMMENT ON COLUMN tender_info.num_disability IS '已僱用身心障礙者人數';

CREATE TABLE tender_award_item (
  pk_atm_main varchar(45) NOT NULL,
  tender_case_no varchar(45) NOT NULL,
  item_sn int NOT NULL,
  tender_sn int NOT NULL,
  item_name varchar(1000) DEFAULT NULL,
  unit varchar(20) DEFAULT NULL,
  is_unit_price_x_qty_lowest char(1) DEFAULT NULL,
  awarded_tenderer varchar(100) DEFAULT NULL,
  request_number int DEFAULT NULL,
  award_price decimal(10,0) DEFAULT NULL,
  base_price decimal(10,0) DEFAULT NULL,
  source_country varchar(100) DEFAULT NULL,
  source_award_price decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (pk_atm_main,tender_case_no,item_sn,tender_sn)
);

COMMENT ON COLUMN tender_award_item.pk_atm_main IS '採購網主鍵';
COMMENT ON COLUMN tender_award_item.tender_case_no IS '標案案號';
COMMENT ON COLUMN tender_award_item.item_sn IS '品項流水號';
COMMENT ON COLUMN tender_award_item.tender_sn IS '廠商流水號';
COMMENT ON COLUMN tender_award_item.item_name IS '品項名稱';
COMMENT ON COLUMN tender_award_item.unit IS '單位';
COMMENT ON COLUMN tender_award_item.is_unit_price_x_qty_lowest IS '是否以單價及預估需求數量之乘積決定最低標';
COMMENT ON COLUMN tender_award_item.awarded_tenderer IS '得標廠商';
COMMENT ON COLUMN tender_award_item.request_number IS '預估需求數量';
COMMENT ON COLUMN tender_award_item.award_price IS '決標金額';
COMMENT ON COLUMN tender_award_item.base_price IS '底價金額';
COMMENT ON COLUMN tender_award_item.source_country IS '原產地國別';
COMMENT ON COLUMN tender_award_item.source_award_price IS '原產地國別得標金額';

CREATE TABLE evaluation_committee_info (
  pk_atm_main varchar(45) NOT NULL,
  tender_case_no varchar(45) NOT NULL,
  sn int NOT NULL,
  is_attend char(1) DEFAULT NULL,
  name varchar(45) DEFAULT NULL,
  occupation varchar(1000) DEFAULT NULL,
  PRIMARY KEY (pk_atm_main,tender_case_no,sn)
);

COMMENT ON COLUMN evaluation_committee_info.pk_atm_main IS '採購網主鍵';
COMMENT ON COLUMN evaluation_committee_info.tender_case_no IS '標案案號';
COMMENT ON COLUMN evaluation_committee_info.sn IS '項次';
COMMENT ON COLUMN evaluation_committee_info.is_attend IS '出席會議';
COMMENT ON COLUMN evaluation_committee_info.name IS '姓名';
COMMENT ON COLUMN evaluation_committee_info.occupation IS '職業';

CREATE TABLE award_info (
  pk_atm_main varchar(45) NOT NULL,
  tender_case_no varchar(45) NOT NULL,
  award_announce_sn varchar(10) DEFAULT NULL,
  revision_sn varchar(10) DEFAULT NULL,
  awarding_date date DEFAULT NULL,
  ori_awarding_announce_date date DEFAULT NULL,
  awarding_announce_date date DEFAULT NULL,
  is_post_bulletin char(1) DEFAULT NULL,
  base_price decimal(10,0) DEFAULT NULL,
  is_base_price_public char(1) DEFAULT NULL,
  total_award_price decimal(10,0) DEFAULT NULL,
  is_total_award_price_public char(1) DEFAULT NULL,
  is_price_dynamic_with_cpi char(1) DEFAULT NULL,
  no_price_dynamic_description varchar(100) DEFAULT NULL,
  fulfill_execution_org_id varchar(45) DEFAULT NULL,
  fulfill_execution_org_name varchar(100) DEFAULT NULL,
  additional_info varchar(2000) DEFAULT NULL,
  PRIMARY KEY (pk_atm_main,tender_case_no)
);

COMMENT ON COLUMN award_info.pk_atm_main IS '採購網主鍵';
COMMENT ON COLUMN award_info.tender_case_no IS '標案案號';
COMMENT ON COLUMN award_info.award_announce_sn IS '決標公告序號';
COMMENT ON COLUMN award_info.revision_sn IS '公告更正序號';
COMMENT ON COLUMN award_info.awarding_date IS '決標日期';
COMMENT ON COLUMN award_info.ori_awarding_announce_date IS '原決標公告日期';
COMMENT ON COLUMN award_info.awarding_announce_date IS '決標公告日期';
COMMENT ON COLUMN award_info.is_post_bulletin IS '是否刊登公報';
COMMENT ON COLUMN award_info.base_price IS '底價金額';
COMMENT ON COLUMN award_info.is_base_price_public IS '底價金額是否公開';
COMMENT ON COLUMN award_info.total_award_price IS '總決標金額';
COMMENT ON COLUMN award_info.is_total_award_price_public IS '總決標金額是否公開';
COMMENT ON COLUMN award_info.is_price_dynamic_with_cpi IS '契約是否訂有依物價指數調整價金規定';
COMMENT ON COLUMN award_info.no_price_dynamic_description IS '未列物價調整規定說明';
COMMENT ON COLUMN award_info.fulfill_execution_org_id IS '履約執行機關代碼';
COMMENT ON COLUMN award_info.fulfill_execution_org_name IS '履約執行機關名稱';
COMMENT ON COLUMN award_info.additional_info IS '附加說明';

CREATE TABLE tender_declaration_info (
  -- 機關資料
  primary_key varchar(45) NOT NULL,
  org_id varchar(45) DEFAULT NULL,
  org_name varchar(45) DEFAULT NULL,
  unit_name varchar(50) DEFAULT NULL,
  org_address varchar(100) DEFAULT NULL,
  contact varchar(45) DEFAULT NULL,
  tel varchar(45) DEFAULT NULL,
  fax varchar(45) DEFAULT NULL,
  email varchar(100) DEFAULT NULL,
  -- 採購資料
  tender_case_no varchar(45) NOT NULL,
  subject_of_procurement varchar(100) DEFAULT NULL,
  attr_of_procurement varchar(100) DEFAULT NULL,
  project_no varchar(100) DEFAULT NULL,
  is_construction char(1) DEFAULT NULL,
  attr_of_goods varchar(45) DEFAULT NULL,
  procurement_money_amt_lv varchar(45) DEFAULT NULL,
  conduct_procurement varchar(100) DEFAULT NULL,
  apply_law varchar(100) DEFAULT NULL,
  is_gpa varchar(45) DEFAULT NULL,
  is_anztec varchar(45) DEFAULT NULL,
  is_astep varchar(45) DEFAULT NULL,
  budget_amount decimal(10,0) DEFAULT NULL,
  is_budget_amount_public char(1) DEFAULT NULL,
  is_extension char(1) DEFAULT NULL,
  is_org_subsidy char(1) DEFAULT NULL,
  is_special_budget char(1) DEFAULT NULL,
  -- 招標資料
  procurement_type varchar(100) DEFAULT NULL,
  awarding_type varchar(45) DEFAULT NULL,
  is_follow_law_64_2 char(1) DEFAULT NULL,
  is_electronic_quote char(1) DEFAULT NULL,
  num_transmit varchar(45) DEFAULT NULL,
  procurement_status varchar(45) DEFAULT NULL,
  publication_date date DEFAULT NULL,
  is_multiple_award char(1) DEFAULT NULL,
  is_base_price char(1) DEFAULT NULL,
  is_special char(1) DEFAULT NULL,
  is_public_view char(1) DEFAULT NULL,
  is_design_build_contract char(1) DEFAULT NULL,
  is_inter_ent_sup_contract char(1) DEFAULT NULL,
  is_joint_procurement char(1) DEFAULT NULL,
  is_engineer_cert_required char(1) DEFAULT NULL,
  is_negotiation char(1) DEFAULT NULL,
  is_follow_law_104_105 char(1) DEFAULT NULL,
  is_follow_law_106_1_1 char(1) DEFAULT NULL,
  -- 領投開標
  is_elec_receive_tender char(1) DEFAULT NULL,
  is_elec_submit_tender char(1) DEFAULT NULL,
  submit_deadline date DEFAULT NULL,
  award_date date DEFAULT NULL,
  award_address varchar(45) DEFAULT NULL,
  is_tender_bond char(1) DEFAULT NULL,
  submit_language varchar(45) DEFAULT NULL,
  submit_address varchar(1000) DEFAULT NULL,
  --其他
  is_follow_law_99 char(1) DEFAULT NULL,
  fulfill_location varchar(200) DEFAULT NULL,
  fulfill_deadline varchar(100) DEFAULT NULL,
  is_post_bulletin char(1) DEFAULT NULL,
  is_authorities_template char(1) DEFAULT NULL,
  project_type varchar(45) DEFAULT NULL,
  is_disaster_reconstruct char(1) DEFAULT NULL,
  qualify_abstract varchar(2000) DEFAULT NULL,
  is_qualify_fulfill char(1) DEFAULT NULL,
  PRIMARY KEY (primary_key)
);

COMMENT ON COLUMN tender_declaration_info.primary_key IS '採購網主鍵';
COMMENT ON COLUMN tender_declaration_info.org_id IS '機關代碼';
COMMENT ON COLUMN tender_declaration_info.org_name IS '機關名稱';
COMMENT ON COLUMN tender_declaration_info.unit_name IS '單位名稱';
COMMENT ON COLUMN tender_declaration_info.org_address IS '機關地址';
COMMENT ON COLUMN tender_declaration_info.contact IS '聯絡人';
COMMENT ON COLUMN tender_declaration_info.tel IS '聯絡電話';
COMMENT ON COLUMN tender_declaration_info.fax IS '傳真號碼';
COMMENT ON COLUMN tender_declaration_info.email IS '電子郵件信箱';
COMMENT ON COLUMN tender_declaration_info.tender_case_no IS '標案案號';
COMMENT ON COLUMN tender_declaration_info.subject_of_procurement IS '標案名稱';
COMMENT ON COLUMN tender_declaration_info.attr_of_procurement IS '標的分類';
COMMENT ON COLUMN tender_declaration_info.project_no IS '工程計畫編號';
COMMENT ON COLUMN tender_declaration_info.is_construction IS '本採購案是否屬於建築工程';
COMMENT ON COLUMN tender_declaration_info.attr_of_goods IS '財物採購性質';
COMMENT ON COLUMN tender_declaration_info.procurement_money_amt_lv IS '採購金額級距';
COMMENT ON COLUMN tender_declaration_info.conduct_procurement IS '辦理方式';
COMMENT ON COLUMN tender_declaration_info.apply_law IS '依據法條';
COMMENT ON COLUMN tender_declaration_info.is_gpa IS '是否適用WTO政府採購協定(GPA)：';
COMMENT ON COLUMN tender_declaration_info.is_anztec IS '是否適用臺紐經濟合作協定(ANZTEC)：';
COMMENT ON COLUMN tender_declaration_info.is_astep IS '是否適用臺星經濟夥伴協定(ASTEP)：';
COMMENT ON COLUMN tender_declaration_info.budget_amount IS '預算金額';
COMMENT ON COLUMN tender_declaration_info.is_budget_amount_public IS '預算金額是否公開';
COMMENT ON COLUMN tender_declaration_info.is_extension IS '後續擴充';
COMMENT ON COLUMN tender_declaration_info.is_org_subsidy IS '是否受機關補助';
COMMENT ON COLUMN tender_declaration_info.is_special_budget IS '是否含特別預算';
COMMENT ON COLUMN tender_declaration_info.procurement_type IS '招標方式';
COMMENT ON COLUMN tender_declaration_info.awarding_type IS '決標方式';
COMMENT ON COLUMN tender_declaration_info.is_follow_law_64_2 IS '是否依政府採購法施行細則第64條之2辦理';
COMMENT ON COLUMN tender_declaration_info.is_electronic_quote IS '是否電子報價';
COMMENT ON COLUMN tender_declaration_info.num_transmit IS '新增公告傳輸次數';
COMMENT ON COLUMN tender_declaration_info.procurement_status IS '招標狀態';
COMMENT ON COLUMN tender_declaration_info.publication_date IS '公告日';
COMMENT ON COLUMN tender_declaration_info.is_multiple_award IS '是否複數決標';
COMMENT ON COLUMN tender_declaration_info.is_base_price IS '是否訂有底價';
COMMENT ON COLUMN tender_declaration_info.is_special IS '是否屬特殊採購';
COMMENT ON COLUMN tender_declaration_info.is_public_view IS '是否已辦理公開閱覽';
COMMENT ON COLUMN tender_declaration_info.is_design_build_contract IS '是否屬統包';
COMMENT ON COLUMN tender_declaration_info.is_inter_ent_sup_contract IS '是否屬共同供應契約採購';
COMMENT ON COLUMN tender_declaration_info.is_joint_procurement IS '是否屬二以上機關之聯合採購(不適用共同供應契約規定)';
COMMENT ON COLUMN tender_declaration_info.is_engineer_cert_required IS '是否應依公共工程專業技師簽證規則實施技師簽證';
COMMENT ON COLUMN tender_declaration_info.is_negotiation IS '是否採行協商措施';
COMMENT ON COLUMN tender_declaration_info.is_follow_law_104_105 IS '是否適用採購法第104條或105條或招標期限標準第10條或第4條之1';
COMMENT ON COLUMN tender_declaration_info.is_follow_law_106_1_1 IS '是否依據採購法第106條第1項第1款辦理';
COMMENT ON COLUMN tender_declaration_info.is_elec_receive_tender IS '是否提供電子領標';
COMMENT ON COLUMN tender_declaration_info.is_elec_submit_tender IS '是否提供電子投標';
COMMENT ON COLUMN tender_declaration_info.submit_deadline IS '截止投標';
COMMENT ON COLUMN tender_declaration_info.award_date IS '開標時間';
COMMENT ON COLUMN tender_declaration_info.award_address IS '開標地點';
COMMENT ON COLUMN tender_declaration_info.is_tender_bond IS '是否須繳納押標金';
COMMENT ON COLUMN tender_declaration_info.submit_language IS '投標文字';
COMMENT ON COLUMN tender_declaration_info.submit_address IS '收受投標文件地點';
COMMENT ON COLUMN tender_declaration_info.is_follow_law_99 IS '是否依據採購法第99條';
COMMENT ON COLUMN tender_declaration_info.fulfill_location IS '履約地點';
COMMENT ON COLUMN tender_declaration_info.fulfill_deadline IS '履約期限';
COMMENT ON COLUMN tender_declaration_info.is_post_bulletin IS '是否刊登公報';
COMMENT ON COLUMN tender_declaration_info.is_authorities_template IS '本案採購契約是否採用主管機關訂定之範本';
COMMENT ON COLUMN tender_declaration_info.project_type IS '歸屬計畫類別';
COMMENT ON COLUMN tender_declaration_info.is_disaster_reconstruct IS '是否屬災區重建工程';
COMMENT ON COLUMN tender_declaration_info.qualify_abstract IS '廠商資格摘要';
COMMENT ON COLUMN tender_declaration_info.is_qualify_fulfill IS '是否訂有與履約能力有關之基本資格';
