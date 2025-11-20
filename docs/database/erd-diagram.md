# PEIMS Entity Relationship Diagram

## Visual ERD Representation

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         PEIMS Database Schema                                │
│                         Database: pharma                                     │
└─────────────────────────────────────────────────────────────────────────────┘

┌──────────────────┐
│     users        │
├──────────────────┤
│ PK: id           │
│    username      │
│    password      │
│    firstname     │
│    lastname      │
│    email         │
└──────────────────┘
        │
        │ (Used by frmMainLogin, frmUsers)
        │

┌──────────────────┐         ┌──────────────────┐         ┌──────────────────┐
│    country       │         │    location      │         │    customer      │
├──────────────────┤         ├──────────────────┤         ├──────────────────┤
│ PK: countryID    │────────>│ PK: locationID   │<────────│ PK: customerID   │
│    name          │         │ FK: countryID    │         │ FK: categoryID   │
│    population    │         │    locationName  │         │ FK: locationID   │
│    percAgeOf_Men │         │    storageCapacity│        │    customerName  │
│    ...           │         │    address       │         └──────────────────┘
└──────────────────┘         └──────────────────┘                 │
        │                            │                             │
        │                            │                             │
   (frmCountry)                 (frmLocation)                 (frmCustomer)
                                     │
                                     │
                    ┌────────────────┼────────────────┐
                    │                │                │
                    ▼                ▼                ▼
        ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐
        │    product       │  │  inventoryitem   │  │     cases        │
        ├──────────────────┤  ├──────────────────┤  ├──────────────────┤
        │ PK: productID    │  │ FK: productID    │  │ PK: caseID       │
        │ FK: locationID   │  │ FK: categoryID   │  │ FK: diseaseID    │
        │ FK: rfidTagID    │  │ FK: locationID   │  │ FK: locationID   │
        │    name          │  │    cost          │  │    date          │
        │    batchNo       │  │    price         │  │    cause         │
        │    price         │  │    isSold        │  │    noOfCasualties│
        │    manDate       │  │    dateStamp     │  └──────────────────┘
        │    expDate       │  │    soldDate      │           │
        │    qrCode        │  └──────────────────┘           │
        └──────────────────┘           │                     │
                │                      │                (frmCases)
                │                 (frmInventoryItem)
           (frmProduct)
                │
                │
    ┌───────────┼───────────┐
    │           │           │
    ▼           ▼           ▼
┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐
│    disease       │  │  productconsump  │  │     rfid         │
├──────────────────┤  ├──────────────────┤  ├──────────────────┤
│ PK: diseaseID    │  │ FK: productID    │  │ PK: rfidTagID    │
│ FK: productID    │  │ FK: locationID   │  │ FK: productID    │
│    name          │  │    itemSold      │  │ FK: categoryID   │
│    requirement   │  │    itemInStock   │  │ FK: locationID   │
│    agesAffected  │  │    price         │  └──────────────────┘
│    type          │  │    date          │           │
│    spreadingRate │  └──────────────────┘           │
└──────────────────┘           │                (frmRfid)
        │                      │
        │                 (frmProductConsumption)
   (frmDisease)


┌──────────────────┐         ┌──────────────────┐
│   department     │         │   employees      │
├──────────────────┤         ├──────────────────┤
│ PK: departmentID │<────────│ PK: employeeID   │
│    name          │         │ FK: departmentID │
│    noOfEmployees │         │    firstName     │
│    description   │         │    lastName      │
└──────────────────┘         │    middleName    │
        │                    │    dateOfBirth   │
        │                    │    designation   │
   (frmDepartment)           │    email         │
                             │    address       │
                             │    mobileNo      │
                             │    ...           │
                             └──────────────────┘
                                     │
                                     │
                                (frmEmployee)
                                     │
                                     │
                                     ▼
                             ┌──────────────────┐
                             │ payrolldetails   │
                             ├──────────────────┤
                             │ FK: employeeID   │
                             │ FK: departmentID │
                             │    employeeName  │
                             │    salary        │
                             │    accountNo     │
                             └──────────────────┘
                                     │
                                     │
                             (frmPayrollDetails)


┌──────────────────┐
│    category      │
├──────────────────┤
│ PK: categoryID   │
│    categoryName  │
│    categoryDesc  │
└──────────────────┘
        │
        │ (Referenced by: customer, inventoryitem, rfid, shipping)
        │
   (frmCategory)


┌──────────────────┐         ┌──────────────────┐
│     order        │         │    invoice       │
├──────────────────┤         ├──────────────────┤
│ PK: orderID      │         │ PK: invoiceID    │
│ FK: customerID   │         │ FK: customerID   │
│    productName   │         │ FK: managerID    │
│    amount        │         │ FK: locationID   │
│    cost          │         │    amount        │
│    orderDate     │         │    date          │
└──────────────────┘         └──────────────────┘
        │                            │
        │                            │
   (frmOrder)                   (frmInvoice)


┌──────────────────┐
│    shipping      │
├──────────────────┤
│ PK: shippingID   │
│ FK: fromLocationID│
│ FK: toLocationID │
│ FK: productID    │
│ FK: packagingCategoryID│
│    quantity      │
│    price         │
└──────────────────┘
        │
        │
   (frmShipping)
