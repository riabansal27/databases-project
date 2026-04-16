-- Output file commands
set echo on
spool at6_schema_output.txt

-- =============================================
-- AT6 Schema Script
-- Author: Ria Bansal
-- Student ID: 34267433
-- Date: 16 April 2026
-- Description: DDL for SALESREP, DRUG, SALESREP_DRUG
-- =============================================

-- Drop tables
drop table salesrep_drug cascade constraints purge;
drop table salesrep cascade constraints purge;
drop table drug cascade constraints purge;

-- Create SALESREP table
CREATE TABLE salesrep (
    slsrep_id     NUMBER(3)    NOT NULL,
    slsrep_name   VARCHAR2(50) NOT NULL,
    slsrep_mobile CHAR(10)     NOT NULL
);

-- Create DRUG table
CREATE TABLE drug (
    drug_code  CHAR(6)      NOT NULL,
    drug_name  VARCHAR2(50) NOT NULL,
    drug_pbs   CHAR(1)      NOT NULL
);

-- Create SALESREP_DRUG table
CREATE TABLE salesrep_drug (
    drug_code        CHAR(6)   NOT NULL,
    slsrep_id        NUMBER(3) NOT NULL,
    sd_date_assigned DATE      NOT NULL
);

-- Add column comments
COMMENT ON COLUMN salesrep.slsrep_id IS 'unique identifier for each sales representative';
COMMENT ON COLUMN salesrep.slsrep_name IS 'full name of the sales representative';
COMMENT ON COLUMN salesrep.slsrep_mobile IS 'unique mobile phone number of sales representative';

COMMENT ON COLUMN drug.drug_code IS 'unique code identifying each drug';
COMMENT ON COLUMN drug.drug_name IS 'name of the drug';
COMMENT ON COLUMN drug.drug_pbs IS 'PBS coverage status: Y = covered, N = not covered';

COMMENT ON COLUMN salesrep_drug.drug_code IS 'drug code, part of composite primary key';
COMMENT ON COLUMN salesrep_drug.slsrep_id IS 'sales rep id, part of composite primary key';
COMMENT ON COLUMN salesrep_drug.sd_date_assigned IS 'date the sales rep was assigned to the drug';

-- Add PRIMARY KEY constraints
ALTER TABLE salesrep
    ADD CONSTRAINT salesrep_pk PRIMARY KEY (slsrep_id);

ALTER TABLE drug
    ADD CONSTRAINT drug_pk PRIMARY KEY (drug_code);

ALTER TABLE salesrep_drug
    ADD CONSTRAINT salesrep_drug_pk PRIMARY KEY (drug_code, slsrep_id);

-- Add UNIQUE constraint
ALTER TABLE salesrep
    ADD CONSTRAINT salesrep_mobile_uq UNIQUE (slsrep_mobile);

-- Add CHECK constraint
ALTER TABLE drug
    ADD CONSTRAINT drug_pbs_ck CHECK (drug_pbs IN ('Y', 'N'));

-- Add FOREIGN KEY constraints
ALTER TABLE salesrep_drug
    ADD CONSTRAINT sd_drug_fk FOREIGN KEY (drug_code)
        REFERENCES drug (drug_code);

ALTER TABLE salesrep_drug
    ADD CONSTRAINT sd_salesrep_fk FOREIGN KEY (slsrep_id)
        REFERENCES salesrep (slsrep_id);
        
spool off
set echo off