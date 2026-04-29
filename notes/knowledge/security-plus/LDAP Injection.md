# LDAP Injection

## What it is
Imagine a library card catalog where you whisper a search request to the librarian — but you slip extra instructions into your whisper that change *what she searches for entirely*. LDAP Injection occurs when an attacker inserts malicious characters into input fields that are used to construct LDAP queries, causing the directory service to execute unintended commands. It exploits insufficient input sanitization in applications that query LDAP-based directories like Active Directory.

## Why it matters
A classic attack targets login forms: an application builds an LDAP query like `(&(uid=USER)(password=PASS))`. By entering `*)(uid=*))(|(uid=*` as the username, an attacker can manipulate the query logic to return TRUE regardless of the password, achieving authentication bypass. This has been weaponized against corporate portals using Active Directory as their authentication backend, granting attackers access without valid credentials.

## Key facts
- **Special characters to sanitize**: `( ) * \ / NUL & |` are the primary LDAP metacharacters used in injection payloads
- **Two query types are vulnerable**: search filters and distinguished name (DN) construction queries both require separate sanitization strategies
- **Wildcard abuse**: A lone `*` as input can dump entire directory contents if search results aren't restricted by the application
- **Defense**: Use parameterized LDAP queries or allowlist input validation; OWASP recommends escaping all metacharacters before query construction
- **Distinct from SQL Injection**: LDAP Injection targets directory services (X.500 protocol) rather than relational databases, but follows the same root cause — unsanitized input reaching an interpreter

## Related concepts
[[SQL Injection]] [[Active Directory]] [[Input Validation]] [[Authentication Bypass]] [[Directory Services]]