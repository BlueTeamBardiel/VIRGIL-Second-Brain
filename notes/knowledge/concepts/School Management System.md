# School Management System

## What it is
Think of it like a hospital's patient record system, but for students — one centralized platform managing enrollment, grades, attendance, finances, and staff data all under one roof. A School Management System (SMS) is a web-based application that consolidates administrative and academic operations for educational institutions. Because it handles PII for minors, financial records, and authentication credentials, it represents a high-value, often under-secured target.

## Why it matters
In 2022, attackers exploited an unauthenticated SQL injection vulnerability in the open-source "Online School Management System" (OSMS) to dump entire student databases — including home addresses, guardian contact information, and login credentials stored in plaintext. This is a textbook case of how legacy educational software skips security hardening because procurement prioritizes features and cost over threat modeling. FERPA violations and reputational damage followed immediately.

## Key facts
- SMS platforms frequently suffer from **OWASP Top 10** vulnerabilities — especially SQL injection (A03) and broken access control (A01) — due to rapid development cycles with minimal security review
- Student data falls under **FERPA** (U.S.) and **COPPA** if users are under 13, making breaches legally consequential beyond just reputational harm
- Default credentials and unpatched admin portals are the most common initial access vector; attackers use **Shodan** to locate exposed SMS login pages
- **Privilege escalation** is a critical risk — a student-level account exploiting IDOR flaws to modify grades or access teacher dashboards is a well-documented attack pattern
- SMS platforms often integrate with **SSO/LDAP**, meaning a single compromised credential can pivot into broader Active Directory compromise across the institution

## Related concepts
[[SQL Injection]] [[IDOR (Insecure Direct Object Reference)]] [[FERPA Compliance]] [[Broken Access Control]] [[Default Credentials]]