--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T5-brm-plsql.sql

--Student ID: 34267433
--Student Name: Ria Bansal

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

/* do not remove these set set serveroutput and set echo commands*/
SET SERVEROUTPUT ON
SET ECHO ON
/* end of do not remove*/



--(a)
-- Function to return the role of an employee given their employee number
-- Returns B, T, M or D, or NULL if employee does not exist
CREATE OR REPLACE FUNCTION get_emp_role(p_emp_no IN NUMBER)
RETURN CHAR
IS
    v_role CHAR(1);
BEGIN
    SELECT emp_role
    INTO v_role
    FROM employee
    WHERE emp_no = p_emp_no;
    
    RETURN v_role;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

-- Write Test Harness for (a)
-- Test 1: Valid manager - should return 'B' for Sarah Mitchell (emp_no 10)
SELECT get_emp_role(10) AS emp_role FROM dual;

-- Test 2: Valid driver - should return 'D' for Michael Johnson (emp_no 15)
SELECT get_emp_role(15) AS emp_role FROM dual;

-- Test 3: Invalid employee - should return NULL
SELECT get_emp_role(999) AS emp_role FROM dual;



--(b)
-- Trigger to enforce business rules when inserting a new employee
-- Rules enforced:
-- 1. Managers (B) must have NULL manager (report to business owner)
-- 2. Non-managers must have a valid manager assigned
-- 3. The assigned manager must have role B
-- 4. Only drivers (D) can have a licence number
-- 5. Non-drivers must have NULL licence number
-- 6. emp_role must be valid (B, T, M, D) - already enforced by check constraint

CREATE OR REPLACE TRIGGER trg_employee_insert
BEFORE INSERT ON employee
FOR EACH ROW
DECLARE
    v_manager_role CHAR(1);
BEGIN
    -- Rule 1: Managers must report to NULL (business owner)
    IF :NEW.emp_role = 'B' AND :NEW.emp_no_manager IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Error: Managers must report to the business owner (manager field must be NULL)');
    END IF;
    
    -- Rule 2: Non-managers must have a manager assigned
    IF :NEW.emp_role != 'B' AND :NEW.emp_no_manager IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 
            'Error: Non-manager employees must be assigned to a manager');
    END IF;
    
    -- Rule 3: The assigned manager must have role B
    IF :NEW.emp_no_manager IS NOT NULL THEN
        v_manager_role := get_emp_role(:NEW.emp_no_manager);
        IF v_manager_role IS NULL THEN
            RAISE_APPLICATION_ERROR(-20003, 
                'Error: The assigned manager does not exist');
        END IF;
        IF v_manager_role != 'B' THEN
            RAISE_APPLICATION_ERROR(-20004, 
                'Error: The assigned manager must have role B (Manager)');
        END IF;
    END IF;
    
    -- Rule 4: Only drivers can have a licence number
    IF :NEW.emp_role != 'D' AND :NEW.emp_licenceno IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20005, 
            'Error: Only drivers can have a licence number');
    END IF;
    
    -- Rule 5: Drivers must have a licence number
    IF :NEW.emp_role = 'D' AND :NEW.emp_licenceno IS NULL THEN
        RAISE_APPLICATION_ERROR(-20006, 
            'Error: Drivers must have a licence number');
    END IF;
    
END;
/

-- Write Test Harness for (b)
-- Test 1: Valid manager insert - should succeed
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (90, 'Test', 'Manager', '0411000001', NULL, 'B', NULL);
ROLLBACK;

-- Test 2: Manager with manager assigned - should fail with error 20001
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (91, 'Bad', 'Manager', '0411000002', NULL, 'B', 10);
ROLLBACK;

-- Test 3: Non-manager with no manager assigned - should fail with error 20002
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (92, 'Bad', 'Dispatcher', '0411000003', NULL, 'T', NULL);
ROLLBACK;

-- Test 4: Non-manager assigned to non-manager - should fail with error 20004
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (93, 'Bad', 'Driver', '0411000004', 'DRV99999999', 'D', 12);
ROLLBACK;

-- Test 5: Non-driver with licence number - should fail with error 20005
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (94, 'Bad', 'Mechanic', '0411000005', 'DRV99999999', 'M', 10);
ROLLBACK;

-- Test 6: Driver without licence number - should fail with error 20006
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (95, 'Bad', 'Driver', '0411000006', NULL, 'D', 10);
ROLLBACK;

-- Test 7: Valid driver insert - should succeed
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (96, 'Good', 'Driver', '0411000007', 'DRV88888888', 'D', 10);
ROLLBACK;



--(c)
-- Stored procedure to handle job assignment
-- Validates all business rules before inserting a new job
-- Parameters: quote_no, driver_no, dispatcher_no, truck_vin, trailer_code,
--             job_cost, job_payment, pickup_dt, job_duration(hours), output message

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
    v_quote_count     NUMBER;
    v_job_count       NUMBER;
    v_driver_role     CHAR(1);
    v_dispatcher_role CHAR(1);
    v_combo_count     NUMBER;
    v_new_job_no      NUMBER;
    v_quote_cost      NUMBER;

