# AvosLocker

## What it is
Like a locksmith who breaks into your house, changes every lock, then leaves a ransom note — but also threatens to post your family photos online if you don't pay — AvosLocker is a Ransomware-as-a-Service (RaaS) operation that combines file encryption with double extortion tactics. First observed in mid-2021, it targets Windows, Linux, and ESXi environments, making it unusually cross-platform for a ransomware family.

## Why it matters
In 2022, CISA issued an advisory warning that AvosLocker affiliates were exploiting on-premises Microsoft Exchange vulnerabilities (including ProxyShell) to gain initial access before deploying ransomware across critical infrastructure sectors. Defenders who had not patched Exchange servers found entire VMware ESXi environments encrypted, wiping out virtualized infrastructure in a single sweep — illustrating why patch management and network segmentation are non-negotiable controls.

## Key facts
- **RaaS model**: AvosLocker operators lease their ransomware to affiliates, who handle intrusions; profits are split, lowering the barrier to entry for attackers
- **Double extortion**: Victims face both encrypted files and threatened publication of stolen data on the "Avos News" leak site
- **Safe Mode abuse**: AvosLocker reboots Windows systems into Safe Mode before encrypting, bypassing endpoint security tools that don't run in Safe Mode
- **Cross-platform targeting**: Linux variants specifically target VMware ESXi servers, enabling mass encryption of virtual machines
- **Legitimate tool abuse (LOLBins)**: Affiliates frequently use AnyDesk, PDQ Deploy, and Cobalt Strike for lateral movement, blending into normal IT traffic

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[ProxyShell Vulnerability]] [[Defense Evasion]] [[Lateral Movement]]