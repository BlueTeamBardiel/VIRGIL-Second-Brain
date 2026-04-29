# Server-Side Template Injection

## What it is
Imagine a mail-merge system where instead of just filling in your name, a malicious user types a formula that calculates the company's entire payroll — and the machine executes it. Server-Side Template Injection (SSTI) occurs when user-supplied input is embedded directly into a server-side template engine (like Jinja2, Twig, or Freemarker) and evaluated as code rather than treated as plain text. The result is that attackers can execute arbitrary expressions or commands on the server.

## Why it matters
In 2016, James Kettle demonstrated SSTI against Uber's infrastructure using Jinja2, achieving remote code execution by injecting `{{7*7}}` into a parameter — when the server returned `49`, it confirmed the vulnerability. This class of flaw can escalate from read-only data leakage to full server compromise, making it far more dangerous than typical injection attacks.

## Key facts
- SSTI is distinct from Cross-Site Scripting (XSS): XSS executes in the browser; SSTI executes on the server
- Detection fingerprint: injecting `{{7*7}}`, `${7*7}`, or `<%= 7*7 %>` and observing if the server returns `49`
- Template engines at risk include Jinja2 (Python), Twig (PHP), Pebble/Freemarker (Java), and Smarty (PHP)
- Successful SSTI can enable RCE, file system access, credential theft, and lateral movement
- Root cause is always the same: unsanitized user input concatenated into a template string before rendering, rather than passed as a data variable

## Related concepts
[[Remote Code Execution]] [[Cross-Site Scripting]] [[Injection Attacks]] [[Input Validation]]