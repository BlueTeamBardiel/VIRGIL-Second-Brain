# TinyFileManager

## What it is
Like a USB thumb drive plugged directly into a web server — TinyFileManager is a single PHP file (~60KB) that, when dropped into a web directory, provides a full graphical file manager accessible via browser. It allows authenticated (or sometimes unauthenticated) users to upload, delete, rename, and execute files on the server through a simple web interface.

## Why it matters
Attackers frequently exploit exposed or default-credential TinyFileManager installations to upload web shells (e.g., a PHP reverse shell disguised as an image), achieving Remote Code Execution (RCE) on the target server. In 2022, CISA and FBI flagged TinyFileManager as an actively exploited vector in attacks against critical infrastructure, where default credentials (`admin/admin@123`) were never changed post-deployment.

## Key facts
- **Default credentials are hardcoded**: `admin/admin@123` and `user/12345` — leaving defaults unchanged is the single most common exploitation path
- **Single-file deployment risk**: Because it's one PHP file, it can be silently dropped into a compromised server by an attacker to establish persistent file access (a classic web shell characteristic)
- **CVE-2021-45010**: Path traversal vulnerability allowing authenticated users to read files outside the intended directory
- **No installation required**: Zero dependencies beyond PHP — making it trivially deployable and equally trivially weaponized
- **Detection signature**: Security tools flag `tinyfilemanager.php` or its hash in web directories as a high-severity indicator of compromise (IoC)

## Related concepts
[[Web Shell]] [[Remote Code Execution]] [[Default Credentials]] [[Path Traversal]] [[Indicator of Compromise]]