# PEIMS Documentation

## 📁 Documentation Structure

This documentation is organized into focused subdirectories for easy navigation and maintenance.

---

## 📂 Folders

### 🗄️ [database/](database/)
**Database schema, relationships, and SQL documentation**

Contains:
- `db-linkage.md` - Complete form-to-table mappings and SQL queries
- `erd-diagram.md` - Entity relationship diagrams and relationships
- `db-quick-reference.md` - Quick lookup guide for tables and queries
- `table-relationships.sql` - SQL script for foreign keys and indexes
- `TRACEABILITY.md` - ⭐ Exact file paths, line numbers, and code snippets
- `SECURITY-FIXES.md` - ⭐ Detailed security vulnerability fixes with code examples

**Use when:** Working with database, understanding data flow, implementing queries, fixing security issues

---

### 🏗️ [architecture/](architecture/)
**System architecture, analysis, and design documentation**

Contains:
- `database-analysis-summary.md` - Executive summary and migration roadmap
- `forms-inventory.md` - Complete list of all application forms
- `module-mapping.md` - Business module to form mappings
- `ui-issues.md` - Known UI/UX issues and recommendations

**Use when:** Understanding system architecture, planning changes, reviewing design

---

### 🔄 [workflows/](workflows/)
**User workflows and business processes**

Contains:
- `workflows.md` - User action flows and database operations

**Use when:** Understanding business processes, training users, documenting procedures

---

### 📊 [reports/](reports/)
**Project reports and completion documentation**

Contains:
- `COMPLETION-REPORT.md` - Project completion summary and deliverables

**Use when:** Reviewing project status, tracking deliverables, reporting progress

---

## 🚀 Quick Start

### For Developers
1. Start with [database/db-quick-reference.md](database/db-quick-reference.md)
2. Reference [database/db-linkage.md](database/db-linkage.md) for details
3. Check [architecture/forms-inventory.md](architecture/forms-inventory.md) for form list

### For Database Administrators
1. Start with [database/table-relationships.sql](database/table-relationships.sql)
2. Review [database/db-linkage.md](database/db-linkage.md)
3. Check [database/erd-diagram.md](database/erd-diagram.md)

### For Architects
1. Start with [architecture/database-analysis-summary.md](architecture/database-analysis-summary.md)
2. Review [database/erd-diagram.md](database/erd-diagram.md)
3. Check [architecture/module-mapping.md](architecture/module-mapping.md)

### For Project Managers
1. Read [reports/COMPLETION-REPORT.md](reports/COMPLETION-REPORT.md)
2. Review [architecture/database-analysis-summary.md](architecture/database-analysis-summary.md)

---

## 📋 Documentation Index

### Database Documentation
| File | Description | Audience |
|------|-------------|----------|
| [db-linkage.md](database/db-linkage.md) | Form-to-table mappings, SQL queries | Developers, DBAs |
| [erd-diagram.md](database/erd-diagram.md) | Entity relationships, visual diagrams | Architects, DBAs |
| [db-quick-reference.md](database/db-quick-reference.md) | Quick lookup guide | All |
| [table-relationships.sql](database/table-relationships.sql) | SQL implementation script | DBAs |
| [TRACEABILITY.md](database/TRACEABILITY.md) | ⭐ Exact file paths and line numbers | Developers, Security |
| [SECURITY-FIXES.md](database/SECURITY-FIXES.md) | ⭐ Security vulnerability fixes | Developers, Security |

### Architecture Documentation
| File | Description | Audience |
|------|-------------|----------|
| [database-analysis-summary.md](architecture/database-analysis-summary.md) | Executive summary, roadmap | Managers, Architects |
| [forms-inventory.md](architecture/forms-inventory.md) | Complete form list | Developers |
| [module-mapping.md](architecture/module-mapping.md) | Module organization | Business Analysts |
| [ui-issues.md](architecture/ui-issues.md) | UI/UX issues | Designers, Developers |

### Workflow Documentation
| File | Description | Audience |
|------|-------------|----------|
| [workflows.md](workflows/workflows.md) | User workflows, processes | All |

### Reports
| File | Description | Audience |
|------|-------------|----------|
| [COMPLETION-REPORT.md](reports/COMPLETION-REPORT.md) | Project completion status | Managers |

---

## 🔍 Find What You Need

### By Task

**Understanding the Database:**
- [database/erd-diagram.md](database/erd-diagram.md) - Visual overview
- [database/db-linkage.md](database/db-linkage.md) - Detailed mappings

**Writing Code:**
- [database/db-quick-reference.md](database/db-quick-reference.md) - Quick patterns
- [database/db-linkage.md](database/db-linkage.md) - SQL queries

**Planning Migration:**
- [architecture/database-analysis-summary.md](architecture/database-analysis-summary.md) - Roadmap
- [database/table-relationships.sql](database/table-relationships.sql) - Schema updates

**Understanding Workflows:**
- [workflows/workflows.md](workflows/workflows.md) - User processes

**Reviewing Progress:**
- [reports/COMPLETION-REPORT.md](reports/COMPLETION-REPORT.md) - Status

---

## 📊 Project Statistics

- **Database Tables:** 17
- **Application Forms:** 20 data entry + 16 reports (corrected)
- **Relationships Mapped:** 30+ foreign keys
- **Documentation Files:** 14 files across 4 categories
- **SQL Scripts:** 1 comprehensive script
- **Vulnerabilities Found:** 5 SQL injection instances

---

## 🔐 Key Information

**Database:** pharma (MySQL)  
**Connection:** localhost:3306  
**Framework:** .NET Framework 4.8  
**Provider:** MySql.Data.MySqlClient

---

## ⚠️ Critical Issues

1. **SQL Injection** - 5 forms vulnerable (with exact line numbers)
2. **Plain Text Passwords** - users table
3. **Hardcoded Connections** - All 20 forms (App.config NOT used)
4. **Missing FK Constraints** - Database level
5. **Using root Account** - All connections

See [database/TRACEABILITY.md](database/TRACEABILITY.md) and [database/SECURITY-FIXES.md](database/SECURITY-FIXES.md) for details.

---

## 📅 Last Updated

**Date:** 2024  
**Status:** Phase 1 Complete  
**Next Phase:** Database Preparation

---

## 📞 Support

For questions about:
- **Database:** See [database/](database/) folder
- **Architecture:** See [architecture/](architecture/) folder
- **Workflows:** See [workflows/](workflows/) folder
- **Status:** See [reports/](reports/) folder

---

**Navigation:** [Database](database/) | [Architecture](architecture/) | [Workflows](workflows/) | [Reports](reports/)
