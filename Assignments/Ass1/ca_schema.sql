-- Name: Ria Bansal
-- Student ID: rban0019
-- Date: 27 April 2026
SET ECHO ON
SPOOL ca_schema_output.txt



DROP TABLE BIN CASCADE CONSTRAINTS 
;

DROP TABLE BIN_COLLECTION CASCADE CONSTRAINTS 
;

DROP TABLE BIN_TYPE CASCADE CONSTRAINTS 
;

DROP TABLE COLLECTION CASCADE CONSTRAINTS 
;

DROP TABLE CONTRACT CASCADE CONSTRAINTS 
;

DROP TABLE CONTRACT_BIN_SUPPLY CASCADE CONSTRAINTS 
;

DROP TABLE CONTRACT_WASTE CASCADE CONSTRAINTS 
;

DROP TABLE LOCAL_AUTHORITY CASCADE CONSTRAINTS 
;

DROP TABLE OWNER CASCADE CONSTRAINTS 
;

DROP TABLE PROPERTY CASCADE CONSTRAINTS 
;

DROP TABLE PROPERTY_OWNER CASCADE CONSTRAINTS 
;

DROP TABLE STREET CASCADE CONSTRAINTS 
;

DROP TABLE TRUCK CASCADE CONSTRAINTS 
;

DROP TABLE WASTE_TYPE CASCADE CONSTRAINTS 
;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE BIN 
    ( 
     bin_rfid           CHAR (24)  NOT NULL , 
     supply_date        DATE  NOT NULL , 
     replacement_reason VARCHAR2 (50) , 
     cbs_id             NUMBER (10)  NOT NULL , 
     prop_id            NUMBER (10) 
    ) 
;

ALTER TABLE BIN 
    ADD CONSTRAINT chk_replacement_reason 
    CHECK (replacement_reason IN ('Bin failure', 'Damaged by owner', 'Damaged during pickup of waste', 'Stolen')) 
;

COMMENT ON COLUMN BIN.bin_rfid IS 'Unique RFID tag identifier for the bin (EPC Gen2 standard, 24 hex characters)' 
;

COMMENT ON COLUMN BIN.supply_date IS 'Date the bin was supplied to the property' 
;

COMMENT ON COLUMN BIN.replacement_reason IS 'Reason for bin replacement if applicable' 
;

COMMENT ON COLUMN BIN.cbs_id IS 'Surrogate key for contract bin supply' 
;

COMMENT ON COLUMN BIN.prop_id IS 'Surrogate key for property' 
;

ALTER TABLE BIN 
    ADD CONSTRAINT BIN_PK PRIMARY KEY ( bin_rfid ) ;

CREATE TABLE BIN_COLLECTION 
    ( 
     cont_no       NUMBER (10)  NOT NULL , 
     collect_date  DATE  NOT NULL , 
     bin_rfid      CHAR (24)  NOT NULL , 
     collected_kgs NUMBER (6,2) , 
     overweight    CHAR (1)  NOT NULL , 
     bc_id         NUMBER (10)  NOT NULL , 
     coll_id       NUMBER (10)  NOT NULL , 
     bin_rfid1     CHAR (24)  NOT NULL 
    ) 
;

ALTER TABLE BIN_COLLECTION 
    ADD CONSTRAINT chk_overweight 
    CHECK (overweight IN ('N', 'Y')) 
;

COMMENT ON COLUMN BIN_COLLECTION.cont_no IS 'Contract number' 
;

COMMENT ON COLUMN BIN_COLLECTION.collect_date IS 'Date of collection' 
;

COMMENT ON COLUMN BIN_COLLECTION.bin_rfid IS 'RFID tag of the bin collected' 
;

COMMENT ON COLUMN BIN_COLLECTION.collected_kgs IS 'Weight of waste collected in kilograms' 
;

COMMENT ON COLUMN BIN_COLLECTION.overweight IS 'Flag indicating if bin was overweight Y or N' 
;

COMMENT ON COLUMN BIN_COLLECTION.bc_id IS 'Surrogate key for bin collection' 
;

COMMENT ON COLUMN BIN_COLLECTION.coll_id IS 'Surrogate key for collection run' 
;

COMMENT ON COLUMN BIN_COLLECTION.bin_rfid1 IS 'Unique RFID tag identifier for the bin (EPC Gen2 standard, 24 hex characters)' 
;

ALTER TABLE BIN_COLLECTION 
    ADD CONSTRAINT BIN_COLLECTION_PK PRIMARY KEY ( bc_id ) ;

ALTER TABLE BIN_COLLECTION 
    ADD CONSTRAINT BIN_COLLECTION_NK UNIQUE ( cont_no , collect_date , bin_rfid ) ;

