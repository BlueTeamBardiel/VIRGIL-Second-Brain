# Blade

## What it is
Like a Swiss Army knife smuggled inside a legitimate-looking pen, Blade is a web application attack framework that weaponizes server-side template injection (SSTI) vulnerabilities to achieve remote code execution. Specifically, Blade refers to a PHP templating engine (used in Laravel) whose improper exposure of user-controlled input to template rendering can let attackers execute arbitrary OS commands on the server.

## Why it matters
In a real-world scenario, a developer building a Laravel application might pass unsanitized user input directly into a `Blade::render()` call — an attacker who discovers this can inject `{{ system('whoami') }}` or similar payloads to enumerate the server, escalate privileges, or establish a reverse shell. This class of vulnerability has appeared in multiple CVEs affecting Laravel-based applications and is a common target during web application penetration tests.

## Key facts
- Blade is Laravel's built-in PHP templating engine; SSTI in Blade occurs when user input reaches `Blade::render()` or `eval()`-based rendering without sanitization
- Safe Blade syntax uses `{{ $var }}` (auto-escaped) but `{!! $var !!}` renders raw HTML/PHP — the double-bang syntax is a common misconfiguration leading to XSS or code execution
- SSTI payloads in Blade differ from Twig or Jinja2 — engine fingerprinting (e.g., testing `{{7*7}}` vs `<%= 7*7 %>`) is required before exploiting
- Exploitation can lead to full Remote Code Execution (RCE), making it a Critical-severity finding under CVSS scoring
- Mitigation: never pass user-controlled data to template rendering functions; use allowlists and Content Security Policy (CSP)

## Related concepts
[[Server-Side Template Injection]] [[Remote Code Execution]] [[Cross-Site Scripting]] [[Laravel Security]] [[Input Validation]]