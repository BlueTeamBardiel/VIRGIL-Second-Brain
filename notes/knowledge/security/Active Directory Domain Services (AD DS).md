---
domain: "Identity & Access Management"
tags: [active-directory, windows-server, authentication, ldap, kerberos, directory-services]
---
# Active Directory Domain Services (AD DS)

**Active Directory Domain Services (AD DS)** is Microsoft's implementation of a **directory service** that provides centralized authentication, authorization, and management of users, computers, and resources within a [[Windows Domain]] environment. Built on open standards including [[LDAP]] and [[Kerberos]], AD DS is the backbone of identity management in the vast majority of enterprise Windows networks and is a critical target in nearly every real-world corporate intrusion.

---

## Overview

Active Directory Domain Services was introduced with Windows 2000 Server and has evolved through every subsequent Windows Server release. At its core, AD DS is a hierarchical, distributed database that stores information about every object in a network — users, groups, computers, printers, policies, and more — and makes that information available to authorized users and services across the enterprise. The technology replaced the older Windows NT domain model and brought with it scalability, replication, and standards-based protocols that could operate across geographically distributed organizations.

The architecture of AD DS is built around a concept called the **domain**, which is a logical grouping of objects that share the same AD DS database. Domains are organized into **trees** (a hierarchy of domains sharing a contiguous DNS namespace) and **forests** (a collection of trees that trust each other). This layered structure allows large enterprises to segment administration while maintaining a unified authentication infrastructure. A single forest can span multiple countries, business units, or security zones, all unified under a shared **Global Catalog**.

AD DS relies on **Domain Controllers (DCs)** — Windows Server instances running the AD DS role — to store and replicate the directory database. In modern AD environments, all DCs are considered peers using a **multi-master replication** model (introduced with Windows 2000), meaning changes can be written to any DC and replicated to all others. However, certain sensitive operations — like changing the domain schema or managing RID pools — are still handled by specific DCs designated as **Flexible Single Master Operations (FSMO)** role holders.

The service integrates tightly with **DNS** (Domain Name System), which it uses for locating DCs and services via SRV records. Without a properly functioning DNS infrastructure, AD DS breaks down entirely — clients cannot find DCs, and authentication fails. This dependency makes DNS a critical component of any AD DS deployment and an important target for both attackers and defenders to understand.

In the real world, AD DS is deployed in an estimated 90%+ of Fortune 500 companies and tens of millions of organizations globally. Its ubiquity, combined with the extreme sensitivity of the data it holds (credentials, group memberships, policy configurations), makes it the single most targeted system in enterprise intrusions. Threat actors from nation-state APTs to ransomware groups invariably target AD DS to achieve lateral movement, privilege escalation, and persistence.

---

## How It Works

### Authentication Flow (Kerberos)

AD DS uses [[Kerberos]] v5 as its primary authentication protocol. The flow proceeds as follows:

1. **AS-REQ**: A client sends an Authentication Service Request to the **Key Distribution Center (KDC)**, which runs on every DC. The request includes the client's username and a timestamp encrypted with the client's password hash.
2. **AS-REP**: The KDC validates the request and responds with a **Ticket Granting Ticket (TGT)** — a signed, time-limited token encrypted with the KDC's own secret (`krbtgt` account hash).
3. **TGS-REQ**: When the client wants to access a network service, it presents its TGT to the KDC's **Ticket Granting Service (TGS)** and requests a **Service Ticket** for the target resource.
4. **TGS-REP**: The KDC issues a Service Ticket encrypted with the target service's account hash (its **Service Principal Name / SPN** key).
5. **AP-REQ**: The client presents the Service Ticket to the target server. The server decrypts it with its own key and grants access based on the embedded authorization data.

Kerberos tickets are time-sensitive (default 10-hour lifetime, 7-day renewal) and require synchronized clocks across all domain members (within 5 minutes by default).

### LDAP Queries

AD DS exposes its directory data via **LDAP (Lightweight Directory Access Protocol)**:

```bash
# Query all users in a domain using ldapsearch (Linux/Kali)
ldapsearch -H ldap://dc01.corp.local -b "DC=corp,DC=local" \
  -D "user@corp.local" -w 'Password1!' \
  "(objectClass=user)" sAMAccountName mail memberOf

# Query for all Domain Admins
ldapsearch -H ldap://dc01.corp.local -b "DC=corp,DC=local" \
  -D "user@corp.local" -w 'Password1!' \
  "(&(objectClass=group)(cn=Domain Admins))" member
```

### Key Ports and Protocols

