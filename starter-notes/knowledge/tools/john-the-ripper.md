# John the Ripper

John the Ripper is a fast password cracker available in Kali Linux (v1.9.0). It supports numerous hash formats and includes conversion utilities for extracting password hashes from various file types and applications.

## Overview

A comprehensive password auditing and recovery tool with support for multiple hash algorithms and formats. Includes numerous helper utilities for converting credentials from common applications and file types into formats John can process.

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
