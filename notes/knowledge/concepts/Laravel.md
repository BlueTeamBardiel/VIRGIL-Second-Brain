# Laravel

## What it is
Like a pre-furnished apartment where the plumbing, wiring, and security system are already installed — you just move in and build your life — Laravel is a PHP web application framework that provides pre-built components (routing, authentication, ORM, templating) so developers ship applications faster without reinventing foundational code. It follows the MVC (Model-View-Controller) architectural pattern and ships with built-in security features like CSRF protection and parameterized queries via Eloquent ORM.

## Why it matters
In 2021, misconfigured Laravel applications exposing `.env` files became a widespread attack vector — threat actors automated scans for publicly accessible environment files containing database credentials, API keys, and `APP_KEY` values. With the `APP_KEY` in hand, attackers could forge encrypted cookies and achieve Remote Code Execution (RCE) through Laravel's deserialization mechanisms, compromising thousands of servers without exploiting any code vulnerability — just misconfiguration.

## Key facts
- Laravel's `.env` file stores secrets in plaintext (DB passwords, API tokens, mail credentials) — exposing it is a critical misconfiguration, not a code vulnerability
- The `APP_KEY` is used for symmetric encryption of cookies and session data; its exposure enables cookie forgery and potential RCE via deserialization gadget chains
- Laravel's Eloquent ORM uses parameterized queries by default, preventing SQL injection — but raw query methods (`DB::raw()`) bypass this protection entirely
- CSRF tokens are generated per-session and validated automatically on state-changing routes — disabling `VerifyCsrfToken` middleware removes this protection globally
- Laravel debug mode (`APP_DEBUG=true`) in production leaks full stack traces, environment variables, and application structure to unauthenticated users

## Related concepts
[[SQL Injection]] [[CSRF]] [[Remote Code Execution]] [[Environment Variable Exposure]] [[Deserialization Attacks]]