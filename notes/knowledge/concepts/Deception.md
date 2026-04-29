# Deception

## What it is
Like a Venus flytrap that looks like a flower to lure insects, deception in cybersecurity means deliberately presenting false information or fake targets to mislead attackers. It is the practice of creating fabricated assets, data, or environments that appear legitimate so defenders can detect, study, or misdirect adversaries.

## Why it matters
During a 2016-style APT intrusion, a defender deploys fake credentials labeled "admin_backup_creds.txt" on a compromised endpoint — the moment the attacker harvests and uses those credentials, the SOC gets an instant, high-fidelity alert with zero false positives. This technique transforms attacker activity into a reliable detection signal rather than relying on signature matching or anomaly thresholds.

## Key facts
- **Honeypots** are decoy systems designed to attract attackers; **honeynets** are networks of honeypots used for broader behavioral analysis
- **Honeyfiles and honeytokens** are fake files or credentials that trigger alerts when accessed — extremely low false-positive rate since legitimate users have no reason to touch them
- Deception technology operates on the principle that **any interaction with a fake asset is inherently suspicious**, inverting the normal detection problem
- **Breadcrumbs** (fake cached credentials, bookmarks, or config files) are planted to lead attackers from real systems toward deception infrastructure
- Deception is categorized under **active defense** and aligns with MITRE ENGAGE, a framework specifically for adversary engagement and denial operations

## Related concepts
[[Honeypot]] [[Threat Intelligence]] [[Active Defense]] [[Indicators of Compromise]] [[Threat Hunting]]