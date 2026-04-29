# Datatables

## What it is
Think of a datatables library like a smart spreadsheet widget bolted onto a webpage — it takes raw HTML tables and supercharges them with sorting, searching, and pagination entirely in the browser. Precisely, Datatables is a popular jQuery JavaScript plugin (and standalone library) that renders interactive, client-side or server-side data tables in web applications. It processes and displays structured data dynamically without requiring full page reloads.

## Why it matters
Datatables frequently appears in security assessments because its server-side processing mode passes user-controlled parameters — like `search[value]`, `order[0][column]`, and `start` — directly to backend queries. If a developer naively concatenates these parameters into SQL statements, an attacker can inject malicious SQL through the search box, achieving full database read access without ever touching a custom input field. This attack vector has been documented in multiple CVEs against applications using unparameterized Datatables server-side endpoints.

## Key facts
- **Client-side vs. server-side mode**: In client-side mode, all data is loaded at once into the DOM — a data exposure risk if sensitive records are loaded but hidden by pagination. In server-side mode, the backend receives raw HTTP parameters that must be sanitized.
- **Common injection point**: The `search[value]` parameter in AJAX requests is a well-known SQLi vector in server-side Datatables implementations.
- **DOM-based XSS risk**: Datatables renders data using `innerHTML` by default in some configurations, enabling stored or reflected XSS if output is unsanitized.
- **IDOR via parameter tampering**: Manipulating `start`, `length`, and `order` parameters can sometimes access unauthorized records if server-side access controls are absent.
- **Mitigation**: Use parameterized queries or ORM bindings for all Datatables server-side parameters; sanitize and validate `columns`, `order`, and `search` inputs explicitly.

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Insecure Direct Object Reference (IDOR)]] [[Client-Side Data Exposure]]