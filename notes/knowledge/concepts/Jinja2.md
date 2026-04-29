# Jinja2

## What it is
Like a mail-merge system for code — you hand it a template with blank fields and a dataset, and it fills in the gaps to produce a finished document. Jinja2 is a Python templating engine that renders dynamic content by substituting variables and executing logic within specially delimited tags (`{{ }}` for expressions, `{% %}` for statements).

## Why it matters
When a web application passes user-controlled input directly into a Jinja2 template without sanitization, attackers can inject template expressions that execute server-side — a Server-Side Template Injection (SSTI) attack. For example, submitting `{{7*7}}` in a form field that renders as `49` confirms Jinja2 SSTI, which can escalate to full Remote Code Execution (RCE) via `{{''.__class__.__mro__[1].__subclasses__()}}` to access Python's object hierarchy and spawn OS commands.

## Key facts
- **SSTI is distinct from XSS**: XSS executes in the victim's browser (client-side); SSTI executes on the server, giving attackers OS-level access.
- **Safe mode is not default**: Jinja2's `Sandbox` environment exists but must be explicitly enabled; standard deployments have no execution restrictions.
- **Detection payload**: `{{7*7}}` → `49` confirms Jinja2; `${7*7}` targets other engines (Freemarker, Velocity), helping attackers fingerprint the backend.
- **CVE relevance**: Flask (built on Jinja2) applications are frequent SSTI targets; the vulnerability appears in OWASP Top 10 under **A03:2021 – Injection**.
- **Mitigation**: Never pass raw user input to `render_template_string()`; use `render_template()` with static template files and treat user input as data, not template logic.

## Related concepts
[[Server-Side Template Injection]] [[Remote Code Execution]] [[Input Validation]] [[Cross-Site Scripting]] [[Flask Security]]