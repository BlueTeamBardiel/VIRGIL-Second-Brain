# VTODO

## What it is
Like a sticky note on your fridge that someone could secretly modify to change your reminders, VTODO is a calendar data format component used within iCalendar (.ics) files to represent task or to-do items. It is defined in RFC 5545 and is commonly processed by calendar applications like Microsoft Outlook, Apple Calendar, and CalDAV servers.

## Why it matters
Attackers have crafted malicious .ics files containing VTODO components with oversized property fields or injected escape sequences to exploit parsing vulnerabilities in calendar clients — for example, CVE-2016-1741 involved malicious calendar data triggering memory corruption in Apple Calendar. A user simply receiving or previewing a calendar invitation containing a weaponized VTODO entry could trigger code execution without any additional interaction, making it a stealthy phishing vector.

## Key facts
- VTODO is a sub-component of the iCalendar format (RFC 5545), delimited by `BEGIN:VTODO` and `END:VTODO` tags
- Supports properties like `SUMMARY`, `DUE`, `PRIORITY`, `STATUS`, and `DESCRIPTION` — any of which can carry malicious payloads if parsers fail to sanitize input
- CalDAV (RFC 4791) servers that sync VTODO items over HTTP/HTTPS can expose these components to server-side injection if input validation is absent
- Because .ics files are plain text, VTODO payloads can bypass binary-focused AV scanning unless the security tool explicitly parses iCalendar structure
- Email gateways should treat .ics attachments with the same scrutiny as Office documents — they can deliver macro-equivalent attacks through parser exploitation

## Related concepts
[[iCalendar Format]] [[CalDAV Protocol]] [[File Format Exploitation]] [[Email Attachment Analysis]] [[Input Validation]]