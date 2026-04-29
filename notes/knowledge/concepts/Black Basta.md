# Black Basta

## What it is
Like a corporate merger gone criminal — Black Basta operates as a polished franchise where developers lease ransomware infrastructure to affiliates who handle the "sales" (intrusions). It is a Ransomware-as-a-Service (RaaS) group that emerged in April 2022, employing double extortion: encrypting victim data *and* threatening to publish stolen files on their leak site, "Basta News."

## Why it matters
In 2023, Black Basta compromised ABB, a multinational industrial automation company, exfiltrating roughly 337 GB of data. The attack demonstrates why network segmentation and privileged access controls are critical — the group used QakBot malware for initial access, then moved laterally using tools like Cobalt Strike before deploying ransomware across Windows and VMware ESXi environments simultaneously.

## Key facts
- **Initial access vector**: Primarily phishing emails delivering QakBot (also spelled Qbot); after QakBot's 2023 FBI takedown, Black Basta pivoted to other loaders like DarkGate
- **Double extortion model**: Victims face both encrypted systems and threatened public data leaks, increasing pressure to pay ransoms
- **Cross-platform capability**: Encrypts both Windows systems and Linux/VMware ESXi servers, targeting virtualization infrastructure directly
- **Believed ties**: Widely assessed to have connections to the defunct Conti ransomware group — many TTPs and personnel overlap post-Conti disbandment in 2022
- **CISA advisory**: CISA, FBI, and HHS issued a joint advisory (May 2024) warning that Black Basta had targeted over 500 organizations globally, with heavy focus on healthcare

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[QakBot]] [[Cobalt Strike]] [[Lateral Movement]]