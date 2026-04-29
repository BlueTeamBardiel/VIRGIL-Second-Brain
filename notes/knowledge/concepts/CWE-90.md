# CWE-90

## What it is
Like a locksmith who blindly follows a note slipped under the door without verifying who wrote it, an LDAP query that trusts unsanitized user input will execute commands it was never meant to run. CWE-90 is LDAP Injection — a vulnerability where attacker-controlled input is inserted into an LDAP query, altering its logic to bypass authentication or extract unauthorized directory data. It mirrors SQL Injection but targets directory services like Active Directory or OpenLDAP instead of relational databases.

## Why it matters
In a corporate environment, an attacker exploiting LDAP Injection on a login portal might submit the username `*)(uid=*))(|(uid=*` to manipulate the filter into always returning true, bypassing password verification entirely. This grants unauthorized access to any account in the directory — including administrators — without knowing a single valid password. Organizations running web applications that authenticate against Active Directory are particularly exposed if input is passed raw into LDAP queries.

## Key facts
- LDAP special characters include `( ) * \ NUL | & = > <` — any of these unescaped in user input can alter query logic
- Two attack types: **authentication bypass** (manipulating filters to return true) and **information disclosure** (extracting directory entries via wildcard injection)
- Mitigation requires **input validation + output encoding** using LDAP-specific escaping libraries (e.g., OWASP's ESAPI `encodeForLDAP()`)
- LDAP Injection is listed in the **OWASP Top 10** under A03:2021 – Injection
- Unlike SQL Injection, LDAP Injection rarely allows data modification since most LDAP implementations are read-optimized; the primary risk is **confidentiality and authentication bypass**

## Related concepts
[[SQL Injection]] [[LDAP Authentication]] [[Input Validation]] [[CWE-89]] [[Directory Services Security]]