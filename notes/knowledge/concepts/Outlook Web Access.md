# Outlook Web Access

## What it is
Think of it as a window cut into the side of your corporate mail room — anyone with the right key can reach in from the street, no need to enter the building. Outlook Web Access (OWA) is Microsoft Exchange's browser-based interface that allows users to access their email, calendar, and contacts over HTTPS from any internet-connected device. It exposes Exchange functionality externally without requiring a VPN or dedicated mail client.

## Why it matters
OWA is a prime target for credential stuffing and password spray attacks because it is intentionally internet-facing and often accessible without MFA. In the 2020 SolarWinds-related intrusions, threat actors leveraged compromised credentials against OWA endpoints to maintain persistent access to victim email systems while blending in with legitimate user traffic. Defenders monitor OWA authentication logs for anomalies like logins from unusual geolocations or repeated failed attempts followed by a single success.

## Key facts
- OWA listens on TCP port 443 (HTTPS); legacy configurations may also expose port 80 with HTTP-to-HTTPS redirects
- Password spraying OWA is a well-documented technique (T1110.003 in MITRE ATT&CK) — attackers try one common password across many accounts to avoid lockout thresholds
- OWA supports both Forms-Based Authentication (FBA) and Integrated Windows Authentication (IWA), making it configurable but also inconsistently secured across organizations
- Enabling Multi-Factor Authentication on OWA is a critical control; without it, a single stolen credential grants full email access
- OWA activity logs (IIS logs + Exchange logging) are key forensic artifacts — they record source IPs, user agents, and accessed mailboxes

## Related concepts
[[Password Spraying]] [[Exchange Server Security]] [[Multi-Factor Authentication]] [[Credential Stuffing]] [[MITRE ATT&CK Framework]]