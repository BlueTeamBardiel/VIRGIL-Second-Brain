# Compression Archives

## What it is
Like a vacuum-sealed storage bag that squashes bulky items into a compact package, a compression archive bundles multiple files into a single container while reducing their total size. Formats such as ZIP, RAR, TAR.GZ, and 7z use algorithms (DEFLATE, LZMA) to encode redundant data patterns more efficiently, and optionally encrypt contents with a password.

## Why it matters
Attackers routinely deliver malware inside password-protected ZIP files specifically to defeat email gateway scanners and antivirus engines — the scanner cannot inspect encrypted contents without the password, so the payload slips through. This technique, popularized in phishing campaigns distributing Emotet and QakBot, forces defenders to implement policies that block or quarantine encrypted archives from external senders entirely.

## Key facts
- **ZIP Slip** is a known path traversal vulnerability where a maliciously crafted archive contains filenames like `../../evil.exe`, causing extraction tools to write files outside the intended directory.
- Password-protected archives bypass many AV/EDR content inspection engines because the payload is encrypted at rest inside the archive until extracted.
- **Polyglot files** can be simultaneously a valid archive AND another file type (e.g., a ZIP that is also a valid JPEG), confusing file-type detection controls.
- Archive files are a common **data exfiltration vehicle** — attackers compress and encrypt sensitive data before moving it to avoid DLP (Data Loss Prevention) pattern matching on file contents.
- Common forensic artifacts: `%TEMP%` directories, recently opened archive paths in registry (`NTUSER.DAT`), and prefetch entries for extraction tools like WinRAR or 7-Zip.

## Related concepts
[[Malware Delivery Techniques]] [[Data Loss Prevention]] [[File Type Validation]]