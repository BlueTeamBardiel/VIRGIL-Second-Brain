# DELETE

## What it is
Like a librarian removing a book from the catalog but leaving the physical book on the shelf, the HTTP DELETE method requests that a server remove a specified resource — but whether the data is truly gone depends entirely on server implementation. It is one of the standard HTTP verbs in RESTful APIs, designed to instruct a web server to destroy the identified resource at a given URI.

## Why it matters
In 2019, researchers found misconfigured Elasticsearch and Solr instances exposed to the internet where unauthenticated DELETE requests could wipe entire databases — no exploit required, just sending `DELETE /index_name` to an open port. Defenders must ensure DELETE endpoints require authentication, authorization checks, and audit logging, since a single unprotected endpoint can enable complete data destruction or ransomware-style leverage without any malware.

## Key facts
- DELETE is an **idempotent** HTTP method — sending the same DELETE request multiple times should produce the same result (resource stays gone), distinguishing it from POST
- Unlike GET or HEAD, DELETE **should not be cacheable** by default, though misconfigured proxies sometimes cache responses unexpectedly
- **OWASP API Security Top 10** highlights broken object-level authorization (BOLA) as a primary risk — attackers may call DELETE on resources belonging to other users by manipulating IDs in the URL
- A **405 Method Not Allowed** response indicates DELETE is disabled server-side; attackers use OPTIONS requests to enumerate which methods are permitted
- In **SQL injection context**, `DELETE` statements injected into input fields can truncate tables — parameterized queries and stored procedures are the primary defense

## Related concepts
[[HTTP Methods]] [[REST API Security]] [[OWASP API Security Top 10]] [[SQL Injection]] [[Access Control]]