--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T1-brm-schema.sql

--Student ID: 34267433
--Student Name: Ria Bansal

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/


/* drop table statements - do not remove*/

DROP TABLE employee CASCADE CONSTRAINTS PURGE;
DROP TABLE job CASCADE CONSTRAINTS PURGE;
DROP TABLE quote CASCADE CONSTRAINTS PURGE;

-- Create EMPLOYEE table
CREATE TABLE employee (
    emp_no          NUMERIC(3) NOT NULL,
    emp_gname       VARCHAR2(30),
    emp_fname       VARCHAR2(30),
    emp_contact_no  CHAR(10) NOT NULL,
    emp_licenceno   VARCHAR2(11),
    emp_role        CHAR(1) NOT NULL,
    emp_no_manager  NUMERIC(3)
);

COMMENT ON COLUMN employee.emp_no IS 'Identifier for employee';
COMMENT ON COLUMN employee.emp_gname IS 'Employee given name';
COMMENT ON COLUMN employee.emp_fname IS 'Employee family name';
COMMENT ON COLUMN employee.emp_contact_no IS 'Employee contact number';
COMMENT ON COLUMN employee.emp_licenceno IS 'Employee licence number - only for drivers';
COMMENT ON COLUMN employee.emp_role IS 'Employee role: B=Manager, T=Truck Dispatcher, M=Mechanic, D=Driver';
COMMENT ON COLUMN employee.emp_no_manager IS 'Manager employee number this employee reports to';

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY (emp_no);
ALTER TABLE employee ADD CONSTRAINT employee_role_ck CHECK (emp_role IN ('B','T','M','D'));
ALTER TABLE employee ADD CONSTRAINT employee_manager_fk FOREIGN KEY (emp_no_manager) REFERENCES employee (emp_no);

-- Create QUOTE table
CREATE TABLE quote (
    quote_no             NUMERIC(5) NOT NULL,
    quote_prepared_date  DATE NOT NULL,
    quote_pref_start_date DATE NOT NULL,
    quote_start_location VARCHAR2(50) NOT NULL,
    quote_end_location   VARCHAR2(60) NOT NULL,
    quote_cost           NUMERIC(6,2) NOT NULL,
    cust_no              NUMERIC(4) NOT NULL,
    emp_no               NUMERIC(3) NOT NULL
);

COMMENT ON COLUMN quote.quote_no IS 'Identifier for quote';
COMMENT ON COLUMN quote.quote_prepared_date IS 'Date the quote was prepared';
COMMENT ON COLUMN quote.quote_pref_start_date IS 'Preferred start date for the quote';
COMMENT ON COLUMN quote.quote_start_location IS 'Start location for the quote';
COMMENT ON COLUMN quote.quote_end_location IS 'End location for the quote';
COMMENT ON COLUMN quote.quote_cost IS 'Quoted cost';
COMMENT ON COLUMN quote.cust_no IS 'Customer who requested the quote';
COMMENT ON COLUMN quote.emp_no IS 'Truck dispatcher who prepared the quote';

ALTER TABLE quote ADD CONSTRAINT quote_pk PRIMARY KEY (quote_no);
ALTER TABLE quote ADD CONSTRAINT quote_customer_fk FOREIGN KEY (cust_no) REFERENCES customer (cust_no);
ALTER TABLE quote ADD CONSTRAINT quote_employee_fk FOREIGN KEY (emp_no) REFERENCES employee (emp_no);

-- Create JOB table
CREATE TABLE job (
    job_no                  NUMERIC(5) NOT NULL,
    job_pickup_dt           DATE NOT NULL,
    job_intended_dropoff_dt DATE NOT NULL,
    job_cost                NUMERIC(6,2),
    job_payment_made        CHAR(1) NOT NULL,
    quote_no                NUMERIC(5) NOT NULL,
    sched_emp_no            NUMERIC(3) NOT NULL,
    driver_emp_no           NUMERIC(3) NOT NULL,
    trailer_code            CHAR(5) NOT NULL,
    truck_vin               CHAR(17) NOT NULL
);

COMMENT ON COLUMN job.job_no IS 'Identifier for job';
COMMENT ON COLUMN job.job_pickup_dt IS 'Job scheduled pick up date and time';
COMMENT ON COLUMN job.job_intended_dropoff_dt IS 'Job intended drop-off date and time';
COMMENT ON COLUMN job.job_cost IS 'Actual job cost if different from quote cost';
COMMENT ON COLUMN job.job_payment_made IS 'Whether the job has been paid: Y or N';
COMMENT ON COLUMN job.quote_no IS 'Quote this job is based on';
COMMENT ON COLUMN job.sched_emp_no IS 'Truck dispatcher who scheduled the job';
COMMENT ON COLUMN job.driver_emp_no IS 'Driver assigned to the job';
COMMENT ON COLUMN job.trailer_code IS 'Trailer assigned to the job';
COMMENT ON COLUMN job.truck_vin IS 'Truck assigned to the job';

ALTER TABLE job ADD CONSTRAINT job_pk PRIMARY KEY (job_no);
ALTER TABLE job ADD CONSTRAINT job_payment_ck CHECK (job_payment_made IN ('Y','N'));
ALTER TABLE job ADD CONSTRAINT job_quote_fk FOREIGN KEY (quote_no) REFERENCES quote (quote_no);
ALTER TABLE job ADD CONSTRAINT job_scheduler_fk FOREIGN KEY (sched_emp_no) REFERENCES employee (emp_no);
ALTER TABLE job ADD CONSTRAINT job_driver_fk FOREIGN KEY (driver_emp_no) REFERENCES employee (emp_no);
ALTER TABLE job ADD CONSTRAINT job_combination_fk FOREIGN KEY (trailer_code, truck_vin) REFERENCES combination (trailer_code, truck_vin);