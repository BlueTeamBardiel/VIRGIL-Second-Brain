# out-of-band SQL injection

## What it is
Imagine passing a note to a spy through a hidden dead drop instead of speaking directly — the message travels a completely separate route from the main conversation. Out-of-band SQL injection works the same way: instead of reading database responses through the normal HTTP channel, an attacker crafts SQL payloads that force the database server to exfiltrate data through a *different* network channel, such as DNS lookups or HTTP requests initiated by the database itself.

## Why it matters
In 2019, attackers exploited Oracle databases using `UTL_HTTP` and DNS-based exfiltration to bypass WAFs that were only inspecting inbound HTTP responses — the stolen data never appeared in the web application's output at all. Defenders must monitor outbound DNS traffic from database servers, since a database making DNS requests to attacker-controlled domains is a strong indicator of compromise.

## Key facts
- Relies on database server-side features: Oracle's `UTL_HTTP`/`UTL_FILE`, MySQL's `LOAD_FILE()` and `SELECT INTO OUTFILE`, or DNS-triggering functions like `xp_dirtree` in MSSQL
- Bypasses both blind SQLi mitigations (no timing needed) and WAFs that only inspect HTTP response content
- The attacker controls a listening server (often a DNS or HTTP server) to receive the exfiltrated data out-of-band
- Requires the database server to have outbound network connectivity — hardened environments with egress filtering can block this technique entirely
- Classified as a *blind* injection variant since the attacker cannot read the response directly from the application; detection focuses on anomalous outbound traffic from the DB host

## Related concepts
[[blind SQL injection]] [[DNS exfiltration]] [[error-based SQL injection]]