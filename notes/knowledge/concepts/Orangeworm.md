# Orangeworm

## What it is
Like a hospital janitor who quietly mops floors for months while memorizing the layout of every room, Orangeworm is a threat group that embeds itself silently in healthcare environments for extended reconnaissance. Precisely, Orangeworm is a targeted cyberespionage group active since approximately 2015, known for deploying the Kwampirs backdoor trojan against healthcare organizations, pharmaceutical companies, and healthcare IT providers primarily in the US, Europe, and Asia.

## Why it matters
In a real-world scenario, Orangeworm compromised hospital networks specifically targeting machines running radiology imaging software and patient consent systems — equipment often running outdated, unpatched Windows XP. This is a textbook case of why legacy medical device security is critical: an attacker with persistent backdoor access to imaging systems could exfiltrate patient data, disrupt diagnostics, or pivot deeper into hospital infrastructure without triggering standard alerts.

## Key facts
- **Primary malware**: Kwampirs backdoor — a remote access trojan (RAT) that copies itself across network shares to propagate laterally, making removal particularly difficult
- **Target sectors**: Healthcare (hospitals, pharma, medical device manufacturers, healthcare IT) — a supply-chain approach to maximize reach
- **TTPs**: Uses scheduled tasks and services for persistence; relies on outdated, legacy systems (Windows XP era) that lack modern endpoint detection
- **Attribution**: Attributed to a single organized group (not nation-state confirmed); motive assessed as corporate espionage / intellectual property theft, not sabotage
- **Detection challenge**: Kwampirs uses a timestamp-copying technique (timestomping) to blend malicious files with legitimate system files, evading forensic timelines

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Kwampirs]] [[Lateral Movement]] [[Legacy System Vulnerabilities]] [[Healthcare Sector Cybersecurity]]