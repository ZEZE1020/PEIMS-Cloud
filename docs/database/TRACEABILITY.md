# Form-to-Database Traceability Matrix

**Last Verified:** 2024  
**Verified By:** Solutions Architect  
**Status:** ✅ Verified against source code

---

## Authentication Forms

| Form File | Table | Method | Line Ref | SQL Query | Vulnerability |
|-----------|-------|--------|----------|-----------|---------------|
| `frmMainLogin.cs` | users | loginButton_Click_1 | ~26 | `SELECT * FROM pharma.users WHERE username='...' and password='...'` | ⚠️ SQL Injection |
| `frmUALogin1.cs` | users | loginButton_Click | ~26 | `SELECT * FROM pharma.users WHERE username='...' and password='...'` | ⚠️ SQL Injection |
| `frmUALogin2.cs` | users | loginButton_Click | ~26 | `SELECT * FROM pharma.users WHERE username='...' and password='...'` | ⚠️ SQL Injection |
| `frmUsers.cs` | users | frmusers_Load | ~30 | `select * from users` | ✅ Safe (DataAdapter) |

**Connection String:** Hardcoded inline  
**Location:** Each form contains: `"datasource=localhost;port=3306;database=pharma;username=root;password="`

---

## Core Business Forms

### Customer Management

| Form File | Table | Method | Line Ref | SQL Query | Connection Type |
|-----------|-------|--------|----------|-----------|-----------------|
| `frmCustomer.cs` | customer | frmcustomer_Load | ~30 | `select * from customer` | Hardcoded inline |

**Connection String:** `"server=localhost;user id=root;database=pharma;password=;"`

---

### Product Management

| Form File | Table | Method | Line Ref | SQL Query | Connection Type |
|-----------|-------|--------|----------|-----------|-----------------|
| `frmProduct.cs` | product | frmproduct_Load | ~35 | `select * from product` | Hardcoded inline |

**Connection String:** `"server=localhost;user id=root;database=pharma;password=;"`

---

### Employee Management

| Form File | Table | Method | Line Ref | SQL Query | Connection Type | Vulnerability |
|-----------|-------|--------|----------|-----------|-----------------|---------------|
| `frmEmployee.cs` | employees | frmemployees_Load | ~36 | `select * from employees` | Hardcoded inline | ✅ Safe |
| `frmEmployee.cs` | employees | SaveButton_Click | ~220 | `insert into pharma.employees (...) values (...)` | Hardcoded inline | ⚠️ SQL Injection |

**Connection Strings:**
- Load: `"server=localhost;user id=root;database=pharma;password=;"`
- Insert: `"Datasource=localhost;Database=pharma;Uid=root;Pwd=;"`

---

## Inventory Forms

| Form File | Table | Method | Line Ref | SQL Query | Connection Type |
|-----------|-------|--------|----------|-----------|-----------------|
| `frmInventoryItem.cs` | inventoryitem | frminventoryitem_Load | ~35 | `select * from inventoryitem` | Hardcoded inline |
| `frmProductConsumption.cs` | productconsumption | frmproductconsumption_Load | ~35 | `select * from productconsumption` | Hardcoded inline |

---

## Transaction Forms

| Form File | Table | Method | Line Ref | SQL Query | Connection Type |
|-----------|-------|--------|----------|-----------|-----------------|
| `frmOrder.cs` | order | frmorder_Load | ~30 | `select * from order` | Hardcoded inline |
| `frmInvoice.cs` | invoice | frminvoice_Load | ~30 | `select * from invoice` | Hardcoded inline |

---

## Organizational Forms

| Form File | Table | Method | Line Ref | SQL Query | Connection Type |
|-----------|-------|--------|----------|-----------|-----------------|
| `frmDepartment.cs` | department | frmdepartment_Load | ~30 | `select * from department` | Hardcoded inline |
| `frmCategory.cs` | category | frmcategory_Load | ~30 | `select * from category` | Hardcoded inline |

---

## Geographic Forms

| Form File | Table | Method | Line Ref | SQL Query | Connection Type |
|-----------|-------|--------|----------|-----------|-----------------|
| `frmCountry.cs` | country | frmcountry_Load | ~30 | `select * from country` | Hardcoded inline |
| `frmLocation.cs` | location | frmlocation_Load | ~35 | `select * from location` | Hardcoded inline |

---

## Logistics Forms

| Form File | Table | Method | Line Ref | SQL Query | Connection Type |
|-----------|-------|--------|----------|-----------|-----------------|
| `frmShipping.cs` | shipping | frmshipping_Load | ~35 | `select * from shipping` | Hardcoded inline |
| `frmRfid.cs` | rfid | frmrfid_Load | ~35 | `select * from rfid` | Hardcoded inline |

