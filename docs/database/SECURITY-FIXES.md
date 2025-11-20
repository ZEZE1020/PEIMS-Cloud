# Security Vulnerability Fixes

**Status:** Documented - Awaiting Implementation  
**Priority:** CRITICAL  
**Affected Forms:** 5 forms with SQL injection vulnerabilities

---

## 1. SQL Injection Vulnerabilities

### Vulnerability 1: frmMainLogin.cs (Line 26)

**Current Code:**
```csharp
MySqlCommand SelectCommand = new MySqlCommand(
    "SELECT * FROM pharma.users WHERE username='" + this.userNameTextBox.Text + 
    "' and password='" + passwordTextBox.Text + "' ; ", myConn);
```

**Fixed Code:**
```csharp
MySqlCommand SelectCommand = new MySqlCommand(
    "SELECT * FROM pharma.users WHERE username=@username AND password=@password", myConn);
SelectCommand.Parameters.AddWithValue("@username", this.userNameTextBox.Text);
SelectCommand.Parameters.AddWithValue("@password", passwordTextBox.Text);
```

---

### Vulnerability 2: frmUALogin1.cs (Line 26)

**Current Code:**
```csharp
MySqlCommand SelectCommand = new MySqlCommand(
    "SELECT * FROM pharma.users WHERE username='" + this.userNameTextBox.Text + 
    "' and password='" + passwordTextBox.Text + "' ; ", myConn);
```

**Fixed Code:**
```csharp
MySqlCommand SelectCommand = new MySqlCommand(
    "SELECT * FROM pharma.users WHERE username=@username AND password=@password", myConn);
SelectCommand.Parameters.AddWithValue("@username", this.userNameTextBox.Text);
SelectCommand.Parameters.AddWithValue("@password", passwordTextBox.Text);
```

---

### Vulnerability 3: frmUALogin2.cs (Line 26)

**Current Code:**
```csharp
MySqlCommand SelectCommand = new MySqlCommand(
    "SELECT * FROM pharma.users WHERE username='" + this.userNameTextBox.Text + 
    "' and password='" + passwordTextBox.Text + "' ; ", myConn);
```

**Fixed Code:**
```csharp
MySqlCommand SelectCommand = new MySqlCommand(
    "SELECT * FROM pharma.users WHERE username=@username AND password=@password", myConn);
SelectCommand.Parameters.AddWithValue("@username", this.userNameTextBox.Text);
SelectCommand.Parameters.AddWithValue("@password", passwordTextBox.Text);
```

---

### Vulnerability 4: frmEmployee.cs (Line 220)

**Current Code:**
```csharp
string Query = "insert into pharma.employees (employeeID,firstName,lastName,middleName," +
    "dateOfBirth,departmentID,designation,email,address,mobileNo,extensionNo,nextOfKin," +
    "genger,age,maritalStatus,passportPic,degreeAttained) values ('" + 
    this.employeeIDTextBox.Text + "','" + this.firstNameTextBox.Text + "','" + 
    this.lastNameTextBox.Text + "','" + this.dateOfBirth_dateTimePicker.Text + "', '" + 
    this.departmentIDTextBox.Text + "','" + this.designationTextBox.Text + "','" + 
    this.emailTextBox.Text + "','" + this.addressTextBox.Text + "','" + 
    this.mobileNoTextBox.Text + "','" + this.extensionNoTextBox.Text + "','" + 
    this.nextOfKinTextBox.Text + "','" + this.genderTextBox.Text + "','" + 
    this.ageTextBox.Text + "','" + this.maritalStatusTextBox.Text + "','" + 
    this.passportPicPictureBox.Text + "','" + this.degreeAttainedTextBox.Text + "') ;";
MySqlCommand cmdDb = new MySqlCommand(Query, conDb);
```

