# On-path

## What it is
Like a corrupt postal worker who opens your letters, reads them, potentially alters them, then reseals and delivers them — neither sender nor receiver knows anything changed. An on-path attack (formerly called "man-in-the-middle") occurs when an attacker secretly positions themselves between two communicating parties, intercepting and potentially manipulating traffic in real time.

## Why it matters
A classic scenario: an attacker on a coffee shop Wi-Fi uses ARP poisoning to associate their MAC address with the gateway's IP address. All traffic from victims flows through the attacker's machine first, enabling credential harvesting or session hijacking before forwarding packets normally. HTTPS and certificate pinning exist specifically to defeat this by making silent interception detectable.

## Key facts
- **ARP poisoning** is the most common LAN-based technique to achieve on-path positioning by corrupting the ARP cache of victims
- **SSL stripping** is an on-path technique that downgrades HTTPS connections to HTTP, making encrypted traffic readable
- **HSTS (HTTP Strict Transport Security)** is a defensive header that prevents SSL stripping by telling browsers to only use HTTPS
- On-path attacks require **network positioning** — the attacker must be on the logical path between the two parties (same network segment, compromised router, or rogue access point)
- Distinguished from **on-path *passive* (eavesdropping)** vs **on-path *active* (injection/modification)** — both are on-path, but only active attacks alter data
- Certificate validation errors in browsers are often the first visible indicator that an on-path attack is occurring

## Related concepts
[[ARP Poisoning]] [[SSL Stripping]] [[Session Hijacking]] [[Rogue Access Point]] [[HSTS]]
