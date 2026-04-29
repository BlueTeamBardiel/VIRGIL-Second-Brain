# NPS

## What it is
Like a bouncer who checks IDs at multiple club entrances from one central podium, Network Policy Server is Microsoft's RADIUS server implementation that centralizes authentication decisions for network access. NPS acts as the policy enforcement hub for dial-up, VPN, wireless, and 802.1X wired connections, evaluating connection requests against defined network policies.

## Why it matters
In a corporate environment, an attacker who compromises an NPS server gains the ability to manipulate or log RADIUS authentication traffic — potentially capturing MSCHAPv2 challenge-response pairs for offline cracking. Defenders configure NPS with certificate-based authentication (EAP-TLS) instead of password-based protocols precisely to eliminate this credential theft vector at the authentication gateway.

## Key facts
- NPS is Microsoft's built-in RADIUS server, included with Windows Server; it replaces the older Internet Authentication Service (IAS)
- Supports multiple EAP methods: EAP-TLS (certificate-based), PEAP-MSCHAPv2 (password-based), and PEAP-TLS for varying security levels
- Network Policies define *who* gets access; Connection Request Policies define *where* the request is processed (locally or forwarded to another RADIUS server)
- NPS can act as a RADIUS **proxy**, forwarding authentication requests to remote RADIUS servers based on realm names (e.g., user@domain.com)
- Failed and successful authentication attempts are logged to Windows Event Viewer under Security logs (Event IDs 6272–6278), making NPS logs critical for forensic investigation of unauthorized access attempts

## Related concepts
[[RADIUS]] [[802.1X]] [[EAP-TLS]] [[Network Access Control]] [[MSCHAPv2]]