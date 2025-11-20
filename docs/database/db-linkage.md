# Database Linkage Documentation

## Connection Configuration

**Database:** `pharma`  
**Server:** `localhost`  
**Port:** `3306`  
**User:** `root`  
**Connection String Location:** `PEIMSV3Cs/app.config`

```xml
<connectionStrings>
    <add name="PEIMSV3Cs.Properties.Settings.pharmaConnectionString" 
         connectionString="server=localhost;user id=root;database=pharma" 
         providerName="MySql.Data.MySqlClient"/>
</connectionStrings>
```

---

## Form → Table Mapping

### Authentication & User Management

| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmMainLogin` | `users` | SELECT | username, password |
| `frmUsers` | `users` | SELECT, INSERT, UPDATE, DELETE | id, username, password, firstname, lastname, email |

**SQL Queries:**
- Login: `SELECT * FROM pharma.users WHERE username='...' and password='...'`
- CRUD: `select * from users`

---

### Core Business Entities

#### Customer Management
| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmCustomer` | `customer` | SELECT, INSERT, UPDATE, DELETE | customerID, categoryID, locationID, customerName |

**SQL Queries:**
- `select * from customer`

#### Product Management
| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmProduct` | `product` | SELECT, INSERT, UPDATE, DELETE | productID, name, locationID, batchNo, price, rfidTagID, manDate, expDate, qrCode |

**SQL Queries:**
- `select * from product`

#### Employee Management
| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmEmployee` | `employees` | SELECT, INSERT, UPDATE, DELETE | employeeID, firstName, lastName, middleName, dateOfBirth, departmentID, designation, email, address, mobileNo, extensionNo, nextOfKin, gender, age, maritalStatus, passportPic, degreeAttained |

**SQL Queries:**
- `select * from employees`
- `insert into pharma.employees (employeeID,firstName,lastName,...) values (...)`

---

### Inventory & Stock Management

| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmInventoryItem` | `inventoryitem` | SELECT, INSERT, UPDATE, DELETE | productID, categoryID, locationID, cost, price, isSold, dateStamp, soldDate |
| `frmProductConsumption` | `productconsumption` | SELECT, INSERT, UPDATE, DELETE | productID, locationID, itemSold, itemInStock, price, date |

**SQL Queries:**
- `select * from inventoryitem`
- `select * from productconsumption`

---

### Order & Invoice Management

| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmOrder` | `order` | SELECT, INSERT, UPDATE, DELETE | orderID, customerID, productName, amount, cost, orderDate |
| `frmInvoice` | `invoice` | SELECT, INSERT, UPDATE, DELETE | invoiceID, customerID, managerID, locationID, amount, date |

**SQL Queries:**
- `select * from order`
- `select * from invoice`

---

### Organizational Structure

| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmDepartment` | `department` | SELECT, INSERT, UPDATE, DELETE | departmentID, name, noOfEmployees, description |
| `frmCategory` | `category` | SELECT, INSERT, UPDATE, DELETE | categoryID, categoryName, categoryDescription |

**SQL Queries:**
- `select * from department`
- `select * from category`

---

### Geographic & Location Data

| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmCountry` | `country` | SELECT, INSERT, UPDATE, DELETE | countryID, name, population, percAgeOf_Men, percAgeOf_Women, percAgeOfChildren, perCapitalAnnualIncome, area |
| `frmLocation` | `location` | SELECT, INSERT, UPDATE, DELETE | locationID, countryID, locationName, storageCapacity, address |

**SQL Queries:**
- `select * from country`
- `select * from location`

---

### Logistics & Tracking

| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmShipping` | `shipping` | SELECT, INSERT, UPDATE, DELETE | shippingID, fromLocationID, toLocationID, productID, packagingCategoryID, quantity, price |
| `frmRfid` | `rfid` | SELECT, INSERT, UPDATE, DELETE | rfidTagID, productID, categoryID, locationID |

**SQL Queries:**
- `select * from shipping`
- `select * from rfid`

---

### Healthcare & Disease Management

| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmDisease` | `disease` | SELECT, INSERT, UPDATE, DELETE | diseaseID, name, productID, requirementProduct, agesAffected, type, spreadingRatePerWk |
| `frmCases` | `cases` | SELECT, INSERT, UPDATE, DELETE | caseID, diseaseID, locationID, date, cause, noOfCasualties |

**SQL Queries:**
- `select * from disease`
- `select * from cases`
- Search: `select * from pharma.cases where (caseID = '...') OR (diseaseID = '...')`

---

### Payroll Management

| Form | MySQL Table | Operations | Key Fields |
|------|-------------|------------|------------|
| `frmPayrollDetails` | `payrolldetails` | SELECT, INSERT, UPDATE, DELETE | employeeID, employeeName, salary, accountNo, departmentID |

**SQL Queries:**
- `select * from payrolldetails`

---

## Entity Relationship Diagram (ERD) Mapping

### Core Relationships