BEGIN
    -- Check 1: Quote must exist
    SELECT COUNT(*) INTO v_quote_count
    FROM quote
    WHERE quote_no = p_quote_no;
    
    IF v_quote_count = 0 THEN
        p_output := 'Error: Quote ' || p_quote_no || ' does not exist';
        RETURN;
    END IF;
    
    -- Check 2: Quote must not already be assigned to a job
    SELECT COUNT(*) INTO v_job_count
    FROM job
    WHERE quote_no = p_quote_no;
    
    IF v_job_count > 0 THEN
        p_output := 'Error: Quote ' || p_quote_no || ' has already been assigned to a job';
        RETURN;
    END IF;
    
    -- Check 3: Driver must exist and have role D
    v_driver_role := get_emp_role(p_driver_no);
    
    IF v_driver_role IS NULL THEN
        p_output := 'Error: Driver ' || p_driver_no || ' does not exist';
        RETURN;
    END IF;
    
    IF v_driver_role != 'D' THEN
        p_output := 'Error: Employee ' || p_driver_no || ' is not a driver';
        RETURN;
    END IF;
    
    -- Check 4: Dispatcher must exist and have role T
    v_dispatcher_role := get_emp_role(p_dispatcher_no);
    
    IF v_dispatcher_role IS NULL THEN
        p_output := 'Error: Dispatcher ' || p_dispatcher_no || ' does not exist';
        RETURN;
    END IF;
    
    IF v_dispatcher_role != 'T' THEN
        p_output := 'Error: Employee ' || p_dispatcher_no || ' is not a truck dispatcher';
        RETURN;
    END IF;
    
    -- Check 5: Truck and trailer combination must exist
    SELECT COUNT(*) INTO v_combo_count
    FROM combination
    WHERE truck_vin = p_truck_vin
    AND trailer_code = p_trailer_code;
    
    IF v_combo_count = 0 THEN
        p_output := 'Error: Truck ' || p_truck_vin || ' and trailer ' || p_trailer_code || ' is not a valid combination';
        RETURN;
    END IF;
    
    -- Get quote cost for job_cost logic
    SELECT quote_cost INTO v_quote_cost
    FROM quote
    WHERE quote_no = p_quote_no;
    
    -- All checks passed - insert the job
    -- job_cost is NULL if same as quote cost, otherwise use provided value
    SELECT job_seq.NEXTVAL INTO v_new_job_no FROM dual;
    
    INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost,
                     job_payment_made, quote_no, sched_emp_no, driver_emp_no,
                     trailer_code, truck_vin)
    VALUES (v_new_job_no,
            p_job_pickup_dt,
            p_job_pickup_dt + (p_job_duration/24),
            CASE WHEN p_job_cost = v_quote_cost THEN NULL ELSE p_job_cost END,
            p_job_payment,
            p_quote_no,
            p_dispatcher_no,
            p_driver_no,
            p_trailer_code,
            p_truck_vin);
    
    COMMIT;
    
    p_output := 'Success: Job ' || v_new_job_no || ' created successfully for quote ' || p_quote_no;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_output := 'Error: Unexpected error - ' || SQLERRM;
END;
/

-- Write Test Harness for (c)
-- Test 1: Valid job assignment - should succeed

DECLARE
    v_msg VARCHAR2(200);
BEGIN
    prc_entry_job(42, 15, 12, '1HGBH41JXMN109186', 'TRL01', NULL, 'Y',
                  TO_DATE('01-Jun-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 5, v_msg);
    DBMS_OUTPUT.PUT_LINE('Test 1: ' || v_msg);
END;
/

-- Clean up Test 1 job so test can be rerun
DELETE FROM job WHERE quote_no = 42;
COMMIT;


-- Test 2: Quote does not exist - should fail
DECLARE
    v_msg VARCHAR2(200);
BEGIN
    prc_entry_job(999, 15, 12, '1HGBH41JXMN109186', 'TRL01', NULL, 'Y',
                  TO_DATE('02-Jun-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 5, v_msg);
    DBMS_OUTPUT.PUT_LINE('Test 2: ' || v_msg);
END;
/

-- Test 3: Quote already assigned to a job - should fail
DECLARE
    v_msg VARCHAR2(200);
BEGIN
    prc_entry_job(20, 15, 12, '1HGBH41JXMN109186', 'TRL01', NULL, 'Y',
                  TO_DATE('03-Jun-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 5, v_msg);
    DBMS_OUTPUT.PUT_LINE('Test 3: ' || v_msg);
END;
/

-- Test 4: Employee is not a driver - should fail
DECLARE
    v_msg VARCHAR2(200);
BEGIN
    prc_entry_job(41, 12, 12, '1HGBH41JXMN109186', 'TRL01', NULL, 'Y',
                  TO_DATE('04-Jun-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 5, v_msg);
    DBMS_OUTPUT.PUT_LINE('Test 4: ' || v_msg);
END;
/

-- Test 5: Employee is not a dispatcher - should fail
DECLARE
    v_msg VARCHAR2(200);
BEGIN
    prc_entry_job(42, 15, 15, '1HGBH41JXMN109186', 'TRL01', NULL, 'Y',
                  TO_DATE('05-Jun-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 5, v_msg);
    DBMS_OUTPUT.PUT_LINE('Test 5: ' || v_msg);
END;
/

-- Test 6: Invalid truck trailer combination - should fail
DECLARE
    v_msg VARCHAR2(200);
BEGIN
    prc_entry_job(43, 15, 12, '1HGBH41JXMN109186', 'TRL09', NULL, 'Y',
                  TO_DATE('06-Jun-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 5, v_msg);
    DBMS_OUTPUT.PUT_LINE('Test 6: ' || v_msg);
END;
/


/* do not add any further set serveroutput and set echo commands in this file */