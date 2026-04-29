# SQL Slammer

## What it is
Imagine a single postcard that, upon being read, causes the recipient to immediately mail copies to every address they know — and each copy does the same thing, simultaneously. SQL Slammer was a self-propagating worm (January 2003) that exploited a buffer overflow vulnerability in Microsoft SQL Server 2000, fitting its entire payload into a single 376-byte UDP packet — small enough to transmit in one datagram, no TCP handshake required.

## Why it matters
On January 25, 2003, SQL Slammer doubled in size every 8.5 seconds and infected roughly 75,000 hosts within 10 minutes, causing significant internet slowdowns and taking down Bank of America ATMs and 911 dispatch systems in Seattle. Its speed demonstrated that patch management lag (the vulnerable patch had been available for 6 months) is a critical attack surface, not a theoretical one.

## Key facts
- Exploited **CVE-2002-0649**, a stack buffer overflow in SQL Server Resolution Service on **UDP port 1434**
- Entire malicious payload was **376 bytes** — the first notable worm to fit in a single UDP datagram
- Propagation used **random IP scanning**, sending copies of itself to randomly generated IP addresses at maximum speed
- Caused an estimated **$1.2 billion in damages** and disrupted internet infrastructure globally within 30 minutes
- No file was written to disk — it was a **fileless, memory-resident worm**, making detection harder for signature-based tools of the era

## Related concepts
[[Buffer Overflow]] [[Worm]] [[UDP Flood]] [[Patch Management]] [[CVE]]