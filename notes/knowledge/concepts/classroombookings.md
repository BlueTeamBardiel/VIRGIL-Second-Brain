# classroombookings

## What it is
Like a school secretary's paper sign-up sheet left on an unlocked front desk — anyone can read, edit, or erase it — classroombookings is an open-source PHP web application used by educational institutions to manage room reservations, but it often ships with default credentials and minimal hardening. It is a scheduling platform that, when misconfigured, exposes administrative interfaces, user data, and database credentials to unauthenticated or low-privileged attackers.

## Why it matters
In 2013–2014, security researchers identified that classroombookings installations running outdated versions were vulnerable to SQL injection and authentication bypass, allowing attackers to dump user databases containing plaintext or weakly hashed passwords. An attacker who compromises a school's booking system can pivot laterally — those recycled credentials often unlock email accounts, VPNs, or student information systems.

## Key facts
- Classroombookings has historically shipped with default admin credentials (`admin`/`admin`), making it a target for credential-stuffing and default-login attacks
- Multiple versions contained **SQL injection vulnerabilities** in booking query parameters, allowing full database extraction without authentication
- Because it runs on PHP with a MySQL backend, misconfigured installations may expose `config.php` containing database credentials in web-accessible directories
- It is frequently indexed by Shodan and Google dorks (e.g., `intitle:"classroombookings"`) making discovery trivial for opportunistic attackers
- Represents the broader risk category of **unmanaged shadow IT** in education sectors — deployed by staff without IT security review or patch management

## Related concepts
[[Default Credentials]] [[SQL Injection]] [[Google Dorking]] [[Shadow IT]] [[PHP Application Security]]