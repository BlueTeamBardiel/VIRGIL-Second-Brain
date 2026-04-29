# MURKYTOP

## What it is
Like a scout that slips into enemy territory to sketch a map before the main army arrives, MURKYTOP is a lightweight reconnaissance tool used exclusively in the initial phases of an intrusion. Specifically, it is a command-line reconnaissance utility attributed to APT10 (Stone Panda), a Chinese state-sponsored threat actor, designed to enumerate system information, network configurations, and running processes on compromised Windows hosts. It operates quietly, gathering intelligence to inform subsequent lateral movement and payload delivery.

## Why it matters
In documented APT10 campaigns targeting managed service providers (MSPs), MURKYTOP was deployed immediately after initial access to profile victim environments before heavier malware like PlugX or RedLeaves was introduced. Defenders analyzing endpoint telemetry who spotted unusual enumeration commands — such as `net view`, `ipconfig /all`, and `tasklist` being chained in rapid succession — could identify MURKYTOP activity and interrupt the kill chain before data exfiltration occurred. Early detection at this reconnaissance phase is significantly cheaper than responding after lateral movement has already succeeded.

## Key facts
- Attributed to **APT10 (Stone Panda / MenuPass)**, a Chinese cyber espionage group targeting MSPs and cloud providers
- Functions as a **post-exploitation reconnaissance tool**, not an initial access or persistence mechanism
- Executes native Windows commands to collect: **running processes, network shares, logged-on users, and system configuration**
- Commonly observed in **Operation Cloud Hopper** (2016–2018), a campaign that compromised MSPs to pivot into their downstream customers
- Produces output that feeds targeting decisions, making it a **pre-lateral-movement indicator** — detection here can prevent full compromise

## Related concepts
[[APT10]] [[Lateral Movement]] [[Living Off the Land (LotL)]] [[Reconnaissance (TA0043)]] [[Managed Service Provider Attacks]]