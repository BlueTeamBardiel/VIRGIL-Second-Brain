# template injection

## What it is
Imagine a mail-merge system where a prankster slips `{{DELETE ALL RECORDS}}` into the "Dear [Name]" field — the template engine obediently executes it instead of treating it as text. Template injection occurs when user-supplied input is embedded directly into a server-side template (e.g., Jinja2, Twig, Freemarker) and the engine evaluates it as code rather than data, granting the attacker execution context within the application.

## Why it matters
In 2019, attackers exploited a Server-Side Template Injection (SSTI) vulnerability in a Jinja2-based Python application by submitting `{{7*7}}` in a form field — when the response returned `49`, they confirmed execution and escalated to full Remote Code Execution (RCE) by calling `os.popen('id').read()`. This single unsanitized input field led to complete server compromise, demonstrating that SSTI can be more dangerous than XSS because the payload executes server-side with application-level privileges.

## Key facts
- **Two types**: Server-Side Template Injection (SSTI) — executes on the server; Client-Side Template Injection (CSTI) — executes in the browser via frameworks like AngularJS.
- **Detection fingerprint**: Mathematical probes like `{{7*7}}`, `${7*7}`, or `<%= 7*7 %>` reveal engine type based on output; each syntax maps to a specific templating engine.
- **Impact can reach RCE**: Unlike XSS, SSTI runs in the server's process space, enabling file read/write, command execution, and lateral movement.
- **Root cause**: Treating user input as template code rather than a literal string — violating input validation and output encoding principles.
- **Mitigation**: Use sandboxed template environments, never concatenate user input into template strings, and apply strict input validation/allowlisting.

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[Cross-Site Scripting (XSS)]] [[Remote Code Execution (RCE)]] [[Input Validation]] [[Code Injection]]