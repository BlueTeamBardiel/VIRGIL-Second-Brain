# Output

## What it is
Like a vending machine that shows you exactly what it dispensed and on which tray — output is any data, signal, or result that a system produces and sends outward after processing input. In security contexts, output refers to the data returned to a user, written to a log, sent over a network, or rendered in a browser after a system processes a request.

## Why it matters
In a Cross-Site Scripting (XSS) attack, the vulnerability lives entirely in *output handling* — an attacker injects a script as input, but the damage happens when the server reflects that script back to a victim's browser without sanitizing it first. Proper output encoding (e.g., converting `<` to `&lt;`) would have neutralized the payload before it ever reached the DOM.

## Key facts
- **Output encoding** vs. **input validation** are complementary defenses — encoding fixes what slips through; neither alone is sufficient
- **Verbose error output** is a classic information disclosure risk — stack traces, SQL errors, and version strings handed to attackers in HTTP responses
- **Side-channel output** (timing, power consumption, electromagnetic emissions) can leak secrets even when logical output looks clean — exploited in attacks like Spectre
- **Data Loss Prevention (DLP)** tools monitor outbound output — emails, clipboard transfers, file uploads — to detect exfiltration
- OWASP lists *Security Misconfiguration* and *Injection* as top risks where unsafe output is the final delivery mechanism for exploitation

## Related concepts
[[Input Validation]] [[Cross-Site Scripting (XSS)]] [[Data Loss Prevention]] [[Information Disclosure]] [[Output Encoding]]