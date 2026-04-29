# SolarWinds

## What it is
Imagine a trusted janitor with master keys to every office in a skyscraper — if someone impersonates that janitor, they get access everywhere without triggering a single alarm. SolarWinds Orion was that janitor: a widely-trusted IT monitoring platform used by thousands of organizations. Attackers compromised its software build pipeline, embedding malicious code (SUNBURST) into legitimate, digitally-signed updates distributed to ~18,000 customers.

## Why it matters
In 2020, Russian-linked threat group Cozy Bear (APT29) used the trojanized Orion update to silently infiltrate U.S. federal agencies, including the Treasury and Homeland Security departments, for nearly nine months before detection. The attack demonstrated that even rigorous perimeter defenses are useless when the threat arrives inside a trusted vendor's signed software package.

## Key facts
- **Supply chain attack**: Malicious code was injected during the build process, not through a traditional network intrusion of victim organizations
- **SUNBURST backdoor**: The malware lay dormant for ~14 days after installation to evade sandbox analysis, then beaconed to attacker-controlled C2 servers disguised as legitimate Orion traffic
- **Digital signature abuse**: The malicious update carried a valid SolarWinds code-signing certificate, bypassing integrity checks that organizations rely on
- **Detection via anomaly analysis**: FireEye discovered the breach while investigating suspicious logins tied to a misconfigured MFA device — not from signature-based AV
- **Vendor risk exposure**: Organizations with high patch compliance actually applied the malicious update *faster*, meaning good hygiene paradoxically accelerated compromise

## Related concepts
[[Supply Chain Attack]] [[Advanced Persistent Threat]] [[Code Signing]] [[Backdoor]] [[Threat Intelligence]]