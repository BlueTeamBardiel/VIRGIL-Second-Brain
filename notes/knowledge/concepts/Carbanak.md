# Carbanak

## What it is
Think of a master forger who doesn't rob a bank's vault directly, but instead learns the handwriting of every teller and manager until they can issue perfectly legitimate-looking wire transfers. Carbanak is an advanced persistent threat (APT) malware toolkit and the threat group behind it, responsible for a series of attacks against financial institutions beginning around 2013. The group used spear-phishing, RAT (Remote Access Trojan) implants, and deep network reconnaissance to impersonate bank employees and manipulate transaction systems from the inside.

## Why it matters
In the Carbanak attacks, threat actors spent months quietly inside bank networks — studying workflows, recording screens, and watching employees process transactions — before ever moving a dollar. They then programmed ATMs to dispense cash on command and manipulated SWIFT transactions, ultimately stealing over **$1 billion across 100+ financial institutions** in more than 30 countries. Defenders learned that anomaly detection in financial transaction systems and privileged account monitoring are critical layers that perimeter defenses alone cannot replace.

## Key facts
- Carbanak leveraged **spear-phishing emails with malicious Word documents** to gain initial footholds via macros
- The group maintained persistence for an average of **2–4 months** inside networks before exfiltrating funds — a hallmark of APT dwell time
- Attack techniques included **video/screen capture of employee desktops** to mimic legitimate banking behavior exactly
- Carbanak overlaps with the **FIN7** threat group, which later pivoted from banking to hospitality/retail sector attacks
- The malware used **legitimate remote administration tools** (e.g., Ammyy Admin) to blend into normal IT traffic and evade detection

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Spear Phishing]] [[Lateral Movement]] [[FIN7]] [[SWIFT Banking Fraud]]