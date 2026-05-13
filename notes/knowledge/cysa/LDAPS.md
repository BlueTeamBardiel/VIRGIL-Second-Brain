# LDAPS — Lightweight Directory Access Protocol over SSL/TLS

## What it is

In **Sonic the Hedgehog 2**, when you grab a ring and a Badnik clocks you, every ring you've collected explodes out of you in a glittering arc — and any one of them, scooped up by an enemy or lost off-screen, is gone. The Special Stage works differently: you enter the warp ring, the rings stay in a controlled tube, and you collect them under the rules of the stage. Same rings, two completely different exposure models. That's exactly what LDAPS does to LDAP — same directory queries, but now they're inside the tube instead of bouncing across the network in cleartext for anyone with a packet capture to scoop up.

**Plain English:** LDAP is how computers ask a directory server (Active Directory, OpenLDAP, 389 Directory Server) "who is this user, what groups are they in, what's their email, are they allowed to do this?" Vanilla LDAP sends those queries — including bind credentials — in cleartext. LDAPS wraps the whole conversation in TLS so the questions, answers, and credentials are encrypted on the wire.

**Technical:** LDAPS is LDAP tunneled over an implicit TLS session on **TCP/636** (and **TCP/3269** for Global Catalog over SSL on Windows DCs). It is functionally distinct from **STARTTLS on port 389**, which negotiates TLS inside the existing plaintext LDAP session. Both achieve the same encryption outcome; the exam and the field treat them as related but not identical. Authentication, search, modify, and bind operations — all of it — runs through the TLS tunnel, with the directory server presenting an X.509 certificate that the client must validate.

## Why it matters

LDAP is the central nervous system of enterprise identity. If an attacker can read LDAP traffic, they can harvest usernames, group memberships, OU structure, computer accounts, and — on a simple bind without TLS — **passwords in cleartext**. That's not theoretical. That's `tcpdump port 389` on a SPAN port and walking away with the domain.

CySA+ tests LDAPS under **Objective 1.3** because malicious activity detection means knowing what *should* be on the wire versus what *is* on the wire. An analyst watching [[Wireshark]] capture should see TLS on 636, not readable `bindRequest` blobs on 389. If you see the latter outbound to the internet, you have a [[Command and Control]] channel masquerading as directory traffic — or a developer who shouldn't be writing code.

It also matters because Microsoft enforced **LDAP channel binding and signing** hardening (KB4520412, originally slated 2020, repeatedly delayed). Misconfigured legacy apps that did simple bind over 389 broke. Every SOC has a war story about an LDAP hardening rollout that took down a payroll integration at month-end.

## Key facts

### Ports, protocols, and modes

| Port | Protocol | Encryption | Notes |
|------|----------|------------|-------|
| 389/TCP | LDAP | None (or STARTTLS upgrade) | Default cleartext; STARTTLS negotiates inline |
| 636/TCP | LDAPS | TLS (implicit) | TLS handshake before any LDAP PDU |
| 3268/TCP | LDAP Global Catalog | None | AD forest-wide search, cleartext |
| 3269/TCP | LDAPS Global Catalog | TLS | AD forest-wide search, encrypted |

> **CompTIA exam trap:** LDAPS uses **TCP/636**, not 389. STARTTLS on 389 also produces encrypted LDAP, but it is not "LDAPS" in the strict sense — it's "LDAP with STARTTLS." If the question asks for the LDAPS port, the answer is 636. If it asks how to encrypt LDAP on the existing port, the answer is STARTTLS.

### Bind types — where credentials live

- **Anonymous bind** — no credentials. Often allowed for reading public attributes. Misconfigured directories let anonymous bind enumerate the entire user list.
- **Simple bind** — username + password sent in the bind request. **Over plaintext LDAP, this is cleartext on the wire.** This is the one that ruins your week.
- **SASL bind** — Simple Authentication and Security Layer. Wraps the bind in Kerberos, GSSAPI, DIGEST-MD5, or similar. Credentials aren't exposed even on port 389, but the rest of the LDAP payload still is.
- **Simple bind over LDAPS or STARTTLS** — credentials encrypted by the TLS tunnel. This is what modern apps should be doing.

*The exam trap, and the war-room trap, are the same: "we're using LDAP, we're fine, it's authenticated" — authenticated isn't encrypted. A simple bind over 389 is a credential leak.*

### Certificate validation

LDAPS requires the client to validate the server's X.509 cert against a trusted CA. In an AD environment, this is usually an Enterprise CA whose root cert is auto-distributed to domain-joined machines via Group Policy. For non-domain-joined Linux boxes, third-party load balancers, or vendor appliances, the CA bundle has to be pushed manually. **Half of all "LDAPS broken" tickets are cert trust failures.** The other half are SAN mismatches — the cert was issued for `dc.corp.local` and the app is connecting to `ldap.corp.local`.

### Detecting LDAP attacks — the SOC angle

This is where Objective 1.3 lands. Common malicious LDAP activity:

