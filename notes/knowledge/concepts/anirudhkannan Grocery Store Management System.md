# anirudhkannan Grocery Store Management System

## What it is
Like a poorly-locked stockroom where the inventory clipboard is left in plain sight, this is a PHP-based web application for managing grocery store inventory, sales, and users — built with common educational-grade security shortcuts that make it a textbook target. It represents a class of small, open-source management systems frequently deployed without hardening, where default credentials and SQL injection vulnerabilities are baked into the codebase from the start.

## Why it matters
Attackers routinely scan GitHub for openly-published source code like this to fingerprint live deployments and exploit known weaknesses — a technique called source code reconnaissance. A penetration tester assessing a small retail business might find this system running with default admin credentials (`admin/admin`) and unparameterized SQL queries, allowing full database exfiltration of customer and transaction data in minutes.

## Key facts
- Contains classic **SQL injection** vulnerabilities in login and search forms due to unsanitized user input concatenated directly into queries
- Likely uses **plaintext or weakly hashed passwords** (MD5) in the database, violating NIST SP 800-63B guidance
- **Default credentials** left unchanged represent a CWE-1392 violation and are among the top causes of small-business breaches
- The application likely lacks **CSRF tokens** on forms, enabling cross-site request forgery attacks against authenticated admin sessions
- As an educational PHP app, it demonstrates **insecure direct object reference (IDOR)** risks — accessing records by sequential IDs without authorization checks

## Related concepts
[[SQL Injection]] [[Insecure Direct Object Reference]] [[Cross-Site Request Forgery]] [[Default Credentials]] [[Insecure Password Storage]]