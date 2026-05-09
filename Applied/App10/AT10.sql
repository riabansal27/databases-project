/*
    File:           AT10.sql
    Student ID:     34267433
    Student Name:   Ria Bansal
    Last Modified:  9 May 2026
*/

SET SERVEROUTPUT ON;
SET ECHO ON;
SPOOL AT10-run.txt

CREATE OR REPLACE PROCEDURE prc_new_pur_order (
    p_pur_order_nbr    IN  NUMBER,
    p_vendor_id        IN  NUMBER,
    p_prod_no          IN  NUMBER,
    p_po_prod_qty      IN  NUMBER,
    p_po_prod_unit_cost IN NUMBER,
    p_output           OUT VARCHAR2
)
AS
    v_vendor_id  NUMBER;
    v_stock      NUMBER;
BEGIN
    -- Check 1: Does this product exist and is it supplied by the given vendor?
    SELECT vendor_id, prod_stock
    INTO v_vendor_id, v_stock
    FROM product
    WHERE prod_no = p_prod_no;

    IF v_vendor_id != p_vendor_id THEN
        p_output := 'Error: Product ' || p_prod_no || ' cannot be supplied by vendor ' || p_vendor_id;
        RETURN;
    END IF;

    -- Check 2: Is current stock less than 10?
    IF v_stock >= 10 THEN
        p_output := 'Error: Stock for product ' || p_prod_no || ' is not below 10 (current stock: ' || v_stock || ')';
        RETURN;
    END IF;

    -- Both checks passed: insert into purchase_order then purchase_order_item
    INSERT INTO purchase_order (po_id, vendor_id, po_date, po_status, po_total_cost)
    VALUES (p_pur_order_nbr, p_vendor_id, SYSDATE, 'P', p_po_prod_qty * p_po_prod_unit_cost);

    INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost)
    VALUES (p_pur_order_nbr, p_prod_no, p_po_prod_qty, p_po_prod_unit_cost);

    COMMIT;
    p_output := 'Success: Purchase order ' || p_pur_order_nbr || ' created successfully.';

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_output := 'Error: Product ' || p_prod_no || ' does not exist.';
END;
/
-- TEST HARNESS

-- Test 1: Valid case (prod_no=2, vendor=101, stock=8 which is < 10)
DECLARE
    v_msg VARCHAR2(200);
BEGIN
    prc_new_pur_order(100, 101, 2, 20, 22.50, v_msg);
    DBMS_OUTPUT.PUT_LINE('Test 1: ' || v_msg);
END;
/

-- Test 2: Wrong vendor (prod_no=2 belongs to vendor 101, not 102)
DECLARE
    v_msg VARCHAR2(200);
BEGIN
    prc_new_pur_order(101, 102, 2, 20, 22.50, v_msg);
    DBMS_OUTPUT.PUT_LINE('Test 2: ' || v_msg);
END;
/

-- Test 3: Stock not below 10 (prod_no=1, vendor=101, stock=45)
DECLARE
    v_msg VARCHAR2(200);
BEGIN
    prc_new_pur_order(102, 101, 1, 10, 15.99, v_msg);
    DBMS_OUTPUT.PUT_LINE('Test 3: ' || v_msg);
END;
/

-- Test 4: Product does not exist
DECLARE
    v_msg VARCHAR2(200);
BEGIN
    prc_new_pur_order(103, 101, 999, 10, 15.99, v_msg);
    DBMS_OUTPUT.PUT_LINE('Test 4: ' || v_msg);
END;
/

SPOOL OFF;