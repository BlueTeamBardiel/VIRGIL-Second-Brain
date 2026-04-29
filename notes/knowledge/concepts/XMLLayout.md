# XmlLayout

## What it is
Think of XmlLayout like a restaurant order ticket that tells the kitchen exactly how to format and display every dish — except instead of food, it's telling a logging framework how to render log entries using XML templates. XmlLayout is a log formatting component (commonly found in Apache log4net and similar frameworks) that structures log output as XML, defining which fields appear and how they're arranged in the logged data.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) demonstrated catastrophically how logging frameworks that parse and render user-controlled input can become remote code execution vectors. XmlLayout configurations that include user-supplied data — such as HTTP headers, usernames, or request parameters — in XML log output can expose systems to XML injection or, in worse cases, JNDI lookup execution if the underlying framework evaluates embedded expressions during layout rendering.

## Key facts
- XmlLayout is a feature of log4net (the .NET/Java logging library), not a standalone product — misconfigurations here affect the entire application's log pipeline
- If user input is embedded unsanitized into XmlLayout output, attackers can inject malicious XML elements that corrupt log integrity or trigger downstream XML parsers
- XML External Entity (XXE) injection becomes a risk when XmlLayout output is later parsed by an XML processor — a common oversight in SIEM ingestion pipelines
- Log4net's XmlLayout includes fields like `<log4net:event>`, `<log4net:message>`, and `<log4net:exception>` — all potential injection points
- Defense requires input sanitization before logging, output encoding in layout templates, and disabling external entity resolution in any XML parser consuming log data

## Related concepts
[[Log Injection]] [[XML External Entity (XXE)]] [[Log4Shell]] [[SIEM]] [[Input Validation]]