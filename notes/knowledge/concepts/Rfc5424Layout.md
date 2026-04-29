# Rfc5424Layout

## What it is
Think of it as a standardized shipping label for log messages — every package (log entry) gets the same fields in the same order so any warehouse (SIEM) can process it automatically. RFC 5424Layout is a log formatting specification used by logging frameworks (like log4net and NLog) that structures syslog messages according to RFC 5424, the modern syslog protocol standard, including fields like priority, version, timestamp, hostname, app-name, process ID, message ID, and structured data.

## Why it matters
During incident response, a SOC analyst correlating events across a web server, firewall, and database needs timestamps and hostnames to line up precisely. If one application uses a proprietary log format, automated ingestion into a SIEM like Splunk or QRadar fails, creating blind spots attackers can exploit by targeting that non-normalized system knowing alerts won't trigger correctly. RFC 5424Layout enforces consistent formatting so correlation rules fire reliably.

## Key facts
- RFC 5424 replaced the older RFC 3164 (BSD syslog) standard, adding structured data elements, UTF-8 encoding support, and a formal message ID field
- The priority value (PRIVAL) is calculated as `(Facility × 8) + Severity`, encoding both pieces of metadata in a single integer at the message header
- Structured data (SD) fields in RFC 5424 allow key-value pairs inside `[...]` blocks, enabling machine-parseable metadata without breaking the message body
- RFC 5424Layout implementations typically map log levels (DEBUG, WARN, ERROR) to syslog severity numbers 7 through 0, critical for SIEM alert thresholds
- Improper or missing timestamp timezone info (RFC 5424 requires ISO 8601 with UTC offset) is a common misconfiguration that breaks log correlation during forensic timelines

## Related concepts
[[Syslog Protocol]] [[SIEM Log Ingestion]] [[Log Normalization]]