```
users (Authentication)
  └─> No direct FK relationships

customer
  ├─> category (categoryID)
  └─> location (locationID)

product
  ├─> location (locationID)
  └─> rfid (rfidTagID)

employees
  └─> department (departmentID)

inventoryitem
  ├─> product (productID)
  ├─> category (categoryID)
  └─> location (locationID)

order
  ├─> customer (customerID)
  └─> product (productName - weak reference)

invoice
  ├─> customer (customerID)
  ├─> employees (managerID)
  └─> location (locationID)

location
  └─> country (countryID)

shipping
  ├─> location (fromLocationID, toLocationID)
  ├─> product (productID)
  └─> category (packagingCategoryID)

rfid
  ├─> product (productID)
  ├─> category (categoryID)
  └─> location (locationID)

disease
  └─> product (productID)

cases
  ├─> disease (diseaseID)
  └─> location (locationID)

payrolldetails
  ├─> employees (employeeID)
  └─> department (departmentID)

productconsumption
  ├─> product (productID)
  └─> location (locationID)
```

---

## Database Tables Summary

| Table Name | Primary Key | Foreign Keys | Related Forms |
|------------|-------------|--------------|---------------|
| `users` | id | - | frmMainLogin, frmUsers |
| `customer` | customerID | categoryID, locationID | frmCustomer |
| `product` | productID | locationID, rfidTagID | frmProduct, frmDisease |
| `employees` | employeeID | departmentID | frmEmployee, frmPayrollDetails |
| `department` | departmentID | - | frmDepartment |
| `category` | categoryID | - | frmCategory |
| `country` | countryID | - | frmCountry |
| `location` | locationID | countryID | frmLocation |
| `inventoryitem` | - | productID, categoryID, locationID | frmInventoryItem |
| `order` | orderID | customerID | frmOrder |
| `invoice` | invoiceID | customerID, managerID, locationID | frmInvoice |
| `shipping` | shippingID | fromLocationID, toLocationID, productID, packagingCategoryID | frmShipping |
| `rfid` | rfidTagID | productID, categoryID, locationID | frmRfid |
| `disease` | diseaseID | productID | frmDisease |
| `cases` | caseID | diseaseID, locationID | frmCases |
| `payrolldetails` | - | employeeID, departmentID | frmPayrollDetails |
| `productconsumption` | - | productID, locationID | frmProductConsumption |

---

## Data Access Patterns

### Standard CRUD Pattern
Most forms follow this pattern:
```csharp
// Load
MySqlDataAdapter ad = new MySqlDataAdapter("select * from `tablename`", strConn);
MySqlCommandBuilder builder = new MySqlCommandBuilder(ad);
ad.Fill(this.newDataSet.tablename);

// Save/Update
bindingSource.EndEdit();
ad.Update(this.newDataSet.tablename);
```

### Special Cases

**frmMainLogin** - Direct SQL query for authentication:
```csharp
SELECT * FROM pharma.users WHERE username='...' and password='...'
```
⚠️ **Security Issue:** Vulnerable to SQL injection

**frmEmployee** - Uses both DataAdapter and direct INSERT:
```csharp
insert into pharma.employees (...) values (...)
```

**frmCases** - Implements search functionality:
```csharp
select * from pharma.cases where (caseID = '...') OR (diseaseID = '...')
```

---

## Report Forms (Crystal Reports)

| Report Form | Data Source Table | Crystal Report File |
|-------------|-------------------|---------------------|
| frmCasesReport | cases | CasesCrystalReport.rpt |
| frmCategoryReport | category | CategoryCrystalReport.rpt |
| frmCountryReport | country | CountryCrystalReport.rpt |
| frmCustomerReport | customer | CustomerCrystalReport.rpt |
| frmDepartmentReport | department | DepartmentCrystalReport.rpt |
| frmDiseaseReport | disease | DiseaseCrystalReport.rpt |
| frmEmployeeReport | employees | EmployeeCrystalReport.rpt |
| frmInventoryItemReport | inventoryitem | InventoryItemCrystalReport.rpt |
| frmInvoiceReport | invoice | InvoiceCrystalReport.rpt |
| frmLocationReport | location | LocationCrystalReport.rpt |
| frmOrderReport | order | OrderCrystalReport.rpt |
| frmPayrollReport | payrolldetails | PayrollCrystalReport.rpt |
| frmProductReport | product | ProductCrystalReport.rpt |
| frmProductConsumptionReport | productconsumption | ProductConsumptionCrystalReport.rpt |
| frmRfidReport | rfid | RfidCrystalReport.rpt |
| frmShippingReport | shipping | ShippingCrystalReport.rpt |

---

## Security Recommendations

1. **SQL Injection Vulnerabilities:**
   - `frmMainLogin`: Uses string concatenation for authentication query
   - `frmEmployee`: Direct INSERT with concatenated values
   - `frmCases`: Search query uses string concatenation

2. **Recommended Fixes:**
   - Use parameterized queries (MySqlParameter)
   - Implement stored procedures
   - Add input validation and sanitization

3. **Password Storage:**
   - Currently stores passwords in plain text
   - Implement password hashing (bcrypt, PBKDF2)

---

## Architecture Notes

- **Framework:** .NET Framework 4.8
- **Database Provider:** MySql.Data.MySqlClient
- **Data Binding:** Uses DataSet and BindingSource pattern
- **Connection Management:** Hardcoded connection strings in each form
- **Recommendation:** Centralize connection string management

---

## Last Updated
Generated: 2024
