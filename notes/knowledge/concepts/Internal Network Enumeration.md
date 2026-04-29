# Internal Network Enumeration

## What it is
Like a burglar who's already picked the front lock and now quietly opens every drawer to map the house layout before stealing anything, internal network enumeration is the systematic process of discovering live hosts, open ports, services, users, and shares *after* initial access to a network. It transforms a foothold into a detailed blueprint an attacker uses to plan lateral movement and privilege escalation.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors used internal enumeration tools like `nltest` and `AdFind` to map Active Directory structure and identify high-value targets after compromising the initial host — waiting weeks before moving laterally to avoid detection. Defenders who monitor for abnormal LDAP queries and port scan traffic from internal hosts can catch this reconnaissance phase before damage escalates.

## Key facts
- **Nmap** is the standard tool for host discovery and port scanning; `nmap -sV -O 192.168.1.0/24` reveals OS versions and services across a subnet
- **NetBIOS and LDAP enumeration** (via tools like `enum4linux` or `BloodHound`) expose Active Directory users, groups, and trust relationships without requiring elevated privileges
- **ICMP ping sweeps** detect live hosts, but many hardened environments block ICMP — requiring TCP/UDP probes instead (ARP scanning works within the same subnet)
- **SMB enumeration** can reveal shared folders, domain names, and password policies using `smbclient` or Metasploit's `smb_enumshares` module
- Enumeration artifacts — repeated failed authentications, unusual LDAP queries, port scan patterns — are detectable via **SIEM correlation rules** and are explicitly tested in CySA+ scenarios

## Related concepts
[[Active Directory Attacks]] [[Lateral Movement]] [[Network Scanning and Reconnaissance]] [[Privilege Escalation]] [[SIEM and Log Analysis]]