---

## Healthcare Forms

| Form File | Table | Method | Line Ref | SQL Query | Connection Type | Vulnerability |
|-----------|-------|--------|----------|-----------|-----------------|---------------|
| `frmDisease.cs` | disease | frmdisease_Load | ~35 | `select * from disease` | Hardcoded inline | ✅ Safe |
| `frmCases.cs` | cases | frmcases_Load | ~34 | `select * from cases` | Hardcoded inline | ✅ Safe |
| `frmCases.cs` | cases | SearchIDButton_Click | ~160 | `select * from pharma.cases where (caseID = '...') OR (diseaseID = '...')` | Hardcoded inline | ⚠️ SQL Injection |

---

## Payroll Forms

| Form File | Table | Method | Line Ref | SQL Query | Connection Type |
|-----------|-------|--------|----------|-----------|-----------------|
| `frmPayrollDetails.cs` | payrolldetails | frmpayrolldetails_Load | ~33 | `select * from payrolldetails` | Hardcoded inline |

---

## Connection String Summary

### ❌ CRITICAL FINDING: App.config NOT USED

**Reality:** All forms use hardcoded connection strings inline in code.

**Common Patterns:**
1. `"server=localhost;user id=root;database=pharma;password=;"` (most forms)
2. `"datasource=localhost;port=3306;database=pharma;username=root;password="` (login forms)
3. `"Datasource=localhost;Database=pharma;Uid=root;Pwd="` (frmEmployee insert)

**App.config Status:** 
- File exists at `PEIMSV3Cs/app.config`
- Contains connection string definition
- ⚠️ **NOT USED BY APPLICATION CODE**

---

## Vulnerability Summary

### SQL Injection Vulnerabilities (5 instances)

| File | Method | Line | Vulnerable Code |
|------|--------|------|-----------------|
| `frmMainLogin.cs` | loginButton_Click_1 | ~26 | `"SELECT * FROM pharma.users WHERE username='" + this.userNameTextBox.Text + "' and password='" + passwordTextBox.Text + "'"` |
| `frmUALogin1.cs` | loginButton_Click | ~26 | `"SELECT * FROM pharma.users WHERE username='" + this.userNameTextBox.Text + "' and password='" + passwordTextBox.Text + "'"` |
| `frmUALogin2.cs` | loginButton_Click | ~26 | `"SELECT * FROM pharma.users WHERE username='" + this.userNameTextBox.Text + "' and password='" + passwordTextBox.Text + "'"` |
| `frmEmployee.cs` | SaveButton_Click | ~220 | `"insert into pharma.employees (...) values ('" + this.employeeIDTextBox.Text + "',..."` |
| `frmCases.cs` | SearchIDButton_Click | ~160 | `"select * from pharma.cases where (caseID = '" + caseIDTextBox.Text + "') OR (diseaseID = '" + diseaseIDTextBox.Text + "')"` |

---

## Verified Form Count

**Data Entry Forms:** 18
1. frmMainLogin
2. frmUALogin1
3. frmUALogin2
4. frmUsers
5. frmCustomer
6. frmProduct
7. frmEmployee
8. frmInventoryItem
9. frmProductConsumption
10. frmOrder
11. frmInvoice
12. frmDepartment
13. frmCategory
14. frmCountry
15. frmLocation
16. frmShipping
17. frmRfid
18. frmDisease
19. frmCases
20. frmPayrollDetails

**Actual Count:** 20 forms (not 18 as previously documented)

**Report Forms:** 16 Crystal Reports (verified by .rpt files)

---

## Fix Examples

### SQL Injection Fix - Authentication

**Current (Vulnerable):**
```csharp
// frmMainLogin.cs line 26
MySqlCommand SelectCommand = new MySqlCommand(
    "SELECT * FROM pharma.users WHERE username='" + this.userNameTextBox.Text + 
    "' and password='" + passwordTextBox.Text + "' ; ", myConn);
```

**Fixed (Parameterized):**
```csharp
MySqlCommand SelectCommand = new MySqlCommand(
    "SELECT * FROM pharma.users WHERE username=@username AND password=@password", myConn);
SelectCommand.Parameters.AddWithValue("@username", this.userNameTextBox.Text);
SelectCommand.Parameters.AddWithValue("@password", passwordTextBox.Text);
```

### Connection String Fix

**Current (Hardcoded):**
```csharp
string strConn = "server=localhost;user id=root;database=pharma;password=;";
```

**Fixed (Config-based):**
```csharp
using System.Configuration;

string strConn = ConfigurationManager.ConnectionStrings["pharmaConnectionString"].ConnectionString;
```

---

**Last Updated:** 2024  
**Verification Status:** ✅ Complete  
**Next Review:** After Phase 2 fixes
