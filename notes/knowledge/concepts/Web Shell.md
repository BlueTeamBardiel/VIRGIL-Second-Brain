# web shell

## What it is
Think of a web shell like leaving a spare key hidden under a doormat — except the doormat is a `.php` file sitting on the victim's web server, and anyone who knows the URL can let themselves in. Precisely, a web shell is a malicious script (typically PHP, JSP, or ASP) uploaded to a compromised web server that provides an attacker with persistent, browser-accessible remote command execution through the server's web interface.

## Why it matters
In the 2021 Microsoft Exchange Server compromise (ProxyShell/Hafnium), attackers chained three CVEs to drop web shells into publicly accessible directories, giving them persistent access even after the initial vulnerability was patched. Defenders hunting for web shells look for anomalous outbound connections from web server processes (e.g., `w3wp.exe` spawning `cmd.exe`) and scan for files with suspicious entropy or known malicious signatures using tools like **YARA** or **ClamAV**.

## Key facts
- Web shells commonly masquerade as legitimate files (e.g., `config.php`, `update.asp`) and are often obfuscated using Base64 encoding or character substitution to evade detection
- Typical upload vectors include unrestricted file upload vulnerabilities, SQL injection with `INTO OUTFILE`, and Remote File Inclusion (RFI)
- A web shell bypasses firewall rules because communication travels over standard HTTP/HTTPS ports (80/443), blending with legitimate traffic
- Detection indicators include web server child processes spawning shells, unexpected `.php`/`.jsp` files in writable directories, and HTTP POST requests returning unusual response sizes
- Web shells provide attackers with persistence, lateral movement capability, and data exfiltration — making them a post-exploitation staple

## Related concepts
[[remote code execution]] [[file upload vulnerability]] [[persistence mechanisms]] [[YARA rules]] [[command and control]]