**Fixed Code:**
```csharp
string Query = "INSERT INTO pharma.employees (employeeID,firstName,lastName,middleName," +
    "dateOfBirth,departmentID,designation,email,address,mobileNo,extensionNo,nextOfKin," +
    "gender,age,maritalStatus,passportPic,degreeAttained) VALUES " +
    "(@empID,@firstName,@lastName,@middleName,@dob,@deptID,@designation,@email," +
    "@address,@mobile,@ext,@nextOfKin,@gender,@age,@marital,@passport,@degree)";

MySqlCommand cmdDb = new MySqlCommand(Query, conDb);
cmdDb.Parameters.AddWithValue("@empID", this.employeeIDTextBox.Text);
cmdDb.Parameters.AddWithValue("@firstName", this.firstNameTextBox.Text);
cmdDb.Parameters.AddWithValue("@lastName", this.lastNameTextBox.Text);
cmdDb.Parameters.AddWithValue("@middleName", this.middleNameTextBox.Text);
cmdDb.Parameters.AddWithValue("@dob", this.dateOfBirth_dateTimePicker.Value);
cmdDb.Parameters.AddWithValue("@deptID", this.departmentIDTextBox.Text);
cmdDb.Parameters.AddWithValue("@designation", this.designationTextBox.Text);
cmdDb.Parameters.AddWithValue("@email", this.emailTextBox.Text);
cmdDb.Parameters.AddWithValue("@address", this.addressTextBox.Text);
cmdDb.Parameters.AddWithValue("@mobile", this.mobileNoTextBox.Text);
cmdDb.Parameters.AddWithValue("@ext", this.extensionNoTextBox.Text);
cmdDb.Parameters.AddWithValue("@nextOfKin", this.nextOfKinTextBox.Text);
cmdDb.Parameters.AddWithValue("@gender", this.genderTextBox.Text);
cmdDb.Parameters.AddWithValue("@age", this.ageTextBox.Text);
cmdDb.Parameters.AddWithValue("@marital", this.maritalStatusTextBox.Text);
cmdDb.Parameters.AddWithValue("@passport", this.passportPicPictureBox.Text);
cmdDb.Parameters.AddWithValue("@degree", this.degreeAttainedTextBox.Text);
```

---

### Vulnerability 5: frmCases.cs (Line 160)

**Current Code:**
```csharp
s = "select * from pharma.cases where (caseID = '" + caseIDTextBox.Text + 
    "') OR (diseaseID = '" + diseaseIDTextBox.Text + "')";
mcd = new MySqlCommand(s, mcon);
```

**Fixed Code:**
```csharp
s = "SELECT * FROM pharma.cases WHERE caseID = @caseID OR diseaseID = @diseaseID";
mcd = new MySqlCommand(s, mcon);
mcd.Parameters.AddWithValue("@caseID", caseIDTextBox.Text);
mcd.Parameters.AddWithValue("@diseaseID", diseaseIDTextBox.Text);
```

---

## 2. Password Security

### Issue: Plain Text Password Storage

**Current Implementation:**
- Passwords stored as plain text in `users` table
- Direct comparison: `WHERE password='...'`

**Recommended Fix:**

**Step 1: Add password hashing library**
```bash
Install-Package BCrypt.Net-Next
```

**Step 2: Update registration code**
```csharp
using BCrypt.Net;

// When creating new user
string hashedPassword = BCrypt.HashPassword(passwordTextBox.Text);

// Store hashedPassword in database instead of plain text
```

**Step 3: Update login code**
```csharp
// Retrieve hashed password from database
MySqlCommand cmd = new MySqlCommand(
    "SELECT password FROM pharma.users WHERE username=@username", conn);
cmd.Parameters.AddWithValue("@username", userNameTextBox.Text);

string storedHash = cmd.ExecuteScalar()?.ToString();

// Verify password
if (storedHash != null && BCrypt.Verify(passwordTextBox.Text, storedHash))
{
    // Login successful
}
```

**Step 4: Migrate existing passwords**
```sql
-- Add new column for hashed passwords
ALTER TABLE users ADD COLUMN password_hash VARCHAR(255);

-- Application code to migrate (run once)
-- Read each user, hash their password, update password_hash column
-- Then drop old password column and rename password_hash to password
```

---

## 3. Connection String Security

### Issue: Hardcoded Connection Strings

**Current Implementation:**
```csharp
// Hardcoded in every form
string strConn = "server=localhost;user id=root;database=pharma;password=;";
```

