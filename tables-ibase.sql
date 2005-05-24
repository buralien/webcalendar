
 /* Table: WEBCAL_ENTRY, Owner: SYSDBA */

CREATE TABLE "WEBCAL_ENTRY" 
(
   "CAL_ID" INTEGER NOT NULL,
   "CAL_GROUP_ID" INTEGER,
   "CAL_DATE" INTEGER NOT NULL,
   "CAL_EXT_FOR_ID" INT NULL,
   "CAL_TIME" INTEGER,
   "CAL_MOD_DATE" INTEGER,
   "CAL_MOD_TIME" INTEGER,
   "CAL_DURATION" INTEGER NOT NULL,
   "CAL_PRIORITY" INTEGER DEFAULT 2,
   "CAL_TYPE" CHAR(1) CHARACTER SET WIN1252 DEFAULT 'E',
   "CAL_ACCESS" CHAR(1) CHARACTER SET WIN1252 DEFAULT 'P',
   "CAL_NAME" VARCHAR(80) CHARACTER SET WIN1252 NOT NULL,
   "CAL_DESCRIPTION" VARCHAR(500) CHARACTER SET WIN1252,
   "CAL_CREATE_BY" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL
);

/* create a default admin user */
INSERT INTO webcal_user ( cal_login, cal_passwd, cal_lastname, cal_firstname, cal_is_admin ) VALUES ( 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 'Default', 'Y' );





/* Table: WEBCAL_ENTRY_REPEATS, Owner: SYSDBA */

CREATE TABLE "WEBCAL_ENTRY_REPEATS" 
(
   "CAL_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_TYPE" VARCHAR(20) CHARACTER SET WIN1252,
   "CAL_END" INTEGER,
   "CAL_FREQUENCY" INTEGER DEFAULT 1,
   "CAL_DAYS" CHAR(7) CHARACTER SET WIN1252
);

/* Table: WEBCAL_ENTRY_REPEATS_NOT, Owner: SYSDBA */
CREATE TABLE "WEBCAL_ENTRY_REPEATS_NOT" 
   "CAL_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_DATE" INTEGER NOT NULL
);


/* Table: WEBCAL_ENTRY_USER, Owner: SYSDBA */

CREATE TABLE "WEBCAL_ENTRY_USER" 
(
   "CAL_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_LOGIN" VARCHAR(25) CHARACTER SET WIN1252 DEFAULT '' NOT NULL,
   "CAL_STATUS" VARCHAR(1) CHARACTER SET WIN1252 DEFAULT 'A',
   "CAL_CATEGORY" INTEGER NULL
);


/* Table: WEBCAL_ENTRY_EXT_USER, Owner: SYSDBA */

CREATE TABLE "WEBCAL_ENTRY_EXT_USER" 
(
   "CAL_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_FULLNAME" VARCHAR(50) CHARACTER SET WIN1252 DEFAULT '' NOT NULL,
   "CAL_EMAIL" VARCHAR(75) CHARACTER SET WIN1252
);


/* Table: WEBCAL_REMINDER_LOG, Owner: SYSDBA */

CREATE TABLE "WEBCAL_REMINDER_LOG" 
(
   "CAL_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_NAME" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
   "CAL_EVENT_DATE" INTEGER DEFAULT 0 NOT NULL,
   "CAL_LAST_SENT" INTEGER DEFAULT 0 NOT NULL
);


/* Table: WEBCAL_SITE_EXTRAS, Owner: SYSDBA */

CREATE TABLE "WEBCAL_SITE_EXTRAS" 
(
   "CAL_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_NAME" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
   "CAL_TYPE" INTEGER NOT NULL,
   "CAL_DATE" INTEGER DEFAULT 0,
   "CAL_REMIND" INTEGER DEFAULT 0,
   "CAL_DATA" VARCHAR(500) CHARACTER SET WIN1252
);


/* Table: WEBCAL_USER, Owner: SYSDBA */

