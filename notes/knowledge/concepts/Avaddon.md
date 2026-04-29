# Avaddon

## What it is
Like a digital loan shark who not only locks your valuables in a safe but also photographs your private documents and threatens to post them online unless you pay — Avaddon is a ransomware-as-a-service (RaaS) operation that combined file encryption with double extortion tactics. It operated from 2020 until mid-2021, when its operators abruptly shut down and released decryption keys for roughly 2,900 victims.

## Why it matters
In 2021, Avaddon targeted the AXA insurance group shortly after AXA announced it would stop reimbursing ransomware payments in France — a highly symbolic attack demonstrating that ransomware groups actively monitor industry developments and retaliate strategically. Defenders studying Avaddon's TTPs learned the value of monitoring .js email attachment campaigns, which were Avaddon's primary initial access vector, and implementing strict email filtering policies before encryption ever begins.

## Key facts
- Operated as **Ransomware-as-a-Service (RaaS)**, recruiting affiliates through Russian-language cybercrime forums starting in June 2020
- Used **double extortion**: encrypted files AND threatened to leak stolen data on a dedicated leak site ("Avaddon Info")
- Primary initial access was **malicious spam (malspam)** with JavaScript attachments disguised as photos or invoices
- Operators performed a rare **voluntary shutdown in June 2021**, releasing 2,934 decryption keys to BleepingComputer, possibly due to increased law enforcement pressure following Colonial Pipeline scrutiny
- Targeted **critical infrastructure and healthcare** sectors across multiple countries, making it relevant to CISA advisories on ransomware threats

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[Initial Access Brokers]] [[Malspam]] [[REvil]]