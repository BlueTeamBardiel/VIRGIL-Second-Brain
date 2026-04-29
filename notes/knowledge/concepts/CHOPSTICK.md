# CHOPSTICK

## What it is
Like a Swiss Army knife disguised as a chopstick — functional, concealed, and multipurpose — CHOPSTICK (also called CORESHELL or X-Agent) is a second-stage modular malware implant used by APT28 (Fancy Bear). It operates as a sophisticated backdoor capable of keylogging, file exfiltration, remote command execution, and screen capture, deployed only after initial compromise is confirmed.

## Why it matters
During the 2016 Democratic National Committee (DNC) breach, APT28 deployed CHOPSTICK after establishing initial access via SOURFACE (the first-stage dropper). Investigators identified CHOPSTICK's encrypted C2 communications and modular plugin architecture as what allowed Russian operators to maintain persistent, stealthy access for months before discovery — demonstrating how second-stage payloads dramatically extend adversary dwell time.

## Key facts
- **Attribution**: Exclusively linked to APT28 (Fancy Bear), a Russian GRU-affiliated threat actor targeting government, military, and political organizations
- **Modular design**: Plugins can be swapped in/out remotely, making it adaptable mid-operation without redeploying the core implant
- **Encrypted C2**: Uses encrypted channels (often over HTTP/HTTPS) to blend with normal traffic and evade signature-based detection
- **Persistence mechanism**: Achieves persistence via Windows Registry modifications and scheduled tasks — classic MITRE ATT&CK T1053/T1547 techniques
- **Detection indicator**: Network defenders look for anomalous encrypted beaconing at regular intervals as a key behavioral IOC

## Related concepts
[[APT28]] [[Command and Control (C2)]] [[SOURFACE]] [[Modular Malware]] [[Lateral Movement]]