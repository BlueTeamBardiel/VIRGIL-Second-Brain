# Gobuster

## What it is
Like a postal worker who tries slipping letters under every door in a building to see which ones open, Gobuster is a brute-force enumeration tool that systematically tries wordlists of paths, subdomains, and filenames against a target to discover hidden content. It is a Go-based command-line tool used during reconnaissance to find web directories, DNS subdomains, virtual hosts, and S3 buckets that are not linked or publicly advertised.

## Why it matters
During a penetration test, an assessor runs Gobuster against a corporate web application and discovers `/admin/backup.zip` — an exposed archive containing database credentials left by a developer. This single find escalates a low-severity engagement into full domain compromise, illustrating why hidden-by-obscurity is not a security control.

## Key facts
- Gobuster operates in multiple modes: `dir` (directory/file brute-forcing), `dns` (subdomain enumeration), `vhost` (virtual host discovery), and `s3` (bucket enumeration)
- It relies on wordlists like SecLists' `common.txt` or `directory-list-2.3-medium.txt` — the quality of the wordlist directly determines what gets discovered
- Gobuster sends HTTP GET requests and classifies responses by status code; defenders can detect it by anomalous 404 spikes or sequential request patterns in web server logs
- Unlike crawlers (e.g., Burp Spider), Gobuster does **not** parse page content — it blindly iterates the wordlist, making it faster but blind to dynamically linked paths
- The `-x` flag appends file extensions (e.g., `.php`, `.bak`, `.conf`), significantly expanding attack surface discovery

## Related concepts
[[Directory Traversal]] [[DNS Enumeration]] [[Web Application Reconnaissance]] [[Burp Suite]] [[SecLists]]