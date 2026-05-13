# On-Path Attacks

## What it is

You're at a coffee shop. You connect to "Starbucks_WiFi." Your laptop sends traffic to what it thinks is the gateway, the gateway forwards it to the internet, and replies come back. Except the gateway isn't the gateway — it's a Raspberry Pi in someone's backpack two tables over, sitting silently between you and the real router, reading every packet you send and forwarding them on so you never notice. That's the attack. The machine in the middle pretends to be the router to you, and pretends to be you to the router. Both sides keep talking. The attacker reads, modifies, or replays everything.

Plain English: an attacker inserts themselves between two endpoints that think they're talking directly. Used to be called man-in-the-middle. CompTIA renamed it on-path because the attacker doesn't have to be a person and doesn't have to be in the middle of the wire — they just have to be *on the path the packets travel.*

Technical definition: an active interception attack where a malicious node positions itself within the communication flow between two parties, capable of eavesdropping (passive) or modifying/injecting traffic (active), typically by abusing trust in network identification protocols — ARP, DNS, DHCP, BGP, or certificate trust chains.

The network stack is the machine's voice and ears. An on-path attack is someone standing between two people having a conversation, repeating what each one says to the other — but free to lie at any moment.

## Why it matters

Every login, every banking session, every API call your help desk tools make — it all assumes the network path is honest. On-path attacks break that assumption. If an attacker is on-path before TLS is established, they can downgrade the connection, present a forged certificate, or strip encryption entirely. If they're on-path after, they may still be able to harvest session cookies, redirect traffic, or inject malicious payloads into unencrypted streams.

For the A+ exam: CompTIA 220-1202 Objective 2.5 lists on-path attack as a vulnerability category. They want you to recognize it in scenarios — public Wi-Fi, rogue access points, ARP poisoning, evil twin networks, suspicious certificate warnings. They'll test you on the difference between *on-path* (active interception) and *eavesdropping/sniffing* (passive listening), and on the mitigations: HTTPS everywhere, VPN, certificate pinning, switch port security, DHCP snooping, DNSSEC.

Career relevance: this is the attack your users will fall into without knowing. They connect to "Free_Airport_WiFi," accept a certificate warning because "it asked me to," and now their O365 session token is in someone else's hands. You'll see the alert in the SIEM, you'll call the user, and they'll swear they didn't do anything.

## In your build, in the enterprise

**Beat 1 — Technical depth.** On-path attacks abuse trust in network identification. The common vectors:

- **ARP poisoning** — attacker broadcasts forged ARP replies on the LAN claiming "the gateway's MAC is mine." Every host on that subnet now sends traffic to the attacker. Layer 2, no authentication on ARP, trivially easy on an open switch.
- **DNS spoofing/cache poisoning** — attacker injects forged DNS responses so `bank.com` resolves to their IP. User types the right URL, lands on the wrong server.
- **DHCP starvation + rogue DHCP** — attacker exhausts the real DHCP pool, then hands out leases naming themselves as the gateway and DNS server.
- **Evil twin AP** — attacker stands up a Wi-Fi network with the same SSID as a legitimate one. Devices auto-connect, all traffic flows through the attacker's box.
- **SSL stripping** — attacker downgrades HTTPS to HTTP for users who type `bank.com` instead of `https://bank.com`. HSTS preload lists are the fix.
- **BGP hijacking** — the enterprise-scale version. Attacker announces routes for IP ranges they don't own, internet-wide traffic detours through their AS.

Tools: Ettercap, Bettercap, mitmproxy, Wireshark for analysis, hostapd-mana for evil twin AP work. Defenders should know the names — you'll see them in pentest reports.

**Beat 2 — Feynman example via your homelab.** You're spinning up a homelab to learn pentesting and you decide to demo an on-path attack on yourself.

**The setup:** Kali VM on your gaming rig, your phone connected to the same Wi-Fi, you run `arpspoof` telling your phone the gateway is the Kali box and telling the router the phone is the Kali box. Now you're on-path. Wireshark fires up. *Suddenly you're reading every DNS query your phone makes in real time.*

**The "oh" moment:** You open the banking app on your phone. Wireshark shows... encrypted garbage. TLS 1.3, certificate pinning, the app refuses to talk to anything that doesn't present the real cert. *HTTPS done right is why your bank still works on hostile networks.*

**The dirty trick:** You try `sslstrip` on a site that doesn't use HSTS. User types `example.com`, your box intercepts the HTTP request, fetches the HTTPS version itself, and serves the user a plain HTTP copy. User sees no padlock — but how many users check? *The padlock is the whole defense, and nobody looks at it.*

**The kicker:** Your homelab demo took twenty minutes. The skill ceiling is low. *This is why the industry moved hard to HTTPS-everywhere, HSTS preload, and certificate transparency logs — because the attack is too cheap not to defend against.*

**Beat 3 — Bridge from homelab to enterprise.** Same fundamental question — *how do I know the thing I'm talking to is actually the thing I think I'm talking to?* — different answers at different scales:

- **Home network:** WPA3, HTTPS everywhere, a VPN if you're on public Wi-Fi. You trust your router because you set it up. Defense is mostly "use encryption and don't click through cert warnings."
- **Small business:** managed switch with DHCP snooping enabled, dynamic ARP inspection, 802.1X on wired ports. Rogue DHCP server can't hand out leases because the switch only accepts DHCP offers from the trusted port.
- **Enterprise:** network access control (NAC), 802.1X with certificate-based authentication, segmented VLANs, DNSSEC, certificate pinning in custom apps, internal CAs with certificate transparency monitoring, EDR that flags suspicious ARP behavior, and SOC analysts watching for the indicators. Plus a written rule: *no domain credentials over public Wi-Fi, ever, without VPN.*

