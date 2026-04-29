# Impossible Travel

## What it is
Like a passport stamp showing you entered New York at 9:00 AM and Tokyo at 9:45 AM — the physics simply don't work. Impossible Travel is a behavioral analytics detection technique that flags authentication events where the same account logs in from two geographically distant locations within a timeframe that no human could physically traverse.

## Why it matters
In 2020, attackers using stolen credentials from a phishing campaign logged into a corporate Office 365 account from Chicago, and 22 minutes later from a server in Eastern Europe. The SIEM's impossible travel rule triggered an alert, froze the session, and forced MFA re-verification — catching the breach before lateral movement occurred. Without this control, the attacker would have had undetected access to email and SharePoint for hours.

## Key facts
- Impossible travel detection is a core feature of **UEBA (User and Entity Behavior Analytics)** and platforms like Microsoft Defender for Cloud Apps and Splunk UBA
- The detection calculates **velocity** — distance divided by time between logins — and compares it against a physical plausibility threshold (typically >800 km/hr triggers review)
- **VPNs, Tor exit nodes, and cloud proxies** are the most common false-positive sources; tuning requires baseline exceptions for known VPN IP ranges
- It is classified as an **anomaly-based detection** method, meaning it requires a behavioral baseline and produces higher false-positive rates than signature-based controls
- On the **CySA+ exam**, impossible travel falls under threat intelligence and UEBA controls; expect it paired with questions about **identity-based attack detection** and insider threat programs

## Related concepts
[[UEBA]] [[Behavioral Analytics]] [[Credential Stuffing]] [[Anomaly-Based Detection]] [[Identity and Access Management]]