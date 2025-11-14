# Form to Module Mapping Audit

This document maps each form to its primary business module and highlights any overlaps with other modules.

| Form                              | Primary Module     | Overlapping Modules          |
| --------------------------------- | ------------------ | ---------------------------- |
| `frmCustomer.cs`                  | CRM                | -                            |
| `frmOrder.cs`                     | CRM                | Inventory                    |
| `frmInvoice.cs`                   | CRM                | Finance                      |
| `frmShipping.cs`                  | CRM                | Inventory                    |
| `frmEmployee.cs`                  | HRM                | -                            |
| `frmDepartment.cs`                | HRM                | -                            |
| `frmPayrollDetails.cs`            | HRM                | Finance                      |
| `frmProduct.cs`                   | Inventory          | -                            |
| `frmInventoryItem.cs`             | Inventory          | -                            |
| `frmProductConsumption.cs`        | Inventory          | -                            |
| `frmCategory.cs`                  | Inventory          | -                            |
| `frmLocation.cs`                  | Inventory          | -                            |
| `frmRfid.cs`                      | Inventory          | -                            |
| `frmCases.cs`                     | Pharmacy/Medical   | CRM                          |
| `frmDisease.cs`                   | Pharmacy/Medical   | -                            |
| `frmPharmacyPrescriptionDatabase.cs` | Pharmacy/Medical   | CRM, Inventory               |
| `frmMain.cs`                      | System/Utility     | -                            |
| `frmMainLogin.cs`                 | System/Utility     | -                            |
| `frmUsers.cs`                     | System/Utility     | -                            |
| `frmEmailGmail.cs`                | System/Utility     | -                            |
| `frmSms.cs`                       | System/Utility     | -                            |
| `frmCountry.cs`                   | System/Utility     | -                            |
| `AboutBox.cs`                     | System/Utility     | -                            |
| `frmSplashScreen.cs`              | System/Utility     | -                            |
| `frmQuickLinks.cs`                | System/Utility     | -                            |
| `frmUALogin1.cs`                  | System/Utility     | -                            |
| `frmUALogin2.cs`                  | System/Utility     | -                            |
| `frmUALogin3.cs`                  | System/Utility     | -                            |
| *Report Forms*                    | *(Varies)*         | *(Mirrors parent form)*      |

## Notes and Verification

This mapping is primarily based on the naming conventions of the forms and a general understanding of a Pharmacy and Enterprise Inventory Management System (PEIMS).

**Methodology and Limitations:**
*   The categorization relies heavily on form names. A deeper code review of each form's `Form_Load` events, button click handlers, and data access logic would provide more precise details on business logic, data interactions, and potential hidden overlaps.
*   The "Overlap Modules" column indicates areas where a form's functionality likely touches upon more than one primary business domain.

**Key Observations:**
*   **Pharmacy/Medical Overlaps:** Forms like `frmCases` (e.g., patient cases) and `frmPharmacyPrescriptionDatabase` inherently overlap with Inventory (for managing medications) and CRM (for patient records).
*   **Login Forms:** The presence of multiple login forms (`frmMainLogin`, `frmUALogin1`, `frmUALogin2`, `frmUALogin3`) suggests different authentication flows, user roles, or possibly an incomplete/redundant implementation that warrants further investigation.
*   **Reporting Forms:** All forms ending with `Report.cs` are assumed to be dedicated reporting interfaces, likely utilizing the Crystal Reports dependency identified earlier. Their module mapping generally mirrors their non-report counterparts.
*   **Finance Module:** There are no explicitly named "Finance" forms. Financial aspects are integrated into CRM (e.g., `frmInvoice`) and HRM (e.g., `frmPayrollDetails`).