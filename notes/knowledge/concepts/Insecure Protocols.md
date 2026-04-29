# Insecure Protocols

## What it is
Imagine sending your bank password on a postcard instead of a sealed envelope — anyone handling the mail can read it. Insecure protocols transmit data (including credentials and session tokens) in plaintext or with weak/broken cryptographic controls, making interception trivial for any attacker with network access.

## Why it matters
In 2021, researchers demonstrated credential harvesting on enterprise networks still running Telnet for legacy device management — a packet capture tool like Wireshark exposed admin usernames and passwords in under 30 seconds. Replacing Telnet with SSH eliminated the exposure without changing operational workflows, illustrating that secure alternatives exist for virtually every insecure protocol.

## Key facts
- **FTP, Telnet, HTTP, SNMP v1/v2, and rlogin** are classic insecure protocols — all transmit credentials in plaintext and are frequently flagged on Security+ exams
- **TFTP** lacks any authentication mechanism entirely, making it particularly dangerous when exposed on internal networks
- **SNMP v1/v2c** uses community strings (essentially shared passwords) sent in cleartext; SNMPv3 adds authentication and encryption and is the required replacement
- Secure replacements follow a predictable pattern: HTTP→HTTPS, FTP→SFTP or FTPS, Telnet→SSH, SNMP v1/v2→SNMPv3, LDAP→LDAPS
- On the CySA+ exam, identifying insecure protocols in a network diagram or pcap output is a core analyst skill — look for ports 21, 23, 80, 161, and 69 as red flags

## Related concepts
[[Man-in-the-Middle Attack]] [[Network Traffic Analysis]] [[Encryption in Transit]] [[Port Security]] [[Protocol Hardening]]