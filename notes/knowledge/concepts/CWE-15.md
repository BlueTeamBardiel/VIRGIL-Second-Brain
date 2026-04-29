# CWE-15

## What it is
Like a thermostat that anyone can adjust by simply turning a dial on the wall — rather than requiring a key — External Control of System or Configuration Setting means an application allows untrusted, external input to directly modify critical configuration parameters without proper authorization or validation. This weakness occurs when software reads configuration values from sources (environment variables, user-supplied data, HTTP headers) that an attacker can manipulate.

## Why it matters
In 2021, attackers exploited externally controllable configuration paths in misconfigured Spring Boot applications via the Actuator endpoint — by sending crafted POST requests, they could modify runtime environment properties, redirect logging destinations, or alter database connection strings mid-session. A defender would harden this by enforcing that configuration changes require authenticated, server-side-only channels and by implementing allowlists for acceptable configuration values.

## Key facts
- **Root cause**: The application trusts external input (HTTP params, environment variables, registry keys) to set values that should only be controlled by administrators or the application itself.
- **Common attack vectors**: HTTP request headers (e.g., `X-Forwarded-For` used as config input), environment variable injection, and query parameters that influence file paths or timeouts.
- **CVSS impact**: Typically affects Integrity and Availability; can escalate to full system compromise if configuration controls security-critical behavior like authentication bypass flags.
- **Distinct from CWE-16** (Configuration): CWE-15 is specifically about *runtime* external control, while CWE-16 covers static misconfiguration.
- **Mitigation**: Validate and sanitize all externally supplied data before use as configuration; prefer hardcoded or server-side-only config sources; apply principle of least privilege to configuration interfaces.

## Related concepts
[[CWE-16 Security Misconfiguration]] [[Environment Variable Injection]] [[Principle of Least Privilege]] [[Input Validation]] [[CWE-94 Code Injection]]