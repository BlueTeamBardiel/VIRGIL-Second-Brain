# Attack Surface vs Attack Vector

## What it is

In **Skyrim**, Whiterun has walls, three gates, a sewer grate by the Underforge, the soft spot in the cliff face where dragons land on the Dragonsreach roof, and the Companions hall door that anyone can walk through during the day. That's the **attack surface** — every place someone could possibly get in. The **attack vector** is the specific route the Stormcloaks actually pick during the civil war siege: they bring catapults to the front gate, knock it open, and pour infantry through the breach. The wall is the surface. The catapult-and-infantry combo through the front gate is the vector.

Plain English: the attack surface is everywhere you *could* be hit. The attack vector is the path the adversary *actually used*.

Technical CS0-003 definition:

- **Attack surface** — the sum of all points (network, application, human, physical, supply chain) where an unauthorized actor could attempt entry, escalation, or data exfiltration. Measured as exposure: open ports, exposed APIs, internet-facing services, third-party connections, employee inboxes, USB ports in the lobby kiosk.
- **Attack vector** — the specific path, mechanism, or technique used to deliver an exploit against the surface. Phishing email with a malicious macro. An exposed RDP port with a weak password. A poisoned dependency in the build pipeline. A USB dropped in the parking lot.

Surface is geography. Vector is the route taken across it.

## Why it matters

CompTIA tests this distinction directly under objective **CS0-003 1.4** (threat intelligence and threat hunting). You will see questions where the answer hinges on whether they're asking about *exposure* (surface) or *path of compromise* (vector). Get the wrong noun, get the wrong answer.

Operationally, the distinction drives two different programs:

- **Attack surface management (ASM)** — reduce exposure. Inventory assets, find shadow IT, kill dead services, close ports, retire forgotten subdomains, audit third-party connections. Defensive, continuous, boring, critical.
- **Attack vector analysis** — model how an adversary would actually move. Map your environment against [[MITRE ATT&CK]], simulate the chain, find the choke points. This is where [[Threat Hunting]] and [[Red Team Exercises]] live.

If you only do surface management, you're shrinking targets without understanding which ones get used. If you only do vector analysis, you miss the forgotten S3 bucket nobody knew existed. You need both. The CISO will ask both questions in the same breath: *"How big is our exposure, and how would they actually get in?"*

## Key facts

### Attack surface — the categories

CompTIA expects you to enumerate the surface across multiple planes. The surface is not just "the firewall."

| Surface category | What's in it | Common exposure |
|---|---|---|
| **Network** | Internet-facing IPs, open ports, VPN endpoints, exposed services | RDP/3389, SMB/445, unpatched VPN concentrators |
| **Application** | Web apps, APIs, mobile apps, thick clients | Injection flaws, broken auth, exposed admin panels |
| **Human** | Employees, contractors, customers | Phishing targets, social engineering, credential reuse |
| **Physical** | Buildings, USB ports, badge readers, datacenter doors | Tailgating, dropped USB, unattended workstations |
| **Supply chain** | Vendors, third-party libraries, MSPs, hardware OEMs | Poisoned updates (SolarWinds), library compromise, vendor RDP |
| **Cloud / SaaS** | IaaS/PaaS/SaaS tenancy, federated identity, OAuth grants | Misconfigured buckets, over-permissive IAM, sprawling SaaS |
| **Insider** | Anyone with legitimate access | [[Insider threat]] — intentional or unintentional |

The surface grows every quarter even if you don't ship anything — vendors add features, certs expire and get re-issued with new SANs, marketing spins up a campaign subdomain and forgets it. ASM is a treadmill, not a project.

### Attack vector — the categories

| Vector type | Mechanism | Example |
|---|---|---|
| **Phishing / social** | Email, SMS, voice, deepfake | Macro doc, credential harvest page |
| **Remote exploitation** | Network-borne exploit against listening service | Log4Shell against an exposed Java app |
| **Credential-based** | Stolen, reused, or guessed creds | Password spray against M365, RDP brute force |
| **Drive-by / watering hole** | Compromised website serves payload | Malvertising, exploit kit on a niche forum |
| **Supply chain** | Compromise of trusted upstream | SolarWinds Orion, dependency confusion |
| **Physical** | Direct hardware access | Malicious USB, evil maid, rogue access point |
| **Insider** | Legitimate access abused | Disgruntled admin exfils customer database |
| **Removable media** | USB, optical, external drives | Stuxnet-style air-gap crossing |

A single intrusion usually chains multiple vectors. Phishing for initial access → stolen creds for [[Lateral Movement]] → supply-chain trust for persistence. The [[Cyber Kill Chain]] maps the chain; ATT&CK maps the techniques inside each link.

### The relationship — surface enables vectors

Every vector requires a surface to land on. Phishing requires inboxes. RDP brute force requires an exposed RDP port. Supply chain requires a trusted vendor relationship. Kill the surface, you kill every vector that depended on it. This is why surface reduction is the highest-leverage defensive move: it deletes whole categories of attack at once, not just one technique.

Inverse is also true: you cannot eliminate the surface entirely. A company that does business has employees (human surface), vendors (supply chain), and customers (application). Surface goes to zero only when the company stops existing. The job is *managing* exposure, not eliminating it.