CREATE TABLE "WEBCAL_USER" 
(
   "CAL_LOGIN" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
   "CAL_PASSWD" VARCHAR(32) CHARACTER SET WIN1252,
   "CAL_LASTNAME" VARCHAR(25) CHARACTER SET WIN1252,
   "CAL_FIRSTNAME" VARCHAR(25) CHARACTER SET WIN1252,
   "CAL_IS_ADMIN" CHAR(1) CHARACTER SET WIN1252 DEFAULT 'N',
   "CAL_EMAIL" VARCHAR(75) CHARACTER SET WIN1252
);


/* Table: WEBCAL_USER_LAYERS, Owner: SYSDBA */

CREATE TABLE "WEBCAL_USER_LAYERS" 
(
   "CAL_LAYERID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_LOGIN" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
   "CAL_LAYERUSER" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
   "CAL_COLOR" VARCHAR(25) CHARACTER SET WIN1252,
   "CAL_DUPS" CHAR(1) CHARACTER SET WIN1252 DEFAULT 'N'
);


/* Table: WEBCAL_USER_PREF, Owner: SYSDBA */

CREATE TABLE "WEBCAL_USER_PREF" 
(
   "CAL_LOGIN" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
   "CAL_SETTING" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
   "CAL_VALUE" VARCHAR(100) CHARACTER SET WIN1252
);

/* Table: WEBCAL_GROUP, Owner: SYSDBA */

CREATE TABLE "WEBCAL_GROUP" 
(
   "CAL_GROUP_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_OWNER" VARCHAR(25) CHARACTER SET WIN1252 NULL,
   "CAL_NAME" VARCHAR(50) CHARACTER SET WIN1252 NOT NULL,
   "CAL_LAST_UPDATE" INTEGER DEFAULT 0 NOT NULL
);

/* Table: WEBCAL_GROUP_USER, Owner: SYSDBA */

CREATE TABLE "WEBCAL_GROUP_USER" 
(
   "CAL_GROUP_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_LOGIN" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL
);

/* Table: WEBCAL_VIEW, Owner: SYSDBA */

CREATE TABLE "WEBCAL_VIEW" 
(
   "CAL_VIEW_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_OWNER" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
   "CAL_NAME" VARCHAR(50) CHARACTER SET WIN1252 NOT NULL,
   "CAL_VIEW_TYPE" VARCHAR(1) CHARACTER SET WIN1252 NOT NULL,
   "CAL_IS_GLOBAL" CHAR(1) CHARACTER SET WIN1252 NOT NULL DEFAULT 'N'
);

/* Table: WEBCAL_VIEW_USER, Owner: SYSDBA */

CREATE TABLE "WEBCAL_VIEW_USER" 
(
   "CAL_VIEW_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_LOGIN" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL
);

/* Table: WEBCAL_CONFIG, Owner: SYSDBA */

CREATE TABLE "WEBCAL_CONFIG" 
(
   "CAL_SETTING" VARCHAR(50) CHARACTER SET WIN1252 NOT NULL,
   "CAL_VALUE" VARCHAR(100) CHARACTER SET WIN1252
);



