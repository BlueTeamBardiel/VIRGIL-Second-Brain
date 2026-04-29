# whitelist

## What it is
Like a VIP club with a strict guest list — if your name isn't written down, the bouncer turns you away regardless of how legitimate you look. A whitelist (allowlist) is an explicit list of entities — IPs, applications, domains, or users — that are *permitted* by default, with everything else denied. It is the inverse of blacklisting and operates on a "deny-all, permit-by-exception" model.

## Why it matters
In 2021, attackers used living-off-the-land techniques, abusing trusted Windows binaries like `certutil.exe` to download malware — bypassing traditional blacklist-based antivirus entirely. An application whitelisting solution (like AppLocker or WDAC) would have blocked the malicious *behavior* of those binaries executing unexpected payloads, stopping the attack at the endpoint before any damage occurred.

## Key facts
- **Application whitelisting** is considered one of the most effective mitigations against malware — the Australian Signals Directorate ranks it #1 in their Essential Eight framework.
- NIST SP 800-167 specifically addresses application whitelisting guidance for enterprise environments.
- Whitelisting can be based on **file path, hash, publisher certificate, or network zone** — hash-based is most secure but hardest to maintain.
- The term "allowlist" is now preferred in modern standards (replacing "whitelist") to use inclusive language — expect both terms on exams.
- IP whitelisting in cloud environments (e.g., AWS Security Groups) restricts inbound traffic to only approved source addresses, reducing attack surface dramatically.
- Whitelisting introduces **availability risk**: legitimate software can be accidentally blocked, making careful baselining and testing critical before deployment.

## Related concepts
[[application control]] [[blacklist]] [[default-deny]] [[AppLocker]] [[zero trust]]