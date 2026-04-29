# Enumeration

## What it is
Like a census worker going door-to-door to catalog every resident, their name, and their job title, enumeration is the active process of extracting detailed information from a target system after initial contact is established. It goes beyond simple scanning to pull specific, usable data: usernames, group memberships, shares, services, and running processes.

## Why it matters
During the 2020 SolarWinds breach, attackers enumerated Active Directory to map privileged accounts and trust relationships before moving laterally across government networks. Defenders who monitor for abnormal LDAP queries, excessive SMB null sessions, or bulk account lookups can detect enumeration in progress — catching attackers during the reconnaissance phase before damage is done.

## Key facts
- **Enumeration is active, not passive** — it requires direct interaction with the target, leaving logs and potential alerts behind
- **Common protocols exploited for enumeration**: LDAP (port 389), SMB (port 445), SNMP (port 161), DNS zone transfers, and NetBIOS (port 137)
- **SNMP enumeration** with default community strings ("public"/"private") can expose full device configurations, routing tables, and connected hosts
- **Null sessions** (anonymous SMB connections) were historically used to enumerate Windows user lists; modern Group Policy should explicitly disable them
- **Tools**: Nmap with scripts (`--script=smb-enum-users`), enum4linux, SNMPwalk, and BloodHound (specifically for Active Directory enumeration) are standard exam references

## Related concepts
[[Active Reconnaissance]] [[LDAP]] [[SNMP]] [[Active Directory Attacks]] [[Network Scanning]]