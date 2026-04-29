# MITRE ATT&CK T1550

## What it is
Like a counterfeiter who doesn't forge the safe's combination but instead molds a wax copy of the key, T1550 (Use Alternate Authentication Material) describes attackers bypassing normal credential verification by using stolen authentication tokens, hashes, or tickets instead of actual passwords. Rather than cracking credentials, adversaries weaponize the authentication artifacts themselves to impersonate legitimate users.

## Why it matters
In the 2020 SolarWinds breach, attackers forged SAML authentication tokens (Golden SAML attack) to access Microsoft 365 services without ever knowing user passwords, persisting undetected for months. Defenders must monitor for anomalous token usage patterns, impossible travel indicators, and authentication events originating from unexpected source IPs — password resets alone cannot remediate this compromise.

## Key facts
- **Sub-techniques include:** Pass-the-Hash (T1550.002), Pass-the-Ticket (T1550.003), Application Access Tokens (T1550.001), and Web Session Cookie theft (T1550.004)
- **Pass-the-Hash** exploits NTLM authentication — attackers use the captured hash directly without cracking it; rotating passwords does NOT invalidate a hash already in use
- **Pass-the-Ticket** targets Kerberos — stolen TGTs or service tickets (especially Golden/Silver Tickets) allow lateral movement across Active Directory environments
- **Golden Ticket attacks** require the KRBTGT account hash; the ticket can be valid for up to 10 years and survives most remediation unless KRBTGT is reset twice
- Detection relies on behavioral analytics: look for Pass-the-Hash via Event ID 4624 (Logon Type 3 with NTLM) and anomalous Kerberos ticket lifetimes

## Related concepts
[[Pass-the-Hash]] [[Kerberos Authentication]] [[Golden Ticket Attack]] [[Lateral Movement]] [[NTLM Authentication]]