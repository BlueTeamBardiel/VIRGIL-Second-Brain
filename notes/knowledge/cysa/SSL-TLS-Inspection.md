# SSL / TLS Inspection

## What it is

In **Persona 5**, when you infiltrate a Palace, you wear the Metaverse outfit and the shadows can't read you — they see a Phantom Thief, not Ren Amamiya. The mask is the whole point. But the moment you step into the Velvet Room, Igor sees through everything. The mask comes off because Igor holds the contract; you agreed to be legible inside his domain. Encrypted traffic crossing your network perimeter is the Phantom Thief outfit. SSL/TLS inspection is the Velvet Room — a place you control, where you pre-arranged the right to see what's underneath.

In plain English: TLS encrypts traffic between a client and a server so nobody in the middle can read it. That's great for privacy and terrible for defenders, because malware encrypts its command-and-control too. SSL/TLS inspection (also called TLS interception, deep packet inspection of encrypted traffic, or break-and-inspect) terminates the TLS session at a security device, decrypts the payload, runs it through IDS/IPS/DLP/sandbox, then re-encrypts it to the real destination. The device acts as a sanctioned man-in-the-middle.

Technically: an inspection appliance (NGFW, SWG, proxy, or CASB) holds an internal CA certificate that every managed endpoint trusts. When a user connects to `https://example.com`, the appliance terminates the TLS handshake, generates a certificate for `example.com` signed by the internal CA on the fly, presents it to the client, and opens a second TLS session outbound to the real `example.com`. Two encrypted tunnels, plaintext in the middle, fully inspectable. Maps to CS0-003 Objective 1.1 — network architecture, encryption, infrastructure concepts.

## Why it matters

Over 95% of web traffic is TLS now. If you can't see inside TLS, you can't see most of the threat. Beaconing to a C2 server, data exfiltration to a cloud bucket, malware downloading its second-stage payload — all of it rides HTTPS by default. A SIEM looking at NetFlow alone sees "encrypted blob to 142.250.x.x on port 443" and shrugs. Decrypt it and you see the `User-Agent: Cobalt Strike` or the 400MB POST to a Discord webhook.

But inspection is also where careers end badly. Decrypting HR's banking session, the CEO's medical portal, or the union rep's legal counsel email is a lawsuit. Decrypting traffic in the EU without GDPR-grade documentation is a regulatory fine. Inspecting certificate-pinned mobile apps will break them in ways helpdesk can't fix. CySA+ tests this trade-off directly under Objective 1.1 (network architecture) and crosses into 1.3 (efficiency and process improvement) when alert tuning depends on TLS visibility.

## Key facts

### How the handshake gets hijacked (in a good way)

| Step | Without inspection | With inspection |
|---|---|---|
| Client says hello | Goes to server | Goes to **inspection appliance** |
| Server cert presented | Real cert from real CA | **Forged cert** signed by internal CA |
| Client validates | Checks public CA trust | Checks **internal CA** in trust store |
| Session keys derived | Client ↔ server | Client ↔ **appliance**, appliance ↔ server |
| Payload visible to | Endpoints only | **Appliance** (plaintext in middle) |

The whole trick rests on the endpoint trusting the internal CA. Push that root cert via GPO, MDM, or image baseline. An unmanaged device — BYOD laptop, contractor phone — won't have the internal root and will throw a certificate warning. That's a tell, not a bug. It means inspection is working.

### Where inspection lives

- **Next-gen firewall (NGFW)** — Palo Alto, Fortinet, Check Point at the perimeter. Inspects north-south traffic.
- **Secure web gateway (SWG)** — Zscaler, Netskope. Often cloud-hosted, sits between endpoint and internet. Core piece of [[SASE]].
- **[[CASB|Cloud Access Security Broker]]** — inspects traffic to sanctioned and shadow SaaS. Often pairs with SWG.
- **Reverse proxy / WAF** — terminates TLS inbound to your web apps. Different direction, same mechanism.
- **DLP inline** — [[Data Loss Prevention]] needs plaintext to find PII, PHI, CHD. No decryption, no DLP signal on HTTPS.

### What you turn it on for

- **C2 detection** — beaconing patterns hidden inside TLS, [[Cobalt Strike]] / [[Sliver]] / [[Mythic]] traffic, DNS-over-HTTPS abuse
- **Malware delivery** — second-stage payloads downloaded over HTTPS from compromised CDNs
- **Data exfiltration** — large POSTs to cloud storage, paste sites, [[Discord]] / [[Telegram]] webhooks
- **Policy enforcement** — block file uploads to personal Google Drive, allow corporate Drive
- **Compliance signal** — proving you can see [[PII]], [[PHI]], or [[CHD]] leaving the network

### What you turn it off for (the bypass list)

You **do not** inspect everything. You build a bypass list — categorized exemptions where decryption is illegal, broken, or unethical:

- **Healthcare** — HIPAA-covered patient portals
- **Banking and financial** — customer banking sessions
- **Legal** — attorney-client privileged communications
- **Government** — IRS, SSA, state portals
- **HR self-service** — payroll, benefits, anything with employee PII the employee owns
- **Certificate-pinned apps** — apps that hard-code the expected cert and refuse anything else (most mobile banking, some EDR agents, Apple services). Inspection breaks them by design.
- **Mutual TLS (mTLS)** — when the client also presents a cert, the appliance can't impersonate it without that private key