/* default system settings */
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'application_name', 'WebCalendar' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'LANGUAGE', 'Browser-defined' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'demo_mode', 'N' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'require_approvals', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'groups_enabled', 'N' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'user_sees_only_his_groups', 'N' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'categories_enabled', 'N' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'allow_conflicts', 'N' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'conflict_repeat_months', '6' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'disable_priority_field', 'N' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'disable_access_field', 'N' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'disable_participants_field', 'N' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'disable_repeating_field', 'N' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'allow_view_other', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'email_fallback_from', 'youremailhere' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'remember_last_login', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'allow_color_customization', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('BGCOLOR','#FFFFFF');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('TEXTCOLOR','#000000');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('H2COLOR','#000000');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('CELLBG','#C0C0C0');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('WEEKENDBG','#D0D0D0');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('TABLEBG','#000000');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('THBG','#FFFFFF');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('THFG','#000000');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('POPUP_FG','#000000');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('POPUP_BG','#FFFFFF');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('TODAYCELLBG','#FFFF33');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'STARTVIEW', 'week.php' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'WEEK_START', '0' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'TIME_FORMAT', '12' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'DISPLAY_UNAPPROVED', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'DISPLAY_WEEKNUMBER', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'WORK_DAY_START_HOUR', '8' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'WORK_DAY_END_HOUR', '17' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'send_email', 'N' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'EMAIL_REMINDER', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'EMAIL_EVENT_ADDED', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'EMAIL_EVENT_UPDATED', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'EMAIL_EVENT_DELETED', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ( 'EMAIL_EVENT_REJECTED', 'Y' );
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('auto_refresh', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('nonuser_enabled', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('allow_html_description', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('reports_enabled', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('DISPLAY_WEEKENDS', 'Y');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('DISPLAY_DESC_PRINT_DAY', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('DATE_FORMAT', '__month__ __dd__, __yyyy__');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('TIME_SLOTS', '12');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('TIMED_EVT_LEN', 'D');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('PUBLISH_ENABLED', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('DATE_FORMAT_MY', '__month__ __yyyy__');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('DATE_FORMAT_MD', '__month__ __dd__');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('CUSTOM_SCRIPT', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('CUSTOM_HEADER', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('CUSTOM_TRAILER', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('bold_days_in_year', 'Y');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('site_extras_in_popup', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('add_link_in_views', 'Y');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('allow_conflict_override', 'Y');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('limit_appts', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('limit_appts_number', '6');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('public_access', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('public_access_default_visible', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('public_access_default_selected', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('public_access_others', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('public_access_can_add', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('public_access_add_needs_approval', 'Y');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('public_access_view_part', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('nonuser_at_top', 'Y');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('allow_external_users', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('external_notifications', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('external_reminders', 'N');
INSERT INTO webcal_config ( cal_setting, cal_value )
  VALUES ('enable_gradients', 'N');



/* Table: WEBCAL_ENTRY_LOG, Owner: SYSDBA */

CREATE TABLE "WEBCAL_ENTRY_LOG" 
(
   "CAL_LOG_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_ENTRY_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAL_LOGIN" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
   "CAL_USER_CAL" VARCHAR(25) CHARACTER SET WIN1252 NULL,
   "CAL_TYPE" VARCHAR(1) CHARACTER SET WIN1252 NOT NULL,
   "CAL_DATE" INTEGER NULL,
   "CAL_TIME" INTEGER NULL,
   "CAL_TEXT" VARCHAR(500) CHARACTER SET WIN1252 NULL
);


/* Table: WEBCAL_CATEGORIES, Owner: SYSDBA */

CREATE TABLE "WEBCAL_CATEGORIES" 
(
   "CAT_ID" INTEGER DEFAULT 0 NOT NULL,
   "CAT_OWNER" VARCHAR(25) CHARACTER SET WIN1252 NULL,
   "CAT_NAME" VARCHAR(80) CHARACTER SET WIN1252 NOT NULL
);

/* Table: WEBCAL_ASST, Owner: SYSDBA */
CREATE TABLE "WEBCAL_ASST"
(
  "CAL_BOSS" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
  "CAL_ASSISTANT"  VARCHAR(25) CHARACTER SET WIN1252 NOT NULL
);

/* Table: "WEBCAL_NONUSER_CALS", Owner: SYSDBA */
CREATE TABLE WEBCAL_NONUSER_CALS (
  "CAL_LOGIN" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
  "CAL_LASTNAME" VARCHAR(25) CHARACTER SET WIN1252,
  "CAL_FIRSTNAME" VARCHAR(25) CHARACTER SET WIN1252,
  "CAL_ADMIN" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL
);

/* Table: "WEBCAL_IMPORT", Owner: SYSDBA */
CREATE TABLE WEBCAL_IMPORT (
  "CAL_IMPORT_ID" INTEGER DEFAULT 0 NOT NULL,
  "CAL_NAME" VARCHAR(50) CHARACTER SET WIN1252 NULL,
  "CAL_DATE" INTEGER DEFAULT 0 NOT NULL,
  "CAL_TYPE" VARCHAR(10) CHARACTER SET WIN1252 NOT NULL,
  "CAL_LOGIN" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL
);

/* Table: "WEBCAL_IMPORT_DATA", Owner: SYSDBA */
CREATE TABLE WEBCAL_IMPORT_DATA (
  "CAL_IMPORT_ID" INTEGER DEFAULT 0 NOT NULL,
  "CAL_ID" INTEGER DEFAULT 0 NOT NULL,
  "CAL_LOGIN" VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
  "CAL_IMPORT_TYPE" VARCHAR(15) CHARACTER SET WIN1252 NOT NULL,
  "CAL_EXTERNAL_ID" VARCHAR(200) CHARACTER SET WIN1252 NULL,
  "CAL_EXTERNAL_ID" VARCHAR(200) NULL
);

/* Table: "WEBCAL_REPORT", Owner: SYSDBA */
CREATE TABLE WEBCAL_REPORT (
  "CAL_LOGIN VARCHAR(25) CHARACTER SET WIN1252 NOT NULL,
  "CAL_REPORT_ID INTEGER DEFAULT 0 NOT NULL,
  "CAL_IS_GLOBAL VARCHAR(1) DEFAULT 'N' CHARACTER SET WIN1252 NOT NULL,
  "CAL_REPORT_TYPE VARCHAR(20) CHARACTER SET WIN1252 NOT NULL,
  "CAL_INCLUDE_HEADER VARCHAR(1) DEFAULT 'Y' CHARACTER SET WIN1252 NOT NULL,
  "CAL_REPORT_NAME VARCHAR(50) CHARACTER SET WIN1252 NOT NULL,
  "CAL_TIME_RANGE INTEGER DEFAULT 0 NOT NULL,
  "CAL_USER VARCHAR(25) CHARACTER SET WIN1252 NULL,
  "CAL_ALLOW_NAV VARCHAR(1) DEFAULT 'Y' CHARACTER SET WIN1252 NOT NULL,
  "CAL_CAT_ID INTEGER NULL,
  "CAL_INCLUDE_EMPTY VARCHAR(1) DEFAULT 'N' CHARACTER SET WIN1252 NOT NULL,
  "CAL_SHOW_IN_TRAILER VARCHAR(1) DEFAULT 'N' CHARACTER SET WIN1252 NOT NULL,
  "CAL_UPDATE_DATE INTEGER DEFAULT 0 NOT NULL
);

/* Table: "WEBCAL_REPORT_TEMPLATE", Owner: SYSDBA */
CREATE TABLE WEBCAL_REPORT_TEMPLATE (
  "CAL_REPORT_ID" INTEGER DEFAULT 0 NOT NULL,
  "CAL_TEMPLATE_TYPE" VARCHAR(1) CHARACTER SET WIN1252 NOT NULL,
  "CAL_TEMPLATE_TEXT" VARCHAR(1024) CHARACTER SET WIN1252 NOT NULL
);

/* Table: "WEBCAL_ACCESS_USER", Owner: SYSDBA */
CREATE TABLE WEBCAL_ACCESS_USER (
  "CAL_LOGIN" VARCHAR(50) CHARACTER SET WIN1252 NOT NULL,
  "CAL_OTHER_USER" VARCHAR(50) CHARACTER SET WIN1252 NOT NULL,
  "CAL_CAN_VIEW" CHAR(1) CHARACTER SET WIN1252 NOT NULL DEFAULT 'N',
  "CAL_CAN_EDIT" CHAR(1) CHARACTER SET WIN1252 NOT NULL DEFAULT 'N',
  "CAL_CAN_DELETE" CHAR(1) CHARACTER SET WIN1252 NOT NULL DEFAULT 'N',
  "CAL_CAN_APPROVE" CHAR(1) CHARACTER SET WIN1252 NOT NULL DEFAULT 'N'
);


/* Table: "WEBCAL_ACCESS_FUNCTION", Owner: SYSDBA */
CREATE TABLE WEBCAL_ACCESS_FUNCTION (
  "CAL_LOGIN" VARCHAR(50) CHARACTER SET WIN1252 NOT NULL,
  "CAL_PERMISSIONS" VARCHAR(64) CHARACTER SET WIN1252 NOT NULL
);


/*  Index definitions for all user tables */

CREATE INDEX "IWEBCAL_ENTRYNEWINDEX" ON "WEBCAL_ENTRY"("CAL_ID");
CREATE INDEX "IWEBCAL_ENTRY_REPEATSNEWINDEX" ON "WEBCAL_ENTRY_REPEATS"("CAL_ID");
CREATE INDEX "IWEBCAL_ENTRY_REPEATS_NOTNEWINDEX" ON "WEBCAL_ENTRY_REPEATS_NOT"("CAL_ID", "CAL_DATE");
CREATE INDEX "IWEBCAL_ENTRY_USERNEWINDEX" ON "WEBCAL_ENTRY_USER"("CAL_ID", "CAL_LOGIN");
CREATE INDEX "IWEBCAL_ENTRY_EXTUSERNEWINDEX" ON "WEBCAL_ENTRY_EXT_USER"("CAL_ID", "CAL_FULLNAME");
CREATE INDEX "IWEBCAL_REMINDER_LOGNEWINDEX" ON "WEBCAL_REMINDER_LOG"("CAL_ID", "CAL_NAME", "CAL_EVENT_DATE");
CREATE INDEX "IWEBCAL_SITE_EXTRASNEWINDEX" ON "WEBCAL_SITE_EXTRAS"("CAL_ID", "CAL_NAME", "CAL_TYPE");
CREATE INDEX "IWEBCAL_USERNEWINDEX" ON "WEBCAL_USER"("CAL_LOGIN");
CREATE INDEX "IWEBCAL_USER_LAYERSNEWINDEX" ON "WEBCAL_USER_LAYERS"("CAL_LOGIN", "CAL_LAYERUSER");
CREATE INDEX "IWEBCAL_USER_PREFNEWINDEX" ON "WEBCAL_USER_PREF"("CAL_LOGIN", "CAL_SETTING");
CREATE INDEX "IWEBCAL_GROUPNEWINDEX" ON "WEBCAL_GROUP"("CAL_GROUP_ID");
CREATE INDEX "IWEBCAL_GROUPUSERNEWINDEX" ON "WEBCAL_GROUP_USER"("CAL_GROUP_ID", "CAL_LOGIN");
CREATE INDEX "IWEBCAL_VIEWNEWINDEX" ON "WEBCAL_VIEW"("CAL_VIEW_ID");
CREATE INDEX "IWEBCAL_VIEWUSERNEWINDEX" ON "WEBCAL_VIEW_USER"("CAL_VIEW_ID", "CAL_LOGIN");
CREATE INDEX "IWEBCAL_CONFIGNEWINDEX" ON "WEBCAL_CONFIG"("CAL_SETTING");
CREATE INDEX "IWEBCAL_ENTRYLOGINDEX" ON "WEBCAL_CONFIG"("CAL_LOG_ID");
CREATE INDEX "IWEBCAL_CATEGORIESINDEX" ON "WEBCAL_CATEGORIES"("CAT_ID");
CREATE INDEX "IWEBCAL_BOSSINDEX" ON "WEBCAL_ASST"("CAL_BOSS", "CAL_ASSISTANT");
CREATE INDEX "IWEBCAL_NONUSERCALSINDEX" ON "WEBCAL_NONUSER_CALS"("CAL_LOGIN");
CREATE INDEX "IWEBCAL_IMPORT2INDEX" ON "WEBCAL_IMPORT"("CAL_IMPORT_ID");
CREATE INDEX "IWEBCAL_IMPORTINDEX" ON "WEBCAL_IMPORT_DATA"("CAL_LOGIN", "CAL_ID");
CREATE INDEX "IWEBCAL_REPORTINDEX" ON "WEBCAL_REPORT"("CAL_REPORT_ID");
CREATE INDEX "IWEBCAL_REPORTTEMPLATEINDEX" ON "WEBCAL_REPORT_TEMPLATE"("CAL_REPORT_ID", "CAL_TEMPLATE_TYPE");
CREATE INDEX "IWEBCAL_ACCESSUSERINDEX" ON "WEBCAL_ACCESS_USER"("CAL_LOGIN", "CAL_OTHER_USER");
CREATE INDEX "IWEBCAL_ACCESSFUNCTIONINDEX" ON "WEBCAL_ACCESS_FUNCTION"("CAL_LOGIN");