CREATE TABLE BIN_TYPE 
    ( 
     waste_type_id   VARCHAR2 (10)  NOT NULL , 
     bin_size        NUMBER (5)  NOT NULL , 
     std_supply_cost NUMBER (8,2) 
    ) 
;

COMMENT ON COLUMN BIN_TYPE.waste_type_id IS 'Identifier for the waste type' 
;

COMMENT ON COLUMN BIN_TYPE.bin_size IS 'Size of the bin in litres' 
;

COMMENT ON COLUMN BIN_TYPE.std_supply_cost IS 'Standard supply cost for this bin type and size' 
;

ALTER TABLE BIN_TYPE 
    ADD CONSTRAINT BIN_TYPE_PK PRIMARY KEY ( waste_type_id, bin_size ) ;

CREATE TABLE COLLECTION 
    ( 
     cont_no      NUMBER (10)  NOT NULL , 
     collect_date DATE  NOT NULL , 
     truck_vin    VARCHAR2 (20)  NOT NULL , 
     coll_id      NUMBER (10)  NOT NULL , 
     truck_vin1   VARCHAR2 (20)  NOT NULL 
    ) 
;

COMMENT ON COLUMN COLLECTION.cont_no IS 'Contract number for this collection run' 
;

COMMENT ON COLUMN COLLECTION.collect_date IS 'Date of the collection run' 
;

COMMENT ON COLUMN COLLECTION.truck_vin IS 'VIN of the truck used for this collection run' 
;

COMMENT ON COLUMN COLLECTION.coll_id IS 'Surrogate key for collection run' 
;

COMMENT ON COLUMN COLLECTION.truck_vin1 IS 'Vehicle Identification Number of the truck' 
;

ALTER TABLE COLLECTION 
    ADD CONSTRAINT COLLECTION_PK PRIMARY KEY ( coll_id ) ;

ALTER TABLE COLLECTION 
    ADD CONSTRAINT COLLECTION_NK UNIQUE ( cont_no , collect_date ) ;

CREATE TABLE CONTRACT 
    ( 
     cont_no         NUMBER (10)  NOT NULL , 
     cont_start_date DATE  NOT NULL , 
     cont_end_date   DATE  NOT NULL , 
     auth_name       VARCHAR2 (100)  NOT NULL 
    ) 
;

COMMENT ON COLUMN CONTRACT.cont_no IS 'Unique contract number' 
;

COMMENT ON COLUMN CONTRACT.cont_start_date IS 'Start date of the contract' 
;

COMMENT ON COLUMN CONTRACT.cont_end_date IS 'End date of the contract' 
;

COMMENT ON COLUMN CONTRACT.auth_name IS 'Name of the local authority, must be unique: authority name' 
;

ALTER TABLE CONTRACT 
    ADD CONSTRAINT CONTRACT_PK PRIMARY KEY ( cont_no ) ;

CREATE TABLE CONTRACT_BIN_SUPPLY 
    ( 
     cont_no          NUMBER (10)  NOT NULL , 
     waste_type_id    VARCHAR2 (10)  NOT NULL , 
     bin_size         NUMBER (5)  NOT NULL , 
     cont_supply_cost NUMBER (8,2)  NOT NULL , 
     cbs_id           NUMBER (10)  NOT NULL , 
     cw_id            NUMBER (10)  NOT NULL , 
     waste_type_id1   VARCHAR2 (10)  NOT NULL , 
     bin_size1        NUMBER (5)  NOT NULL 
    ) 
;

COMMENT ON COLUMN CONTRACT_BIN_SUPPLY.cont_no IS 'Contract number' 
;

COMMENT ON COLUMN CONTRACT_BIN_SUPPLY.cbs_id IS 'Surrogate key for contract bin supply' 
;

COMMENT ON COLUMN CONTRACT_BIN_SUPPLY.cw_id IS 'Surrogate key for contract waste' 
;

COMMENT ON COLUMN CONTRACT_BIN_SUPPLY.waste_type_id1 IS 'Identifier for the waste type' 
;

COMMENT ON COLUMN CONTRACT_BIN_SUPPLY.bin_size1 IS 'Size of the bin in litres' 
;

ALTER TABLE CONTRACT_BIN_SUPPLY 
    ADD CONSTRAINT CONTRACT_BIN_SUPPLY_PK PRIMARY KEY ( cbs_id ) ;

