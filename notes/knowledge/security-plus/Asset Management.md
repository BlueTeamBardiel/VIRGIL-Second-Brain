# Asset Management

## What it is

In *Call of Duty: Warzone*, before you drop into Verdansk you stare at the **Loadout menu** — every weapon has a serial-numbered blueprint, every attachment is logged in your armory, and the **Custom Loadout Drop** crate that falls from the sky only contains gear *you* registered to your profile. If a weapon isn't in your inventory list, you can't deploy with it. If you pick up a stranger's loadout drop by mistake, Infinity Ward's backend still knows whose blueprint it was, when it spawned, and where it landed. That ledger — *what gear exists, who owns it, what state it's in, and when it disappears from circulation* — is exactly what asset management is in the enterprise.

In plain English: **you can't protect what you don't know you own.** Asset management is the discipline of tracking every device, piece of software, license, virtual machine, container, mobile phone, and data store the organization has, from the moment it's bought to the moment it's destroyed.

**Technical definition:** Asset management is the process of [[acquisition]], [[assignment-ownership|assignment/ownership]], [[asset-tracking|monitoring/tracking]], and [[disposal]] of all enterprise resources — hardware, software, data, and licenses — across their entire lifecycle, supported by an authoritative inventory and enforced via documented procedures.

CompTIA places this squarely in **Objective 4.2: "Explain the security implications of proper hardware, software, and data asset management."**

## Why it matters

Asset management is the unsexy foundation that every other security control sits on top of. Consider the chain reaction when it fails:

- A laptop is bought on a corporate card but never enrolled in [[MDM|Mobile Device Management]]. It never receives patches. Six months later it's the entry point for ransomware.
- An [[EOL|end-of-life]] server is forgotten in a closet. It's still on the network, still running Windows Server 2008, still listening on SMBv1.
- A developer spins up an EC2 instance for a "quick test," tags it incorrectly, and walks away. Three years later it's mining cryptocurrency for a threat actor and nobody noticed because it wasn't in any inventory.
- An employee leaves. Their laptop is reclaimed, but the [[BYOD]] phone with cached corporate email is never wiped because nobody recorded that it had MDM enrollment.

In incident response, the **first question** is always "is this asset ours, and what is it?" Without an authoritative inventory, the [[incident-response]] clock burns while analysts play detective on their own network. Regulators (HIPAA, PCI-DSS, SOX) explicitly require asset inventories. Frameworks like CIS Controls list **"Inventory and Control of Enterprise Assets"** and **"Inventory and Control of Software Assets"** as Controls #1 and #2 — *before* anything about firewalls or encryption.

> **Why CompTIA tests this:** SY0-701 added significant weight to governance and operational hygiene topics. Expect scenario questions where the "right answer" is updating the asset inventory, sanitizing media before disposal, or properly classifying ownership — not deploying a new technical control.

## Key facts

### The asset lifecycle (memorize this order)

CompTIA frames asset management as a lifecycle. Know the stages and what happens at each:

| Stage | What happens | Security concerns |
|---|---|---|
| **Acquisition/Procurement** | Asset is purchased, leased, or built | Supply chain risk, vendor vetting, [[hardware-root-of-trust]] verification |
| **Assignment/Ownership** | Asset is given to a user, team, or system owner | Accountability, [[acceptable-use-policy|AUP]] sign-off, classification tagging |
| **Monitoring/Tracking** | Asset is in active use; tracked in inventory | Patch state, configuration drift, license compliance |
| **Disposal/Decommissioning** | Asset is retired | [[data-sanitization]], [[certificate-of-destruction]], license reclamation |

### Acquisition and procurement

Security starts before the asset arrives.

- **Vendor due diligence:** [[supply-chain-attack]] risk means you vet manufacturers and resellers. Counterfeit Cisco gear and tampered firmware are real.
- **Procurement standards:** Approved hardware lists prevent random "shadow IT" purchases on personal credit cards.
- **Receiving/intake:** Verify serial numbers, check for tamper-evident seals, and image the device with a known-good baseline before it ever touches the production network.
- **Onboarding:** Enroll in MDM/[[EDR]], apply baseline configurations via [[group-policy]] or configuration management, assign to a user.

### Assignment and ownership

Every asset needs a name attached to it. CompTIA distinguishes:

- **Data owner** — usually a senior business executive, ultimately accountable for the data.
- **Data custodian** — IT/Ops, handles day-to-day technical protection (backups, access enforcement).
- **Data steward** — responsible for data quality, labeling, and ensuring use complies with policy.
- **System/asset owner** — accountable for a specific system's security posture.
- **Data processor** — entity that processes data on behalf of the controller (GDPR term).
- **Data controller** — entity that decides *why and how* personal data is processed.

> **CompTIA exam trap:** Don't confuse **owner** with **custodian**. The owner *decides* classification and access policy; the custodian *implements* it. If a question asks "who classifies the data?" — that's the owner. "Who runs the backups?" — custodian.

### Monitoring and tracking — the inventory

The heart of asset management is an authoritative, continuously updated inventory. Two flavors:

**Hardware inventory must capture:**
- Asset tag / unique identifier
- Serial number, MAC address(es)
- Make, model, hardware specs
- Assigned user / department / cost center
- Physical location
- Purchase date, warranty/lease end date
- Classification (e.g., handles PHI? PCI?)
- Current state (active, in-stock, in-repair, retired)

**Software inventory must capture:**
- Application name, version, vendor
- Installation source (approved repository?)
- License key, license type (per-seat, per-core, site)
- Installed-on-which-assets
- End-of-support date
- Approved/unapproved/tolerated status