> **CompTIA exam trap:** Certificate pinning defeats TLS inspection by design. The pinned app has the real cert's hash baked in and rejects the appliance's forged cert. The fix isn't "force the inspection" — it's "exempt the app from inspection." CySA+ will give you a scenario where mobile banking breaks after deploying NGFW. The answer is bypass list, not "regenerate the internal CA."

### The PKI you have to run

Inspection means you now operate a [[PKI]]. That's a real job:

- **Root CA** — kept offline, signs the intermediate
- **Intermediate (issuing) CA** — lives on the inspection appliance or HSM, signs the forged site certs
- **Trust distribution** — internal root pushed to every managed endpoint via GPO, Intune, JAMF, MDM
- **Certificate lifecycle** — rotation, CRL, OCSP responder for revocation
- **Key protection** — the intermediate private key is a god-tier secret. Whoever steals it can impersonate any HTTPS site to any of your endpoints. Store it in an HSM. Audit access. Treat like a domain admin credential.

### What inspection breaks and how it shows up at the help desk

- **TLS 1.3 + Encrypted Client Hello (ECH)** — designed specifically to resist middlebox inspection. Many appliances downgrade to TLS 1.2 to keep visibility. That's a security trade-off the SOC has to sign off on.
- **HSTS preload** — strict transport security with HSTS preload will refuse the forged cert. Users see hard errors, not bypass prompts.
- **Self-signed cert sites** — appliance often blocks by default. Helpdesk gets tickets from devs hitting internal lab sites.
- **CRL/OCSP checks** — appliance has to proxy these too, or revocation checking breaks.
- **Performance** — TLS termination is CPU-expensive. Sizing the appliance is a real budget conversation. A 10Gbps link inspected at TLS 1.3 with full payload scanning needs serious silicon.

### Privacy, legal, and the banner

Inspection without disclosure is a lawsuit waiting. Required controls:

- **Acceptable use policy** explicitly stating traffic is inspected
- **Login banner** on managed devices stating monitoring
- **Bypass categories** documented in policy, reviewed by legal and HR
- **Audit log** of who can view decrypted content (almost always: nobody, except triggered DLP/IDS alerts)
- **Regional carve-outs** — EU users under [[GDPR]], works councils in Germany, specific consent regimes in some jurisdictions

> **CompTIA exam trap:** "The organization wants to inspect all encrypted traffic to detect data exfiltration." The right answer is almost never "decrypt everything." CySA+ expects you to recognize that selective inspection with documented bypass categories is the defensible position. Blanket decryption fails legal review and breaks pinned apps.

### Logging the decrypt event

Inspection devices generate their own logs — separate from the payload itself. You want:

- **Connection metadata** — source, destination, SNI, ALPN, cipher, cert hash
- **Decision** — inspected, bypassed (and why), blocked
- **Cert anomalies** — expired, self-signed, untrusted CA, mismatched SAN — all IoCs
- **Decrypted payload alerts** — only the DLP / IDS hit, never the full plaintext stored

Feed all of this into the [[SIEM]]. Log SNI even on bypassed traffic — it's the one field you always get, and it's what threat hunters pivot on when an endpoint starts beaconing to a freshly registered domain.

## SOC reality

- **What the 3am alert looks like:** SWG fires "C2 beacon detected — TLS payload matched Cobalt Strike profile, src 10.4.22.81, dst 198.51.100.43, every 60s ±jitter, decrypted via inspection policy CORP-DEFAULT." Without inspection, that alert is "HTTPS to 198.51.100.43" and gets closed as noise.
- **L1 first action:** confirm the inspection policy actually applied (sometimes it didn't — check the bypass category), pull the SNI history for that endpoint, escalate to L2 if the destination is uncategorized or newly registered.
- **What the IR lead asks:** "Was it inspected? If yes, what was in the payload? If no, why was it bypassed, and do we have NetFlow at least?" The bypass list is the first thing IR audits after a breach.
- **What never to promise legal:** "We have full visibility into all traffic." You don't. You have visibility into the categories you inspect, on the endpoints that trust your root, when the user isn't on a guest network or hotspot. Be precise.
- **The handoff:** L1 triages the alert → L2 confirms decryption worked and pulls the payload → IR scopes the endpoint → forensics images it → legal gets notified the moment decrypted content might be reviewed by a human. That last step is non-negotiable in most jurisdictions.

## Related concepts

[[PKI]] · [[TLS 1.3]] · [[Certificate Pinning]] · [[NGFW]] · [[SWG]] · [[CASB]] · [[SASE]] · [[DLP]] · [[Zero Trust]] · [[Network Segmentation]] · [[Encryption]] · [[Log Ingestion]] · [[GDPR]] · [[PII]] · [[CHD]] · [[C2 Detection]] · [[MITRE ATT&CK T1071]]

*Source: VIRGIL knowledge base — 2026-05-11*