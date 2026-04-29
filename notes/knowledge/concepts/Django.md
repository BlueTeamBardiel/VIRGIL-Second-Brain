# Django

## What it is
Think of Django like a pre-fabricated apartment building — the plumbing, electrical, and load-bearing walls are already built so you just furnish the rooms. Django is a high-level Python web framework that follows a "batteries included" philosophy, providing built-in components for authentication, database ORM, admin interfaces, and form handling out of the box.

## Why it matters
A misconfigured Django deployment left in DEBUG mode exposes a full stack trace, environment variables, and installed app paths to anyone who triggers a 404 — handing an attacker a detailed map of the application internals. Security assessors specifically probe for `DEBUG = True` in production environments because Django's error pages can leak database credentials and secret keys stored in settings files.

## Key facts
- Django's `SECRET_KEY` setting is used for cryptographic signing of cookies, sessions, and CSRF tokens — exposure of this key allows an attacker to forge session data and bypass authentication
- Django provides built-in CSRF protection via middleware that validates a synchronization token on every POST request; disabling `django.middleware.csrf.CsrfViewMiddleware` is a common misconfiguration
- The Django ORM uses parameterized queries by default, preventing SQL injection — raw queries via `RawSQL()` or `.extra()` break this protection if user input is interpolated
- Django's `ALLOWED_HOSTS` setting prevents HTTP Host header injection attacks; an empty or wildcard value is a security misconfiguration finding
- Django admin (`/admin`) is enabled by default and accessible at a predictable URL, making it a common target for credential-stuffing and brute-force attacks

## Related concepts
[[CSRF]] [[SQL Injection]] [[Session Hijacking]] [[HTTP Host Header Injection]] [[Security Misconfiguration]]