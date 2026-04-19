# Homelab Budget Build Guide
> The best lab is the one you actually use. Start where you are.

A homelab isn't about hardware. It's about building a hands-on environment where you can break things safely, learn from failures, and demonstrate skills you can't get from a book or a certification. This guide covers every budget tier — from zero dollars to a proper rack — with honest opinions on what's worth buying.

---

## The $0 Homelab: Virtualization on Your Existing PC

You don't need to buy anything. If you have a PC with 16GB+ RAM and a modern CPU, you have a homelab.

### Hypervisor Options

**VMware Workstation Pro (now free as of 2024)**
- Best performance and compatibility for Windows VMs
- Supports nested virtualization (VMs inside VMs — needed for some AD setups)
- Download free from Broadcom (requires account)
- Ideal for: Windows Server, Active Directory, Kali Linux

**VirtualBox (free, open source)**
- Cross-platform: Windows, macOS, Linux
- Slightly worse performance than VMware but totally capable
- Good for: Linux VMs, quick experiments, learning environments

**Hyper-V (Windows 10/11 Pro, Enterprise)**
- Built into Windows Pro — enable in "Windows Features"
- Best for Windows Server VMs and AD labs
- Used in production Azure — understanding Hyper-V is transferable
- Enable: `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All`

### What to Run
- **[[Active Directory]] lab:** 1× Windows Server 2022 VM (domain controller) + 1–2 Windows 10/11 VMs (clients). Join clients to domain, create users, set GPOs.
- **[[Kali Linux]]:** For learning offensive tools — [[Metasploit]], [[Burp Suite]], [[Nmap]]. Always keep this isolated from your main network.
- **Ubuntu Server:** For [[Ansible]], [[Docker]], web servers. Low RAM footprint (~1GB).
- **Metasploitable / VulnHub VMs:** Intentionally vulnerable machines for practice.

### RAM minimums
- AD lab (DC + 1 client): 8GB (tight), 16GB (comfortable), 32GB (ideal for full [YOUR-LAB]-style setup)
- Each Windows VM: 2-4GB. Each Linux VM: 512MB–2GB.

---

## The $50–150 Homelab: Used Mini PCs

Used mini PCs are the best value in homelab hardware. Businesses refresh hardware every 3–5 years; surplus HP EliteDesk, Dell OptiPlex, and Lenovo ThinkCentre machines flood eBay and Facebook Marketplace.

### What to Look For

