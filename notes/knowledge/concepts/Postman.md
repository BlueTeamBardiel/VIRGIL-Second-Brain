# Postman

## What it is
Think of Postman like a universal TV remote that can send any signal to any device — letting you craft and fire HTTP requests at APIs without needing a browser or application front-end. Precisely, Postman is a GUI-based API testing and development tool that allows users to manually construct HTTP/HTTPS requests (GET, POST, PUT, DELETE, etc.), inspect responses, and automate API workflows.

## Why it matters
During a web application penetration test, an attacker can use Postman to bypass a mobile app's front-end input validation entirely, sending malicious payloads directly to a REST API endpoint that the developers assumed only their app would call. This technique has exposed broken object-level authorization (BOLA/IDOR) vulnerabilities in countless production APIs, where changing a single user ID parameter in a request reveals another user's data. Defenders use Postman collections to document and regression-test API security controls after patching.

## Key facts
- Postman can import API specifications (OpenAPI/Swagger) and auto-generate requests, making it a fast reconnaissance tool for mapping attack surfaces
- Supports environment variables, allowing testers to quickly swap between staging and production targets or rotate authentication tokens
- Postman's "Interceptor" feature can capture browser traffic, similar to Burp Suite's proxy functionality, making it useful for session token harvesting during assessments
- Collections can be exported and run headlessly via **Newman** (Postman's CLI runner), enabling automated security regression testing in CI/CD pipelines
- A common exam scenario: using Postman to test for improper HTTP method handling — e.g., a server accepting a DELETE request on an endpoint that should only allow GET

## Related concepts
[[API Security]] [[IDOR]] [[Burp Suite]] [[REST API]] [[Input Validation]]