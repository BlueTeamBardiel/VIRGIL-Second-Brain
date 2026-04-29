# POST

## What it is
Like slipping a sealed envelope through a mail slot instead of writing on the outside of the package, POST sends data in the HTTP request body rather than the URL. It is an HTTP method designed to submit data to a server for processing, storage, or action — typically used in login forms, file uploads, and API calls where payload privacy and size matter.

## Why it matters
Attackers exploit POST requests in credential stuffing attacks, automating thousands of login attempts against a login endpoint because POST body data doesn't appear in server logs or browser history as readily as GET parameters. Defenders monitor POST traffic to `/login`, `/auth`, and `/api` endpoints for anomalous volume or rate patterns as a key detection signal in web application security.

## Key facts
- POST data is included in the **request body**, not the URL, so it won't appear in browser history or most server access logs by default — but it is **not encrypted** unless HTTPS is used
- POST is **not idempotent** — sending the same POST request twice may create two separate resources or trigger two actions (unlike GET or PUT)
- SQL injection via POST body parameters is a critical attack vector; WAFs must inspect request bodies, not just URLs
- CSRF (Cross-Site Request Forgery) attacks frequently abuse POST requests to trick authenticated users into submitting unintended actions
- POST requests can carry **any content type**: JSON (`application/json`), form data (`application/x-www-form-urlencoded`), or multipart (file uploads) — each requires different input validation

## Related concepts
[[HTTP Methods]] [[CSRF]] [[SQL Injection]] [[Web Application Firewall]] [[HTTPS]]