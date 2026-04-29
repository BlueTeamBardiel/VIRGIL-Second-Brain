# PUT

## What it is
Like replacing an entire page in a binder rather than scribbling a note in the margin, PUT is an HTTP method that overwrites a resource at a specified URL with the exact content you send. Unlike PATCH (which modifies partially), PUT replaces the entire resource — if it doesn't exist, some servers will create it.

## Why it matters
Misconfigured web servers that allow unauthenticated PUT requests are a classic attack vector: an attacker can upload a malicious web shell (e.g., `PUT /shell.php`) directly to the server, gaining remote code execution. This was exploited heavily against older Apache and IIS configurations and remains a test case in penetration assessments today.

## Key facts
- PUT is one of the "unsafe" HTTP methods alongside POST, DELETE, and PATCH — it modifies server state and should require authentication/authorization
- Web servers like older IIS with WebDAV enabled often had PUT enabled by default, creating a direct file upload vulnerability
- A properly secured server should return `405 Method Not Allowed` or `401 Unauthorized` when PUT is called without valid credentials
- Nmap's `http-methods` script and tools like `curl -X PUT` are commonly used to enumerate whether PUT is enabled on a target
- Unlike POST, PUT is defined as **idempotent** — sending the same PUT request multiple times produces the same result, which matters for API security design

## Related concepts
[[HTTP Methods]] [[WebDAV]] [[Remote Code Execution]] [[Web Shell]] [[REST API Security]]