CREATE TABLE CONTRACT_WASTE 
    ( 
     cont_no              NUMBER (10)  NOT NULL , 
     waste_type_id        NUMBER (10)  NOT NULL , 
     coll_cost_per_kg     NUMBER (8,2)  NOT NULL , 
     collection_frequency CHAR (20)  NOT NULL , 
     cw_id                NUMBER (10)  NOT NULL , 
     cont_no1             NUMBER (10)  NOT NULL , 
     waste_type_id1       VARCHAR2 (100)  NOT NULL 
    ) 
;

COMMENT ON COLUMN CONTRACT_WASTE.cont_no IS 'Contract number' 
;

COMMENT ON COLUMN CONTRACT_WASTE.waste_type_id IS 'Identifier for the waste type' 
;

COMMENT ON COLUMN CONTRACT_WASTE.coll_cost_per_kg IS 'Collection cost per kilogram for this waste type under this contract' 
;

COMMENT ON COLUMN CONTRACT_WASTE.collection_frequency IS 'collection for this waste type under this contract' 
;

COMMENT ON COLUMN CONTRACT_WASTE.cw_id IS 'Surrogate key for contract waste' 
;

COMMENT ON COLUMN CONTRACT_WASTE.cont_no1 IS 'Unique contract number' 
;

COMMENT ON COLUMN CONTRACT_WASTE.waste_type_id1 IS 'Unique identifier for the waste type' 
;

ALTER TABLE CONTRACT_WASTE 
    ADD CONSTRAINT CONTRACT_WASTE_PK PRIMARY KEY ( cw_id ) ;

ALTER TABLE CONTRACT_WASTE 
    ADD CONSTRAINT CONTRACT_WASTE_NK UNIQUE ( cont_no , waste_type_id ) ;

CREATE TABLE LOCAL_AUTHORITY 
    ( 
     auth_name      VARCHAR2 (100)  NOT NULL , 
     ceo_given_name VARCHAR2 (50)  NOT NULL , 
     ceo_fam_name   VARCHAR2 (50)  NOT NULL , 
     auth_phone     CHAR (10)  NOT NULL , 
     auth_area      NUMBER (10,2)  NOT NULL , 
     auth_type      CHAR (20)  NOT NULL 
    ) 
;

ALTER TABLE LOCAL_AUTHORITY 
    ADD CONSTRAINT chk_auth_type 
    CHECK (auth_type IN ('Borough', 'City', 'District Council', 'Shire', 'Town')) 
;

COMMENT ON COLUMN LOCAL_AUTHORITY.auth_name IS 'Name of the local authority, must be unique: authority name' 
;

COMMENT ON COLUMN LOCAL_AUTHORITY.ceo_given_name IS 'Given name of the CEO' 
;

COMMENT ON COLUMN LOCAL_AUTHORITY.ceo_fam_name IS 'Family name of the CEO' 
;

COMMENT ON COLUMN LOCAL_AUTHORITY.auth_phone IS 'Contact phone number of the authority' 
;

COMMENT ON COLUMN LOCAL_AUTHORITY.auth_area IS 'Total area of the authority in square kilometres' 
;

COMMENT ON COLUMN LOCAL_AUTHORITY.auth_type IS 'Type of local authority' 
;

ALTER TABLE LOCAL_AUTHORITY 
    ADD CONSTRAINT LOCAL_AUTHORITY_PK PRIMARY KEY ( auth_name ) ;

CREATE TABLE OWNER 
    ( 
     owner_id    NUMBER (10)  NOT NULL , 
     owner_email VARCHAR2 (100)  NOT NULL , 
     owner_phone CHAR (15) , 
     owner_name  VARCHAR2 (100)  NOT NULL 
    ) 
;

COMMENT ON COLUMN OWNER.owner_id IS 'Unique identifier for the owner' 
;

COMMENT ON COLUMN OWNER.owner_email IS 'Email address of the owner' 
;

COMMENT ON COLUMN OWNER.owner_phone IS 'Phone number of the owner' 
;

COMMENT ON COLUMN OWNER.owner_name IS 'Name of the owner' 
;

ALTER TABLE OWNER 
    ADD CONSTRAINT OWNER_PK PRIMARY KEY ( owner_id ) ;

CREATE TABLE PROPERTY 
    ( 
     auth_name   VARCHAR2 (100)  NOT NULL , 
     street_id   NUMBER (10)  NOT NULL , 
     street_no   NUMBER (10)  NOT NULL , 
     prop_id     NUMBER (10)  NOT NULL , 
     auth_name1  VARCHAR2 (100) , 
     auth_name11 VARCHAR2 (100) 
    ) 
;

COMMENT ON COLUMN PROPERTY.auth_name IS 'Name of the local authority' 
;

COMMENT ON COLUMN PROPERTY.street_id IS 'Street identifier' 
;

