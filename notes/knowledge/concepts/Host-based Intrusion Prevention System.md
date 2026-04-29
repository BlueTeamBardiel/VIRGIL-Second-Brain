# Host-based Intrusion Prevention System

## What it is
Think of a HIPS like a bouncer living *inside* the nightclub — not checking IDs at the door, but watching every patron's behavior on the dance floor and physically ejecting anyone who throws a punch. A Host-based Intrusion Prevention System (HIPS) is software installed directly on an endpoint that monitors system calls, application behavior, and network traffic in real time, automatically blocking malicious activity before it executes or causes damage.

## Why it matters
In the 2017 NotPetya outbreak, attackers used legitimate Windows administrative tools (PsExec, WMIC) to propagate ransomware — activity that bypassed traditional antivirus entirely. A properly tuned HIPS would have detected the anomalous system call patterns and lateral movement behaviors, terminating the processes before encryption began, even without a known malware signature.

## Key facts
- HIPS operates at the **host level**, meaning it protects one machine regardless of network segmentation or firewall rules
- Uses **signature-based**, **anomaly-based**, and **policy-based** detection methods — often all three simultaneously
- Can block **zero-day exploits** by detecting behavioral anomalies rather than relying on known signatures
- Common HIPS actions include: **blocking execution**, **quarantining files**, **killing processes**, and **alerting administrators**
- Unlike a HIDS (Host-based Intrusion *Detection* System), HIPS actively **prevents** — it doesn't just log and alert; it intervenes
- Generates high false positives in misconfigured environments, making **tuning and baselining** a critical operational task

## Related concepts
[[Host-based Intrusion Detection System]] [[Endpoint Detection and Response]] [[Application Whitelisting]] [[Behavioral Analysis]] [[Zero-Day Exploit]]