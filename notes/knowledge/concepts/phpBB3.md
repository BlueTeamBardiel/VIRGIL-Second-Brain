# phpBB3

## What it is
Like a bulletin board at a community center where anyone can pin up messages and reply — except it runs on PHP and MySQL and lives on a web server. phpBB3 is an open-source forum software package (version 3.x) that allows website owners to deploy threaded discussion boards with user accounts, permissions, and moderation tools.

## Why it matters
Attackers frequently target outdated phpBB3 installations because unpatched versions have suffered from SQL injection, Remote Code Execution (RCE), and Cross-Site Scripting (XSS) vulnerabilities. In a real-world scenario, an attacker exploiting CVE-2019-13776 could leverage a persistent XSS flaw to steal administrator session cookies, then use that access to upload a PHP web shell and fully compromise the underlying server. Defenders must enforce version patching, disable PHP execution in upload directories, and apply Web Application Firewall (WAF) rules against known phpBB exploit signatures.

## Key facts
- phpBB3 stores user passwords using **bcrypt** (since 3.1+); older 2.x versions used unsalted MD5, making cracked credential databases from breaches still dangerous for password reuse attacks
- Common attack vector: **unauthenticated SQL injection** in search or login parameters to dump the `phpbb_users` table containing usernames and hashed passwords
- Default admin panel lives at `/adm/index.php` — security hardening requires moving or IP-restricting this path
- phpBB3 uses a **token-based CSRF protection** mechanism; vulnerabilities arise when extensions (MODs) fail to validate these tokens
- Metasploit Framework includes dedicated modules targeting phpBB3 RCE vulnerabilities, making exploitation accessible to low-skill attackers

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Remote Code Execution]] [[Web Application Firewall]] [[Password Hashing]]