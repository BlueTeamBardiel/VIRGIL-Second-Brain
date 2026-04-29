# fileUpload Endpoint

## What it is
Think of it like a mailroom that accepts packages without checking if the box contains a bomb — a file upload endpoint is a web application interface that accepts files from users and stores or processes them on the server. Precisely, it is an HTTP endpoint (typically accepting POST requests) that handles multipart/form-data submissions, saving user-supplied files to disk, a database, or cloud storage.

## Why it matters
In the 2017 Apache Struts vulnerability exploited against Equifax, attackers leveraged improper input handling on a web endpoint — a file upload flaw allows analogous attacks where an adversary uploads a PHP webshell disguised as an innocent profile picture, achieving Remote Code Execution (RCE) simply by navigating to the uploaded file's URL. Defending this correctly is the difference between a functioning website and a fully compromised server.

## Key facts
- **Unrestricted file upload** is an OWASP Top 10-adjacent vulnerability; attackers bypass weak filters by changing file extensions (e.g., `shell.php` → `shell.php.jpg`) or manipulating MIME types in the Content-Type header
- **Magic bytes validation** (inspecting the actual file signature/header bytes) is more reliable than extension or MIME-type checking alone, since both can be trivially spoofed
- Uploaded files should **never be stored in a web-accessible directory** — storing outside the web root prevents direct execution of uploaded malicious scripts
- **Content Disposition and execution permissions** must be stripped; web servers should be configured to never execute files in upload directories (e.g., `php_flag engine off` in `.htaccess`)
- Antivirus scanning, file size limits, and **randomizing stored filenames** are defense-in-depth controls that slow or prevent exploitation

## Related concepts
[[Unrestricted File Upload]] [[Web Shell]] [[MIME Type Spoofing]] [[Input Validation]] [[Remote Code Execution]]