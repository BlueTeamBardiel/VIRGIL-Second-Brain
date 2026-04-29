# dwell time

## What it is
Like a burglar who breaks into a house in January and quietly lives in the attic until June before stealing anything, dwell time is the gap between when an attacker first gains access and when they're actually detected. Precisely defined, it is the number of days a threat actor remains undetected inside a compromised environment.

## Why it matters
In the 2013 Target breach, attackers maintained access for roughly three weeks after their initial intrusion before exfiltrating 40 million credit card records — classic high dwell time enabling maximum damage. Had detection occurred within hours rather than weeks, defenders could have isolated the Citrix-linked vendor credentials and cut off lateral movement before the POS systems were ever touched.

## Key facts
- The global median dwell time has dropped significantly over the years — from over 200 days in 2013 to roughly 10 days by 2023 (per Mandiant M-Trends reports), but ransomware groups often deliberately compress their own dwell time to avoid detection.
- Longer dwell time = more reconnaissance, lateral movement, and data staging — directly increasing breach severity and cost.
- Detection source matters: breaches discovered internally have shorter dwell times than those disclosed by external parties (e.g., law enforcement or customers).
- EDR, NDR, and SIEM tools are specifically designed to reduce dwell time by increasing detection velocity.
- CySA+ and Security+ frame dwell time reduction as a core goal of threat hunting and continuous monitoring programs.

## Related concepts
[[lateral movement]] [[threat hunting]] [[mean time to detect (MTTD)]] [[indicators of compromise]] [[SIEM]]