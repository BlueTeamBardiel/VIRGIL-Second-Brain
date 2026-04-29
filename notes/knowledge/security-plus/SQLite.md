# SQLite

## What it is
Think of SQLite like a filing cabinet built directly into the wall of a room — no separate filing room needed, no clerk to manage it. SQLite is a self-contained, serverless relational database engine that stores an entire database as a single file on disk, requiring zero configuration or external server process.

## Why it matters
Forensic investigators and attackers alike prize SQLite databases because browsers, mobile apps, and operating systems store enormous amounts of sensitive data in them — Chrome stores browsing history, cookies, and saved passwords in SQLite files; an attacker who gains filesystem access can simply copy and query these files offline. Conversely, defenders use SQLite artifact analysis as a core technique in both malware investigations and insider threat cases.

## Key facts
- Chrome, Firefox, Safari, iOS, and Android all use SQLite to store cookies, history, form data, and cached credentials — making it a primary forensic artifact target
- SQLite databases use the `.db`, `.sqlite`, or `.sqlite3` file extension and can be queried directly with the `sqlite3` command-line tool or tools like DB Browser for SQLite
- Deleted records in SQLite are not immediately overwritten — they remain in "free pages" and can be carved forensically, a technique examiners call **SQLite artifact recovery**
- SQLite injection vulnerabilities follow standard SQL injection patterns (`' OR '1'='1`) but have slightly different function syntax (e.g., `sqlite_version()` instead of `@@version`)
- The `WAL` (Write-Ahead Log) file and `-shm` (shared memory) file that accompany SQLite databases often contain additional forensic evidence not present in the main `.db` file

## Related concepts
[[SQL Injection]] [[Database Forensics]] [[Browser Artifacts]] [[File System Analysis]] [[Credential Harvesting]]