| Port | Protocol | Purpose |
|------|----------|---------|
| 88 | TCP/UDP | Kerberos authentication |
| 389 | TCP/UDP | LDAP (plaintext/STARTTLS) |
| 636 | TCP | LDAPS (LDAP over TLS) |
| 445 | TCP | SMB (Group Policy, SYSVOL) |
| 464 | TCP/UDP | Kerberos password change (kpasswd) |
| 3268 | TCP | Global Catalog LDAP |
| 3269 | TCP | Global Catalog LDAPS |
| 53 | TCP/UDP | DNS (DC locator SRV records) |
| 135 | TCP | RPC Endpoint Mapper |
| 49152–65535 | TCP | Dynamic RPC (replication, admin) |

### Group Policy Processing

**Group Policy Objects (GPOs)** are stored in the **SYSVOL** share (`\\domain\SYSVOL`) and linked to AD DS containers (sites, domains, OUs). When a client logs in:

```powershell
# View applied GPOs on a Windows machine
gpresult /R

# Force an immediate Group Policy refresh
gpupdate /force

# View GPO processing details
gpresult /H C:\gpo_report.html
```

Policy is applied in **LSDOU** order: Local → Site → Domain → Organizational Unit, with later policies overwriting earlier ones (unless inheritance is blocked or enforcement is set).

### PowerShell Administration

```powershell
# Install AD DS role on Windows Server
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Promote server to Domain Controller (new forest)
Install-ADDSForest `
  -DomainName "corp.local" `
  -DomainNetbiosName "CORP" `
  -ForestMode "WinThreshold" `
  -DomainMode "WinThreshold" `
  -InstallDns:$true `
  -SafeModeAdministratorPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
  -Force

# Enumerate all AD users
Get-ADUser -Filter * -Properties * | Select-Object Name, SamAccountName, Enabled, LastLogonDate

# Find all Domain Admins
Get-ADGroupMember -Identity "Domain Admins" -Recursive

# Find stale computer accounts (inactive 90+ days)
$cutoff = (Get-Date).AddDays(-90)
Get-ADComputer -Filter {LastLogonDate -lt $cutoff -and Enabled -eq $true} `
  -Properties LastLogonDate | Select-Object Name, LastLogonDate
```

### Replication

AD DS replicates directory changes between DCs using the **Directory Replication Service (DRS)** protocol over RPC. The **Knowledge Consistency Checker (KCC)** automatically builds a replication topology. Replication within a site uses **urgent replication** for critical changes (e.g., account lockouts) and **scheduled replication** for normal changes. Between sites, replication is controlled by **site link** objects.

```powershell
# Check replication status
repadmin /replsummary

# Force replication from a specific DC
repadmin /syncall /AdeP

