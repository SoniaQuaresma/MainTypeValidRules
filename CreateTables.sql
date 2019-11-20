-- Create table to store the rules parameters
-- here we will store all the rules for a statistical domain
-- This uses an ORACLE database and we chose a tablespace VALDATA

create table VTLCTRL
(
  id            NUMBER,
  type          VARCHAR2(20),
  sub_type      VARCHAR2(20),
  tbl_dsd       VARCHAR2(100),
  key_list      VARCHAR2(500),
  chk_fld1      VARCHAR2(100),
  chk_fld2      VARCHAR2(100),
  chk_fld3      VARCHAR2(100),
  val1          VARCHAR2(100),
  val2          VARCHAR2(100),
  val3          VARCHAR2(100),
  val_list      VARCHAR2(1000),
  tbl_codes     VARCHAR2(100),
  tbl_codes_fld VARCHAR2(100)
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Below are tables for storing logs
-- the PROCEDURE for validation will
-- look for tables with prefix TLOG_
-- and a suffix corresponding to the
-- type of rule being executed and
-- stored in the type field 
-- in the table VTLCTRL above
-- if these tables don't exist they will be created
-- during the rules execution

-- ATENTION the structure of the log tables varies!
-- Depending on the type of rule being fired
-- the reason for this is to mime
-- and compare directly with results being 
-- produced by Sandbox VTL interpreter

-- Create table for storing logs 
-- of the type COC rules
create table TLOG_ANI_GIPCAT_S_2016_COC
(
  id              NUMBER,
  freq            VARCHAR2(10) not null,
  dim_cl_h_gipcat VARCHAR2(50) not null,
  bool_var        CHAR(5),
  errorcode       VARCHAR2(2000),
  errorlevel      CHAR(5),
  val_date        DATE
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Create table for storing logs 
-- of the type COV rules
create table TLOG_ANI_GIPCAT_S_2016_COV
(
  id              NUMBER,
  freq            VARCHAR2(10) not null,
  ref_area        VARCHAR2(10) not null,
  dim_cl_h_gipcat VARCHAR2(50) not null,
  time_period     VARCHAR2(10) not null,
  bool_var        VARCHAR2(5),
  errorcode       VARCHAR2(2000),
  errorlevel      CHAR(5),
  val_date        DATE
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table for storing logs 
-- of the type FDL rules
create table TLOG_ANI_GIPCAT_S_2016_FDL
(
  id              NUMBER,
  freq            VARCHAR2(10) not null,
  ref_area        VARCHAR2(10) not null,
  dim_cl_h_gipcat VARCHAR2(50) not null,
  time_period     VARCHAR2(10) not null,
  bool_var        VARCHAR2(5),
  errorcode       VARCHAR2(2000),
  errorlevel      CHAR(5),
  val_date        DATE
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table for storing logs 
-- of the type FDM rules
create table TLOG_ANI_GIPCAT_S_2016_FDM
(
  id              NUMBER,
  freq            VARCHAR2(10) not null,
  ref_area        VARCHAR2(10) not null,
  dim_cl_h_gipcat VARCHAR2(50) not null,
  time_period     VARCHAR2(10) not null,
  bool_var        VARCHAR2(5),
  errorcode       VARCHAR2(2000),
  errorlevel      CHAR(5),
  val_date        DATE
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table for storing logs 
-- of the type RDW rules
create table TLOG_ANI_GIPCAT_S_2016_RDW
(
  id              NUMBER,
  freq            VARCHAR2(10) not null,
  ref_area        VARCHAR2(10) not null,
  dim_cl_h_gipcat VARCHAR2(50) not null,
  time_period     VARCHAR2(10) not null,
  bool_var        VARCHAR2(5),
  errorcode       VARCHAR2(2000),
  errorlevel      CHAR(5),
  val_date        DATE
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table for storing logs 
-- of the type REP rules
create table TLOG_ANI_GIPCAT_S_2016_REP
(
  id              NUMBER,
  freq            VARCHAR2(10),
  ref_area        VARCHAR2(10),
  dim_cl_h_gipcat VARCHAR2(50),
  bool_var        VARCHAR2(5),
  errorcode       VARCHAR2(2000),
  errorlevel      CHAR(5),
  val_date        DATE
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Create table for storing logs 
-- of the type RNR rules
create table TLOG_ANI_GIPCAT_S_2016_RNR
(
  id          NUMBER,
  freq        VARCHAR2(10) not null,
  ref_area    VARCHAR2(10) not null,
  time_period VARCHAR2(10) not null,
  bool_var    VARCHAR2(5),
  errorcode   VARCHAR2(2000),
  errorlevel  CHAR(5),
  val_date    DATE
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table for storing logs 
-- of the type VAD rules
create table TLOG_ANI_GIPCAT_S_2016_VAD
(
  id          NUMBER,
  freq        VARCHAR2(10) not null,
  ref_area    VARCHAR2(10) not null,
  time_period VARCHAR2(10) not null,
  bool_var    VARCHAR2(5),
  errorcode   VARCHAR2(2000),
  errorlevel  CHAR(5),
  val_date    DATE
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table for storing logs 
-- of the type VCO rules
create table TLOG_ANI_GIPCAT_S_2016_VCO
(
  id          NUMBER,
  freq        VARCHAR2(10) not null,
  ref_area    VARCHAR2(10) not null,
  time_period VARCHAR2(10) not null,
  bool_var    VARCHAR2(5),
  errorcode   CHAR(93),
  errorlevel  CHAR(5),
  val_date    DATE
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table for storing logs 
-- of the type VIR rules
create table TLOG_ANI_GIPCAT_S_2016_VIR
(
  id              NUMBER,
  freq            VARCHAR2(10) not null,
  ref_area        VARCHAR2(10) not null,
  dim_cl_h_gipcat VARCHAR2(50) not null,
  time_period     VARCHAR2(10) not null,
  bool_var        VARCHAR2(5),
  errorcode       VARCHAR2(2000),
  errorlevel      CHAR(5),
  val_date        DATE
)
tablespace TS_VALDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
