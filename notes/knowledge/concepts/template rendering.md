# template rendering

## What it is
Like a mail-merge document where `{{name}}` gets swapped for "Alice" before printing, template rendering is the process where a web framework substitutes variables and expressions inside a template file to produce the final HTML output sent to the user. The danger emerges when user-supplied input is placed *inside* the template itself rather than safely passed as a variable value.

## Why it matters
In 2017, attackers exploited a Server-Side Template Injection (SSTI) vulnerability in Jinja2-powered applications by submitting payloads like `{{7*7}}` — if the server returned `49`, it confirmed the template engine was evaluating user input. From there, attackers escalated to `{{config.__class__.__init__.__globals__['os'].popen('id').read()}}` to achieve full Remote Code Execution (RCE), compromising the underlying server without any traditional code injection.

## Key facts
- **SSTI vs XSS**: Cross-Site Scripting executes on the client's browser; Server-Side Template Injection executes on the *server*, making it far more severe — often leading to RCE.
- **Detection canary**: Submitting `{{7*7}}` or `${7*7}` and receiving `49` confirms template evaluation of user input.
- **Engine-specific payloads**: Jinja2 (Python), Twig (PHP), Freemarker (Java), and Smarty each have distinct syntax; fingerprinting the engine guides exploitation.
- **Root cause**: Developers concatenating user input directly into template strings (e.g., `render("Hello " + user_input)`) instead of passing input as a context variable.
- **Mitigation**: Always pass user data as template *context variables*, never interpolate it into the template string itself; use sandboxed template environments where available.

## Related concepts
[[server-side template injection]] [[cross-site scripting]] [[remote code execution]] [[input validation]]