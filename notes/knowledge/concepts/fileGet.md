# fileGet

## What it is
Like a librarian fetching any book you request — even ones from the restricted back room — `fileGet` refers to functions or API methods that retrieve file contents from a system, often without sufficient access controls validating *who* is asking or *what* they're allowed to read. Precisely, it is a file retrieval operation (common in web frameworks, FTP commands, and cloud APIs) that reads and returns file data, and becomes a vulnerability when user-supplied input directly influences which file path is resolved.

## Why it matters
Attackers exploit insecure `fileGet`-style operations to perform **Local File Inclusion (LFI)** or **Path Traversal** attacks. For example, a PHP application using `file_get_contents($_GET['path'])` without sanitization lets an attacker request `../../etc/passwd` to dump system credentials — a real-world pattern seen in countless CVEs against web applications and NAS devices. Defenders must validate and sanitize all file path inputs and apply principle of least privilege to file system access.

## Key facts
- **Path traversal sequences** like `../`, URL-encoded as `%2e%2e%2f`, are the primary exploit vector against unvalidated `fileGet` implementations.
- **OWASP A01 (Broken Access Control)** and **A03 (Injection)** both cover insecure file retrieval scenarios — exam-relevant classification.
- Insecure `fileGet` calls can expose `/etc/shadow`, application config files, and private keys — escalating from information disclosure to full system compromise.
- Mitigations include **allowlisting** valid file paths, using **chroot jails** or **containerization** to limit accessible directories, and stripping traversal characters server-side.
- FTP's `RETR` command is the protocol-level analog — a `fileGet` operation that historically enabled anonymous retrieval of sensitive files when misconfigured.

## Related concepts
[[Path Traversal]] [[Local File Inclusion]] [[Insecure Direct Object Reference]] [[Least Privilege]] [[Input Validation]]