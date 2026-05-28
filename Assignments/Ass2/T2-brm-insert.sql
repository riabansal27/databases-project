/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-brm-insert.sql

--Student ID: 34267433
--Student Name: Ria Bansal

/*
Indicate if AI was used (Yes/No): Yes

If AI was used:
I used Gemini Large Language Model
I used these prompts:
"Generate 10 employee inserts, 30 quote inserts, and 20 job inserts matching the exact integrity constraints, preloaded master lookup IDs, strict dd-Mon-yyyy date formats, and explicit cardinality rules for Task 2 ensuring all PK values stay below 100."
*/

-- All inserts treated as a single transaction
-- setting up initial test state for the database

--------------------------------------
--INSERT INTO employee
--------------------------------------
-- Managers report to business owner (NULL)
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (10, 'Sarah', 'Mitchell', '0411111111', NULL, 'B', NULL);
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (11, 'David', 'Miller', '0422222222', NULL, 'B', NULL);

-- Truck Dispatchers report to Sarah Mitchell (10)
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (12, 'Alice', 'Jones', '0433333333', NULL, 'T', 10);
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (13, 'Bob', 'Brown', '0444444444', NULL, 'T', 10);

-- Mechanic reports to David Miller (11)
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (14, 'Charlie', 'Green', '0455555555', NULL, 'M', 11);

-- Drivers must have licence numbers
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (15, 'Michael', 'Johnson', '0477777777', 'DRV10000001', 'D', 10);
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (16, 'Fiona', 'Gray', '0488888888', 'DRV10000002', 'D', 10);
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (17, 'George', 'Blue', '0499999999', 'DRV10000003', 'D', 11);
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (18, 'Hannah', 'Pink', '0400000000', 'DRV10000004', 'D', 11);
INSERT INTO employee (emp_no, emp_gname, emp_fname, emp_contact_no, emp_licenceno, emp_role, emp_no_manager)
VALUES (19, 'James', 'White', '0411222333', 'DRV10000005', 'D', 11);

--------------------------------------
--INSERT INTO quote
--------------------------------------
-- Customer 1 quotes (6 quotes)
INSERT INTO quote VALUES (20, TO_DATE('01-May-2026', 'dd-Mon-yyyy'), TO_DATE('10-May-2026', 'dd-Mon-yyyy'), '55 Lonsdale Street, Melbourne', 'Caulfield VIC 3162', 1200.00, 1, 12);
INSERT INTO quote VALUES (21, TO_DATE('02-May-2026', 'dd-Mon-yyyy'), TO_DATE('12-May-2026', 'dd-Mon-yyyy'), 'Melbourne CBD VIC 3000', 'St Kilda VIC 3182', 850.00, 1, 12);
INSERT INTO quote VALUES (22, TO_DATE('03-May-2026', 'dd-Mon-yyyy'), TO_DATE('15-May-2026', 'dd-Mon-yyyy'), 'Dandenong VIC 3175', 'Frankston VIC 3199', 1500.00, 1, 13);
INSERT INTO quote VALUES (23, TO_DATE('04-May-2026', 'dd-Mon-yyyy'), TO_DATE('18-May-2026', 'dd-Mon-yyyy'), 'Geelong VIC 3220', 'Ballarat VIC 3350', 2200.00, 1, 13);
INSERT INTO quote VALUES (24, TO_DATE('05-May-2026', 'dd-Mon-yyyy'), TO_DATE('20-May-2026', 'dd-Mon-yyyy'), 'Richmond VIC 3121', 'Hawthorn VIC 3122', 600.00, 1, 12);
INSERT INTO quote VALUES (25, TO_DATE('06-May-2026', 'dd-Mon-yyyy'), TO_DATE('22-May-2026', 'dd-Mon-yyyy'), 'Sunshine VIC 3020', 'Footscray VIC 3011', 750.00, 1, 12);

