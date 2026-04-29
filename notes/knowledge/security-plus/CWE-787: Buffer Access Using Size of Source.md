# CWE-787: Buffer Access Using Size of Source

## What it is
Imagine measuring how much flour to pour into a small bowl by checking the size of the *bag* instead of the bowl — you'll overflow it every time. CWE-787 is exactly that mistake in code: a program calculates how many bytes to read or copy using the *source* buffer's size rather than the *destination* buffer's capacity, causing writes beyond the destination's allocated boundary. This is a specific instance of out-of-bounds write, one of the most exploitable memory corruption classes.

## Why it matters
The classic `strcpy`-style vulnerability exploits this flaw — an attacker supplies a crafted input string longer than the destination buffer, and since the copy operation sizes itself to the source, adjacent memory (including return addresses or function pointers) gets overwritten. This was the root cause pattern in countless stack smashing exploits, including early remote code execution vulnerabilities in network daemons like `wu-ftpd`, enabling full shell access without credentials.

## Key facts
- **Ranked #1 in MITRE's CWE Top 25** most dangerous software weaknesses (2023), reflecting its prevalence and severity.
- The canonical unsafe function pairing: `strcpy(dest, src)` sizes the copy to `strlen(src)`, ignoring `dest` capacity entirely.
- Exploitation can overwrite the **stack return address**, **saved frame pointers**, or **heap metadata**, enabling RCE or privilege escalation.
- Mitigations include using size-bounded alternatives (`strncpy`, `strlcpy`, `memcpy_s`) and enabling **compiler canaries** (e.g., `-fstack-protector`) plus **ASLR**.
- Static analysis tools (Coverity, CodeQL) and **fuzzing** are the primary detection methods during SDLC — runtime checks alone are insufficient.

## Related concepts
[[CWE-125 Out-of-Bounds Read]] [[Stack Buffer Overflow]] [[Memory-Safe Programming]] [[ASLR]] [[Fuzzing]]