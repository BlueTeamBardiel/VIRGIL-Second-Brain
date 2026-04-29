# Hive

## What it is
Think of Hive like a criminal franchise: a central organization provides the tools, infrastructure, and support while independent operators carry out the actual jobs and split the profits. Hive was a notorious **Ransomware-as-a-Service (RaaS)** operation active from June 2021 to January 2023, where core developers leased ransomware to affiliates who conducted attacks and shared roughly 20% of ransom proceeds back to the group.

## Why it matters
In 2021–2022, Hive attacked over 1,500 victims globally — including hospitals, schools, and critical infrastructure — collecting more than $100 million in ransom payments. The FBI conducted a landmark covert operation in 2022–2023, secretly infiltrating Hive's network, obtaining decryption keys, and distributing them to victims without payment — preventing an estimated $130 million in ransom demands before DOJ dismantled the infrastructure in January 2023.

## Key facts
- Hive used **double extortion**: encrypting victim data AND threatening to publish it on their "HiveLeaks" dark web site if ransom was unpaid
- Affiliates deployed Hive via **phishing emails, RDP exploitation, and compromised VPN credentials** — standard initial access vectors
- Hive malware was written in **Go (Golang)** and later rewritten in **Rust**, making it cross-platform and harder to detect/analyze
- The FBI's infiltration is a textbook example of **offensive cyber operations for defensive outcomes** — obtaining keys by compromising attacker infrastructure
- Hive targeted **Healthcare and Public Health (HPH) sector** disproportionately, making it a named threat in CISA advisories (AA22-321A)

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[Dark Web]] [[RDP Exploitation]] [[CISA Advisories]]