-- Customer 2 quotes (6 quotes)
INSERT INTO quote VALUES (26, TO_DATE('01-May-2026', 'dd-Mon-yyyy'), TO_DATE('11-May-2026', 'dd-Mon-yyyy'), 'Preston VIC 3072', 'Reservoir VIC 3073', 550.00, 2, 13);
INSERT INTO quote VALUES (27, TO_DATE('02-May-2026', 'dd-Mon-yyyy'), TO_DATE('14-May-2026', 'dd-Mon-yyyy'), 'Epping VIC 3076', 'Craigieburn VIC 3064', 900.00, 2, 12);
INSERT INTO quote VALUES (28, TO_DATE('03-May-2026', 'dd-Mon-yyyy'), TO_DATE('16-May-2026', 'dd-Mon-yyyy'), 'Werribee VIC 3030', 'Hoppers Crossing VIC 3029', 650.00, 2, 12);
INSERT INTO quote VALUES (29, TO_DATE('04-May-2026', 'dd-Mon-yyyy'), TO_DATE('19-May-2026', 'dd-Mon-yyyy'), 'Sunbury VIC 3429', 'Melton VIC 3337', 1100.00, 2, 13);
INSERT INTO quote VALUES (30, TO_DATE('05-May-2026', 'dd-Mon-yyyy'), TO_DATE('21-May-2026', 'dd-Mon-yyyy'), 'Glen Waverley VIC 3150', 'Wheelers Hill VIC 3150', 580.00, 2, 13);
INSERT INTO quote VALUES (31, TO_DATE('06-May-2026', 'dd-Mon-yyyy'), TO_DATE('24-May-2026', 'dd-Mon-yyyy'), 'Springvale VIC 3171', 'Noble Park VIC 3174', 700.00, 2, 12);

-- Customer 3 quotes (6 quotes)
INSERT INTO quote VALUES (32, TO_DATE('02-May-2026', 'dd-Mon-yyyy'), TO_DATE('12-May-2026', 'dd-Mon-yyyy'), 'Coburg VIC 3058', 'Brunswick VIC 3056', 620.00, 3, 12);
INSERT INTO quote VALUES (33, TO_DATE('03-May-2026', 'dd-Mon-yyyy'), TO_DATE('14-May-2026', 'dd-Mon-yyyy'), 'Kew VIC 3101', 'Camberwell VIC 3124', 800.00, 3, 13);
INSERT INTO quote VALUES (34, TO_DATE('04-May-2026', 'dd-Mon-yyyy'), TO_DATE('17-May-2026', 'dd-Mon-yyyy'), 'Malvern VIC 3144', 'Toorak VIC 3142', 750.00, 3, 12);
INSERT INTO quote VALUES (35, TO_DATE('05-May-2026', 'dd-Mon-yyyy'), TO_DATE('20-May-2026', 'dd-Mon-yyyy'), 'Doncaster VIC 3108', 'Manningham VIC 3109', 920.00, 3, 13);
INSERT INTO quote VALUES (36, TO_DATE('06-May-2026', 'dd-Mon-yyyy'), TO_DATE('22-May-2026', 'dd-Mon-yyyy'), 'Essendon VIC 3040', 'Moonee Ponds VIC 3039', 640.00, 3, 12);
INSERT INTO quote VALUES (37, TO_DATE('07-May-2026', 'dd-Mon-yyyy'), TO_DATE('26-May-2026', 'dd-Mon-yyyy'), 'Carlton VIC 3053', 'Fitzroy VIC 3065', 510.00, 3, 13);

-- Customer 4 quotes (6 quotes)
INSERT INTO quote VALUES (38, TO_DATE('03-May-2026', 'dd-Mon-yyyy'), TO_DATE('13-May-2026', 'dd-Mon-yyyy'), 'Moorabbin VIC 3189', 'Brighton VIC 3186', 880.00, 4, 13);
INSERT INTO quote VALUES (39, TO_DATE('04-May-2026', 'dd-Mon-yyyy'), TO_DATE('15-May-2026', 'dd-Mon-yyyy'), 'Sandringham VIC 3191', 'Cheltenham VIC 3192', 710.00, 4, 12);
INSERT INTO quote VALUES (40, TO_DATE('05-May-2026', 'dd-Mon-yyyy'), TO_DATE('18-May-2026', 'dd-Mon-yyyy'), 'Mentone VIC 3194', 'Mordialloc VIC 3195', 690.00, 4, 13);
INSERT INTO quote VALUES (41, TO_DATE('06-May-2026', 'dd-Mon-yyyy'), TO_DATE('21-May-2026', 'dd-Mon-yyyy'), 'Oakleigh VIC 3166', 'Clayton South VIC 3169', 480.00, 4, 12);
INSERT INTO quote VALUES (42, TO_DATE('07-May-2026', 'dd-Mon-yyyy'), TO_DATE('24-May-2026', 'dd-Mon-yyyy'), 'Mulgrave VIC 3170', 'Notting Hill VIC 3168', 520.00, 4, 12);
INSERT INTO quote VALUES (43, TO_DATE('08-May-2026', 'dd-Mon-yyyy'), TO_DATE('27-May-2026', 'dd-Mon-yyyy'), 'Burwood VIC 3125', 'Camberwell VIC 3124', 610.00, 4, 13);

