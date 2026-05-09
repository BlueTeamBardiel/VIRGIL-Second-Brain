# Viruses and Worms

## What it is

In Smash Bros, a **virus** is the Pollen from Piranha Plant — it has to attach to something (the plant's bite) and trigger when the player swings. A **worm** is Sonic. It moves on its own, crosses the whole stage without help, and you didn't invite it. That's exactly what these are — viruses ride on host files and need a user to execute them; worms self-propagate across networks without anyone clicking anything.

A **virus** is malicious code that attaches to a legitimate file or program and requires user execution to run; a **worm** is malicious code that self-replicates and spreads autonomously across networks by exploiting vulnerabilities.

## Why it matters

Worms cause outages at internet scale — Conficker, WannaCry, and NotPetya each chewed through unpatched networks in hours, costing billions and shutting down hospitals, ports, and shipping giants. Viruses remain the foundation for credential theft, ransomware delivery, and persistent footholds. Objective 2.4 explicitly lists both as malware types you must distinguish, and CompTIA's favorite trap is the propagation question: if the answer involves "user opened the attachment," it's a virus; if it spread to 200 machines overnight with no one touching anything, it's a worm.

## Key facts

### Viruses — how they work

- Require a **host file** and **user action** to execute.
- Replicate by infecting other files on the same system once triggered.
- Common subtypes:

| Type | Behavior |
|---|---|
| **Boot sector virus** | Infects the [[MBR]] / boot record; loads before the OS |
| **Macro virus** | Embedded in Office documents via [[VBA]]; triggered on file open |
| **Polymorphic virus** | Mutates its code each infection to evade signature-based [[antivirus]] |
| **Metamorphic virus** | Rewrites its entire codebase each generation — harder to detect than polymorphic |
| **Fileless virus** | Lives in memory / registry; no disk artifact for AV to scan |
| **Armored virus** | Uses anti-debugging and anti-reverse-engineering techniques |
| **Multipartite virus** | Infects both boot sector and files |

### Worms — how they work

- **Self-propagating**. No user interaction needed.
- Spread by exploiting network vulnerabilities, weak credentials, or open shares.
- Often carry a **payload** — ransomware, [[backdoor]], [[botnet]] agent.
- Famous examples for the exam:

| Worm | Vector |
|---|---|
| **Morris (1988)** | First major internet worm; fingerd and sendmail bugs |
| **Code Red / Nimda** | IIS exploits |
| **Conficker** | SMB vulnerability ([[MS08-067]]) |
| **Stuxnet** | USB + multiple zero-days; targeted Siemens PLCs |
| **WannaCry** | [[EternalBlue]] / SMBv1 exploit |
| **NotPetya** | EternalBlue + credential theft via [[Mimikatz]] |

### Virus vs. Worm — the exam table

| Feature | Virus | Worm |
|---|---|---|
| Needs host file | Yes | No |
| Needs user action | Yes | No |
| Self-propagates over network | No | Yes |
| Primary spread | File sharing, email attachments | Network exploit, scanning |
| Detection focus | File signatures, behavior | Network anomalies, [[IDS]]/[[IPS]] |

### Defenses

- **[[Patch management]]** — kills worms before they start. WannaCry had a patch two months prior.
- **[[Antivirus]] / [[EDR]]** — signature, heuristic, and behavioral detection.
- **[[Network segmentation]]** — limits worm blast radius.
- **[[Host-based firewall]]** — blocks unsolicited inbound from peer machines.
- **Disable [[SMBv1]]**, restrict [[macro execution]], block [[autorun]] on USB.
- **[[Application allowlisting]]** — unsigned executables don't run.
- **Email filtering and [[attachment sandboxing]]** — kills macro viruses on arrival.
- **Least privilege** — a virus running as a standard user can't infect system files.

### CompTIA traps

- "Spreads without user interaction" → **worm**, always.
- "Embedded in a Word document" → **macro virus**.
- "Changes its code to evade signatures" → **polymorphic** (or metamorphic if it rewrites entirely).
- "Lives only in memory" → **fileless**, not a worm.

## Related concepts

[[Malware]] · [[Trojan]] · [[Ransomware]] · [[Rootkit]] · [[Logic bomb]] · [[Spyware]] · [[Botnet]] · [[Antivirus]] · [[EDR]] · [[Patch management]] · [[Network segmentation]] · [[EternalBlue]] · [[Indicators of compromise]]

---
*Source: VIRGIL knowledge base — 2026-05-08*