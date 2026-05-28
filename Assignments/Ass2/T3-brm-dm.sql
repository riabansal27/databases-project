--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-brm-dm.sql

--Student ID: 34267433
--Student Name: Ria Bansal

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

--3(a)
DROP SEQUENCE emp_seq;
DROP SEQUENCE quote_seq;
DROP SEQUENCE job_seq;

-- Create sequences for EMPLOYEE, QUOTE and JOB primary keys
-- Starting at 300, incrementing by 5
CREATE SEQUENCE emp_seq START WITH 300 INCREMENT BY 5;
CREATE SEQUENCE quote_seq START WITH 300 INCREMENT BY 5;
CREATE SEQUENCE job_seq START WITH 300 INCREMENT BY 5;

--3(b)
-- Insert new employee Aurello Brown as Truck Dispatcher
-- assigned to manager Sarah Mitchell
-- Started 15 May 2026
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (
    emp_seq.NEXTVAL,
    'Aurello',
    'Brown',
    '0431952053',
    NULL,
    'T',
    (SELECT emp_no FROM employee
     WHERE UPPER(emp_gname) = UPPER('Sarah')
     AND UPPER(emp_fname) = UPPER('Mitchell')
     AND emp_role = 'B')
);

COMMIT;


--3(d)


--3(e)