-- Customer 5 quotes (6 quotes) - quotes 48 and 49 are never assigned to a job
INSERT INTO quote VALUES (44, TO_DATE('04-May-2026', 'dd-Mon-yyyy'), TO_DATE('14-May-2026', 'dd-Mon-yyyy'), 'Rowville VIC 3178', 'Lysterfield VIC 3156', 630.00, 5, 12);
INSERT INTO quote VALUES (45, TO_DATE('05-May-2026', 'dd-Mon-yyyy'), TO_DATE('16-May-2026', 'dd-Mon-yyyy'), 'Knoxfield VIC 3180', 'Scoresby VIC 3179', 450.00, 5, 13);
INSERT INTO quote VALUES (46, TO_DATE('06-May-2026', 'dd-Mon-yyyy'), TO_DATE('19-May-2026', 'dd-Mon-yyyy'), 'Boronia VIC 3155', 'Wantirna VIC 3152', 720.00, 5, 12);
INSERT INTO quote VALUES (47, TO_DATE('07-May-2026', 'dd-Mon-yyyy'), TO_DATE('22-May-2026', 'dd-Mon-yyyy'), 'Ringwood VIC 3134', 'Mitcham VIC 3132', 800.00, 5, 13);
-- These 2 quotes are intentionally left unassigned to any job
INSERT INTO quote VALUES (48, TO_DATE('08-May-2026', 'dd-Mon-yyyy'), TO_DATE('25-May-2026', 'dd-Mon-yyyy'), 'Vermont VIC 3133', 'Nunawading VIC 3131', 590.00, 5, 12);
INSERT INTO quote VALUES (49, TO_DATE('09-May-2026', 'dd-Mon-yyyy'), TO_DATE('26-May-2026', 'dd-Mon-yyyy'), 'Mitcham VIC 3132', 'Donvale VIC 3111', 400.00, 5, 12);

--------------------------------------
--INSERT INTO job
--------------------------------------
-- Note: job_cost NULL means same as quote cost
-- driver_emp_no must be role D, sched_emp_no must be role T

