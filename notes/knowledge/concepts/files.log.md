# files.log

## What it is
Like a postal inspector's record of every package that passed through a sorting facility — who sent it, what type, how big, and whether it was delivered — files.log is Zeek's dedicated log for tracking every file transferred across monitored network connections. It captures file metadata extracted from protocols like HTTP, SMTP, and FTP, regardless of whether the file was explicitly saved to disk.

## Why it matters
During a malware investigation, an analyst can query files.log to identify a suspicious executable (MIME type: `application/x-dosexec`) downloaded over HTTP hours before endpoint alerts fired. Cross-referencing the `sha256` hash against VirusTotal reveals the payload, and the `conn_uids` field links the file transfer back to the exact connection in conn.log — reconstructing the infection chain without needing full packet captures.

## Key facts
- Every entry contains a **SHA1, MD5, and SHA256 hash** of the transferred file, enabling direct threat intelligence lookups without extracting the file itself
- The **`source` field** identifies which protocol analyzer extracted the file (e.g., `HTTP`, `SMTP`, `FTP`), critical for understanding the delivery vector
- The **`mime_type` field** reveals the true file type based on magic bytes — an `.exe` disguised as a `.jpg` will still show `application/x-dosexec`
- **`conn_uids`** links file events back to conn.log connection records, enabling full session reconstruction across Zeek logs
- Files transferred in **multiple chunks** (e.g., large downloads) may appear as multiple log entries sharing the same `fuid` (file unique identifier)

## Related concepts
[[conn.log]] [[Zeek Network Security Monitor]] [[HTTP log]] [[File Carving]] [[Threat Intelligence Hash Lookup]]