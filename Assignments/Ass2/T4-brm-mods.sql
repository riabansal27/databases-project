--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-brm-mods.sql

--Student ID: 34267433
--Student Name: Ria Bansal

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

--4(a)
-- Add quote_status (Y/N) and quote_not_assigned_reason columns to QUOTE table
-- quote_status: Y = assigned to a job, N = not assigned
-- quote_not_assigned_reason: reason if not assigned by preferred start date

ALTER TABLE quote ADD quote_status CHAR(1);
ALTER TABLE quote ADD quote_not_assigned_reason VARCHAR2(200);

-- Add column comments
COMMENT ON COLUMN quote.quote_status IS 'Whether quote has been assigned to a job: Y = assigned, N = not assigned';
COMMENT ON COLUMN quote.quote_not_assigned_reason IS 'Reason quote was not converted to a job by preferred start date';

-- Add check constraint for quote_status
ALTER TABLE quote ADD CONSTRAINT quote_status_ck CHECK (quote_status IN ('Y', 'N'));

-- Initialise quote_status based on current data
-- Y if a job exists for this quote, N if no job exists
UPDATE quote
SET quote_status = CASE
    WHEN EXISTS (SELECT 1 FROM job WHERE job.quote_no = quote.quote_no)
    THEN 'Y'
    ELSE 'N'
END;

COMMIT;

-- Show structural changes
DESC quote;

-- Show data changes
SELECT quote_no, quote_status, quote_not_assigned_reason
FROM quote
ORDER BY quote_no;

--4(b)

-- Each truck needs regular services
-- SERVICE table stores service start and end date/time per truck
-- SERVICE_TASK table stores individual tasks within a service

-- Create SERVICE table
CREATE TABLE service (
    service_id        NUMERIC(5) NOT NULL,
    truck_vin         CHAR(17) NOT NULL,
    service_start_dt  DATE NOT NULL,
    service_end_dt    DATE
);

COMMENT ON COLUMN service.service_id IS 'Identifier for service';
COMMENT ON COLUMN service.truck_vin IS 'Truck being serviced';
COMMENT ON COLUMN service.service_start_dt IS 'Start date and time of service';
COMMENT ON COLUMN service.service_end_dt IS 'End date and time of service';

ALTER TABLE service ADD CONSTRAINT service_pk PRIMARY KEY (service_id);
ALTER TABLE service ADD CONSTRAINT service_truck_fk FOREIGN KEY (truck_vin)
    REFERENCES truck (truck_vin);

-- Create SERVICE_TASK table
CREATE TABLE service_task_type (
    task_type_code  VARCHAR2(10) NOT NULL,
    task_type_desc  VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN service_task_type.task_type_code IS 'Identifier for service task type';
COMMENT ON COLUMN service_task_type.task_type_desc IS 'Description of the service task type';

ALTER TABLE service_task_type ADD CONSTRAINT service_task_type_pk PRIMARY KEY (task_type_code);

-- Create SERVICE_TASK table linking service to task type and mechanic
CREATE TABLE service_task (
    service_task_id  NUMERIC(5) NOT NULL,
    service_id       NUMERIC(5) NOT NULL,
    task_type_code   VARCHAR2(10) NOT NULL,
    emp_no           NUMERIC(3) NOT NULL,
    task_note        VARCHAR2(200)
);

COMMENT ON COLUMN service_task.service_task_id IS 'Identifier for service task';
COMMENT ON COLUMN service_task.service_id IS 'Service this task belongs to';
COMMENT ON COLUMN service_task.task_type_code IS 'Type of service task performed';
COMMENT ON COLUMN service_task.emp_no IS 'Mechanic who performed the task';
COMMENT ON COLUMN service_task.task_note IS 'Free text note explaining the task';

ALTER TABLE service_task ADD CONSTRAINT service_task_pk PRIMARY KEY (service_task_id);
ALTER TABLE service_task ADD CONSTRAINT service_task_service_fk FOREIGN KEY (service_id)
    REFERENCES service (service_id);
ALTER TABLE service_task ADD CONSTRAINT service_task_type_fk FOREIGN KEY (task_type_code)
    REFERENCES service_task_type (task_type_code);
ALTER TABLE service_task ADD CONSTRAINT service_task_mechanic_fk FOREIGN KEY (emp_no)
    REFERENCES employee (emp_no);

DESC service;
DESC service_task_type;
DESC service_task; 