-- Combination 1: TRL02 + 2FMDK3GC8BBA12345 used in 2 jobs
INSERT INTO job VALUES (50, TO_DATE('10-May-2026 08:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('11-May-2026 17:00:00', 'dd-Mon-yyyy hh24:mi:ss'), NULL, 'Y', 20, 12, 15, 'TRL02', '2FMDK3GC8BBA12345');
INSERT INTO job VALUES (51, TO_DATE('12-May-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('13-May-2026 16:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 900.00, 'Y', 21, 12, 16, 'TRL02', '2FMDK3GC8BBA12345');

-- Combination 2: TRL03 + 3VWFE21C04M000001 used in 2 jobs
INSERT INTO job VALUES (52, TO_DATE('15-May-2026 07:30:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('16-May-2026 15:30:00', 'dd-Mon-yyyy hh24:mi:ss'), 1550.00, 'N', 22, 13, 17, 'TRL03', '3VWFE21C04M000001');
INSERT INTO job VALUES (53, TO_DATE('18-May-2026 08:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('19-May-2026 18:00:00', 'dd-Mon-yyyy hh24:mi:ss'), NULL, 'Y', 23, 13, 18, 'TRL03', '3VWFE21C04M000001');

-- Combination 3: TRL04 + 4T1BF1FK5CU123456 used in 2 jobs
INSERT INTO job VALUES (54, TO_DATE('20-May-2026 06:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('20-May-2026 14:00:00', 'dd-Mon-yyyy hh24:mi:ss'), NULL, 'Y', 24, 12, 15, 'TRL04', '4T1BF1FK5CU123456');
INSERT INTO job VALUES (55, TO_DATE('22-May-2026 08:30:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('23-May-2026 12:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 780.00, 'Y', 25, 12, 16, 'TRL04', '4T1BF1FK5CU123456');

-- Combination 4: TRL05 + 5FNRL5H40BB098765 used in 2 jobs
INSERT INTO job VALUES (56, TO_DATE('25-May-2026 10:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('25-May-2026 17:00:00', 'dd-Mon-yyyy hh24:mi:ss'), NULL, 'N', 26, 13, 17, 'TRL05', '5FNRL5H40BB098765');
INSERT INTO job VALUES (57, TO_DATE('11-May-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('12-May-2026 13:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 950.00, 'Y', 27, 13, 18, 'TRL05', '5FNRL5H40BB098765');

-- Combination 5: TRL06 + 1FTFW1ET5DFC10112 used in 2 jobs
INSERT INTO job VALUES (58, TO_DATE('14-May-2026 08:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('15-May-2026 16:00:00', 'dd-Mon-yyyy hh24:mi:ss'), NULL, 'Y', 28, 12, 15, 'TRL06', '1FTFW1ET5DFC10112');
INSERT INTO job VALUES (59, TO_DATE('16-May-2026 07:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('17-May-2026 11:30:00', 'dd-Mon-yyyy hh24:mi:ss'), 610.00, 'Y', 29, 12, 16, 'TRL06', '1FTFW1ET5DFC10112');

-- Remaining unique combinations
INSERT INTO job VALUES (60, TO_DATE('19-May-2026 08:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('20-May-2026 15:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 1100.00, 'Y', 30, 13, 17, 'TRL07', '2C4RDGCG8ER123789');
INSERT INTO job VALUES (61, TO_DATE('21-May-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('21-May-2026 16:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 580.00, 'N', 31, 13, 18, 'TRL08', '5XYKT3A69CG234567');
INSERT INTO job VALUES (62, TO_DATE('24-May-2026 08:30:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('25-May-2026 12:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 700.00, 'Y', 32, 12, 15, 'TRL05', '1HGBH41JXMN109186');
INSERT INTO job VALUES (63, TO_DATE('12-May-2026 07:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('12-May-2026 14:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 620.00, 'Y', 33, 12, 16, 'TRL08', '2FMDK3GC8BBA12345');
INSERT INTO job VALUES (64, TO_DATE('14-May-2026 08:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('15-May-2026 17:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 800.00, 'Y', 34, 13, 17, 'TRL01', '3VWFE21C04M000001');
INSERT INTO job VALUES (65, TO_DATE('17-May-2026 09:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('18-May-2026 13:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 750.00, 'Y', 35, 12, 18, 'TRL06', '1FTFW1ET5DFC10112');
INSERT INTO job VALUES (66, TO_DATE('20-May-2026 08:30:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('21-May-2026 16:30:00', 'dd-Mon-yyyy hh24:mi:ss'), NULL, 'N', 36, 13, 15, 'TRL04', '4T1BF1FK5CU123456');
INSERT INTO job VALUES (67, TO_DATE('22-May-2026 07:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('22-May-2026 15:00:00', 'dd-Mon-yyyy hh24:mi:ss'), NULL, 'Y', 37, 12, 16, 'TRL03', '3VWFE21C04M000001');
INSERT INTO job VALUES (68, TO_DATE('26-May-2026 08:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('27-May-2026 17:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 510.00, 'Y', 38, 13, 17, 'TRL02', '2FMDK3GC8BBA12345');
INSERT INTO job VALUES (69, TO_DATE('13-May-2026 10:00:00', 'dd-Mon-yyyy hh24:mi:ss'), TO_DATE('14-May-2026 14:00:00', 'dd-Mon-yyyy hh24:mi:ss'), NULL, 'Y', 39, 13, 18, 'TRL05', '5FNRL5H40BB098765');

COMMIT;