COMMENT ON COLUMN PROPERTY.street_no IS 'Street number of the property' 
;

COMMENT ON COLUMN PROPERTY.prop_id IS 'Surrogate key for property' 
;

COMMENT ON COLUMN PROPERTY.auth_name1 IS 'Name of the local authority' 
;

COMMENT ON COLUMN PROPERTY.auth_name11 IS 'Name of the local authority, must be unique: authority name' 
;

ALTER TABLE PROPERTY 
    ADD CONSTRAINT PROPERTY_PK PRIMARY KEY ( prop_id ) ;

ALTER TABLE PROPERTY 
    ADD CONSTRAINT PROPERTY_NK UNIQUE ( auth_name , street_id , street_no ) ;

CREATE TABLE PROPERTY_OWNER 
    ( 
     owner_id  NUMBER (10)  NOT NULL , 
     auth_name VARCHAR2 (100)  NOT NULL , 
     street_id NUMBER (10)  NOT NULL , 
     street_no NUMBER (10)  NOT NULL , 
     po_id     NUMBER (10)  NOT NULL , 
     prop_id   NUMBER (10)  NOT NULL , 
     owner_id1 NUMBER (10)  NOT NULL 
    ) 
;

COMMENT ON COLUMN PROPERTY_OWNER.owner_id IS 'Owner identifier' 
;

COMMENT ON COLUMN PROPERTY_OWNER.auth_name IS 'Name of the local authority' 
;

COMMENT ON COLUMN PROPERTY_OWNER.street_id IS 'Street identifier' 
;

COMMENT ON COLUMN PROPERTY_OWNER.street_no IS 'Street number of the property' 
;

COMMENT ON COLUMN PROPERTY_OWNER.po_id IS 'Surrogate key for property owner' 
;

COMMENT ON COLUMN PROPERTY_OWNER.prop_id IS 'Surrogate key for property' 
;

COMMENT ON COLUMN PROPERTY_OWNER.owner_id1 IS 'Unique identifier for the owner' 
;

ALTER TABLE PROPERTY_OWNER 
    ADD CONSTRAINT PROPERTY_OWNER_PK PRIMARY KEY ( po_id ) ;

ALTER TABLE PROPERTY_OWNER 
    ADD CONSTRAINT PROPERTY_OWNER_NK UNIQUE ( owner_id , auth_name , street_id , street_no ) ;

