# Online Student Enrollment System

## What it is
Like a school registrar's office that never closes, an Online Student Enrollment System (OSES) is a web-based platform allowing students to register for courses, submit personal data, and manage academic records through a browser interface. These systems typically integrate with identity providers, payment processors, and student information databases, creating a complex attack surface spanning authentication, data storage, and third-party APIs.

## Why it matters
In 2021, attackers exploited SQL injection vulnerabilities in a university enrollment portal to extract Social Security Numbers, dates of birth, and financial aid records for over 40,000 students — data that fueled downstream identity theft campaigns. Defenders hardened the system by implementing parameterized queries, WAF rules, and mandatory multi-factor authentication for all student accounts, illustrating how a single unvalidated input field can compromise an entire institution's PII holdings.

## Key facts
- OSES platforms are high-value targets because they aggregate PII, financial data, and authentication credentials in a single application
- Common vulnerabilities include SQL injection, broken access control (IDOR allowing students to view others' records), and insecure direct object references in course registration endpoints
- FERPA (Family Educational Rights and Privacy Act) mandates that institutions protect student education records, making a breach legally consequential beyond reputational damage
- Session management flaws are especially dangerous: enrollment periods create spike traffic that developers sometimes accommodate by weakening token expiration policies
- Role-based access control (RBAC) failures frequently expose administrative functions — such as grade modification — to authenticated but unprivileged student accounts

## Related concepts
[[SQL Injection]] [[Broken Access Control]] [[FERPA Compliance]] [[Session Management]] [[Role-Based Access Control]]