# API testing

## What it is
Think of an API like a restaurant's kitchen window — customers (apps) send orders through it, but what happens if you shout a weird order nobody planned for? API testing is the practice of probing application programming interfaces to discover misconfigurations, broken authentication, excessive data exposure, and logic flaws before attackers do. It involves sending crafted requests to endpoints and analyzing responses for unintended behavior.

## Why it matters
In 2019, Facebook's API exposed millions of user records because developers left debug endpoints publicly accessible — endpoints that returned far more data than the mobile app ever displayed on screen. A security tester performing API enumeration and parameter fuzzing would have caught this "excessive data exposure" vulnerability before production. This is exactly why API testing is now a core skill in any web application penetration test.

## Key facts
- **OWASP API Security Top 10** is the primary reference framework — know it for CySA+; top risks include Broken Object Level Authorization (BOLA) and Broken Authentication
- **Fuzzing** API parameters (e.g., changing `user_id=123` to `user_id=124`) tests for **Broken Object Level Authorization (BOLA/IDOR)**, the #1 API vulnerability
- Tools commonly used: **Burp Suite**, **Postman**, and **OWASP ZAP** for intercepting and manipulating API traffic
- **API documentation leakage** (exposed Swagger/OpenAPI spec files) can give attackers a complete map of endpoints — always check `/swagger.json` or `/api-docs`
- REST APIs return HTTP status codes that reveal logic: a `403` vs `404` difference can confirm whether a resource exists, aiding enumeration

## Related concepts
[[OWASP Top 10]] [[Fuzzing]] [[Broken Access Control]] [[Penetration Testing]] [[IDOR]]