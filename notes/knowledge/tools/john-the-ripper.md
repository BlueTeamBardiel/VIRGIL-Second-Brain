# John the Ripper

John the Ripper is a fast password cracker available in Kali Linux (v1.9.0). It supports numerous hash formats and includes conversion utilities for extracting password hashes from various file types and applications.

## What Is It? (Feynman Version)

John the Ripper is a *mechanical locksmith*: it takes a lock (a password hash) and tries every key (possible passwords) until it finds the one that opens it. It is not a single algorithm but a collection of tools that can read a lock from many different locks (file formats, services, and encryption schemes) and then attempt to open it.

## Why Does It Exist?

Back in the day, system administrators had to manually guess user passwords or rely on weak passwords that could be cracked with simple tools. When attackers gained a hash file—say from a leaked `/etc/shadow` or a compromised database—they needed a way to turn that hash into a plaintext password quickly. John the Ripper fills that gap by providing a single, extensible platform that supports dozens of hashing algorithms, from simple DES-based passwords to modern SHA‑256 and PBKDF2 variants. Without it, attackers would have to write custom scripts for each hash type, a slow and error‑prone process. An example of its real‑world use is when a security team audits an old Linux server, extracts the `shadow` file, and runs John to confirm that all users are using passwords that can be cracked in a few hours, thereby prompting a password policy update.

## How It Works (Under The Hood)

1. **Hash Acquisition**  
   • *unshadow*: combines `/etc/passwd` and `/etc/shadow` into a single file with username:hash lines.  
   • *conversion utilities* (e.g., `ldif2john`, `bitlocker2john`) read specific file formats and output a standardized `username:hash` string.  
   Each converter knows the internal structure of its source file and extracts the raw hash value and any necessary salts.

2. **Wordlist Preparation**  
   • `unique` removes duplicates from massive dictionaries, ensuring memory is used efficiently.  
   • The user may feed a custom list of words, common passwords, or generated combinations.

3. **Cracking Engine**  
   • John loads the hashes into memory and applies a *rule‑based* or *brute‑force* algorithm.  
   • It supports *incremental mode* (trying all character combinations) and *mask mode* (guessing passwords that match a given pattern).  
   • The engine can parallelise across CPU cores or distribute work over a network (the `john` binary can talk to a central server that manages jobs).

4. **Verification**  
   • When a guessed password, when hashed, matches the stored hash, John outputs `username:plaintext`.  
   • It then stops working on that hash and moves to the next.

## What Breaks When It Goes Wrong?

When John the Ripper is misused (for example, by an attacker with a stolen hash dump), the consequences are tangible:  
- **Data breach**: Plaintext passwords can be used to access other services (phishing, credential stuffing).  
- **Operational disruption**: If internal accounts are compromised, attackers can alter configurations, disable security tools, or exfiltrate data.  
- **Reputational damage**: A public incident where an attacker used John to crack thousands of passwords can erode customer trust.  
- **Legal exposure**: Organizations may face regulatory fines if password policies are non‑compliant and passwords are exposed.

The first sign is usually an alert from an IDS or a sudden spike in failed login attempts. From there, the blast radius expands as attackers pivot to other systems using the stolen credentials.

## Lab Relevance

John the Ripper is a staple in any red‑team or penetration‑testing lab. Here’s how to exercise it:

| Step | Command | What to watch |
|------|---------|---------------|
| 1. Extract a password hash | `unshadow /etc/passwd /etc/shadow > myhashes.txt` | Verify the file contains `username:$6$...` lines. |
| 2. Run John in incremental mode | `john --incremental=All myhashes.txt` | Watch CPU usage spike and track time to first crack. |
| 3. Use a custom wordlist | `john --wordlist=/usr/share/wordlists/rockyou.txt myhashes.txt` | Observe success rate and tweak the list. |
| 4. Crack a network capture | `hccap2john capture.cap > wpa.txt && john wpa.txt` | Learn how wireless hashes are extracted and cracked. |
| 5. Recover a BitLocker key | `bitlocker2john disk_image.dd > bitlocker.txt && john bitlocker.txt` | See how full‑disk encryption can be compromised with the right converter. |

**Safety tip**: Always run John in a sandboxed VM. Some hashes (e.g., LM) are trivial to crack; others (e.g., PBKDF2‑SHA256) may take days. Use `--max-crypts=100000` to avoid runaway jobs.

## Core Binaries

- **john** — main password cracker executable
- **unshadow** — combines /etc/passwd and /etc/shadow for cracking
- **unique** — removes duplicate passwords from wordlists with configurable memory usage
- **mailer** — processes password files

## Hash Conversion Utilities (john-data package)

### System & Directory Services
- ldif2john, krb2john, ccache2john, kdcdump2john — LDAP, Kerberos, directory services
- sap2john, ibmiscanner2john — enterprise systems
- radius2john, mosquitto2john — network services

### Encryption & Disk
- bitlocker2john, truecrypt2john, luks2john, diskcryptor2john — full-disk encryption
- dmg2john, vdi2john, vmx2john — disk images
- rar2john, 7z2john, zip2john — archive formats

### Cryptocurrency & Wallets
- bitcoin2john, ethereum2john, monero2john, electrum2john, multibit2john — crypto wallets
- blockchain2john, bitshares2john, tezos2john — blockchain formats

### Password Managers
- lastpass2john, dashlane2john, keepass2john, 1password2john, bitwarden2john — password managers
- enpass2john, pwsafe2john — encrypted vaults

### Applications & Browsers
- mozilla2john, filezilla2john, ssh2john, pgp2john, signal2john — app credentials
- itunes_backup2john, keychain2john, ios7tojohn — Apple devices
- android-related converters — mobile OS

### Document Formats
- office2john, pdf2john, libreoffice2john, iwork2john — office/document files

### Network & Capture
- pcap2john, wpapcap2john, hccap2john, eapmd5tojohn — wireless captures
- ssh2john, known_hosts2john — SSH keys

### Other Formats
- gpg2john, openssl2john, pfx2john — cryptographic keys
- vncpcap2john — VNC sessions

## Categories

[[passwords]] • [[post-exploitation]] • [[vulnerability]] • [[top10-tools]]

## References

- [Kali John Documentation](https://www.kali.org/tools/john/)
- Package Tracker & Source Code available via Kali repositories

## Tags

#kali #password-cracking #hash-cracking #utility #security-tools

---  
_Ingested: 2026-04-15 20:48 | Source: https://www.kali.org/tools/john/_