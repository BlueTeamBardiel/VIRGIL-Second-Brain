# Order of Volatility

## What it is
Like a melting ice sculpture — you photograph the fine details first before they're gone forever, then capture the base. Order of Volatility is the principle that digital evidence must be collected in sequence from most to least transient, ensuring that ephemeral data (gone the moment power cuts) is preserved before stable data (survives indefinitely on disk).

## Why it matters
During a live ransomware incident, a responder who reboots the compromised machine to "start fresh" destroys RAM contents containing the encryption keys, active network connections revealing the C2 server, and running malicious processes — evidence that could have enabled decryption and attacker attribution. Collecting volatile memory first with a tool like Volatility or Magnet RAM Capture preserves this critical forensic window before it evaporates.

## Key facts
- **Correct collection order:** CPU registers/cache → RAM → Swap/pagefile → Network state → Running processes → Disk storage → Remote logs → Archive media
- RAM is the most volatile — completely lost on power loss; hard drives retain data for years without power
- Network connections and ARP cache are highly volatile and should be captured with `netstat` and `arp -a` immediately upon response
- Swap/pagefile sits between RAM and disk in volatility — it persists across reboots but is frequently overwritten
- On Security+/CySA+: "most volatile first" is the guiding rule; violations constitute forensic evidence contamination and may render evidence inadmissible

## Related concepts
[[Digital Forensics]] [[Chain of Custody]] [[Memory Forensics]] [[Incident Response Lifecycle]] [[Evidence Integrity]]