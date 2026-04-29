# Resource Development

## What it is
Like a theater troupe building costumes, sets, and props before opening night, attackers assemble their tools, infrastructure, and capabilities *before* the first malicious packet is ever sent. In MITRE ATT&CK terminology, Resource Development (TA0042) is the pre-attack phase where adversaries acquire or create the assets needed to support their operations — domains, servers, malware, compromised accounts, and code-signing certificates.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors spent months staging their operation: registering lookalike domains, building the SUNBURST backdoor, and acquiring infrastructure that blended with legitimate traffic. Defenders who monitored newly registered domains mimicking Orion software naming conventions could have detected this staging activity before the malicious update was ever distributed — demonstrating that hunting during Resource Development can stop attacks before they begin.

## Key facts
- MITRE ATT&CK breaks Resource Development into sub-techniques including: Acquire Infrastructure, Compromise Accounts, Obtain Capabilities, Stage Capabilities, and Develop Capabilities
- Attackers often purchase domains aged 30+ days to bypass reputation-based filtering systems
- Code signing certificates are frequently stolen or purchased to make malware appear legitimate to endpoint defenses
- Bulletproof hosting providers are a common resource, offering infrastructure that ignores law enforcement takedown requests
- Threat intelligence platforms like Shodan and passive DNS databases can help defenders detect adversary staging infrastructure before it's activated

## Related concepts
[[MITRE ATT&CK Framework]] [[Threat Intelligence]] [[Command and Control Infrastructure]] [[Domain Generation Algorithms]] [[Supply Chain Attacks]]