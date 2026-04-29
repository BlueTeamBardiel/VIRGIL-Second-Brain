# CWE-23

## What it is
Like a postal worker who delivers a package to "123 Main St/../../Mayor's Office" by literally following every directory instruction in the address, Relative Path Traversal occurs when an application uses unsanitized user input containing `../` sequences to construct file paths. This allows attackers to escape the intended directory and access files anywhere the application has permission to read.

## Why it matters
In 2021, attackers exploited path traversal vulnerabilities in Accellion FTA file-transfer appliances, using `../` sequences to read configuration files and steal credentials outside the web root. The attack led to massive data breaches at dozens of organizations including universities and government agencies, demonstrating that file-access logic is a critical attack surface.

## Key facts
- The vulnerability differs from CWE-22 (Path Traversal) specifically because it involves **relative** paths (using `../`) rather than absolute paths — both are related but distinct weakness entries
- Common payload patterns include `../`, `..\` (Windows), `..%2F` (URL-encoded), and `....//` (double encoding bypass)
- Proper defense requires **canonicalizing** the path first (resolving to absolute form), then validating it starts with the approved base directory — blocklisting `../` alone is insufficient
- Languages like Python (`os.path.realpath()`), Java (`getCanonicalPath()`), and PHP (`realpath()`) provide canonicalization functions specifically to address this
- CVSS scores for path traversal vulnerabilities frequently reach 7.5–9.1 (High/Critical) due to potential access to `/etc/passwd`, private keys, or application source code

## Related concepts
[[CWE-22 Path Traversal]] [[Input Validation]] [[Directory Indexing]] [[File Inclusion Vulnerability]]