CREATE TABLE STREET 
    ( 
     auth_name     VARCHAR2 (100)  NOT NULL , 
     street_id     NUMBER (10)  NOT NULL , 
     street_name   VARCHAR2 (100)  NOT NULL , 
     street_length NUMBER (10,2)  NOT NULL , 
     road_surface  VARCHAR2 (20)  NOT NULL , 
     num_lanes     NUMBER (2)  NOT NULL , 
     auth_name1    VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE STREET 
    ADD CONSTRAINT chk_road_surface 
    CHECK (road_surface IN ('Asphalt', 'Concrete', 'Unsealed')) 
;

COMMENT ON COLUMN STREET.auth_name IS 'Name of the local authority' 
;

COMMENT ON COLUMN STREET.street_id IS 'treet identifier within the local authority' 
;

COMMENT ON COLUMN STREET.street_name IS 'name of street' 
;

COMMENT ON COLUMN STREET.street_length IS 'Length of the street in meters' 
;

COMMENT ON COLUMN STREET.road_surface IS 'Type of road surface' 
;

COMMENT ON COLUMN STREET.num_lanes IS 'Number of lanes on the street' 
;

COMMENT ON COLUMN STREET.auth_name1 IS 'Name of the local authority, must be unique: authority name' 
;

ALTER TABLE STREET 
    ADD CONSTRAINT STREET_PK PRIMARY KEY ( auth_name, auth_name1 ) ;

CREATE TABLE TRUCK 
    ( 
     truck_vin   VARCHAR2 (20)  NOT NULL , 
     truck_rego  VARCHAR2 (10)  NOT NULL , 
     truck_make  VARCHAR2 (50)  NOT NULL , 
     truck_model VARCHAR2 (50)  NOT NULL , 
     truck_year  NUMBER (4)  NOT NULL 
    ) 
;

COMMENT ON COLUMN TRUCK.truck_vin IS 'Vehicle Identification Number of the truck' 
;

COMMENT ON COLUMN TRUCK.truck_rego IS 'Registration number of the truck' 
;

COMMENT ON COLUMN TRUCK.truck_make IS 'Make of the truck' 
;

COMMENT ON COLUMN TRUCK.truck_model IS 'Model of the truck' 
;

COMMENT ON COLUMN TRUCK.truck_year IS 'Year of manufacture of the truck' 
;

ALTER TABLE TRUCK 
    ADD CONSTRAINT TRUCK_PK PRIMARY KEY ( truck_vin ) ;

CREATE TABLE WASTE_TYPE 
    ( 
     waste_type_id   VARCHAR2 (100)  NOT NULL , 
     waste_type_desc VARCHAR2 (100)  NOT NULL 
    ) 
;

COMMENT ON COLUMN WASTE_TYPE.waste_type_id IS 'Unique identifier for the waste type' 
;

COMMENT ON COLUMN WASTE_TYPE.waste_type_desc IS 'Description of the waste type' 
;

ALTER TABLE WASTE_TYPE 
    ADD CONSTRAINT WASTE_TYPE_PK PRIMARY KEY ( waste_type_id ) ;

ALTER TABLE BIN_COLLECTION 
    ADD CONSTRAINT bin_bin_collection_fk FOREIGN KEY 
    ( 
     bin_rfid1
    ) 
    REFERENCES BIN 
    ( 
     bin_rfid
    ) 
;

ALTER TABLE CONTRACT_BIN_SUPPLY 
    ADD CONSTRAINT bin_type_cbs_fk FOREIGN KEY 
    ( 
     waste_type_id1,
     bin_size1
    ) 
    REFERENCES BIN_TYPE 
    ( 
     waste_type_id,
     bin_size
    ) 
;

ALTER TABLE BIN_COLLECTION 
    ADD CONSTRAINT collection_bin_collection_fk FOREIGN KEY 
    ( 
     coll_id
    ) 
    REFERENCES COLLECTION 
    ( 
     coll_id
    ) 
;

ALTER TABLE BIN 
    ADD CONSTRAINT contract_bin_supply_bin_fk FOREIGN KEY 
    ( 
     cbs_id
    ) 
    REFERENCES CONTRACT_BIN_SUPPLY 
    ( 
     cbs_id
    ) 
;

ALTER TABLE CONTRACT_WASTE 
    ADD CONSTRAINT contract_contract_waste_fk FOREIGN KEY 
    ( 
     cont_no1
    ) 
    REFERENCES CONTRACT 
    ( 
     cont_no
    ) 
;

ALTER TABLE CONTRACT_BIN_SUPPLY 
    ADD CONSTRAINT contract_waste_bin_supply_fk FOREIGN KEY 
    ( 
     cw_id
    ) 
    REFERENCES CONTRACT_WASTE 
    ( 
     cw_id
    ) 
;

ALTER TABLE CONTRACT 
    ADD CONSTRAINT local_authority_contract_fk FOREIGN KEY 
    ( 
     auth_name
    ) 
    REFERENCES LOCAL_AUTHORITY 
    ( 
     auth_name
    ) 
;

ALTER TABLE STREET 
    ADD CONSTRAINT local_authority_street_fk FOREIGN KEY 
    ( 
     auth_name1
    ) 
    REFERENCES LOCAL_AUTHORITY 
    ( 
     auth_name
    ) 
;

ALTER TABLE PROPERTY_OWNER 
    ADD CONSTRAINT owner_property_owner_fk FOREIGN KEY 
    ( 
     owner_id1
    ) 
    REFERENCES OWNER 
    ( 
     owner_id
    ) 
;

ALTER TABLE BIN 
    ADD CONSTRAINT property_bin_fk FOREIGN KEY 
    ( 
     prop_id
    ) 
    REFERENCES PROPERTY 
    ( 
     prop_id
    ) 
;

ALTER TABLE PROPERTY_OWNER 
    ADD CONSTRAINT property_property_owner_fk FOREIGN KEY 
    ( 
     prop_id
    ) 
    REFERENCES PROPERTY 
    ( 
     prop_id
    ) 
;

ALTER TABLE PROPERTY 
    ADD CONSTRAINT street_property_fk FOREIGN KEY 
    ( 
     auth_name1,
     auth_name11
    ) 
    REFERENCES STREET 
    ( 
     auth_name,
     auth_name1
    ) 
;

ALTER TABLE COLLECTION 
    ADD CONSTRAINT truck_collection_fk FOREIGN KEY 
    ( 
     truck_vin1
    ) 
    REFERENCES TRUCK 
    ( 
     truck_vin
    ) 
;

ALTER TABLE CONTRACT_WASTE 
    ADD CONSTRAINT waste_type_contract_waste_fk FOREIGN KEY 
    ( 
     waste_type_id1
    ) 
    REFERENCES WASTE_TYPE 
    ( 
     waste_type_id
    ) 
;



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             0
-- ALTER TABLE                             37
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
SPOOL OFF