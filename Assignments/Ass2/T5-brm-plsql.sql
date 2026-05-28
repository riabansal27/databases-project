--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T5-brm-plsql.sql

--Student ID:
--Student Name:

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

/* do not remove these set set serveroutput and set echo commands*/
SET SERVEROUTPUT ON
SET ECHO ON
/* end of do not remove*/


--(a)
-- Write your create function statemet,
-- finish it with a slash(/) followed by a blank line


-- Write Test Harness for (a)



--(b)
-- Write your create trigger statement,
-- finish it with a slash(/) followed by a blank line


-- Write Test Harness for (b)


--(c)
-- Complete the following create procedure statement
-- do not change the name and/or the order of the parameters
-- finish it with a slash(/) followed by a blank line

CREATE OR REPLACE PROCEDURE prc_entry_job(
p_quote_no IN NUMBER,
p_driver_no IN NUMBER,
p_dispatcher_no IN NUMBER,
p_truck_vin IN VARCHAR2,
p_trailer_code IN CHAR,
p_job_cost IN NUMBER,
p_job_payment IN CHAR,
p_job_pickup_dt IN DATE,
p_job_duration IN NUMBER,
p_output OUT VARCHAR2)
IS

BEGIN

END;
/

-- Write Test Harness for (c)





/* do not add any further set serveroutput and set echo commands in this file */