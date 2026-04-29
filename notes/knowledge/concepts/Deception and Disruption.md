# Deception and Disruption

## What it is
Like a medieval castle deploying a fake drawbridge to lure attackers into a killing field, deception technology tricks adversaries into revealing themselves while disruption actively degrades their ability to operate. Precisely defined: deception involves deploying convincing decoys (honeypots, honeytokens, fake credentials) to detect and study attackers, while disruption uses active countermeasures to interfere with attacker tools, timing, or infrastructure.

## Why it matters
During the SolarWinds supply chain attack, organizations with honeytokens—fake API keys and credentials seeded in legitimate-looking files—were able to detect lateral movement when attackers attempted to use those credentials, triggering alerts invisible to standard logging. This gave defenders critical early warning that pure signature-based tools completely missed.

## Key facts
- **Honeypots** are decoy systems designed to attract attackers; **honeynets** are networks of honeypots; **honeytokens** are fake data artifacts (fake AWS keys, bogus database records) with no legitimate use
- **Disruption** techniques include DNS sinkholes (redirecting malware C2 traffic to defender-controlled servers), tarpit systems (slowing attacker connections), and injecting false data into attacker reconnaissance
- Deception operates on the principle of **asymmetric cost**: defenders spend little deploying a honeytoken while attackers spend enormous effort chasing a dead end
- Any interaction with a honeytoken is a **high-fidelity alert**—zero false positives, since no legitimate user should ever touch it
- Deception technologies map directly to **MITRE ATT&CK** defensive techniques and support **active defense** strategies without crossing into legally murky "hack-back" territory

## Related concepts
[[Honeypots and Honeynets]] [[Threat Intelligence]] [[Indicators of Compromise]] [[Active Defense]] [[DNS Sinkholing]]