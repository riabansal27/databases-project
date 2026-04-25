/*
    Student Name: Ria Bansal
    Student ID: rban0019
    Date: 25-Apr-2026
    Description: AT7 - Product Vendor DML
    AI Usage: No AI was used to generate the INSERT statements.
    The data was manually created to meet the task requirements.
*/

SET ECHO ON
SPOOL prod_vendor_details.txt

INSERT INTO vendor VALUES (1, 'Western Digital', '1234567890');
INSERT INTO vendor VALUES (2, 'Seagate', '0987654321');
INSERT INTO vendor VALUES (3, 'Samsung', '1122334455');
INSERT INTO vendor VALUES (4, 'Sony', '5544332211');
INSERT INTO vendor VALUES (5, 'LG Electronics', '6677889900');


INSERT INTO product VALUES (1, '2TB My Cloud Drive', 195.00, 5, 1);
INSERT INTO product VALUES (2, '1TB Portable Hard Drive', 76.00, 4, 1);
INSERT INTO product VALUES (3, 'Live Media Player', 119.00, 15, 1);
INSERT INTO product VALUES (4, '2TB Desktop Drive', 94.00, 12, 2);
INSERT INTO product VALUES (5, '4TB NAS Drive', 76.00, 8, 2);
INSERT INTO product VALUES (6, '2TB Personal Storage', 169.00, 3, 2);
INSERT INTO product VALUES (7, 'Samsung 970 EVO SSD', 149.00, 20, 3);
INSERT INTO product VALUES (8, 'Samsung T7 Portable SSD', 99.00, 7, 3);
INSERT INTO product VALUES (9, 'Sony 64GB SD Card', 25.00, 9, 4);
INSERT INTO product VALUES (10, 'Sony 128GB SD Card', 45.00, 25, 4);

COMMIT;

SET ECHO OFF
SPOOL OFF