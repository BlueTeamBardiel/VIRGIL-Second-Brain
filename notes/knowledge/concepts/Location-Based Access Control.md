# Location-Based Access Control

## What it is
Think of a casino vault that only unlocks for employees whose ID badge was swiped at the building's front door — if you claim to be inside but never entered, the vault stays shut. Location-Based Access Control (LBAC) restricts resource access based on the physical or geographic location of the requesting user or device, using signals like GPS coordinates, IP geolocation, Wi-Fi network identity, or cell tower triangulation to enforce policy.

## Why it matters
In 2020, attackers exploiting stolen VPN credentials were blocked at several enterprises using LBAC policies that flagged logins originating from Eastern Europe when the account owner's normal baseline was Chicago — the anomalous geography triggered a deny-and-alert response before data exfiltration occurred. Without location as a contextual factor, valid credentials alone would have granted full access.

## Key facts
- **Geofencing** is the common implementation — a defined geographic boundary that triggers allow/deny decisions; crossing it can revoke an active session in real time
- IP geolocation is the weakest location signal; VPNs and Tor trivially spoof it, so high-assurance environments layer GPS or network-based signals on top
- LBAC is a core component of **Zero Trust Architecture**, functioning as one context attribute alongside device health and user identity
- Under **NIST SP 800-207**, location is classified as an environmental attribute used in policy decision points (PDPs)
- Impossible travel detection — a user authenticating from New York then Tokyo within 30 minutes — is a derivative LBAC enforcement technique used in UEBA and CASB tools

## Related concepts
[[Zero Trust Architecture]] [[Context-Aware Access Control]] [[Geofencing]] [[UEBA]] [[Multi-Factor Authentication]]