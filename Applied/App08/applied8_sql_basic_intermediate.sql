/*
FIT3171 Databases Applied 08
applied8_sql_basic_intermediate.sql

student id: 34267433
student name:Ria Bansal
applied class number:
last modified date:

*/

/* Part A - Retrieving data from a single table */

-- A1 
SELECT *
FROM uni.student
WHERE upper(stuaddress) LIKE upper('%Caulfield%')
ORDER BY stuid;


-- A2
SELECT *
FROM uni.unit
WHERE upper(unitcode) LIKE ('FIT1%')
ORDER BY unit.code;

-- A3

SELECT stuid,stulname,stufname,stuaddress
FROM uni.student
WHERE upper(stulname) LIKE ('S%') AND lower(stufname) LIKE ('%i%')
ORDER BY stuid;

-- A4
SELECT unitcode,ofsemester
FROM uni.offering
WHERE to_char(ofyear,'YYYY')='2021'
ORDER BY unitcode, ofsemester;

-- A5
SELECT unitcode,to_char(ofyear,'YYYY') AS ofyear
FROM uni.offering
WHERE to_char(ofyear,'YYYY')='2019'AND ofsemester=2 OR to_char(ofyear,'YYYY')='2020' AND ofsemester=2
ORDER BY ofyear,unitcode;
-- A5
SELECT
    to_char(
        ofyear, 'yyyy'
    ) AS offering_year,
    unitcode
FROM
    uni.offering
WHERE
    ofsemester = 2
    AND ( ( to_char(
        ofyear, 'yyyy'
    ) = '2019' )
          OR ( to_char(
        ofyear, 'yyyy'
    ) = '2020' ) )
ORDER BY
    offering_year,
    unitcode;


----A6
SELECT stuid,unitcode,enrolmark
FROM uni.enrolment
WHERE to_char(ofyear,'YYYY')='2021' AND ofsemester=2 AND enrolmark < 50
ORDER BY stuid, unitcode;






/* Part B - Retrieving data from multiple tables */

-- B1


-- B2


-- B3


-- B4


-- B5


-- B6


-- B7


-- B8



/* Part C - Aggregate Function, Group By and Having */

-- C1


-- C2


-- C3


-- C4


-- C5


-- C6


-- C7

