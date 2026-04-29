# Compute Hijacking

## What it is
Like a squatter secretly running a commercial bakery in your empty warehouse — using your electricity, ovens, and flour without permission — compute hijacking occurs when an attacker covertly commandeers a victim's CPU, GPU, or cloud resources to perform work that benefits the attacker. Formally, it is the unauthorized use of computing resources, most commonly for cryptocurrency mining (cryptojacking) or distributed attack infrastructure, without the resource owner's knowledge or consent.

## Why it matters
In 2018, Tesla's AWS environment was compromised when attackers exploited an unsecured Kubernetes dashboard to deploy Monero mining containers, effectively billing Tesla for the attacker's mining profits. Detection was delayed because attackers throttled CPU usage to avoid performance alerts — a classic evasion technique. This case illustrates why cloud resource monitoring and container security are critical defensive controls.

## Key facts
- **Cryptojacking** is the most common form; attackers embed mining scripts (e.g., Coinhive-style JavaScript) in websites or deploy malware that mines Monero, chosen for its CPU-friendliness and transaction privacy.
- Indicators of compromise include **sustained high CPU/GPU usage**, increased cloud billing spikes, and degraded system performance on otherwise idle machines.
- Compute hijacking can occur via **drive-by browser scripts** (no installation required), malware, compromised supply chains, or misconfigured cloud/container environments.
- On Security+/CySA+, compute hijacking is categorized under **resource abuse** threats; detection falls under behavioral analytics and anomaly-based monitoring.
- Defense controls include **Content Security Policy (CSP) headers** to block unauthorized scripts, endpoint detection tools monitoring CPU baselines, and strict IAM policies in cloud environments.

## Related concepts
[[Cryptojacking]] [[Malware]] [[Cloud Security Misconfigurations]] [[Botnet]] [[Resource Exhaustion]]