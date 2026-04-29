# StringTemplate

## What it is
Like a mail merge document where you fill in the `{{name}}` fields — but for code output — StringTemplate is a template engine that enforces strict separation between logic and presentation by design. It deliberately restricts templates from executing arbitrary code, making it architecturally safer than engines like Jinja2 or Freemarker. Developed by Terence Parr, it uses a formal grammar that intentionally limits what templates can do.

## Why it matters
In 2023, developers migrating from Freemarker to StringTemplate discovered their applications had previously been vulnerable to Server-Side Template Injection (SSTI) — attackers were injecting `${7*7}` payloads that executed arbitrary Java expressions. StringTemplate's restricted model means injected template syntax like `<% Runtime.exec() %>` simply won't evaluate, turning a critical RCE vector into a harmless string display. This architectural constraint functions as a security control by default.

## Key facts
- StringTemplate uses `<attribute>` syntax (angle brackets) rather than `${}` or `{{}}`, making it visually distinct in code review
- Its **"no side effects" principle** means templates cannot call arbitrary methods or modify application state — reducing SSTI attack surface by design
- Unlike Jinja2 or Twig, StringTemplate intentionally has no `eval()`, `exec()`, or filter mechanisms that accept raw code
- SSTI payloads crafted for other engines (Freemarker, Velocity, Twig) typically **fail silently** in StringTemplate rather than executing
- When improperly configured or when user input is concatenated directly into template strings (not passed as attributes), injection risk re-emerges — the separation model must be respected by the developer

## Related concepts
[[Server-Side Template Injection]] [[Injection Attacks]] [[Input Validation]]