#### Enumeration and discovery techniques

You don't build the inventory by walking around with a clipboard. Use:

- **[[network-scanner|Network discovery scans]]** — Nmap, [[vulnerability-scanner|vulnerability scanners]] like Nessus/Qualys
- **Passive network monitoring** — DHCP logs, ARP tables, NetFlow, [[siem|SIEM]] correlation
- **Agent-based** — EDR/MDM agents report in
- **CMDB integration** — Configuration Management Database (e.g., ServiceNow) is the authoritative ledger
- **[[802.1x]]/NAC** — Network Access Control refuses to admit unknown devices to the network in the first place
- **Cloud-native inventory** — AWS Config, Azure Resource Graph, GCP Asset Inventory

#### Tagging and classification

Tags drive automation. Modern cloud and EDR environments use tags for everything: backup policies, patch windows, alerting thresholds, billing.

- **Classification tags:** Public, Internal, Confidential, Restricted (or organization's labels)
- **Functional tags:** prod / staging / dev
- **Regulatory tags:** PCI, HIPAA, GDPR, CUI
- **Owner tags:** team, business unit, cost center

Untagged or mistagged assets are a top finding in cloud audits.

### Configuration enforcement

An asset isn't just "tracked" — it's expected to remain in a known-good state.

- **[[configuration-baseline|Baselines]]** — golden image, hardened build, CIS Benchmarks
- **[[configuration-drift|Configuration drift detection]]** — when a host deviates from baseline
- **[[change-management]]** — every change is documented, approved, reversible
- **Patch management** — tied to inventory; you can't patch hosts you don't know about

### Disposal and decommissioning

This is the section CompTIA loves to trick you on.

#### Data sanitization methods

| Method | What it does | When to use | Reversible? |
|---|---|---|---|
| **Erasing/Deletion** | Removes file pointers | Almost never sufficient | Trivially |
| **Clearing** | Overwrites with non-sensitive data (e.g., zeros) | Reuse within org, low-sensitivity | Generally not |
| **Purging/Wiping** | Multi-pass overwrite or [[cryptographic-erase]] | Reuse outside org, moderate-sensitivity | Practically no |
| **Cryptographic erase** | Destroy the encryption key on a [[SED|self-encrypting drive]] | Fast wipe of encrypted media | No (key gone) |
| **Degaussing** | Strong magnetic field destroys magnetic media | Magnetic HDDs and tapes only — **does NOT work on SSDs** | No |
| **Destruction** | Shred, pulverize, incinerate, melt | Highest sensitivity, EOL media | No |

> **CompTIA exam trap #1:** **Degaussing does not work on SSDs.** SSDs store data in NAND flash cells — there's nothing magnetic to scramble. For SSDs, use cryptographic erase or physical destruction (shredding to small particle size).

> **CompTIA exam trap #2:** A **certificate of destruction** is the documentation a third-party disposal vendor provides proving they destroyed the media. It's a *compliance artifact* — it does not itself sanitize anything. The exam will offer it as a distractor when the actual question is about sanitization technique.

#### Decommissioning checklist

- Remove from production network / change firewall rules
- Revoke certificates, API keys, service accounts tied to the asset
- Sanitize data per classification level
- Update [[CMDB]] to "decommissioned" status
- Reclaim software licenses
- Remove from monitoring, backup, and patching tools (otherwise you'll get false alerts forever)
- Physical destruction or [[chain-of-custody|documented chain-of-custody]] handoff to disposal vendor
- Certificate of destruction filed

### Special cases

#### BYOD and mobile

[[BYOD|Bring-Your-Own-Device]] complicates ownership: the **device** belongs to the employee, but **corporate data** on it belongs to the company. Solutions:

- [[MDM]] / [[MAM|Mobile Application Management]]
- **Containerization** — corporate data lives in an isolated work profile
- **Selective wipe** — destroy corporate data only, not personal photos
- Clear BYOD policy with employee consent to remote wipe

#### Cloud and virtual assets

A spun-up VM is just as much an asset as a physical server, but it can be born and die in minutes.

- **Tagging at creation** is mandatory (enforce via [[IaC|Infrastructure-as-Code]] policy)
- **Ephemeral assets** — containers, serverless functions — require continuous discovery, not periodic scans
- **Shadow IT in the cloud** — anyone with a credit card can spin up SaaS. Use [[CASB|Cloud Access Security Brokers]] to detect.

#### Software licensing

Asset management isn't just security — it's also legal. Software audits (Microsoft, Oracle, Adobe) can result in seven-figure penalties for over-deployment.

- **Per-seat licensing** — one license per named user; common for SaaS apps
- **Per-device licensing** — license tied to a workstation regardless of who uses it
- **Concurrent licensing** — license pool shared across users; only N can run simultaneously
- **Subscription / consumption-based** — cloud-style, billed by usage (CPU-hours, API calls, GB stored)

True-up audits force the gap between deployed and licensed to be reconciled — usually painfully. Maintain an accurate software inventory inside the [[CMDB]] and reconcile quarterly.

## Related concepts

[[CMDB]] · [[Configuration Management]] · [[BYOD]] · [[MDM]] · [[MAM]] · [[CASB]] · [[Shadow IT]] · [[IaC]] · [[Chain of Custody]] · [[Certificate of Destruction]] · [[Data Sanitization]] · [[Degaussing]] · [[Cryptographic Erase]] · [[Software Bill of Materials]] · [[Vulnerability Management]] · [[Patch Management]] · [[Decommissioning]]

---
*Source: VIRGIL knowledge base — 2026-05-08*
