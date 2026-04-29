# index.php

## What it is
Like a lobby receptionist who greets every visitor entering a building, `index.php` is the default entry-point file a web server automatically loads when a directory is requested without a specific filename. It is a PHP-based default document that handles routing, authentication checks, and initial application logic before any other page renders.

## Why it matters
Attackers frequently target `index.php` with Local File Inclusion (LFI) attacks by manipulating parameters like `?page=../../../etc/passwd`, exploiting poor input sanitization in the file's routing logic. A vulnerable `index.php` that blindly includes user-supplied filenames can expose the entire server filesystem or enable Remote Code Execution (RCE) if combined with log poisoning techniques.

## Key facts
- Web servers (Apache, Nginx) serve `index.php` automatically via the **DirectoryIndex** directive, making it the universal attack surface for web application exploitation
- Exposing PHP error messages through a misconfigured `index.php` reveals server paths, PHP version, and database credentials — valuable reconnaissance for attackers
- **File inclusion vulnerabilities** (LFI/RFI) in `index.php` are classified under **CWE-98** and appear on the OWASP Top 10 under A03:2021 (Injection)
- A missing or blank `index.php` in subdirectories can cause **directory listing**, exposing sensitive files to unauthenticated users
- Security scanners (Nikto, Gobuster) specifically probe for `index.php` as an initial fingerprinting step to identify frameworks like WordPress, Joomla, or Laravel

## Related concepts
[[Local File Inclusion (LFI)]] [[Directory Traversal]] [[Web Application Firewall (WAF)]] [[PHP Security]] [[Directory Listing]]