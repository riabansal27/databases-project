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



--3(c)
-- Insert quote prepared by Aurello Brown for customer VICTORIA ELLA (Flintstone Store)
-- Quote prepared 17 May 2026, preferred start 25 May 2026
-- From 29 Kuranda Road, Adelaide SA 5030 to 9 Albatros Drive, Mount Gambier SA 5270
-- Quoted cost $1000

INSERT INTO quote (quote_no, quote_prepared_date, quote_pref_start_date, quote_start_location, quote_end_location, quote_cost, cust_no, emp_no)
VALUES (
    quote_seq.NEXTVAL,
    TO_DATE('17-May-2026', 'dd-Mon-yyyy'),
    TO_DATE('25-May-2026', 'dd-Mon-yyyy'),
    '29 Kuranda Road, Adelaide SA 5030',
    '9 Albatros Drive, Mount Gambier SA 5270',
    1000.00,
    (SELECT cust_no FROM customer
     WHERE UPPER(cust_gname) = UPPER('VICTORIA')
     AND UPPER(cust_fname) = UPPER('ELLA')
     AND UPPER(cust_bname) = UPPER('Flintstone Store')),
    (SELECT emp_no FROM employee
     WHERE UPPER(emp_gname) = UPPER('Aurello')
     AND UPPER(emp_fname) = UPPER('Brown'))
);

-- Pickup 9 AM on 25 May 2026, duration 5 hours so dropoff 2 PM
-- Driver Michael Johnson, Truck 1HGBH41JXMN109186, Trailer TRL08
-- Payment made (Y), dispatcher is Aurello Brown

INSERT INTO job (job_no, job_pickup_dt, job_intended_dropoff_dt, job_cost, job_payment_made, quote_no, sched_emp_no, driver_emp_no, trailer_code, truck_vin)
VALUES (
    job_seq.NEXTVAL,
    TO_DATE('25-May-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'),
    TO_DATE('25-May-2026 14:00:00', 'dd-Mon-yyyy hh24:mi:ss'),
    NULL,
    'Y',
    (SELECT quote_no FROM quote
     WHERE quote_prepared_date = TO_DATE('17-May-2026', 'dd-Mon-yyyy')
     AND cust_no = (SELECT cust_no FROM customer
    WHERE UPPER(cust_gname) = UPPER('VICTORIA')
    AND UPPER(cust_fname) = UPPER('ELLA') AND UPPER(cust_bname) = UPPER('Flintstone Store'))),
    (SELECT emp_no FROM employee
     WHERE UPPER(emp_gname) = UPPER('Aurello')
     AND UPPER(emp_fname) = UPPER('Brown')),
    (SELECT emp_no FROM employee
     WHERE UPPER(emp_gname) = UPPER('Michael')
     AND UPPER(emp_fname) = UPPER('Johnson')
     AND emp_role = 'D'),
    'TRL08',
    '1HGBH41JXMN109186'
);

COMMIT;



--3(d)
-- On 20 May 2026, VICTORIA ELLA called to shift pickup from 9 AM to 2 PM on 25 May 2026
-- Job cost is 20% higher than quoted cost ($1000 * 1.20 = $1200)
-- Victoria agreed and paid the gap

UPDATE job
SET job_pickup_dt = TO_DATE('25-May-2026 14:00:00', 'dd-Mon-yyyy hh24:mi:ss'),
job_intended_dropoff_dt = TO_DATE('25-May-2026 19:00:00', 'dd-Mon-yyyy hh24:mi:ss'),
job_cost = (SELECT quote_cost * 1.20 FROM quote
WHERE quote_no = job.quote_no),
job_payment_made = 'Y'
WHERE quote_no = (SELECT quote_no FROM quote
WHERE quote_prepared_date = TO_DATE('17-May-2026', 'dd-Mon-yyyy')
AND cust_no = (SELECT cust_no FROM customer
WHERE UPPER(cust_gname) = UPPER('VICTORIA')
AND UPPER(cust_fname) = UPPER('ELLA') AND UPPER(cust_bname) = UPPER('Flintstone Store')));

COMMIT;

--3(e)

