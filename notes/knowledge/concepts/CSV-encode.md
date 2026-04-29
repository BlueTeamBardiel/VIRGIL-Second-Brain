# CSV-encode

## What it is
Like putting a hazardous chemical in a sealed container before shipping it — CSV encoding wraps dangerous characters in quotes or escapes them so they can't escape their data cell and become executable instructions. Precisely, CSV encoding is the process of sanitizing data destined for Comma-Separated Values files by escaping special characters (commas, quotes, newlines) to prevent them from being interpreted as structure or formula commands.

## Why it matters
CSV Injection (also called Formula Injection) attacks occur when an attacker inputs a value like `=SYSTEM("cmd")` or `=HYPERLINK("http://evil.com","Click")` into a web form field that is later exported to a CSV file. When a victim opens that file in Excel or Google Sheets, the spreadsheet engine executes the formula as if it were legitimate — potentially exfiltrating data or executing commands. Proper CSV encoding neutralizes this by prefixing formula-triggering characters (`=`, `+`, `-`, `@`) with a single quote or escaping them before writing to the file.

## Key facts
- CSV injection exploits spreadsheet formula execution, **not** the CSV parser itself — the vulnerability lives in the consuming application (Excel, LibreOffice)
- Dangerous leading characters that must be escaped: `=`, `+`, `-`, `@`, `\t` (tab), `\r` (carriage return)
- The OWASP-recommended defense is to prepend a single quote (`'`) before any cell value starting with these characters, forcing spreadsheet apps to treat it as a literal string
- Double-quotes within CSV fields must be escaped by doubling them (`""`) per RFC 4180 — failure to do so enables structure-breaking injection
- CSV injection is classified under **CWE-1236** (Improper Neutralization of Formula Elements in a CSV File) and appears in OWASP's data validation guidance

## Related concepts
[[Input Validation]] [[Formula Injection]] [[Output Encoding]] [[Injection Attacks]] [[OWASP Top 10]]