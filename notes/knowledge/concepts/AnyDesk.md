# AnyDesk

## What it is
Think of it like giving someone a spare key to your house — except the key works over the internet and the "house" is your entire computer. AnyDesk is a legitimate remote desktop application that establishes encrypted graphical control sessions between devices using a proprietary DeskRT codec, allowing real-time screen sharing, file transfer, and input control across networks.

## Why it matters
In tech support scams and Living-off-the-Land (LotL) attacks, threat actors socially engineer victims into installing AnyDesk voluntarily, granting full system access without triggering antivirus alerts — because the tool itself is benign. During the 2022 ransomware campaigns targeting healthcare, attackers used AnyDesk as a persistent backdoor after initial compromise, maintaining C2 access even when other malware was removed.

## Key facts
- AnyDesk communicates over port **443** (HTTPS) or **6568**, making it difficult to block via standard firewall rules without disrupting legitimate web traffic
- It generates a unique **9-digit AnyDesk ID** per device — attackers use these IDs as lightweight C2 identifiers that are hard to correlate without endpoint telemetry
- Classified as a **Potentially Unwanted Application (PUA)** by many EDR platforms; it appears frequently in MITRE ATT&CK under **T1219 (Remote Access Software)**
- AnyDesk traffic blends with normal HTTPS flows, making it a **defense evasion** technique — detection relies on behavioral analysis (unexpected parent processes, unusual outbound connections) rather than signature matching
- Organizations should enforce **application allowlisting** and monitor for AnyDesk installation events via Windows Event ID **11707** (MSI install) or Sysmon **Event ID 1** (process creation)

## Related concepts
[[Remote Access Trojans (RAT)]] [[Living off the Land (LotL)]] [[Command and Control (C2)]] [[Application Allowlisting]] [[Social Engineering]]