# Show replication failures
repadmin /showrepl * /errorsonly
```

---

## Key Concepts

- **Domain Controller (DC)**: A Windows Server with the AD DS role installed that stores a writable copy of the AD database (`ntds.dit`) and services authentication and directory queries for its domain. Every domain requires at least one DC; best practice mandates two or more for redundancy.

- **NTDS.DIT**: The **Active Directory database file** stored at `C:\Windows\NTDS\ntds.dit` on every DC. It contains all AD objects including user accounts and their password hashes. Extracting this file is the holy grail for attackers — it enables offline cracking or pass-the-hash attacks against every account in the domain.

- **Organizational Unit (OU)**: A container object within a domain used to organize users, computers, and groups into logical administrative units. OUs are the primary target for GPO linking and can have delegated administrative permissions, enabling tiered administration without granting full Domain Admin rights.

- **FSMO Roles**: **Flexible Single Master Operations** roles are special DC responsibilities that cannot be performed by multiple DCs simultaneously. The five roles are: Schema Master, Domain Naming Master (forest-wide), and RID Master, PDC Emulator, and Infrastructure Master (domain-wide). The PDC Emulator is especially critical as it handles time synchronization, password changes, and account lockouts.

- **Global Catalog (GC)**: A DC role that stores a partial, read-only replica of all objects from every domain in the forest. GCs are essential for cross-domain authentication and for resolving Universal Group memberships. Port 3268/3269 is used to query the GC specifically.

- **Trust Relationships**: Trusts allow users in one domain or forest to authenticate to resources in another. Types include **transitive** (automatically extended to all domains in a forest), **non-transitive** (limited to two specific domains), **one-way**, **two-way**, and **forest trusts** (linking entire forests). Misconfigured trusts are a common lateral movement path.

- **Service Principal Names (SPNs)**: Unique identifiers that associate a service instance with a service account in AD DS. SPNs are the mechanism Kerberos uses to identify what account a service ticket should be encrypted for — making them central to the [[Kerberoasting]] attack technique.

---

## Security Implications

### Critical Attack Vectors

**DCSync Attack**: An attacker with `DS-Replication-Get-Changes-All` privileges (typically Domain Admins, Enterprise Admins, or any account with delegated replication rights) can simulate a Domain Controller's replication requests to pull all password hashes from the directory without ever touching `ntds.dit`.

```powershell
# Mimikatz DCSync - pulls krbtgt hash
lsadump::dcsync /user:krbtgt /domain:corp.local
```

**Pass-the-Hash (PtH)**: Because NTLM authentication accepts a password hash directly, an attacker who extracts a hash from memory (`lsass.exe`) or `ntds.dit` can authenticate as that user without knowing the plaintext password. The `krbtgt` hash is especially dangerous — possessing it enables **Golden Ticket** attacks.

**Golden Ticket**: Created using the `krbtgt` account's NTLM hash, a Golden Ticket is a forged Kerberos TGT that grants the holder unlimited access to any resource in the domain for as long as the `krbtgt` password has not been rotated (typically years in many environments). Golden Tickets can be backdated and set to any expiry.

```
# Mimikatz Golden Ticket creation
kerberos::golden /user:FakeAdmin /domain:corp.local /sid:S-1-5-21-... /krbtgt:<hash> /ticket:golden.kirbi
```

**Kerberoasting**: Any authenticated domain user can request Service Tickets for any SPN. Because Service Tickets are encrypted with the service account's hash, they can be exported and cracked offline. Service accounts are often configured with weak passwords and rarely changed, making this highly effective.

**AS-REP Roasting**: Accounts with **"Do not require Kerberos preauthentication"** enabled will respond to AS-REQ with an AS-REP encrypted by the user's hash — without the attacker needing valid credentials first.

**LDAP Relay / NTLM Relay**: If LDAP signing is not enforced, an attacker performing an NTLM relay attack can relay captured credentials to a DC's LDAP interface to create accounts, modify ACLs, or enable DCSync rights. Tools like `ntlmrelayx.py` (Impacket) automate this.

**BloodHound / AD Enumeration**: The [[BloodHound]] tool graphs AD object relationships and identifies attack paths to Domain Admin from any starting point. It operates entirely over standard LDAP queries, making it difficult to distinguish from normal administrative activity.

**Notable Real-World Incidents**:
- **SolarWinds/SUNBURST (2020)**: Attackers leveraged AD FS (Federation Services) tokens and SAML forgery after gaining access to on-premises AD infrastructure.
- **NotPetya (2017)**: Spread laterally across networks using stolen domain credentials and pass-the-hash, destroying systems at Maersk, Merck, and others.
- **CVE-2020-1472 (Zerologon)**: A critical vulnerability in the Netlogon protocol allowed unauthenticated attackers to change a DC's computer account password and instantly achieve Domain Admin. CVSS score 10.0.
- **CVE-2021-42278 / CVE-2021-42287 (noPac)**: A combination of two vulnerabilities allowed a standard domain user to impersonate a Domain Controller and achieve Domain Admin in minutes.
- **CVE-2022-26923 (Certifried)**: Privilege escalation through AD Certificate Services (AD CS) allowing a low-privileged user to obtain a certificate that could be used to authenticate as a Domain Controller.

---

## Defensive Measures

### Tiered Administration Model

Implement **Microsoft's Active Directory Tier Model** (or the newer Enterprise Access Model):
- **Tier 0**: Domain Controllers, AD DS, PKI — accessed only from dedicated Privileged Access Workstations (PAWs)
- **Tier 1**: Servers and applications
- **Tier 2**: User workstations

Never allow Tier 0 credentials to be used on Tier 1 or Tier 2 systems (prevents credential theft from compromised workstations).

### Protecting Privileged Accounts

```powershell
# Enable Protected Users security group for all admin accounts
# Members cannot use NTLM, CredSSP, or WDigest; TGT lifetime reduced to 4 hours
Add-ADGroupMember -Identity "Protected Users" -Members "AdminUser1","AdminUser2"

# Enforce smart card / MFA requirement for privileged accounts
Set-ADUser -Identity "AdminUser1" -SmartcardLogonRequired $true
```

### Credential Exposure Reduction

- **Disable WDigest authentication** to prevent plaintext credentials in memory:
```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" `
  -Name "UseLogonCredential" -Value 0
```

- **Enable Credential Guard** on Windows 10/11 and Server 2016+ to protect LSASS with virtualization-based security (VBS), preventing Mimikatz-style hash extraction.

- **Enable LSA Protection** (RunAsPPL):
```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" `
  -Name "RunAsPPL" -Value 1
```

### Hardening LDAP and SMB

```powershell
# Enforce LDAP signing on Domain Controllers (via GPO)
# Computer Configuration > Windows Settings > Security Settings > Local Policies > Security Options
# "Domain controller: LDAP server signing requirements" = Require signing

# Enforce LDAP channel binding (apply via Registry or GPO)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" `
  -Name "LdapEnforceChannelBinding" -Value