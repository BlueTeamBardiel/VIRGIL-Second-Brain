# WannaCry

## What it is
Imagine a master key that opens every lock in a hospital, except after opening each door it chains it shut and demands ransom — that's WannaCry. It is a self-propagating ransomworm that encrypts victim files and demands Bitcoin payment, using a stolen NSA exploit to spread autonomously across networks without requiring any user interaction.

## Why it matters
In May 2017, WannaCry infected over 200,000 systems across 150 countries within 72 hours, crippling the UK's National Health Service and forcing hospitals to turn away patients. A security researcher accidentally activated a hardcoded kill switch domain, halting propagation — demonstrating that even catastrophic malware can have exploitable design flaws worth hunting for during incident response.

## Key facts
- Exploited **EternalBlue** (MS17-010), an SMBv1 vulnerability developed by the NSA and leaked by Shadow Brokers; Microsoft had patched it two months prior in **MS17-010**
- Classified as a **cryptoworm** — combining ransomware encryption with worm-style autonomous lateral movement via **port 445**
- The kill switch was an unregistered domain embedded in the code; registering it for ~$10 stopped global spread, illustrating the importance of malware reverse engineering
- Demanded **$300–$600 in Bitcoin** per host; despite massive infection scale, attackers collected relatively little due to Bitcoin traceability fears
- North Korea's **Lazarus Group** was attributed by US, UK, and Australian governments as the responsible threat actor

## Related concepts
[[EternalBlue]] [[Ransomware]] [[SMB Protocol]] [[Lateral Movement]] [[Patch Management]]