- **LDAP enumeration** — `ldapsearch`, BloodHound's SharpHound collector, ADExplorer. An attacker pulls the entire AD object graph to map paths to Domain Admin. Detection: anomalous volume of LDAP queries from a workstation account, especially queries for `objectClass=user` with no filter, or queries against `CN=Schema`.
- **LDAP injection** — like SQL injection but for directory filters. Untrusted input concatenated into a search filter. `(&(uid=*)(userPassword=*))` instead of `(uid=alice)`. Detection: WAF logs, [[Log analysis/correlation]] against application logs showing malformed filters.
- **Pass-the-hash via LDAP** — not exactly LDAP-specific, but the LDAP bind is where the captured hash gets used. Channel binding stops this; many old apps don't support it.
- **LDAP relay** — attacker forces a victim to authenticate to attacker-controlled host, relays the auth to a domain controller over LDAP. **LDAP signing** mitigates; **LDAP channel binding** over LDAPS mitigates further.
- **LDAP as C2** — rare but real. Attackers have used LDAP attribute writes (e.g., `description` field, `info` field) as a covert channel. Beaconing as directory traffic. Detection: [[User behavior analysis]] flagging accounts that write to AD attributes they never touch normally.

### What it looks like in a packet capture

In [[Wireshark]] on port 389, you'll see `LDAP` protocol entries and you can read the `bindRequest`, `searchRequest`, and `searchResEntry` PDUs in the dissector pane — usernames, DNs, attributes, the lot. On port 636, you'll see `TLSv1.2` or `TLSv1.3` records, the handshake, and then encrypted application data. The dissector won't show you the LDAP payload without the server's private key. **That's the point.**

If you see port 389 LDAP traffic leaving the perimeter outbound to a random IP, that's not LDAP. That's something pretending to be LDAP, or a misconfigured app, or [[Command and Control]] using an allowed protocol for cover.

> **CompTIA exam trap:** "Which protocol replaces LDAP for secure directory access?" — the expected answer is **LDAPS**, even though pedantically LDAP+STARTTLS achieves the same thing. CompTIA tests the named protocol. Also: SLDAP is not a real thing. If you see it on a question, it's a distractor.

### LDAP signing vs LDAP channel binding vs LDAPS

These three get conflated. They're different controls.

| Control | What it does | Protects against |
|---------|--------------|------------------|
| LDAP signing | Cryptographically signs LDAP messages (integrity) | Tampering with LDAP traffic in transit |
| LDAP channel binding | Binds the LDAP authentication to the TLS channel | Relay attacks where an attacker proxies auth |
| LDAPS | Encrypts the entire LDAP session via TLS | Eavesdropping, credential theft |

A hardened AD environment runs all three. The question "is LDAPS enough?" — answer: not if attackers can still force a downgrade to LDAP on 389 or relay an unsigned bind. Defense in depth.

## Feynman anchor — Sonic and the protected ring

In **Sonic 2**, the rings you carry are the difference between living and a Game Over. Get hit without a ring, you die. The ring count is your authentication token, your session, your everything.

- Vanilla LDAP is Sonic running through Chemical Plant Zone with 200 rings, no shield, every loop and spring exposed. Anyone with a packet sniffer is a Badnik with perfect timing.
- LDAPS is Sonic with the **invincibility monitor** active — the same level, the same rings, but the encryption wrapper means the Badniks (passive eavesdroppers) can't touch the payload.
- LDAP signing is Sonic counting his rings after every checkpoint — *did anyone tamper with my ring total since the last save?*
- Channel binding is the **lock-on cartridge** — the auth and the channel are mechanically welded so you can't swap one for another mid-run.
- Anonymous bind enumeration is the **debug mode level select** — if you didn't disable it, anyone who knows the code walks the whole map.

*I learned this the hard way watching a vendor appliance ship with simple bind to a customer's DC over port 389. The pentest report came back with a screenshot of the service account password in Wireshark. The vendor's response was "but it's authenticated traffic." Authenticated isn't encrypted. Encrypted isn't signed. Signed isn't channel-bound. Stack them or get rung out.*

## SOC reality

- **The 3am alert** looks like: "LDAP queries from HOST-ACCT-7821 exceeded baseline by 4000%, target = domain controller, filter = `(objectClass=user)`." That's not a user logging in. That's BloodHound or an attacker enumerating.
- **L1 first action:** confirm the source host, check if the account is a service account doing legitimate bulk sync (Azure AD Connect, CMDB scanner) or a workstation that has no business doing LDAP enumeration. Pivot to [[EDR]] process tree on the source.
- **CISO's first question after a directory enumeration incident:** "Did they get the group memberships of the Domain Admins group?" If yes, every DA password rotates tonight and you're explaining to the change board why.
- **Never promise:** "we've blocked it" when you've blocked port 389 — attackers can absolutely tunnel LDAP queries over 636 or HTTPS. Blocking the port isn't blocking the technique.
- **Escalation:** L1 confirms anomalous LDAP volume → L2 pulls [[Packet capture]] and confirms query patterns → IR engages identity team to assess exposure → if BloodHound-style enumeration confirmed, treat as pre-lateral-movement and hunt for the initial access vector backward.

## Related concepts

[[LDAP]] · [[Active Directory]] · [[TLS]] · [[STARTTLS]] · [[Kerberos]] · [[Pass-the-Hash]] · [[BloodHound]] · [[Wireshark]] · [[Packet capture]] · [[Command and Control]] · [[User behavior analysis]] · [[Log analysis/correlation]] · [[EDR]] · [[Channel Binding]] · [[LDAP Injection]] · [[Certificate Authority]]

*Source: VIRGIL knowledge base — 2026-05-11*