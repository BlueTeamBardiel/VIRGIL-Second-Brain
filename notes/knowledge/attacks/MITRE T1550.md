# MITRE T1550

## What it is
Imagine stealing a hotel keycard rather than learning the combination to a safe — you skip the hard part entirely and just use what someone else already unlocked. T1550 (Use Alternate Authentication Material) describes exactly this: attackers bypass normal credential authentication by using stolen tokens, hashes, cookies, or tickets instead of actual passwords.

## Why it matters
In the 2020 SolarWinds compromise, attackers forged SAML tokens (Golden SAML attack) to authenticate to cloud services as legitimate users — no passwords required, no MFA prompted. Defenders must monitor for authentication events originating from unusual locations or processes even when credentials appear valid, since the credentials technically *are* valid.

## Key facts
- **Sub-techniques include:** Pass-the-Hash (T1550.002), Pass-the-Ticket (T1550.003), Application Access Token abuse (T1550.001), and Web Session Cookie theft (T1550.004)
- **Pass-the-Hash** works against NTLM authentication — an attacker uses the NT hash directly without cracking it, making password complexity irrelevant
- **Pass-the-Ticket** exploits Kerberos by reusing stolen TGTs or service tickets; the Golden Ticket attack uses a compromised KRBTGT hash to forge arbitrary tickets
- **Detection focus:** Look for logon events (Event ID 4624) with logon type 3 (network) or anomalous service ticket requests (Event ID 4769) with unusual encryption types
- Enforcing **SMB signing** and disabling NTLM where possible directly mitigates Pass-the-Hash; rotating the KRBTGT account password twice neutralizes Golden Tickets

## Related concepts
[[Pass-the-Hash]] [[Kerberos Authentication]] [[Golden Ticket Attack]] [[NTLM Authentication]] [[Token Impersonation]]