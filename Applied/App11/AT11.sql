/*
    File:           AT11.sql
    Student ID:     34267433
    Student Name:   Ria Bansal
    Last Modified:  24 May 2026
*/

SET SERVEROUTPUT ON;
SET ECHO ON;
SPOOL AT11-run.txt

-- =============================================
-- FUNCTION: cal_pur_order_total
-- =============================================
CREATE OR REPLACE FUNCTION cal_pur_order_total (
    p_po_id IN NUMBER
) RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT SUM(po_prod_qty * po_prod_unit_cost)
    INTO v_total
    FROM purchase_order_item
    WHERE po_id = p_po_id;

    RETURN v_total;
END;
/

-- TEST HARNESS: cal_pur_order_total
-- Test 1: Valid PO (PO 1)
DECLARE
    v_total NUMBER;
BEGIN
    v_total := cal_pur_order_total(1);
    DBMS_OUTPUT.PUT_LINE('Test 1 - Total for PO 1: ' || v_total);
END;
/

-- Test 2: Valid PO (PO 3)
DECLARE
    v_total NUMBER;
BEGIN
    v_total := cal_pur_order_total(3);
    DBMS_OUTPUT.PUT_LINE('Test 2 - Total for PO 3: ' || v_total);
END;
/

-- =============================================
-- TRIGGER: trg_update_stock
-- =============================================
CREATE OR REPLACE TRIGGER trg_update_stock
AFTER UPDATE OF po_status ON purchase_order
FOR EACH ROW
WHEN (NEW.po_status = 'C' AND OLD.po_status = 'P')
BEGIN
    UPDATE product p
    SET p.prod_stock = p.prod_stock + (
        SELECT poi.po_prod_qty
        FROM purchase_order_item poi
        WHERE poi.po_id = :NEW.po_id
        AND poi.prod_no = p.prod_no
    )
    WHERE p.prod_no IN (
        SELECT prod_no
        FROM purchase_order_item
        WHERE po_id = :NEW.po_id
    );
    DBMS_OUTPUT.PUT_LINE('Stock updated for PO: ' || :NEW.po_id);
END;
/

-- TEST HARNESS: trg_update_stock
SELECT prod_no, prod_name, prod_stock
FROM product
WHERE prod_no IN (SELECT prod_no FROM purchase_order_item WHERE po_id = 2);

-- Update PO 2 status to C (Completed) to fire trigger
UPDATE purchase_order
SET po_status = 'C'
WHERE po_id = 2;

-- Check stock after update
SELECT prod_no, prod_name, prod_stock
FROM product
WHERE prod_no IN (SELECT prod_no FROM purchase_order_item WHERE po_id = 2);

COMMIT;

SPOOL OFF;
SET ECHO OFF;