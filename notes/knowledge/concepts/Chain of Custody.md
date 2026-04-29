# chain of custody

## What it is
Like a hospital blood sample that gets logged every time it changes hands — who drew it, who transported it, who tested it — chain of custody is the documented, unbroken record of who collected, handled, transferred, and stored digital evidence from the moment of seizure to courtroom presentation. Any gap in this record can render evidence inadmissible, just as a mishandled blood sample can invalidate a test result.

## Why it matters
In a ransomware investigation, a forensic analyst imaging a compromised server must hash the drive (typically with SHA-256) immediately upon acquisition and log every subsequent access. If a defense attorney can show the hash changed between acquisition and analysis — or that an undocumented person accessed the drive — the prosecution's evidence collapses entirely, potentially letting attackers walk free despite clear guilt.

## Key facts
- **Write blockers** must be used during acquisition to prevent any modification of the original media, preserving forensic integrity
- The chain of custody document must record: date/time, location, personnel involved, and reason for each transfer or access
- **Hashing** (MD5 historically, SHA-256 preferred) is performed at acquisition and verified at each stage — matching hashes prove evidence was not altered
- Evidence must be stored in a **tamper-evident container** (sealed bags, locked lockers) with access restricted to authorized personnel only
- Both the original evidence and working copies (forensic images) require separate chain of custody documentation; analysts work only from the copy, never the original

## Related concepts
[[digital forensics]] [[forensic imaging]] [[evidence handling]] [[legal hold]] [[integrity verification]]