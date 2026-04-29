# CRUD

## What it is
Like a librarian who can add new books, read existing ones, update their records, and remove damaged copies — CRUD describes the four fundamental operations any data system must perform: **Create, Read, Update, and Delete**. These are the atomic actions underlying virtually every database interaction, API endpoint, and web application feature.

## Why it matters
Attackers targeting web applications frequently exploit improperly secured CRUD operations — for example, a poorly authorized "Update" endpoint that allows a low-privilege user to modify another user's account data (an Insecure Direct Object Reference vulnerability). Defenders use CRUD as a framework to enforce least-privilege access controls, ensuring each user role can only perform the specific operations they legitimately need on specific resources.

## Key facts
- **CRUD maps directly to HTTP methods**: Create → POST, Read → GET, Update → PUT/PATCH, Delete → DELETE — making REST API security reviews predictable and structured
- **Missing authorization checks on any single CRUD operation** creates a vulnerability; attackers probe all four, not just the obvious ones
- **Broken Object Level Authorization (BOLA/IDOR)** — OWASP API Security Top 10 #1 — almost always involves unauthorized Read or Update operations against another user's resources
- **Audit logging** should capture all four CRUD events for sensitive data; missing Delete logs is a common forensic blind spot attackers exploit to cover tracks
- **Excessive data exposure** typically occurs in Read operations where APIs return full database objects instead of filtered, role-appropriate fields

## Related concepts
[[IDOR]] [[REST API Security]] [[Least Privilege]] [[Access Control]] [[SQL Injection]]