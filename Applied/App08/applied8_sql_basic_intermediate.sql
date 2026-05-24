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
SELECT unitcode,ofsemester,stafffname,stafflname
FROM uni.offering
JOIN uni.staff
ON offering.staffid=staff.staffid
WHERE to_char(ofyear,'YYYY')='2021'
ORDER BY ofsemester,unitcode;



-- B2
SELECT enrolment.stuid,stufname ||' '|| stulname AS student_name,unitname
FROM uni.student
JOIN uni.enrolment 
ON student.stuid = enrolment.stuid
JOIN uni.unit 
ON unit.unitcode=enrolment.unitcode
WHERE ofsemester=1 AND to_char(ofyear,'YYYY')='2021'
ORDER BY unitname,stuid;






-- B4
SELECT unit.unitcode,unitname,ofsemester,ofyear,enrolmark,enrolgrade
FROM uni.UNIT
JOIN uni.ENROLMENT
ON unit.unitcode=enrolment.unitcode
JOIN uni.student
ON enrolment.stuid=student.stuid
WHERE upper(stufname)=upper('Brier') AND upper(stulname)=upper('Kilgour')
ORDER BY ofyear,ofsemester,unitcode;





-- B5


-- B6


-- B7
SELECT student.stuid,stufname,stulname
FROM uni.STUDENT
JOIN uni.ENROLMENT
ON student.stuid=enrolment.stuid
WHERE upper(enrolgrade)='HD'AND ofsemester=2 AND upper(unitcode)='FIT2094' AND to_char(ofyear,'YYYY')='2021'
ORDER BY stuid;





-- B8
SELECT stufname ||' '|| stulname AS student_name,enrolment.unitcode
FROM uni.STUDENT
JOIN uni.ENROLMENT
ON student.stuid=enrolment.stuid
WHERE enrolmark IS NULL AND ofsemester=1 AND to_char(ofyear,'YYYY')='2021'
ORDER BY student_name;


/* Part C - Aggregate Function, Group By and Having */


-- C2
SELECT COUNT(*) AS student_count
FROM uni.enrolment
WHERE unitcode='FIT1045' AND to_char(ofyear,'YYYY')='2019'


SELECT COUNT(DISTINCT stuid) AS student_count
FROM uni.enrolment
WHERE unitcode='FIT1045' and to_char(ofyear,'YYYY')='2019'





-- C4
SELECT COUNT(stuid) AS total_students,unitcode
FROM uni.enrolment
WHERE enrolgrade='WH' AND ofsemester=2 AND to_char(ofyear,'YYYY')='2020'
GROUP BY unitcode
ORDER BY total_students desc,unitcode;






-- C5
SELECT unitcode,COUNT(prerequnitcode) AS totalnumber_used
FROM uni.prereq
GROUP BY prerequnitcode
ORDER BY prerequnitcode,totalnumber_used






-- C6


-- C7
SELECT unit.unitcode, unitname
FROM uni.unit 
JOIN uni.enrolment
ON unit.unitcode=enrolment.unitcode
WHERE upper(enrolgrade)='DEF'AND ofsemester=2 AND to_char(ofyear,'YYYY')='2021'
GROUP BY unit.unitcode,unitname
HAVING COUNT(*)>=2
ORDER BY unitcode;


