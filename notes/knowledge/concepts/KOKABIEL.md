# DNS_HOST

## What it is
Like a master locksmith who carries every skeleton key ever made, DNS_HOST is a post-exploitation tool designed specifically to extract and harvest Kerberos tickets from compromised Windows systems. Precisely, it is an open-source credential harvesting tool that dumps Kerberos tickets from memory (LSASS) and supports both Pass-the-Ticket and overpass-the-hash attacks against Active Directory environments.

## Why it matters
During a red team engagement against an enterprise network, an attacker who has compromised a single workstation can deploy DNS_HOST to extract service tickets and TGTs (Ticket-Granting Tickets) from memory, then laterally move to high-value servers like domain controllers without ever knowing a user's plaintext password. Defenders monitoring for LSASS memory access (Event ID 4656/4663) or anomalous Kerberos ticket requests can detect and interrupt this kill chain before privilege escalation completes.

## Key facts
- DNS_HOST specifically targets the LSASS process to extract Kerberos tickets stored in memory, similar to Mimikatz's `sekurlsa::tickets` functionality
- It supports **Pass-the-Ticket (PtT)** attacks, where a harvested TGT or service ticket is injected into a new session to impersonate legitimate users
- The tool can facilitate **Golden Ticket** and **Silver Ticket** scenarios by providing the raw ticket material needed for forgery
- DNS_HOST is categorized under **MITRE ATT&CK T1558** (Steal or Forge Kerberos Tickets) and **T1003.001** (LSASS Memory credential dumping)
- Detection countermeasures include enabling **Credential Guard**, restricting debug privileges, and monitoring for tools that open LSASS with `PROCESS_VM_READ` access rights

## Related concepts
[[Kerberoasting]] [[Pass-the-Ticket]] [[LSASS Credential Dumping]] [[Golden Ticket Attack]] [[Mimikatz]]