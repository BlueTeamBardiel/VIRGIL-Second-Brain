# NAC — Network Access Control

## What it is

In **Grand Theft Auto V**, when you roll up to Los Santos Customs in a stolen car with three stars of heat, the mechanic doesn't open the garage door. He clocks the plates, sees the cops on your tail, and the shutters stay down. Bring in a clean ride you actually own, with no wanted level, and the door rolls up — full access to upgrades, respray, the works. The garage decides who gets in based on who you are, what you're driving, and whether you're trailing trouble.

That's exactly what **NAC** does — it's the bouncer at the network's front door who checks ID, inspects your gear, and either lets you in, sends you to a holding lane, or kicks you to the curb.

Technically: **Network Access Control** is a set of policies and enforcement mechanisms that authenticate endpoints, assess their security posture, and authorize them onto specific network segments based on identity, device health, and context. It enforces *who* (user identity), *what* (device type and posture), *where* (network location), *when* (time of day), and *how* (connection method) before any packet hits production VLANs.

NAC sits at the intersection of [[Identity and Access Management]], [[Network Segmentation]], and [[Zero Trust]] — it's the enforcement muscle that turns identity decisions into network reality.

## Why it matters

The 2024 CISA advisories on ransomware lateral movement all share a common failure: a single compromised endpoint got onto a flat network and walked sideways to the crown jewels. NAC is the control that breaks that chain. No NAC, no segmentation enforcement — and the attacker's first foothold is the same as their last.

For CySA+ (Objective **CS0-003 1.1**), NAC shows up as part of the broader story of **infrastructure concepts and network architecture**. The exam wants you to know NAC isn't a product — it's a policy layer that ties together 802.1X, posture assessment, VLAN assignment, and quarantine workflows. Get the moving parts straight and the questions answer themselves.

Career-wise: every regulated environment (PCI, HIPAA, defense, finance) eventually mandates NAC. Knowing how it actually deploys — and where it breaks — separates the analyst who reads the alert from the analyst who tunes the policy.

## Key facts

### The four NAC decisions

Every NAC enforcement is four questions answered in order:

1. **Authentication** — who is this user/device? Tied to [[802.1X]], [[RADIUS]], [[Active Directory]], certificates from internal [[PKI]].
2. **Posture assessment** — is this device healthy? AV current? OS patched? Disk encrypted? Domain-joined?
3. **Authorization** — given identity + posture, which VLAN/segment do they get?
4. **Continuous monitoring** — does the posture stay healthy after admission, or do we yank access mid-session?

Miss any one of these and you have port security, not NAC.

### Pre-admission vs post-admission

| Mode | When the check happens | Strength | Weakness |
|---|---|---|---|
| **Pre-admission** | Before the device gets an IP / before traffic flows | Stops bad devices at the door | Slow; can break legitimate edge cases |
| **Post-admission** | After connection, checks behavior on the wire | Catches devices that go bad after admission | Bad device already touched the network |

Real deployments do both. Pre-admission gates the handshake; post-admission watches for posture drift.

### Agent vs agentless

- **Agent-based** — NAC client (persistent or dissolvable) on the endpoint reports posture in detail. Strong, but you need to deploy and maintain the agent. Doesn't work for IoT, printers, medical devices, BYOD that won't accept your software.
- **Agentless** — NAC infers posture from network behavior, DHCP fingerprints, MAC OUI, [[SNMP]] queries, [[nmap]] scans. Weaker signal, broader coverage. Required for the half of your network that can't run an agent.

> **CompTIA exam trap:** Agentless NAC is not "lesser NAC" — it's the only option for IoT, OT, and unmanaged devices. CompTIA will offer "deploy agent on every device" as a distractor for an IoT-heavy hospital scenario. Wrong. The right answer is agentless fingerprinting plus segmentation.

### 802.1X — the protocol that does the work

NAC's enforcement plumbing is almost always **802.1X**, the IEEE port-based access control standard. The pieces:

- **Supplicant** — client software on the endpoint that presents credentials
- **Authenticator** — the switch or wireless AP, which holds the port in an unauthorized state until told otherwise
- **Authentication server** — usually [[RADIUS]] backed by AD or a certificate authority
- **EAP** — the carrier protocol. EAP-TLS (certificate-based) is the gold standard; PEAP/EAP-MSCHAPv2 (password-based) is everywhere because it's cheaper to deploy

For devices that can't speak 802.1X (printers, badge readers), NAC falls back to **MAC Authentication Bypass (MAB)** — the switch sends the MAC address as the credential. Trivially spoofable. Treat MAB endpoints as untrusted and segment hard.

### Quarantine VLAN — the holding cell

When a device fails posture, NAC doesn't drop the connection — it shoves the device into a **quarantine VLAN** with reachability only to remediation servers (patch repo, AV update, NAC self-service portal). Once the device cleans up, re-authentication moves it to the production VLAN. This is critical for the user experience: a "you're broken, fix yourself here" workflow keeps the helpdesk queue from melting.

### NAC and the zero-trust story

[[Zero Trust]] says *never trust, always verify, assume breach*. NAC is one of the load-bearing controls that makes zero trust real at the network layer:

