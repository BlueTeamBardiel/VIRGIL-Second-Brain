# Legacy Systems

## What it is
Like a 1970s elevator still running in a modern skyscraper — functional enough that nobody replaces it, but incompatible with modern safety codes and impossible to patch. Legacy systems are outdated hardware or software that organizations continue operating past vendor support lifecycles, leaving them unable to receive security updates, patches, or modern authentication protocols.

## Why it matters
In 2017, the WannaCry ransomware attack devastated the UK's NHS because thousands of hospital computers still ran Windows XP — an OS Microsoft had stopped patching in 2014. Attackers exploited EternalBlue, an SMBv1 vulnerability, and the unsupported systems had no defense. Hospitals diverted ambulances and cancelled 19,000 appointments because a "still-working" system met "catastrophically vulnerable."

## Key facts
- Legacy systems often cannot support modern encryption standards (TLS 1.2/1.3), forcing organizations to maintain weak protocols like SSL 3.0 or TLS 1.0 across the entire network
- **Compensating controls** are the standard mitigation: network segmentation, application-layer firewalls, and strict allowlisting isolate legacy systems when patching is impossible
- End-of-Life (EOL) and End-of-Support (EOS) are distinct — EOL means no new features; EOS means no security patches, which is the critical threshold
- Many industrial control systems (ICS/SCADA) run legacy OS because replacing them requires full production shutdowns costing millions, creating persistent, high-value targets
- Security+ and CySA+ frame legacy systems as a **configuration management** and **vulnerability management** problem requiring formal risk acceptance documentation when compensating controls are insufficient

## Related concepts
[[Patch Management]] [[Network Segmentation]] [[SCADA/ICS Security]] [[Compensating Controls]] [[Vulnerability Management]]