```

---

## Relationship Types

### One-to-Many Relationships

1. **country → location**
   - One country has many locations
   - FK: location.countryID → country.countryID

2. **location → customer**
   - One location has many customers
   - FK: customer.locationID → location.locationID

3. **location → product**
   - One location stores many products
   - FK: product.locationID → location.locationID

4. **category → customer**
   - One category has many customers
   - FK: customer.categoryID → category.categoryID

5. **department → employees**
   - One department has many employees
   - FK: employees.departmentID → department.departmentID

6. **product → disease**
   - One product treats many diseases
   - FK: disease.productID → product.productID

7. **disease → cases**
   - One disease has many cases
   - FK: cases.diseaseID → disease.diseaseID

8. **location → cases**
   - One location has many cases
   - FK: cases.locationID → location.locationID

9. **customer → order**
   - One customer has many orders
   - FK: order.customerID → customer.customerID

10. **customer → invoice**
    - One customer has many invoices
    - FK: invoice.customerID → customer.customerID

### Many-to-Many Relationships (via Junction Tables)

1. **product ↔ location** (via inventoryitem)
   - Products can be in multiple locations
   - Locations can have multiple products

2. **product ↔ category** (via inventoryitem, rfid)
   - Products belong to categories
   - Categories contain multiple products

---

## Table Dependencies (Hierarchical Order)

### Level 1 (No Dependencies)
- `users`
- `country`
- `category`
- `department`

### Level 2 (Depends on Level 1)
- `location` (depends on country)
- `employees` (depends on department)

### Level 3 (Depends on Level 2)
- `customer` (depends on category, location)
- `product` (depends on location)
- `payrolldetails` (depends on employees, department)

### Level 4 (Depends on Level 3)
- `inventoryitem` (depends on product, category, location)
- `disease` (depends on product)
- `rfid` (depends on product, category, location)
- `order` (depends on customer)
- `invoice` (depends on customer, location)
- `shipping` (depends on location, product, category)
- `productconsumption` (depends on product, location)

### Level 5 (Depends on Level 4)
- `cases` (depends on disease, location)

---

## Form-to-Table Access Matrix

| Form | Tables Accessed | Access Type |
|------|----------------|-------------|
| frmMainLogin | users | SELECT |
| frmUsers | users | CRUD |
| frmCountry | country | CRUD |
| frmLocation | location | CRUD |
| frmCategory | category | CRUD |
| frmDepartment | department | CRUD |
| frmCustomer | customer | CRUD |
| frmProduct | product | CRUD |
| frmEmployee | employees | CRUD |
| frmInventoryItem | inventoryitem | CRUD |
| frmOrder | order | CRUD |
| frmInvoice | invoice | CRUD |
| frmShipping | shipping | CRUD |
| frmRfid | rfid | CRUD |
| frmDisease | disease | CRUD |
| frmCases | cases | CRUD + Search |
| frmPayrollDetails | payrolldetails | CRUD |
| frmProductConsumption | productconsumption | CRUD |

---

## Key Observations

### Referential Integrity
- Most forms use foreign keys to maintain relationships
- No explicit CASCADE rules visible in code
- Manual relationship management required

### Data Consistency Issues
1. **Weak References:**
   - `order.productName` uses product name instead of productID
   - Potential data inconsistency if product names change

2. **Missing Constraints:**
   - No visible CHECK constraints
   - No UNIQUE constraints (except implied PKs)

3. **Orphan Records Risk:**
   - Deleting parent records may leave orphaned children
   - No CASCADE DELETE visible

### Normalization
- Generally follows 3NF (Third Normal Form)
- Some denormalization in `payrolldetails` (employeeName duplicates employees.firstName/lastName)
- `order` table has weak normalization (productName instead of FK)

---

## Recommended Database Improvements

1. **Add Foreign Key Constraints:**
```sql
ALTER TABLE customer 
  ADD CONSTRAINT fk_customer_category 
  FOREIGN KEY (categoryID) REFERENCES category(categoryID);

ALTER TABLE customer 
  ADD CONSTRAINT fk_customer_location 
  FOREIGN KEY (locationID) REFERENCES location(locationID);
```

2. **Fix Weak References:**
```sql
ALTER TABLE `order` 
  ADD COLUMN productID INT,
  ADD CONSTRAINT fk_order_product 
  FOREIGN KEY (productID) REFERENCES product(productID);
```

3. **Add Indexes:**
```sql
CREATE INDEX idx_customer_location ON customer(locationID);
CREATE INDEX idx_product_location ON product(locationID);
CREATE INDEX idx_employees_department ON employees(departmentID);
```

4. **Add Cascade Rules:**
```sql
ALTER TABLE employees 
  DROP FOREIGN KEY fk_employees_department,
  ADD CONSTRAINT fk_employees_department 
  FOREIGN KEY (departmentID) REFERENCES department(departmentID)
  ON DELETE RESTRICT ON UPDATE CASCADE;
```

---

## Migration Considerations

When migrating to cloud (AWS RDS MySQL):
1. Export current schema with relationships
2. Add missing FK constraints
3. Implement proper indexing strategy
4. Set up automated backups
5. Configure parameter groups for optimization
6. Enable slow query logging
7. Implement connection pooling

---

## Last Updated
Generated: 2024
