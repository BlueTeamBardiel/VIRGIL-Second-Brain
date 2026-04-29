# Exfiltration Over C2 Channel

## What it is
Like a spy who smuggles stolen documents out of the country in the same diplomatic pouch they used to receive their instructions, attackers reuse their already-established command-and-control communication channel to send stolen data back out. Precisely: **Exfiltration Over C2 Channel (MITRE ATT&CK T1041)** is the technique where an attacker transmits stolen data outbound through the same protocol and infrastructure used for C2 communications, rather than establishing a separate exfiltration path.

## Why it matters
In the 2020 SolarWinds SUNBURST attack, stolen data was exfiltrated via the same HTTPS-based C2 channel used to issue commands — blending seamlessly with legitimate Orion product traffic. This made detection extremely difficult because defenders were looking for *anomalous* traffic, while the exfiltration was disguised inside *expected* traffic patterns on trusted ports.

## Key facts
- Maps to **MITRE ATT&CK T1041** under the Exfiltration tactic; commonly paired with encrypted C2 channels (T1573) to evade inspection
- Attackers favor this technique because it requires **no additional network connections**, reducing the attack surface for detection
- Common protocols abused include **HTTPS (443), DNS, and IRC** — ports often whitelisted through firewalls
- Detection relies on **behavioral baselines**: unusually large outbound transfers, high data volume ratios (more outbound than inbound), and off-hours communication spikes
- **DLP (Data Loss Prevention)** tools and **SSL/TLS inspection** at the perimeter are primary defensive controls; without TLS decryption, encrypted C2 exfiltration is nearly invisible

## Related concepts
[[Command and Control (C2)]] [[DNS Tunneling]] [[Data Loss Prevention (DLP)]] [[Network Traffic Analysis]] [[MITRE ATT&CK Framework]]