### Threat-intelligence inputs that shape both

CompTIA 1.4 cares that you know where the intel comes from. The same sources inform surface management and vector analysis:

- **Open source (OSINT)** — Shodan, Censys, certificate transparency logs, [[Social Media]], [[Blogs and Forums]]. Free, broad, noisy.
- **Closed source / paid feeds** — Mandiant, Recorded Future, CrowdStrike intel. Curated, timely, expensive.
- **Government bulletins** — CISA advisories, FBI flash reports, NSA cybersecurity advisories. Authoritative for nation-state activity.
- **CERT / CSIRT advisories** — US-CERT, regional CERTs, sector-specific [[ISACs]]. Industry-specific intel.
- **Deep / dark web** — leaked credential dumps, initial-access-broker forums, ransomware leak sites. High signal, legal/operational risk to access directly.
- **Internal sources** — your own [[SIEM]] logs, [[IoC]] matches, prior incident reports. The most relevant intel you have, usually the most underused.
- **Information sharing organizations** — [[ISACs]] and ISAOs. Peer-to-peer intel within a sector.

Intel feeds get evaluated on **timeliness, relevancy, accuracy, and confidence level**. A six-month-old IoC for malware that doesn't target your stack is noise. CompTIA tests these four adjectives directly.

### Threat actors — different actors, different surface preferences

| Actor type | Surface they prefer | Typical vector |
|---|---|---|
| **Script kiddie** | Whatever's exposed and unpatched | Public exploits, off-the-shelf tooling |
| **Hacktivist** | Public-facing web, social accounts | Defacement, DDoS, leaks |
| **Organized crime** | Anywhere money flows | Ransomware via phishing or exposed RDP |
| **Nation-state / [[APT]]** | High-value, often supply chain | Custom malware, zero-days, long dwell |
| **Insider** | Whatever they already have access to | Legitimate creds, slow exfil |

Knowing the actor narrows the likely vector, which narrows the surface you defend hardest. A regional bank prioritizes organized-crime ransomware vectors. A defense contractor prioritizes APT supply-chain compromise. Same surface map, different highlights.

### CompTIA exam traps

> **CompTIA exam trap:** Surface is *what's exposed*; vector is *how they got in*. The question "Which of the following reduces the attack surface?" wants asset retirement, port closure, patching. The question "Which of the following is an attack vector?" wants phishing, USB drop, exploitation. Read the noun.

> **CompTIA exam trap:** Supply chain shows up on both sides. The vendor relationship is part of your **surface**; the poisoned update pushed through that relationship is the **vector**. CompTIA will offer both as answer choices and the right one depends on what's being asked.

> **CompTIA exam trap:** An **isolated network** (air-gapped OT, classified enclave) reduces network surface but does not eliminate it — removable media, insider, and supply chain vectors still apply. Stuxnet is the canonical exam example. "Air-gapped" ≠ "no attack surface."

> **CompTIA exam trap:** **Honeypots** are not part of your defensive attack surface in the traditional sense — they're [[Active Defense]]. They expand your *observable* surface deliberately, to draw vectors into a monitored sandbox. If the question asks whether deploying a honeypot increases attack surface, the technically correct answer is *yes, but intentionally and instrumented*.

> **CompTIA exam trap:** Vulnerability management reduces surface (patching closes the door); incident response handles vector exploitation (after the door's been used). Don't conflate them. Different programs, different metrics, different teams sometimes.

## SOC reality

- The CISO asks two questions every quarter: *"What's our external attack surface look like?"* and *"What's the most likely vector against us right now?"* You answer the first with a Shodan/Censys/ASM-tool report; you answer the second with current threat intel mapped to your stack.
- The ASM tool alerts on a new subdomain that nobody on the security team provisioned. That's marketing standing up a campaign site on a third-party host with the company's name in the cert. New surface, no security review. Ticket goes to L2 who chases down the business owner. *I learned this the hard way: marketing ships faster than security reviews, and the certificate transparency log will tell on them every time.*
- At 3am the alert that fires is rarely "attack surface increased." It's "successful authentication from new geography on the VPN concentrator." That's a vector being exercised against a known surface element. The L1 analyst's first move is verify the user, not panic about exposure.
- Never tell leadership "we have no attack surface" or "we've closed all vectors." Both are lies. The honest framing is: *"We've reduced exposure on these categories, we're monitoring these vectors, here's residual risk and what it would cost to lower it further."*
- The handoff: surface findings from ASM tooling → vulnerability management team for remediation. Vector intel from threat intel team → detection engineering for new [[SIEM]] rules and hunt hypotheses. Two different pipes, same source of truth.

## Related concepts

[[Threat Intelligence]] · [[Threat Hunting]] · [[Vulnerability Management]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Indicators of Compromise]] · [[Insider Threat]] · [[Supply Chain Attack]] · [[Active Defense]] · [[Honeypot]] · [[Risk Management]] · [[APT]] · [[Attack Surface Management]] · [[Social Engineering]] · [[ISACs]]

*Source: VIRGIL knowledge base — 2026-05-11*