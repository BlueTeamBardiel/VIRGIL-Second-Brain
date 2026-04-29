# CSV

## What it is
Like a spreadsheet stored as plain text — rows of data separated by commas, columns implied by position — CSV (Comma-Separated Values) is a flat-file format for storing tabular data with no formatting, formulas, or metadata. It's human-readable, universally supported, and intentionally simple.

## Why it matters
CSV Injection (also called Formula Injection) is a real attack vector: an attacker enters a payload like `=SYSTEM("calc.exe")` into a web form field. When an admin exports user data to a CSV and opens it in Excel or LibreOffice, the spreadsheet engine executes the formula — potentially exfiltrating data or running commands. This is why output encoding and input validation must extend even to "harmless" export functions.

## Key facts
- **CSV Injection** occurs when user-controlled data containing formula characters (`=`, `+`, `-`, `@`) is embedded in a CSV and later opened in a spreadsheet application that evaluates formulas
- CSV files have **no native authentication or integrity controls** — they can be trivially modified in transit or at rest without detection unless hashed or signed
- Mitigations include **prepending a single quote** (`'`) to fields starting with formula characters, or stripping/escaping them entirely before export
- CSV is commonly used in **log exports, user data dumps, and SIEM ingestion pipelines** — making it a high-value target for data exfiltration and manipulation
- **RFC 4180** defines the informal standard for CSV formatting, but implementations vary widely — inconsistencies can cause parsing errors that lead to **data deserialization bugs** in automated pipelines

## Related concepts
[[Input Validation]] [[Formula Injection]] [[Output Encoding]] [[Data Exfiltration]] [[SIEM]]