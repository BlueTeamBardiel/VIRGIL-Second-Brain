# CozyCar

## What it is
Like a parasite that mimics a harmless cell to slip past the immune system, CozyCar disguises itself as legitimate software components to avoid detection. It is a sophisticated backdoor Trojan attributed to the Russian APT29 (Cozy Bear) group, designed for persistent, stealthy remote access to compromised systems while masquerading as benign processes.

## Why it matters
In the 2014–2015 breach of the Democratic National Committee, CozyCar was deployed as the initial foothold — sitting silently for months while exfiltrating sensitive communications before anyone noticed. Defenders studying this campaign learned the critical importance of behavioral anomaly detection over signature-based scanning, since CozyCar's disguised components evaded traditional AV tools entirely.

## Key facts
- **Attribution:** Linked to APT29 (Cozy Bear), assessed to be Russian SVR intelligence operatives
- **Delivery mechanism:** Typically delivered via spear-phishing emails with malicious attachments or links that execute a dropper
- **Evasion technique:** Injects malicious code into legitimate processes (e.g., Adobe Reader, browser components) to blend with normal system activity — a classic process hollowing approach
- **C2 communication:** Uses encrypted HTTP/HTTPS channels to communicate with command-and-control servers, making traffic blend with normal web traffic
- **Persistence:** Establishes persistence via Windows registry modifications and scheduled tasks, surviving reboots without re-infection

## Related concepts
[[APT29]] [[Spear Phishing]] [[Process Hollowing]] [[Command and Control (C2)]] [[Persistence Mechanisms]]