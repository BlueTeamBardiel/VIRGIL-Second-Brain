# menuPass

## What it is
Like a skilled locksmith who specializes exclusively in picking one brand of lock, menuPass is a Chinese state-sponsored threat actor (APT10) laser-focused on managed service providers and global supply chains. Tracked by multiple vendors as Stone Panda and APT10, this group operates on behalf of China's Ministry of State Security and has been active since at least 2006.

## Why it matters
In 2016–2017, menuPass executed "Operation Cloud Hopper," infiltrating managed service providers (MSPs) to pivot into dozens of downstream client networks across healthcare, defense, and finance sectors worldwide. By compromising the MSP — the trusted locksmith holding everyone's keys — they gained simultaneous access to multiple high-value targets without triggering per-target alarms, demonstrating why third-party risk is a critical attack surface.

## Key facts
- **Attribution:** Linked to China's MSS (Ministry of State Security), specifically the Tianjin Bureau; two members indicted by the U.S. DOJ in 2018
- **Primary technique:** Supply chain compromise via MSP infiltration — classic "island hopping" to reach final targets
- **Tools used:** PlugX, RedLeaves, QuasarRAT, and the custom ANEL/ChChes malware families
- **MITRE ATT&CK:** Heavily maps to T1199 (Trusted Relationship), T1078 (Valid Accounts), and T1059 (Command and Scripting Interpreter)
- **Target sectors:** Defense, aerospace, satellite technology, pharmaceutical, and government — industries with high-value intellectual property aligned with China's national development goals

## Related concepts
[[APT (Advanced Persistent Threat)]] [[Supply Chain Attack]] [[Managed Service Provider (MSP) Risk]] [[MITRE ATT&CK Framework]] [[Lateral Movement]]