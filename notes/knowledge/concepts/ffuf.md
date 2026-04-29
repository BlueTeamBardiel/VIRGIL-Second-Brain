# ffuf

## What it is
Like a postal worker who tries delivering a letter to every possible apartment number in a building to find which ones actually exist, ffuf (Fuzz Faster U Fool) is a high-speed web fuzzer that systematically substitutes wordlist entries into HTTP request parameters, headers, or URL paths to discover hidden endpoints, files, and directories. It replaces the `FUZZ` keyword in a crafted request with each candidate word, analyzing server responses to identify valid targets.

## Why it matters
During a red team engagement, an attacker uses ffuf to discover an unlinked `/admin-backup` directory returning a 200 OK response, exposing a configuration file with database credentials — a path the client never knew was publicly accessible. Defenders use the same tool during reconnaissance assessments to inventory exposed attack surface before real adversaries do.

## Key facts
- ffuf uses the `FUZZ` keyword as a placeholder; replacing it in URLs (`/FUZZ`), headers, or POST body data enables directory, parameter, and virtual host enumeration
- Response filtering flags (`-fc`, `-fs`, `-fw`, `-fl`) filter by status code, size, word count, or line count — critical for eliminating false positives in noisy environments
- Supports multiple simultaneous wordlists using `FUZZ`, `FUZ2Z`, etc., enabling credential stuffing or multi-parameter fuzzing in a single run
- `-rate` and `-t` flags control requests-per-second and threads, making it stealthy enough to evade basic rate-limiting detection or aggressive enough to maximize speed
- Common wordlists used with ffuf come from SecLists (e.g., `Discovery/Web-Content/common.txt`), making SecLists knowledge directly complementary

## Related concepts
[[Directory Traversal]] [[Web Application Reconnaissance]] [[Burp Suite]] [[SecLists]] [[Parameter Tampering]]