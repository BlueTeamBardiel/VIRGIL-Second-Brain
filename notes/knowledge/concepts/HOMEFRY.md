# HOMEFRY

## What it is
Like a locksmith who secretly makes copies of every key they cut for customers, HOMEFRY is a backdoor implant attributed to the China-nexus threat group APT41. Specifically, it is a password dumping and backdoor tool used to harvest credentials from compromised Windows systems, enabling persistent access long after the initial breach.

## Why it matters
In APT41 intrusion campaigns targeting healthcare and technology sectors, HOMEFRY was deployed *after* initial access was established via exploited public-facing applications. Attackers used it to dump credentials from memory, then leveraged those credentials for lateral movement across the network — turning one compromised host into a full domain compromise. Defenders who only monitored perimeter traffic missed the internal credential theft entirely.

## Key facts
- HOMEFRY is a 64-bit Windows malware tool linked to APT41 (a Chinese state-sponsored threat actor conducting both espionage and financially motivated operations)
- Functions as both a **credential harvester** (similar in purpose to Mimikatz) and a **backdoor**, giving it dual-use capability
- Often deployed alongside other APT41 tools such as LOWKEY and HIGHNOON as part of a staged intrusion toolkit
- Targets **LSASS memory** to extract plaintext credentials and NTLM hashes, enabling pass-the-hash attacks
- Detection focuses on anomalous LSASS access patterns, which Windows Credential Guard and attack surface reduction rules in Defender can help mitigate

## Related concepts
[[APT41]] [[Credential Dumping]] [[LSASS]] [[Pass-the-Hash]] [[Lateral Movement]]