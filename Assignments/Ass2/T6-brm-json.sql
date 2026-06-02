/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T6-brm-json.sql

--Student ID:34267433
--Student Name: Ria Bansal

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

SET PAGESIZE 100
SET WRAP OFF
SET HEADING OFF

-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

-- Task 6(a): Generate JSON documents for each customer who has at least one quote
-- Each document represents a customer and their quotes with job statistics

-- Generates one JSON document per customer who has at least one quote
-- Includes customer details, statistics, and all their quotes with job info

SELECT
    JSON_OBJECT(
        '_id' VALUE c.cust_no,
        'customer_name' VALUE 
            CASE 
                WHEN c.cust_gname IS NOT NULL AND c.cust_fname IS NOT NULL 
                    THEN c.cust_gname || ' ' || c.cust_fname
                WHEN c.cust_gname IS NOT NULL AND c.cust_fname IS NULL 
                    THEN c.cust_gname
                WHEN c.cust_gname IS NULL AND c.cust_fname IS NOT NULL 
                    THEN c.cust_fname
                ELSE '-'
            END,
        'customer_business' VALUE 
            CASE WHEN c.cust_bname IS NOT NULL THEN c.cust_bname ELSE '-' END,
        'customer_address' VALUE 
            c.cust_street || ', ' || c.cust_town || ', ' || c.cust_pcode,
        'customer_phone' VALUE c.cust_contact_no,
        'customer_stats' VALUE JSON_OBJECT(
            'number_of_quotes' VALUE COUNT(DISTINCT q.quote_no),
            'number_of_jobs' VALUE COUNT(DISTINCT j.job_no),
            'total_paid_jobcost' VALUE 
                CASE 
                    WHEN SUM(CASE WHEN j.job_payment_made = 'Y' 
                        THEN NVL(j.job_cost, q.quote_cost) ELSE 0 END) = 0 
                    THEN '-'
                    ELSE '$' || TO_CHAR(SUM(CASE WHEN j.job_payment_made = 'Y' 
                        THEN NVL(j.job_cost, q.quote_cost) ELSE 0 END), 'FM999990.00')
                END,
            'total_unpaid_jobcost' VALUE 
                CASE 
                    WHEN SUM(CASE WHEN j.job_payment_made = 'N' 
                        THEN NVL(j.job_cost, q.quote_cost) ELSE 0 END) = 0 
                    THEN '-'
                    ELSE '$' || TO_CHAR(SUM(CASE WHEN j.job_payment_made = 'N' 
                        THEN NVL(j.job_cost, q.quote_cost) ELSE 0 END), 'FM999990.00')
                END
        ),
        'quotes' VALUE JSON_ARRAYAGG(
            JSON_OBJECT(
                'quote_no' VALUE q.quote_no,
                'quote_prepared_on' VALUE 
                    TO_CHAR(q.quote_prepared_date, 'dd-Mon-yyyy'),
                'preferred_start_date' VALUE 
                    TO_CHAR(q.quote_pref_start_date, 'dd-Mon-yyyy'),
                'start_location' VALUE q.quote_start_location,
                'end_location' VALUE q.quote_end_location,
                'quote_cost' VALUE '$' || TO_CHAR(q.quote_cost, 'FM999990.00'),
                'assigned_to_job' VALUE 
                    CASE WHEN j.job_no IS NOT NULL THEN 'Y' ELSE 'N' END,
                'job_cost' VALUE 
                    CASE 
                        WHEN j.job_no IS NULL THEN '-'
                        ELSE '$' || TO_CHAR(NVL(j.job_cost, q.quote_cost), 'FM999990.00')
                    END
            ) ORDER BY q.quote_no
        ) FORMAT JSON
    ) || ','
FROM customer c
JOIN quote q ON c.cust_no = q.cust_no
LEFT JOIN job j ON q.quote_no = j.quote_no
GROUP BY 
    c.cust_no,
    c.cust_gname,
    c.cust_fname,
    c.cust_bname,
    c.cust_street,
    c.cust_town,
    c.cust_pcode,
    c.cust_contact_no
ORDER BY c.cust_no;