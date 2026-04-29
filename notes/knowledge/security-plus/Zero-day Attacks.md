# Zero-day Attacks

## What it is
Imagine a locksmith discovers a master key flaw that opens every apartment in a building — but tells no one, selling copies to burglars before the landlord even knows the lock is broken. A zero-day attack exploits a software vulnerability that is unknown to the vendor, meaning no patch exists at the time of exploitation. The name refers to the vendor having had "zero days" to fix the flaw before it was weaponized.

## Why it matters
In 2021, the ProxyLogon vulnerability in Microsoft Exchange was exploited as a zero-day by the HAFNIUM threat group, compromising tens of thousands of organizations worldwide before Microsoft could issue an emergency patch. Defenders had no signature to detect it, forcing teams to rely on behavioral anomaly detection and network traffic analysis rather than traditional antivirus — a stark reminder that patch management alone cannot stop what vendors haven't acknowledged yet.

## Key facts
- Zero-days become **N-day vulnerabilities** the moment a patch or public disclosure occurs — the clock starts ticking for unpatched systems immediately
- **CVE (Common Vulnerabilities and Exposures)** IDs are assigned only after disclosure, meaning true zero-days have no CVE during active exploitation
- Organizations selling zero-day exploits legally (e.g., Zerodium) can pay **over $1 million** for iOS zero-days, reflecting their scarcity and market value
- Defense strategies rely on **threat hunting, behavioral analytics, and network segmentation** rather than signature-based detection
- Zero-days are commonly associated with **APT (Advanced Persistent Threat)** actors due to the resources required to discover and preserve them

## Related concepts
[[Advanced Persistent Threats]] [[Vulnerability Management]] [[Intrusion Detection Systems]] [[Patch Management]] [[Threat Hunting]]