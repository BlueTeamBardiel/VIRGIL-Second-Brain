# EAP-TLS

## What it is
Like two spies who only trust each other after exchanging government-issued ID badges *in both directions*, EAP-TLS is a mutual authentication protocol where both the client and the authentication server present X.509 digital certificates to verify identity. It is the most secure variant of the Extensible Authentication Protocol, operating inside the 802.1X framework to protect wired and wireless network access.

## Why it matters
In a rogue access point attack, an adversary sets up a fake Wi-Fi hotspot mimicking a corporate SSID to harvest credentials. EAP-TLS defeats this because the client refuses to authenticate unless the server presents a valid, trusted certificate — meaning the fake AP cannot impersonate the legitimate RADIUS server without the private key it doesn't have. This mutual certificate exchange eliminates the credential-harvesting threat that weaker EAP variants like PEAP or EAP-TTLS are susceptible to when misconfigured.

## Key facts
- **Mutual authentication**: Both client *and* server must present valid X.509 certificates — not just the server as in HTTPS.
- **No passwords over the wire**: Authentication is entirely certificate-based, eliminating password-spraying and credential-stuffing risks at the network access layer.
- **Requires PKI infrastructure**: Every client device must have a certificate provisioned, making deployment complex but highly resistant to phishing.
- **Uses TLS handshake within EAP**: The TLS tunnel is established first, then credentials (certificates) are exchanged inside it — nothing travels in cleartext.
- **Gold standard for 802.1X**: Frequently cited on Security+ as the strongest EAP method; preferred in high-security environments like government and healthcare.

## Related concepts
[[802.1X]] [[RADIUS]] [[PKI]] [[PEAP]] [[X.509 Certificates]]