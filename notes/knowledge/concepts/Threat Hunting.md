# threat hunting

## What it is
Like a detective who doesn't wait for a crime report but instead walks the neighborhood looking for signs of trouble, threat hunting is the proactive search for adversaries already inside your network before any alert fires. It assumes compromise has occurred and uses human-led investigation — guided by hypotheses — to find what automated tools missed. It's distinct from incident response, which is reactive, and from monitoring, which is passive.

## Why it matters
In the 2020 SolarWinds supply chain attack, malicious backdoors sat dormant for months inside victim networks, deliberately designed to stay below SIEM alert thresholds. Organizations that practiced hypothesis-driven threat hunting — specifically looking for anomalous outbound DNS traffic and unusual service account behavior — were able to detect SUNBURST activity that automated tools never flagged.

## Key facts
- Threat hunting operates on the **assume breach** mindset — the adversary is already inside, you just haven't found them yet
- Hunts are built around **hypotheses** derived from threat intelligence, ATT&CK TTPs, or anomalies (e.g., "What if an attacker is using Living-off-the-Land binaries for lateral movement?")
- The **MITRE ATT&CK framework** is the primary reference hunters use to map adversary behaviors and structure hunt queries
- Maturity is measured on the **Hunting Maturity Model (HMM)**: Level 0 (reactive/alert-driven) up to Level 4 (fully automated, data-science-powered hunts)
- Key data sources for hunting include **EDR telemetry, DNS logs, NetFlow, and Windows Event Logs** (especially Event IDs 4624, 4688, 4698)

## Related concepts
[[MITRE ATT&CK]] [[SIEM]] [[Indicators of Compromise]] [[EDR]] [[incident response]]