# ftp.log

## What it is
Like a hotel front desk ledger recording every guest who checked in, what room they requested, and whether they were turned away — `ftp.log` is Zeek's dedicated log file capturing all FTP control-channel activity: authentication attempts, commands issued, files transferred, and server response codes. It separates FTP traffic from generic connection logs so analysts can focus specifically on file transfer behavior.

## Why it matters
During the 2020 SolarWinds supply chain investigation, attackers used FTP and similar protocols to stage and exfiltrate payloads from compromised environments. Reviewing `ftp.log` lets defenders spot anonymous FTP logins (`USER anonymous`), mass file downloads via `RETR` commands, or uploads of web shells via `STOR` — all critical indicators of compromise that raw packet capture would bury.

## Key facts
- **Fields include**: `uid`, `id.orig_h`, `id.resp_h`, `user`, `password`, `command`, `arg`, `mime_type`, `file_size`, `reply_code`, and `reply_msg`
- **Reply code 230** = successful login; **530** = login failure — high volumes of 530s signal brute-force attempts
- **Anonymous FTP** appears as `user: anonymous` with an email-style password; immediately suspicious in corporate environments
- **Command field** reveals attacker intent: `STOR` (upload), `RETR` (download), `MKD` (make directory), `DELE` (delete)
- FTP sends credentials in **plaintext** over port 21 — `ftp.log` may contain recoverable usernames and passwords from legacy systems

## Related concepts
[[conn.log]] [[files.log]] [[weird.log]] [[credential theft]] [[cleartext protocol detection]]