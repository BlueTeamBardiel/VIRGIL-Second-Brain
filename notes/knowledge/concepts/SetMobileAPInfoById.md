# SetMobileAPInfoById

## What it is
Like a hotel front desk clerk who can reprogram any room key by just knowing the room number — no master key required — `SetMobileAPInfoById` is a function (found in certain mobile device management and router firmware APIs) that allows configuration data for a wireless access point to be updated by supplying only an identifier, often without adequate authentication checks. It exposes AP settings (SSID, password, security mode) to modification through an API call.

## Why it matters
In documented vulnerabilities affecting home routers and mobile hotspot firmware, attackers on the local network (or sometimes remotely) have exploited unauthenticated or improperly authorized calls to functions like this to silently change Wi-Fi credentials or downgrade encryption to WEP — essentially locking out legitimate users or enabling eavesdropping. This class of vulnerability was central to several SOHO router CVEs where mass exploitation enabled botnet recruitment (Mirai variants).

## Key facts
- Functions like this are common targets in **IDOR (Insecure Direct Object Reference)** attacks — swapping one AP ID for another grants unauthorized control over a different device
- Lack of authentication on management API endpoints is classified under **OWASP API Security Top 10: API2 (Broken Authentication)** and **API5 (Broken Function Level Authorization)**
- Exploitation can enable **evil twin setup** by remotely renaming a legitimate AP to a cloned SSID with attacker-controlled credentials
- These vulnerabilities often surface during **firmware analysis** via static analysis tools (binwalk, Ghidra) or fuzzing router management interfaces
- Remediation requires **per-call authentication tokens**, input validation on ID parameters, and rate limiting on AP configuration endpoints

## Related concepts
[[Insecure Direct Object Reference]] [[Evil Twin Attack]] [[OWASP API Security Top 10]] [[Firmware Analysis]] [[Broken Function Level Authorization]]