# Hydra

## What it is
Like a telemarketer with a phonebook who never gets tired, Hydra systematically tries every possible username/password combination against a login service until one works. It is an open-source, parallelized network login cracker that automates credential brute-force and dictionary attacks across dozens of protocols simultaneously.

## Why it matters
A penetration tester assessing a corporate VPN discovers that the SSH management port is exposed to the internet. Using Hydra with a rockyou.txt wordlist, they recover a valid admin credential in under 10 minutes because the account had no lockout policy — demonstrating exactly why account lockout and rate-limiting controls are non-negotiable hardening requirements.

## Key facts
- Supports 50+ protocols including SSH, FTP, HTTP/HTTPS, RDP, SMB, SMTP, and Telnet, making it extremely versatile in real engagements
- Uses parallelized threads (configurable with `-t` flag, default 16) to dramatically speed up attacks compared to sequential guessing
- Can perform both **brute-force** (character permutations) and **dictionary attacks** (wordlist-based), with username and password lists supplied via `-L` and `-P` flags respectively
- Countermeasures that directly defeat Hydra include: account lockout policies, CAPTCHA, multi-factor authentication, fail2ban, and IP-based rate limiting
- On Security+/CySA+, Hydra represents the category of **online password attacks** — distinguishing it from offline attacks (like Hashcat) that crack captured hashes without touching the live service

## Related concepts
[[Brute Force Attack]] [[Dictionary Attack]] [[Credential Stuffing]] [[Account Lockout Policy]] [[Burp Suite]]