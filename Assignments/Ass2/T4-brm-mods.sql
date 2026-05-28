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