**HP EliteDesk 800 G2/G3/G4 Mini**
- Tiny (roughly 7"×7"×1.4"), quiet, sips power (~35W under load)
- i5 or i7, upgradeable RAM to 32GB, M.2 + 2.5" storage
- G3 and G4 support NVMe — fast storage matters for hypervisor IO
- Street price: $40–80 depending on specs

**Dell OptiPlex 7050/7060/7070 Micro**
- Same form factor as EliteDesk, similarly specced
- G8/G9 generations support DDR5 (pricier but faster)
- Street price: $60–120

**Lenovo ThinkCentre M720q/M920q**
- Popular in [YOUR-LAB]-style setups, well-supported by Linux
- Comparable specs to EliteDesk/OptiPlex
- Street price: $50–90

### What to Avoid
- Machines with **soldered RAM** (no upgrade path) — check before buying
- **Core 2 Duo / Sandy Bridge** era (2nd/3rd gen Intel) — too old for nested virtualization
- **Celeron/Pentium** variants — skip, get an i5 minimum
- **No UEFI/BIOS access** claims — always verify you can change boot order
- Anything without a working power adapter listing

### Best Bang for Buck
Target a **6th–10th gen Intel Core i5 with 16–32GB RAM and a 256GB+ SSD** for $60–100. This machine runs a [[Proxmox]] hypervisor with 4–6 VMs simultaneously.

---

## The $200–500 Homelab: Serious Lab Infrastructure

### Raspberry Pi Cluster
- Pi 5 (4GB): ~$60 each. 4× = $240 + $40 switches/cables = $280 total
- Great for: [[Pi-hole]], [[Kubernetes]], network monitoring, low-power 24/7 services
- Not great for: Windows VMs (ARM, not x86)
- Add a PoE HAT and PoE switch for clean cable management

### Used Server Hardware
- **Dell PowerEdge R720/R730** on eBay: $200–400 with 128–256GB RAM
- Loud (seriously, data center loud), power-hungry (~200W idle), but ECC RAM and IPMI/iDRAC remote management
- Good for: serious storage (12+ drive bays), enterprise software testing, high VM density
- Needs: 1U rack or acceptable space + significant noise tolerance

### NAS Options
- **Synology DS923+** (~$400): 4-bay, AMD Ryzen, great software, surveillance station, VMs
- **TrueNAS Scale** on old hardware: free, ZFS, excellent for reliable storage
- DIY NAS with a mini PC + USB dock: cheap but no hardware RAID protection

---

## Free Software Stack

Build an enterprise-quality lab for $0 in software:

| Software | Purpose | Why |
|---|---|---|
| **[[Proxmox]] VE** | Hypervisor | Free, ZFS storage, clustering, Ceph support, better than ESXi |
| **pfSense / OPNsense** | Firewall/router | Enterprise-grade routing on commodity hardware |
| **[[Pi-hole]]** | DNS filtering + monitoring | See every DNS query on your network |
| **TrueNAS Scale** | NAS + ZFS storage | Enterprise storage without the license |
| **[[Portainer]]** | Docker management UI | Manage containers without memorizing every docker command |
| **[[Wazuh]]** | SIEM + EDR | Open source, feeds [[Grafana]], runs on modest hardware |
| **[[Grafana]] + [[Prometheus]]** | Monitoring dashboard | Beautiful metrics from every machine |
| **[[Semaphore]]** | Ansible UI | Run Ansible playbooks from a web interface |

---

## What to Run for Maximum Resume Value

### Active Directory Lab (highest priority)
Employers assume you can reset passwords. AD at a sysadmin level is rarer. Build this:
- Windows Server 2022 DC with FSMO roles
- GPOs: password policy, software restriction, drive mapping
- 2–3 Windows 10/11 clients domain-joined
- Users, OUs, security groups structured like a real org

**Resume bullet:** "Deployed and administered Active Directory lab with 10+ users, group policy objects, and domain-joined workstations"

### Vulnerable VM Practice
- **VulnHub.com** — free downloadable vulnerable VMs (Mr. Robot, Kioptrix series, etc.)
- **HackTheBox Free Machines** — retired machines available to free users
- **DVWA** (Damn Vulnerable Web Application) — web app attacks
- **Metasploitable** — intentionally vulnerable Ubuntu for Metasploit practice

### SIEM (valuable for SOC roles)
- **Splunk Free tier**: 500MB/day ingest, full enterprise feature set — perfect for a lab
- **Elastic Stack (ELK)**: Free, excellent visualization, requires more setup than Splunk
- **[[Wazuh]]**: Open source SIEM + EDR that integrates with Elastic — what [YOUR-LAB] uses
- Ship Windows Event Logs, Linux auth.log, and firewall logs into it. Practice writing detection queries.

### IDS/IPS
- **[[Suricata]]**: Network IDS — write rules, detect port scans, flag suspicious traffic
- **[[Zeek]]**: Network analysis framework — extracts metadata from traffic (what Suricata doesn't)
- Run both on a dedicated monitoring VM or Raspberry Pi with a span port

---

## How to Talk About Your Homelab in Interviews

### What to emphasize
- **Specific technologies:** "I run Proxmox with 8 VMs including a two-DC Active Directory environment, Wazuh SIEM, and Grafana monitoring"
- **Problems you solved:** "When the domain controller lost its DHCP reservation, I discovered Semaphore was using stale inventory — wrote a fix playbook"
- **Automation:** "I automated weekly apt upgrades across all lab machines with Ansible and Semaphore"
- **Learning outcomes:** "The lab helped me understand how Wazuh correlates Windows Event IDs to detect lateral movement"

### What not to say
- "I have a homelab" with no specifics — sounds like you set up a NAS and stopped
- Don't over-explain the hardware — employers care about software and skills
- Don't claim production-level experience if it was a lab — but do explain the concepts are the same

### The line that lands well
> "I built a 10-node homelab running Active Directory, automated deployment via Ansible, a Wazuh SIEM ingesting logs from every machine, and a threat intelligence pipeline that processes 100+ CVEs and security feeds daily. It's where I practice everything I study."

That's 2 sentences and it's more impressive than most candidates' 3 years of "experience."

---

## Tags
`[[Homelab]]` `[[Active Directory]]` `[[Proxmox]]` `[[Networking]]` `[[TryHackMe]]` `[[Ansible]]` `[[Docker]]` `[[Wazuh]]` `[[Help Desk]]` `[[Job Search]]`
