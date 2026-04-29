# kodcloud KodExplorer

## What it is
Think of it as a Swiss Army knife web-based file manager — like having Windows Explorer running entirely in your browser, but hosted on *your* server. KodExplorer (by kodcloud) is a PHP-based web application that provides a full-featured file management interface, code editor, and document viewer accessible via HTTP/HTTPS on self-hosted servers.

## Why it matters
Attackers frequently scan for exposed KodExplorer installations using tools like Shodan or Nuclei because default or weak credentials grant direct filesystem access to the underlying server. In documented CVE-2021-45043, an authenticated user could exploit a path traversal vulnerability to read arbitrary files outside the intended web root — making it a pivot point for credential harvesting and lateral movement after initial compromise.

## Key facts
- **CVE-2021-45043**: Path traversal vulnerability allowing authenticated users to read sensitive system files (e.g., `/etc/passwd`) by manipulating file path parameters.
- KodExplorer runs entirely in PHP with no external dependencies, making it trivially deployable — and trivially forgotten/unpatched on servers.
- Default installations expose the login panel at `/index.php` with weak default credentials (`admin/admin`), a common misconfiguration finding in penetration tests.
- Because it provides a built-in code editor, a compromised KodExplorer account is functionally equivalent to a web shell — attackers can write and execute malicious PHP files directly.
- Threat actors have used KodExplorer as a persistence mechanism, deploying it as a backdoor file manager after initial compromise via other vulnerabilities.

## Related concepts
[[Path Traversal]] [[Web Shell]] [[Default Credentials]]