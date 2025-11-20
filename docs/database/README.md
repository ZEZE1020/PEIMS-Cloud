# Database Documentation

Complete database schema, relationships, and SQL documentation for PEIMS.

## 📄 Files

### [db-linkage.md](db-linkage.md)
**Primary database reference**

- Form-to-table mappings (all 18 forms)
- SQL queries used by each form
- Foreign key relationships
- Security vulnerability analysis
- Data access patterns
- Report form mappings

**Use for:** Daily development, understanding data flow, debugging

---

### [erd-diagram.md](erd-diagram.md)
**Visual entity relationships**

- ASCII ERD diagrams
- Relationship types (1:M, M:M)
- Table dependency hierarchy
- Normalization analysis
- Database improvement recommendations

**Use for:** Understanding schema, planning changes, training

---

### [db-quick-reference.md](db-quick-reference.md)
**Quick lookup guide**

- Table-form quick lookup
- Common SQL patterns
- Foreign key summary
- Security issues list
- Performance indexes
- Migration checklist

**Use for:** Quick lookups, troubleshooting, code reviews

---

### [table-relationships.sql](table-relationships.sql)
**SQL implementation script**

- Foreign key constraints
- Index definitions
- Verification queries
- Orphaned record detection
- Maintenance queries

**Use for:** Database updates, adding constraints, optimization

---

## Database Overview

**Name:** pharma  
**Tables:** 17  
**Forms:** 18 data entry forms  
**Relationships:** 30+ foreign keys

## Connection String

```
Server: localhost
Database: pharma
User: root
Provider: MySql.Data.MySqlClient
```

Location: `PEIMSV3Cs/app.config`

---

[← Back to Docs](../)
