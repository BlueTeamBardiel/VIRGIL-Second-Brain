# Lucifer

## What it is
Like a traveling salesman who picks locks *and* recruits locals to join his gang, Lucifer is a hybrid malware that combines cryptojacking with self-propagating worm capabilities. Precisely, it is a multi-exploitation malware that leverages a collection of known CVEs against Windows systems to mine Monero cryptocurrency while also launching DDoS attacks and spreading laterally across networks.

## Why it matters
In 2020, Lucifer was observed actively exploiting unpatched Windows vulnerabilities — including EternalBlue (CVE-2017-0144) and vulnerabilities in Apache, Oracle WebLogic, and Laravel — to compromise enterprise networks. A single unpatched internet-facing server could become both a mining slave and a launchpad for internal network compromise, making patch management a critical defensive control.

## Key facts
- Lucifer was discovered in **June 2020** by Palo Alto Networks Unit 42 researchers and operates in two distinct versions (v1 and v2)
- It exploits **multiple CVEs simultaneously** including EternalBlue, EternalRomance, DoublePulsar, and vulnerabilities in Apache Struts and Oracle WebLogic
- Uses **XMRig** (a legitimate open-source Monero miner) as its cryptomining payload — a technique called "living off the land" mining
- Achieves persistence via **scheduled tasks and Windows Registry** run keys, and spreads via brute-forcing SMB, FTP, MSSQL, and RDP credentials
- Combines **three threat types in one**: cryptominer, DDoS bot, and self-propagating worm — making detection and classification harder

## Related concepts
[[EternalBlue]] [[Cryptojacking]] [[Lateral Movement]] [[XMRig]] [[Worm]]