- Continuous authentication, not one-shot at login
- Posture-based authorization, not just identity
- Microsegmentation downstream — NAC drops you into the *right* segment, not the *whole* network
- Integrates with [[CASB]] for cloud, [[SASE]] for branch/remote, [[SDN]] for dynamic policy

The CISA/NSA zero-trust maturity model lists device posture and network access control as Tier 1 capabilities. If your interviewer asks "how does ZT actually enforce at the wire?" — the answer is NAC + microsegmentation + identity-aware proxy.

### Common NAC integrations

- **[[SIEM]]** — NAC events (admission, quarantine, denial) ingested at appropriate logging levels for correlation
- **[[EDR]]** — EDR posture (is the agent running, is it healthy) feeds NAC's admission decision
- **[[MDM]] / UEM** — mobile device posture for BYOD admission
- **[[PKI]]** — issues the device and user certificates that EAP-TLS validates
- **[[MFA]]** — for high-risk segments, NAC can require MFA step-up before authorization
- **[[Vulnerability scanner]]** — feeds CVE posture into NAC; a device with a critical unpatched CVE drops to quarantine

### CompTIA exam traps

> **CompTIA exam trap:** NAC ≠ firewall. NAC decides admission and segment placement; the firewall decides traffic flow once admitted. CompTIA will offer "deploy a NAC to block port 445 between subnets" — wrong tool. That's a firewall/ACL job. NAC's job ends once the device is on the right VLAN.

> **CompTIA exam trap:** 802.1X is the protocol; NAC is the policy framework that uses it. Don't conflate them. You can deploy 802.1X without NAC (pure port authentication) but you can't deploy enterprise NAC without an enforcement layer like 802.1X or inline appliance.

> **CompTIA exam trap:** MAB (MAC Authentication Bypass) is a compensating control, not a security feature. If the exam scenario describes "printers authenticating by MAC address" — the risk to flag is **MAC spoofing**, and the mitigation is **segmentation into an isolated printer VLAN with no path to sensitive data**.

### Deployment models

| Model | Where the enforcement lives | Fit |
|---|---|---|
| **Inline** | NAC appliance sits in traffic path | High control, single point of failure, latency cost |
| **Out-of-band** | NAC instructs switches via [[SNMP]]/RADIUS CoA to change VLANs | Scales better, depends on switch capability |
| **DHCP-based** | NAC controls DHCP scope to grant or deny IPs | Lightweight, easy to bypass (static IP) |
| **Cloud-delivered** | NAC posture and policy from cloud, enforcement at edge | Fits [[SASE]] architectures, remote-first orgs |

The trend is cloud-delivered NAC as part of [[SASE]] / [[SSE]] stacks — same policy whether the user is on-prem, at home, or on hotel WiFi.

### What NAC doesn't do

- It doesn't inspect payload. Once you're on the segment, [[NGFW]], [[IDS/IPS]], [[DLP]] take over.
- It doesn't encrypt traffic. [[TLS]], [[IPsec]] do that.
- It doesn't replace [[IAM]]. NAC authenticates the *session*; IAM governs the *identity lifecycle*.
- It doesn't catch a compromised-but-compliant device. If the endpoint passes posture and the attacker is living off the land, NAC waved them through. That's why you still need [[EDR]] and behavior analytics.

*The day I learned NAC's limit was the day a fully-patched, EDR-protected, domain-joined laptop walked onto the production VLAN carrying a Cobalt Strike beacon the user installed from a phishing email. NAC did its job perfectly. The job just wasn't the one we needed done.*

## SOC reality

- The 3am NAC alert isn't a breach — it's usually a contractor with an expired AV signature getting dropped to quarantine. L1 verifies device ownership, pings the user, walks them through update, releases. 95% of NAC tickets are this.
- The 3am NAC alert that *matters* is **unknown device, unknown MAC, plugged into a conference-room jack at 3:14am**. That's not a posture miss; that's physical intrusion or an insider. Escalate to L2 immediately, pull badge logs, check camera coverage.
- The CISO's question after any NAC incident is the same: *"Did the device touch anything before quarantine?"* If pre-admission was working, the answer is no. If post-admission caught the drift, the answer is *"yes, for N minutes, here's the flow data."* Have the answer ready or have the logs ready.
- Never tell leadership "NAC blocked it" as a final statement. NAC blocked *that attempt from that device on that segment*. The attacker may already be on a different segment via different credentials. Scope the blast radius before you scope the win.
- The handoff: L1 owns quarantine releases and known-device triage. L2 owns posture policy tuning and unknown-device investigation. IR owns any unknown device that successfully admitted before being caught. Legal/HR owns the conversation when the unknown device turns out to belong to a recently-terminated employee.

## Related concepts

[[802.1X]] · [[RADIUS]] · [[Zero Trust]] · [[Network Segmentation]] · [[Identity and Access Management]] · [[PKI]] · [[MFA]] · [[SASE]] · [[CASB]] · [[SDN]] · [[EDR]] · [[MDM]] · [[SIEM]] · [[Microsegmentation]] · [[NGFW]] · [[Privileged Access Management]] · [[Passwordless authentication]]

*Source: VIRGIL knowledge base — 2026-05-11*