# principle of input distrust

## What it is
Like a customs agent who X-rays every bag regardless of whether the traveler looks friendly, secure software treats all input as potentially hostile until proven otherwise. Also called "never trust user input," this principle holds that any data entering a system boundary — from users, APIs, files, or other services — must be validated, sanitized, or rejected before use. The source of the input is irrelevant; the content itself must earn trust.

## Why it matters
SQL injection attacks succeed almost entirely because developers trusted that form fields would contain only what users were *supposed* to enter. An attacker who submits `' OR '1'='1` into a login field can bypass authentication because the application passed raw input directly into a database query — a textbook violation of input distrust. Parameterized queries enforce the principle by treating user data as data, never as executable code.

## Key facts
- **All input surfaces are attack surfaces**: HTTP parameters, headers, cookies, file uploads, environment variables, and IPC messages must all be distrusted
- **Allowlist over denylist**: Defining what *is* acceptable (allowlisting) is stronger than trying to block every bad pattern (denylisting), which attackers can often bypass
- **Validation ≠ sanitization**: Validation checks whether input meets expected format; sanitization transforms or escapes it — both may be necessary
- **Trust boundary**: Input distrust applies at every system layer change — client→server, server→database, service→service (relevant for microservices and zero trust models)
- **Server-side enforcement is mandatory**: Client-side validation (JavaScript) is a UX convenience, not a security control — it is trivially bypassed with tools like Burp Suite

## Related concepts
[[input validation]] [[SQL injection]] [[cross-site scripting (XSS)]] [[trust boundaries]] [[defense in depth]]