**Recommended Fix:**

**Step 1: Create centralized connection manager**

Create `DatabaseHelper.cs`:
```csharp
using System.Configuration;
using MySql.Data.MySqlClient;

namespace PEIMSV3Cs
{
    public static class DatabaseHelper
    {
        private static string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["pharmaConnectionString"].ConnectionString;
            }
        }

        public static MySqlConnection GetConnection()
        {
            return new MySqlConnection(ConnectionString);
        }

        public static MySqlDataAdapter GetDataAdapter(string query)
        {
            return new MySqlDataAdapter(query, ConnectionString);
        }
    }
}
```

**Step 2: Update app.config**
```xml
<connectionStrings>
    <add name="pharmaConnectionString" 
         connectionString="server=localhost;user id=pharma_app;database=pharma;password=SecurePassword123!;SslMode=Required" 
         providerName="MySql.Data.MySqlClient"/>
</connectionStrings>
```

**Step 3: Update all forms**
```csharp
// Old code
string strConn = "server=localhost;user id=root;database=pharma;password=;";
MySqlDataAdapter ad = new MySqlDataAdapter("select * from customer", strConn);

// New code
MySqlDataAdapter ad = DatabaseHelper.GetDataAdapter("select * from customer");
```

**Step 4: Use AWS Secrets Manager (for cloud)**
```csharp
using Amazon.SecretsManager;
using Amazon.SecretsManager.Model;

public static class DatabaseHelper
{
    private static string GetConnectionStringFromSecrets()
    {
        var client = new AmazonSecretsManagerClient();
        var request = new GetSecretValueRequest
        {
            SecretId = "peims/database/connection"
        };
        var response = client.GetSecretValueAsync(request).Result;
        return response.SecretString;
    }
}
```

---

## 4. Database User Security

### Issue: Using root Account

**Current:** All connections use `root` user

**Recommended Fix:**

```sql
-- Create application-specific user
CREATE USER 'pharma_app'@'localhost' IDENTIFIED BY 'SecurePassword123!';

-- Grant only necessary permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON pharma.* TO 'pharma_app'@'localhost';

-- Do NOT grant DROP, CREATE, ALTER, etc.

-- Flush privileges
FLUSH PRIVILEGES;
```

---

## Implementation Checklist

### Phase 1: SQL Injection Fixes (Week 1)
- [ ] Fix frmMainLogin.cs
- [ ] Fix frmUALogin1.cs
- [ ] Fix frmUALogin2.cs
- [ ] Fix frmEmployee.cs
- [ ] Fix frmCases.cs
- [ ] Test all fixed forms
- [ ] Code review

### Phase 2: Password Security (Week 2)
- [ ] Install BCrypt.Net-Next
- [ ] Update user registration forms
- [ ] Update login forms
- [ ] Create password migration script
- [ ] Test authentication
- [ ] Migrate existing passwords

### Phase 3: Connection String (Week 3)
- [ ] Create DatabaseHelper class
- [ ] Update app.config
- [ ] Create database user (pharma_app)
- [ ] Update all 20 forms
- [ ] Test all forms
- [ ] Remove hardcoded strings

### Phase 4: Testing (Week 4)
- [ ] Security testing
- [ ] Penetration testing
- [ ] User acceptance testing
- [ ] Performance testing
- [ ] Documentation update

---

## Testing Procedures

### SQL Injection Testing

**Test Case 1: Login bypass**
```
Username: admin' OR '1'='1
Password: anything
Expected: Login should FAIL (after fix)
```

**Test Case 2: Data extraction**
```
Username: admin' UNION SELECT * FROM users--
Password: anything
Expected: Should not return data (after fix)
```

### Password Security Testing

**Test Case 1: Verify hashing**
```
1. Create user with password "test123"
2. Check database - should see bcrypt hash (starts with $2a$ or $2b$)
3. Login with "test123" - should succeed
4. Login with wrong password - should fail
```

---

**Last Updated:** 2024  
**Status:** Ready for Implementation  
**Priority:** CRITICAL
