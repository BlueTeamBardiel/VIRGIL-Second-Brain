# Data Theft

## What it is
Like a pickpocket who photographs your credit card instead of taking your wallet — leaving no obvious trace they were ever there — data theft is the unauthorized copying or exfiltration of sensitive information from a system, often without destroying or removing the original. It encompasses any technique used to transfer confidential data to an attacker-controlled destination, from simple file copying to covert channel tunneling.

## Why it matters
In the 2020 SolarWinds breach, attackers embedded a backdoor in software updates and quietly exfiltrated data from U.S. government agencies for months without triggering alerts. The damage wasn't a loud ransomware explosion — it was silent, persistent data collection, illustrating why detecting *outbound* anomalous traffic is just as critical as blocking inbound attacks.

## Key facts
- **Exfiltration channels** include DNS tunneling, HTTPS POST requests to C2 servers, steganography, and removable media — all used to bypass DLP controls
- **Data Loss Prevention (DLP)** tools inspect content in motion, at rest, and in use; they are the primary defensive control mapped to this threat
- **Indicators of exfiltration** include large outbound transfers during off-hours, repeated DNS queries to unknown domains, and unusual use of cloud storage apps
- **MITRE ATT&CK** catalogs exfiltration as a dedicated tactic (TA0010) with techniques like *Exfiltration Over Web Service* (T1567) and *Scheduled Transfer* (T1029)
- Under regulations like **GDPR and HIPAA**, a confirmed data theft incident triggers mandatory breach notification requirements, regardless of whether data was "used"

## Related concepts
[[Data Loss Prevention]] [[Exfiltration]] [[Insider Threat]] [[Command and Control]] [[MITRE ATT&CK Framework]]