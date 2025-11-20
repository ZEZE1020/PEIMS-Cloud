-- ============================================================================
-- PEIMS Database Schema - Table Relationships
-- Database: pharma
-- Purpose: SQL script to create foreign key constraints and indexes
-- ============================================================================

-- This script documents and creates the relationships between tables
-- identified during the form-to-table mapping analysis

USE pharma;

-- ============================================================================
-- SECTION 1: DROP EXISTING CONSTRAINTS (if any)
-- ============================================================================

-- Note: Run this section only if recreating constraints
-- ALTER TABLE customer DROP FOREIGN KEY IF EXISTS fk_customer_category;
-- ALTER TABLE customer DROP FOREIGN KEY IF EXISTS fk_customer_location;
-- ... (add others as needed)

-- ============================================================================
-- SECTION 2: LOCATION & GEOGRAPHY RELATIONSHIPS
-- ============================================================================

-- Country to Location (1:M)
ALTER TABLE location
ADD CONSTRAINT fk_location_country
FOREIGN KEY (countryID) REFERENCES country(countryID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 3: CUSTOMER RELATIONSHIPS
-- ============================================================================

-- Customer to Category (M:1)
ALTER TABLE customer
ADD CONSTRAINT fk_customer_category
FOREIGN KEY (categoryID) REFERENCES category(categoryID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Customer to Location (M:1)
ALTER TABLE customer
ADD CONSTRAINT fk_customer_location
FOREIGN KEY (locationID) REFERENCES location(locationID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 4: PRODUCT RELATIONSHIPS
-- ============================================================================

-- Product to Location (M:1)
ALTER TABLE product
ADD CONSTRAINT fk_product_location
FOREIGN KEY (locationID) REFERENCES location(locationID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Product to RFID (1:1 or 1:M depending on design)
-- Note: Verify if rfidTagID in product should reference rfid table
-- ALTER TABLE product
-- ADD CONSTRAINT fk_product_rfid
-- FOREIGN KEY (rfidTagID) REFERENCES rfid(rfidTagID)
-- ON DELETE SET NULL
-- ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 5: EMPLOYEE & DEPARTMENT RELATIONSHIPS
-- ============================================================================

-- Employee to Department (M:1)
ALTER TABLE employees
ADD CONSTRAINT fk_employees_department
FOREIGN KEY (departmentID) REFERENCES department(departmentID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 6: INVENTORY RELATIONSHIPS
-- ============================================================================

-- InventoryItem to Product (M:1)
ALTER TABLE inventoryitem
ADD CONSTRAINT fk_inventoryitem_product
FOREIGN KEY (productID) REFERENCES product(productID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- InventoryItem to Category (M:1)
ALTER TABLE inventoryitem
ADD CONSTRAINT fk_inventoryitem_category
FOREIGN KEY (categoryID) REFERENCES category(categoryID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- InventoryItem to Location (M:1)
ALTER TABLE inventoryitem
ADD CONSTRAINT fk_inventoryitem_location
FOREIGN KEY (locationID) REFERENCES location(locationID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 7: ORDER & INVOICE RELATIONSHIPS
-- ============================================================================

-- Order to Customer (M:1)
ALTER TABLE `order`
ADD CONSTRAINT fk_order_customer
FOREIGN KEY (customerID) REFERENCES customer(customerID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Note: Add productID column to order table first
-- ALTER TABLE `order` ADD COLUMN productID INT AFTER productName;
-- ALTER TABLE `order`
-- ADD CONSTRAINT fk_order_product
-- FOREIGN KEY (productID) REFERENCES product(productID)
-- ON DELETE RESTRICT
-- ON UPDATE CASCADE;

-- Invoice to Customer (M:1)
ALTER TABLE invoice
ADD CONSTRAINT fk_invoice_customer
FOREIGN KEY (customerID) REFERENCES customer(customerID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Invoice to Location (M:1)
ALTER TABLE invoice
ADD CONSTRAINT fk_invoice_location
FOREIGN KEY (locationID) REFERENCES location(locationID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Invoice to Manager/Employee (M:1)
ALTER TABLE invoice
ADD CONSTRAINT fk_invoice_manager
FOREIGN KEY (managerID) REFERENCES employees(employeeID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 8: SHIPPING RELATIONSHIPS
-- ============================================================================

-- Shipping from Location (M:1)
ALTER TABLE shipping
ADD CONSTRAINT fk_shipping_from_location
FOREIGN KEY (fromLocationID) REFERENCES location(locationID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Shipping to Location (M:1)
ALTER TABLE shipping
ADD CONSTRAINT fk_shipping_to_location
FOREIGN KEY (toLocationID) REFERENCES location(locationID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Shipping to Product (M:1)
ALTER TABLE shipping
ADD CONSTRAINT fk_shipping_product
FOREIGN KEY (productID) REFERENCES product(productID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Shipping to Category (M:1)
ALTER TABLE shipping
ADD CONSTRAINT fk_shipping_category
FOREIGN KEY (packagingCategoryID) REFERENCES category(categoryID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 9: RFID RELATIONSHIPS
-- ============================================================================

-- RFID to Product (M:1)
ALTER TABLE rfid
ADD CONSTRAINT fk_rfid_product
FOREIGN KEY (productID) REFERENCES product(productID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- RFID to Category (M:1)
ALTER TABLE rfid
ADD CONSTRAINT fk_rfid_category
FOREIGN KEY (categoryID) REFERENCES category(categoryID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- RFID to Location (M:1)
ALTER TABLE rfid
ADD CONSTRAINT fk_rfid_location
FOREIGN KEY (locationID) REFERENCES location(locationID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 10: HEALTHCARE RELATIONSHIPS
-- ============================================================================

-- Disease to Product (M:1)
ALTER TABLE disease
ADD CONSTRAINT fk_disease_product
FOREIGN KEY (productID) REFERENCES product(productID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Cases to Disease (M:1)
ALTER TABLE cases
ADD CONSTRAINT fk_cases_disease
FOREIGN KEY (diseaseID) REFERENCES disease(diseaseID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Cases to Location (M:1)
ALTER TABLE cases
ADD CONSTRAINT fk_cases_location
FOREIGN KEY (locationID) REFERENCES location(locationID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 11: PAYROLL RELATIONSHIPS
-- ============================================================================

-- PayrollDetails to Employee (M:1)
ALTER TABLE payrolldetails
ADD CONSTRAINT fk_payroll_employee
FOREIGN KEY (employeeID) REFERENCES employees(employeeID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- PayrollDetails to Department (M:1)
ALTER TABLE payrolldetails
ADD CONSTRAINT fk_payroll_department
FOREIGN KEY (departmentID) REFERENCES department(departmentID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 12: PRODUCT CONSUMPTION RELATIONSHIPS
-- ============================================================================

-- ProductConsumption to Product (M:1)
ALTER TABLE productconsumption
ADD CONSTRAINT fk_productconsumption_product
FOREIGN KEY (productID) REFERENCES product(productID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ProductConsumption to Location (M:1)
ALTER TABLE productconsumption
ADD CONSTRAINT fk_productconsumption_location
FOREIGN KEY (locationID) REFERENCES location(locationID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- ============================================================================
-- SECTION 13: INDEXES FOR PERFORMANCE
-- ============================================================================

-- Primary lookup indexes
CREATE INDEX idx_customer_name ON customer(customerName);
CREATE INDEX idx_product_name ON product(name);
CREATE INDEX idx_employee_name ON employees(lastName, firstName);
CREATE INDEX idx_disease_name ON disease(name);

-- Foreign key indexes (if not automatically created)
CREATE INDEX idx_customer_category ON customer(categoryID);
CREATE INDEX idx_customer_location ON customer(locationID);
CREATE INDEX idx_product_location ON product(locationID);
CREATE INDEX idx_employees_department ON employees(departmentID);
CREATE INDEX idx_inventoryitem_product ON inventoryitem(productID);
CREATE INDEX idx_inventoryitem_category ON inventoryitem(categoryID);
CREATE INDEX idx_inventoryitem_location ON inventoryitem(locationID);
CREATE INDEX idx_order_customer ON `order`(customerID);
CREATE INDEX idx_invoice_customer ON invoice(customerID);
CREATE INDEX idx_invoice_location ON invoice(locationID);
CREATE INDEX idx_shipping_from ON shipping(fromLocationID);
CREATE INDEX idx_shipping_to ON shipping(toLocationID);
CREATE INDEX idx_shipping_product ON shipping(productID);
CREATE INDEX idx_rfid_product ON rfid(productID);
CREATE INDEX idx_disease_product ON disease(productID);
CREATE INDEX idx_cases_disease ON cases(diseaseID);
CREATE INDEX idx_cases_location ON cases(locationID);
CREATE INDEX idx_payroll_employee ON payrolldetails(employeeID);
CREATE INDEX idx_payroll_department ON payrolldetails(departmentID);
CREATE INDEX idx_productconsumption_product ON productconsumption(productID);
CREATE INDEX idx_productconsumption_location ON productconsumption(locationID);

-- Date-based query indexes
CREATE INDEX idx_order_date ON `order`(orderDate);
CREATE INDEX idx_invoice_date ON invoice(date);
CREATE INDEX idx_cases_date ON cases(date);
CREATE INDEX idx_product_mandate ON product(manDate);
CREATE INDEX idx_product_expdate ON product(expDate);
CREATE INDEX idx_inventoryitem_dateStamp ON inventoryitem(dateStamp);
CREATE INDEX idx_inventoryitem_soldDate ON inventoryitem(soldDate);
CREATE INDEX idx_productconsumption_date ON productconsumption(date);

-- Composite indexes for common queries
CREATE INDEX idx_inventoryitem_product_location ON inventoryitem(productID, locationID);
CREATE INDEX idx_order_customer_date ON `order`(customerID, orderDate);
CREATE INDEX idx_invoice_customer_date ON invoice(customerID, date);

-- ============================================================================
-- SECTION 14: VERIFICATION QUERIES
-- ============================================================================

-- Check all foreign key constraints
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    REFERENCED_TABLE_SCHEMA = 'pharma'
    AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY
    TABLE_NAME, COLUMN_NAME;

-- Check all indexes
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    SEQ_IN_INDEX,
    INDEX_TYPE
FROM
    INFORMATION_SCHEMA.STATISTICS
WHERE
    TABLE_SCHEMA = 'pharma'
ORDER BY
    TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;

-- ============================================================================
-- SECTION 15: RELATIONSHIP SUMMARY
-- ============================================================================

/*
RELATIONSHIP SUMMARY:

Level 1 (No Dependencies):
- users
- country
- category
- department

Level 2 (Depends on Level 1):
- location (→ country)
- employees (→ department)

Level 3 (Depends on Level 2):
- customer (→ category, location)
- product (→ location)
- payrolldetails (→ employees, department)

Level 4 (Depends on Level 3):
- inventoryitem (→ product, category, location)
- disease (→ product)
- rfid (→ product, category, location)
- order (→ customer)
- invoice (→ customer, location, employees)
- shipping (→ location, product, category)
- productconsumption (→ product, location)

Level 5 (Depends on Level 4):
- cases (→ disease, location)

TOTAL RELATIONSHIPS: 30+ foreign key constraints
*/

-- ============================================================================
-- SECTION 16: MAINTENANCE QUERIES
-- ============================================================================

-- Find orphaned records (records with invalid foreign keys)
-- Run these BEFORE adding constraints to identify data issues

-- Orphaned customers (invalid categoryID)
SELECT c.* FROM customer c
LEFT JOIN category cat ON c.categoryID = cat.categoryID
WHERE cat.categoryID IS NULL AND c.categoryID IS NOT NULL;

-- Orphaned customers (invalid locationID)
SELECT c.* FROM customer c
LEFT JOIN location l ON c.locationID = l.locationID
WHERE l.locationID IS NULL AND c.locationID IS NOT NULL;

-- Orphaned products (invalid locationID)
SELECT p.* FROM product p
LEFT JOIN location l ON p.locationID = l.locationID
WHERE l.locationID IS NULL AND p.locationID IS NOT NULL;

-- Orphaned employees (invalid departmentID)
SELECT e.* FROM employees e
LEFT JOIN department d ON e.departmentID = d.departmentID
WHERE d.departmentID IS NULL AND e.departmentID IS NOT NULL;

-- Add more orphan checks as needed...

-- ============================================================================
-- END OF SCRIPT
-- ============================================================================

-- Notes:
-- 1. Test this script in a development environment first
-- 2. Backup your database before running
-- 3. Some constraints may fail if data integrity issues exist
-- 4. Adjust ON DELETE and ON UPDATE rules based on business requirements
-- 5. Consider using CASCADE DELETE carefully - it can delete related data
-- 6. RESTRICT prevents deletion if related records exist
-- 7. SET NULL sets foreign key to NULL when parent is deleted (requires nullable column)
