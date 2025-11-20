# Database Quick Reference Guide

## Connection String
```
Server: localhost
Database: pharma
User: root
Provider: MySql.Data.MySqlClient
```

## Tables & Forms Quick Lookup

| # | Table | Form | Purpose |
|---|-------|------|---------|
| 1 | users | frmMainLogin, frmUsers | Authentication & user management |
| 2 | customer | frmCustomer | Customer records |
| 3 | product | frmProduct | Product catalog |
| 4 | employees | frmEmployee | Employee records |
| 5 | department | frmDepartment | Department structure |
| 6 | category | frmCategory | Product/customer categories |
| 7 | country | frmCountry | Country demographics |
| 8 | location | frmLocation | Storage locations |
| 9 | inventoryitem | frmInventoryItem | Inventory tracking |
| 10 | order | frmOrder | Customer orders |
| 11 | invoice | frmInvoice | Billing & invoices |
| 12 | shipping | frmShipping | Logistics & shipping |
| 13 | rfid | frmRfid | RFID tag management |
| 14 | disease | frmDisease | Disease database |
| 15 | cases | frmCases | Disease case tracking |
| 16 | payrolldetails | frmPayrollDetails | Employee payroll |
| 17 | productconsumption | frmProductConsumption | Product usage analytics |

## Common SQL Patterns

### Standard CRUD
```csharp
// SELECT
ad = new MySqlDataAdapter("select * from `tablename`", strConn);
ad.Fill(this.newDataSet.tablename);

// INSERT/UPDATE/DELETE
bindingSource.EndEdit();
ad.Update(this.newDataSet.tablename);
```

### Authentication
```csharp
SELECT * FROM pharma.users 
WHERE username='...' and password='...'
```

### Search
```csharp
SELECT * FROM pharma.cases 
WHERE (caseID = '...') OR (diseaseID = '...')
```

## Foreign Key Relationships

```
country → location
location → customer, product, cases, invoice
category → customer, inventoryitem, rfid
department → employees, payrolldetails
product → disease, inventoryitem, rfid, shipping
disease → cases
customer → order, invoice
employees → payrolldetails
```

## Critical Security Issues

⚠️ **SQL Injection Vulnerabilities:**
- frmMainLogin (authentication)
- frmEmployee (INSERT)
- frmCases (search)

⚠️ **Plain Text Passwords:**
- users table stores unencrypted passwords

## Report Files

All Crystal Reports located in: `PEIMSV3Cs/*.rpt`

Format: `{Entity}CrystalReport.rpt`

## Data Flow

```
User Login (frmMainLogin)
    ↓
Main Menu (frmMain)
    ↓
    ├─> Customer Management → customer table
    ├─> Product Management → product table
    ├─> Employee Management → employees table
    ├─> Inventory → inventoryitem table
    ├─> Orders → order table
    ├─> Invoices → invoice table
    └─> Reports → Crystal Reports
```

## Database Size Estimates

Based on typical pharmaceutical operations:

| Table | Est. Rows | Growth Rate |
|-------|-----------|-------------|
| users | 10-100 | Low |
| customer | 1K-10K | Medium |
| product | 5K-50K | Medium |
| employees | 50-500 | Low |
| inventoryitem | 10K-100K | High |
| order | 10K-1M | High |
| invoice | 10K-1M | High |
| cases | 100-10K | Medium |

## Backup Strategy

Recommended:
- Daily full backups
- Hourly transaction log backups
- 30-day retention
- Off-site replication

## Performance Indexes

Recommended indexes:
```sql
-- High-traffic lookups
CREATE INDEX idx_customer_name ON customer(customerName);
CREATE INDEX idx_product_name ON product(name);
CREATE INDEX idx_employee_name ON employees(lastName, firstName);

-- Foreign key indexes
CREATE INDEX idx_customer_location ON customer(locationID);
CREATE INDEX idx_product_location ON product(locationID);
CREATE INDEX idx_order_customer ON `order`(customerID);
CREATE INDEX idx_invoice_customer ON invoice(customerID);

-- Date-based queries
CREATE INDEX idx_order_date ON `order`(orderDate);
CREATE INDEX idx_invoice_date ON invoice(date);
CREATE INDEX idx_cases_date ON cases(date);
```

## Cloud Migration Checklist

- [ ] Export current database schema
- [ ] Document all stored procedures (if any)
- [ ] Identify data volume and growth rate
- [ ] Plan for connection string updates
- [ ] Set up AWS RDS MySQL instance
- [ ] Configure security groups
- [ ] Implement SSL/TLS connections
- [ ] Update app.config with new connection string
- [ ] Test all forms with cloud database
- [ ] Set up automated backups
- [ ] Configure monitoring and alerts
- [ ] Update documentation

## Contact & Support

For database issues:
1. Check connection string in app.config
2. Verify MySQL service is running
3. Check user permissions
4. Review error logs
5. Consult db-linkage.md for detailed mapping

---

Last Updated: 2024