**Beat 4 — The point.** Same question — "is this conversation actually private and actually with who I think it's with?" — answered with WPA3 at home and a six-layer defense in depth at the enterprise. Get the question into your bones. Every time you connect to a network, every time your laptop accepts a certificate, every time DNS resolves — you're trusting something. Know what you're trusting and how it could lie.

## Key facts

### On-path attack vectors and mitigations

| Vector | Layer | What it abuses | Primary mitigation |
|---|---|---|---|
| ARP poisoning | L2 | Unauthenticated ARP | Dynamic ARP Inspection (DAI), static ARP entries |
| Rogue DHCP | L2/L3 | First-response wins | DHCP snooping on managed switches |
| DNS spoofing | L7 | Plaintext DNS | DNSSEC, DoH/DoT, trusted resolvers |
| Evil twin Wi-Fi | L2 | SSID has no identity | WPA3-Enterprise, 802.1X, certificate validation |
| SSL stripping | L7 | HTTP → HTTPS upgrade | HSTS, HSTS preload, HTTPS-only mode in browsers |
| BGP hijack | L3 | Trust between ASes | RPKI, route filtering, BGP monitoring |
| Rogue proxy | L7 | Configured proxy trust | PAC file integrity, certificate pinning |

### On-path vs. eavesdropping — CompTIA's favorite distinction

**Eavesdropping (passive)** — attacker captures traffic but doesn't alter it. Packet sniffing on a hub, listening to open Wi-Fi. No modification, no injection. Detection is hard because nothing changes.

**On-path (active)** — attacker is in the flow, can read AND modify AND inject. They're not just listening — they're a participant pretending to be invisible.

> **CompTIA exam trap:** "man-in-the-middle" and "on-path" are the same thing. Older materials use MITM. The exam uses *on-path attack*. If you see MITM in a question, mentally translate. Both terms refer to active interception, not passive sniffing.

> **CompTIA exam trap:** A user on public Wi-Fi sees a certificate warning and clicks through. Is this an on-path attack, social engineering, or both? The setup (rogue AP forging a cert) is on-path. The user clicking past the warning is the human vulnerability the attack depends on. CompTIA will frame this as the on-path attack — the certificate warning is the defense that worked; the user defeated it.

> **CompTIA exam trap:** Evil twin and on-path are listed as separate items in objective 2.5. Evil twin is one specific *method* of getting into on-path position (rogue Wi-Fi AP). On-path is the broader category. Evil twin is always on-path; on-path isn't always evil twin.

### Indicators a user/tech might see

- Repeated certificate warnings on sites that normally work
- Browser shows HTTP on a site you know does HTTPS
- DNS resolving familiar domains to weird IPs (`nslookup` shows a strange address)
- Wi-Fi shows two networks with the same SSID, different signal strengths
- Login pages that look slightly off — wrong fonts, wrong logos, fields rearranged
- Sudden need to "re-authenticate" to services that didn't log you out
- Captive portal that asks for credentials it shouldn't need

### Defenses, ranked by effort and impact

1. **HTTPS everywhere + HSTS** — free, automatic, defeats most opportunistic on-path attacks
2. **VPN on untrusted networks** — encrypts the tunnel before the local network sees it
3. **DNS over HTTPS (DoH) or DNS over TLS (DoT)** — denies the attacker the DNS spoofing vector
4. **Certificate validation discipline** — never click through cert warnings; train users to call the help desk instead
5. **Managed switch features (DAI, DHCP snooping, port security)** — enterprise LAN hardening
6. **802.1X with certificate auth** — Wi-Fi clients verify the AP's cert before connecting, defeats evil twin
7. **Network segmentation** — even if attacker gets on-path on one VLAN, blast radius is limited

## Helpdesk reality

- **User:** "My browser keeps saying the certificate isn't trusted on the company website but it worked yesterday." → Don't tell them to ignore it. Verify the cert chain yourself, check if anything changed in the proxy or AV's SSL inspection, confirm the user isn't on a hostile network. Cert warnings exist for a reason.
- **User:** "I logged into the airport Wi-Fi and now my Outlook is asking me to sign in again." → Possible session hijack via on-path. Force a password reset, revoke active sessions in M365 admin, check sign-in logs for unfamiliar IPs. Tell them not to enter credentials on public Wi-Fi again without VPN — and mean it.
- **User:** "I think someone hacked my Wi-Fi, every website looks weird." → Could be DNS hijack at the router (compromised home router with attacker-controlled DNS), could be malware on the device. Check the router's DNS settings, run AV/EDR scan on the endpoint.
- **Never promise:** "HTTPS means you're safe." HTTPS means the transport is encrypted to the server you connected to. If the user connected to the wrong server because of DNS spoofing or evil twin, HTTPS to the attacker's server is still HTTPS — and still owned.
- **The training conversation:** users don't need to know what ARP poisoning is. They need to know: don't click past certificate warnings, don't enter credentials on networks you don't trust, use the VPN. Three rules. Repeat them.

## Related concepts

[[Evil Twin Attacks]] · [[Spoofing]] · [[Phishing]] · [[VPN]] · [[Wireless Security WPA3]] · [[DNS]] · [[HTTPS and TLS]] · [[Certificate Management]] · [[Public Wi-Fi Risks]] · [[Network Segmentation]] · [[Zero Trust]]

*Source: VIRGIL knowledge base — 2026-05-11*