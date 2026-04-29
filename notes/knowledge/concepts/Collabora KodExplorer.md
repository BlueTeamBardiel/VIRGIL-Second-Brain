# Collabora KodExplorer

## What it is
Think of it like a Swiss Army knife left unlocked in a hotel room — powerful, convenient, and dangerous if the wrong person finds it. Collabora KodExplorer (also known simply as KodExplorer) is a web-based file manager and code editor that runs on a server, allowing users to browse, upload, edit, and execute files through a browser interface.

## Why it matters
In 2023, CVE-2023-35885 was disclosed — a path traversal vulnerability in KodExplorer that allowed authenticated attackers to read arbitrary files outside the intended web root, potentially exposing `/etc/passwd`, SSH keys, or application credentials. Attackers who compromise low-privilege KodExplorer accounts can chain this with other vulnerabilities to achieve full server takeover, making it a meaningful pivot point in web application penetration tests.

## Key facts
- **CVE-2023-35885** is a path traversal vulnerability in KodExplorer versions prior to 4.51 allowing arbitrary file reads by authenticated users.
- KodExplorer is written in PHP and is self-hosted, meaning misconfigured deployments frequently expose it to the public internet without proper authentication hardening.
- Because it provides a built-in code editor and file upload functionality, a successful exploit can quickly escalate to **Remote Code Execution (RCE)** by uploading a PHP web shell.
- Path traversal attacks use sequences like `../../../` to escape the intended directory sandbox — a classic technique testable on Security+/CySA+ exams.
- Default or weak credentials on KodExplorer installations are a common initial access vector found during external attack surface assessments.

## Related concepts
[[Path Traversal Attack]] [[Remote Code Execution]] [[Web Shell]] [[File Upload Vulnerability]] [[PHP Security]]