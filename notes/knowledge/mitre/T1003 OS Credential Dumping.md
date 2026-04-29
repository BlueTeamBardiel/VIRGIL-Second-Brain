# T1003: OS Credential Dumping

Adversaries dump credentials from OS caches, memory, or structures to obtain account login material (hashes or cleartext) for [[Lateral Movement]] and accessing restricted information.

**Tactic:** [[Credential Access]]  
**Platforms:** Linux, Windows, macOS  
**ATT&CK ID:** T1003  
**Last Modified:** 24 October 2025

## Sub-techniques

| ID | Name |
|----|------|
| [[T1003.001]] | LSASS Memory |
| [[T1003.002]] | Security Account Manager |
| [[T1003.003]] | NTDS |
| [[T1003.004]] | LSA Secrets |
| [[T1003.005]] | Cached Domain Credentials |
| [[T1003.006]] | DCSync |
| [[T1003.007]] | Proc Filesystem |
| [[T1003.008]] | /etc/passwd and /etc/shadow |

## Associated Groups & Software

**Notable Threat Actors:**
- [[APT28]] — uses [[Mimikatz]] and custom tools
- [[APT32]] — uses GetPassword_x64
- [[APT39]] — uses Mimikatz variants
- [[Axiom]] — credential dumping capability
- [[BlackByte]] — uses [[Cobalt Strike]] and [[Mimikatz]]
- [[Ember Bear]] — gathers SSH keys and credential material
- [[Leviathan]] — uses HOMEFRY
- [[Mustang Panda]] — uses Hdump
- [[Poseidon Group]] — focuses on domain/database credentials
- [[Storm-0501]] — uses [[Impacket]] SecretsDump
- [[Tonto Team]] — varied credential dumping tools

**Associated Tools:**
- [[Mimikatz]]
- [[Cobalt Strike]]
- [[Impacket]]
- [[Carbanak]]
- [[HOMEFRY]]
- [[MgBot]]
- [[OnionDuke]]
- [[PinchDuke]]
- [[Revenge RAT]]
- [[Trojan.Karagany]]

## Tags

#att&ck #credential-access #credentials #lateral-movement #post-compromise

---

## What Is It? (Feynman Version)

Think of a safe that stores every password you ever typed into a computer, and it keeps that safe in the system's own memory or in hidden files. OS Credential Dumping is the act of cracking open that safe—reading the memory or files where the system keeps login material so an attacker can reuse those credentials elsewhere.

---

## Why Does It Exist?

Before credential dumping, an attacker could only exploit the account they logged in with. If that account had limited privileges, the attacker would be stuck. Credential dumping solves that limitation by harvesting credentials from the operating system itself—hashes for Windows accounts, hashed passwords from the SAM database, or SSH keys on Linux. Real-world incidents, such as the 2019 Mimikatz wave, showed that once an attacker had a foothold, they could use stolen hashes to move laterally without having to guess passwords again. It also circumvents basic network perimeter defenses by using legitimate credentials in place of stolen ones.

---

## How It Works (Under The Hood)

1. **Privilege Elevation**  
   An attacker first ensures they can read protected memory or registry keys. On Windows, this often involves obtaining **SYSTEM** rights via a local exploit or exploiting a vulnerability that exposes LSASS. On Linux, the attacker might gain root or use a misconfigured `sudo` rule.

2. **Locating the Store**  
   - **LSASS Memory**: The LSASS process keeps in-memory copies of user hashes and Kerberos tickets.  
   - **Security Account Manager (SAM)**: A registry hive (`SAM`) holds hashed Windows passwords.  
   - **NTDS**: Domain controllers store the entire Active Directory database, which contains password hashes.  
   - **LSA Secrets**: Stored in the registry under `HKLM\SAM\Domains\Account\Secrets`.  
   - **Cached Domain Credentials**: Local copies of domain logins kept on a workstation.  
   - **DCSync**: LDAP replication command that copies domain credentials from a DC to a local machine.  
   - **Proc Filesystem**: On Linux, `/proc/[pid]/task/[tid]/status` may expose cleartext passwords if the process stores them.  
   - **/etc/passwd & /etc/shadow**: `/etc/shadow` holds hashed Unix passwords; `/etc/passwd` contains user metadata.

3. **Reading the Data**  
   - **Memory Dump**: Tools like Mimikatz use `ReadProcessMemory` (Windows) or `/proc/pid/mem` (Linux) to pull raw bytes from the target process.  
   - **Registry/File Access**: Directly opening registry keys or files with appropriate permissions.  
   - **LDAP Queries**: For DCSync, the tool authenticates with a user that has replication rights and queries `dsdb` to extract user entries.  
   - **File Copy**: On Linux, tools such as `pwdump` read `/etc/shadow` directly.

4. **Parsing & Exporting**  
   Once raw data is obtained, the tool interprets Windows structures (`LSASS` memory format, `SAM` BLOBs) or Unix password entries. It then outputs credentials in a readable form: cleartext passwords, NTLM hashes, Kerberos tickets, or hashed values that can be used with tools like Hashcat or CrackMapExec.

5. **Exploitation**  
   The attacker now possesses credentials that can be used to:
   - Log in to remote hosts via RDP/SSH.  
   - Pass-the-hash to authenticate to SMB shares.  
   - Kerberoast or AS-REP roast for Kerberos tickets.  
   - Create new privileged accounts or elevate existing ones.

---

## What Breaks When It Goes Wrong?

When a credential dump fails or is imperfect, the attacker may:
- **Trigger Security Alerts**: Many EDR solutions flag high‑privilege memory reads or registry accesses, prompting incident response.  
- **Create Corrupted Data**: A poorly parsed dump can result in malformed credential lists, leading to failed lateral moves and wasted time.  
- **Cause System Instability**: Reading massive memory segments or accessing critical registry keys can slow or crash the target machine, alerting users or admins.  
- **Expose the Attacker**: Improper cleanup (e.g., leaving temporary files or memory images on disk) can be discovered during forensic analysis.  
- **Account Lockouts**: If the attacker repeatedly uses stolen credentials, repeated failed login attempts may trigger lockout policies, exposing the attack.  
- **Audit Trails**: Actions like DCSync or registry reads generate Windows security logs that, if not obfuscated, reveal the attacker’s presence.

The human cost of a failed or noisy dump ranges from lost productivity due to service interruptions, to the financial impact of incident response and forensic investigations, and ultimately to reputational damage when compromised credentials leak to the public.