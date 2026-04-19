---
domain: "identity-and-access-management"
tags: [active-directory, windows, ldap, kerberos, domain-controller, authentication]
---
# Active Directory

**Active Directory (AD)** is Microsoft's proprietary directory service, first introduced with Windows Server 2000, that provides centralized **authentication**, **authorization**, and **identity management** for Windows-based enterprise networks. It acts as a hierarchical database storing information about network objects — users, computers, groups, printers, and policies — and uses [[Kerberos]] and [[LDAP]] as its core protocols to authenticate identities and answer directory queries. Understanding Active Directory is foundational to both enterprise IT administration and offensive/defensive [[cybersecurity]], as it is the single most targeted system in modern enterprise attack campaigns.

---

## Overview

Active Directory was designed to solve the scaling problem of managing hundreds or thousands of networked computers and user accounts in a Windows environment. Before AD, administrators had to configure each machine independently or rely on NT Domains, which lacked the hierarchical flexibility needed for large organizations. AD introduced the concept of a **forest**, **tree**, and **domain** hierarchy, allowing organizations to logically partition their environments while still maintaining centralized policy control through **Group Policy Objects (GPOs)**.

At its core, Active Directory runs on one or more **Domain Controllers (DCs)** — Windows Server instances that host the AD database (`NTDS.dit`) and respond to authentication requests from clients. Every object in AD — whether a user, computer, or group — is assigned a unique **Security Identifier (SID)** and stored in a hierarchical namespace modeled on DNS. For example, a domain named `corp.example.com` creates an LDAP namespace of `DC=corp,DC=example,DC=com`, within which organizational units (OUs), users, and computers are nested.

Active Directory integrates tightly with **DNS**; in fact, AD cannot function without a properly configured DNS infrastructure. Clients locate domain controllers by querying DNS for **SRV records** (e.g., `_ldap._tcp.corp.example.com`). Once a DC is found, clients use [[Kerberos]] (on port 88) to exchange tickets that prove identity without sending passwords over the wire. For legacy compatibility, [[NTLM]] authentication is also supported, though it is far weaker and subject to well-known attacks.

Beyond authentication, AD provides **Group Policy**, a mechanism that allows administrators to enforce hundreds of security and configuration settings — from password complexity requirements to software deployment and firewall rules — across all machines in a domain. GPOs are linked to sites, domains, or OUs and are processed by clients at startup and at periodic refresh intervals (by default every 90 minutes with a random 0–30 minute offset).

Active Directory has evolved into a broader **identity platform**. **Active Directory Domain Services (AD DS)** is the classic on-premises directory. **Active Directory Certificate Services (AD CS)** issues X.509 certificates for internal PKI. **Active Directory Federation Services (AD FS)** enables SAML-based federated identity. **Azure Active Directory (now Microsoft Entra ID)** extends identity to the cloud, and **Azure AD Connect** synchronizes on-premises AD accounts to the cloud. In 2024 enterprise environments, a hybrid AD/Entra ID topology is extremely common.

---

## How It Works

### Logical Structure

Active Directory organizes objects into a hierarchy:

- **Forest**: The top-level security boundary. All domains in a forest share a common schema, global catalog, and trust relationships. A forest can contain one or more trees.
- **Tree**: A collection of domains sharing a contiguous DNS namespace (e.g., `example.com`, `corp.example.com`, `dev.corp.example.com`).
- **Domain**: The core administrative unit. Contains users, computers, groups, and GPOs. Domains have their own security policies and trusts.
- **Organizational Unit (OU)**: A container within a domain used to group objects for delegated administration and GPO application.
- **Object**: Any entity stored in AD — users, computers, groups, printers, shared folders.

### Authentication Flow (Kerberos)

1. **AS-REQ**: The client sends a Kerberos Authentication Service Request to the DC (KDC) on **UDP/TCP port 88**, including the username and an encrypted timestamp (pre-authentication).
2. **AS-REP**: The KDC validates pre-auth and returns a **Ticket Granting Ticket (TGT)** encrypted with the `krbtgt` account's NTLM hash, plus a session key encrypted with the user's hash.
3. **TGS-REQ**: When the user needs to access a service (e.g., a file share), the client presents the TGT to the KDC and requests a **Ticket Granting Service (TGS)** ticket for the target Service Principal Name (SPN).
4. **TGS-REP**: The KDC returns a service ticket encrypted with the service account's hash.
5. **AP-REQ**: The client presents the service ticket directly to the target service (e.g., a file server). No password ever traverses the network.

### Key Ports and Protocols

| Protocol / Service | Port(s) | Purpose |
|--------------------|---------|---------|
| Kerberos | TCP/UDP 88 | Authentication ticket exchange |
| LDAP | TCP/UDP 389 | Directory queries and modifications |
| LDAPS | TCP 636 | LDAP over TLS |
| Global Catalog | TCP 3268 / 3269 | Forest-wide object search |
| DNS | UDP/TCP 53 | DC/SRV record lookup |
| SMB / CIFS | TCP 445 | File sharing, GPO, SYSVOL |
| RPC / DCOM | TCP 135 + dynamic | Remote management, replication |
| NetBIOS | UDP 137/138, TCP 139 | Legacy name resolution |
| WinRM / WMI | TCP 5985/5986 | Remote management |

### The NTDS.dit Database

The AD database is stored at `C:\Windows\NTDS\NTDS.dit` on every domain controller. It uses an **Extensible Storage Engine (ESE)** format and contains all AD objects, their attributes, and — critically — **NTLM password hashes** and **Kerberos keys** for every user and computer account. Access is controlled by the operating system; the file is locked while AD is running. Extracting this file and the **SYSTEM hive** (which contains the Boot Key needed to decrypt the database) is the ultimate goal of many credential-dumping attacks.

### Replication

When multiple DCs exist, AD uses **multi-master replication** via the **Knowledge Consistency Checker (KCC)**, which automatically builds a replication topology. Changes on any DC replicate to all others. The **USN (Update Sequence Number)** and **invocationID** track changes to prevent replication loops. Replication uses **RPC over TCP port 135** with dynamically negotiated high ports.

### Common Administrative Commands

```powershell
# List all domain controllers
Get-ADDomainController -Filter *

# Find all user accounts
Get-ADUser -Filter * -Properties LastLogonDate, PasswordLastSet | Select Name, LastLogonDate, PasswordLastSet

# List all members of Domain Admins
Get-ADGroupMember -Identity "Domain Admins" -Recursive

# Find computers not updated in 90 days (potential stale objects)
$cutoff = (Get-Date).AddDays(-90)
Get-ADComputer -Filter {LastLogonTimeStamp -lt $cutoff} -Properties LastLogonTimeStamp

# Check for accounts with "Password Never Expires"
Get-ADUser -Filter {PasswordNeverExpires -eq $true} -Properties PasswordNeverExpires

# Query LDAP directly (requires ldp.exe or ldapsearch)
# Linux equivalent:
ldapsearch -H ldap://dc01.corp.example.com -x -b "DC=corp,DC=example,DC=com" "(objectClass=user)" cn sAMAccountName

# Create a new OU
New-ADOrganizationalUnit -Name "Workstations" -Path "DC=corp,DC=example,DC=com"

# Force GPO update on remote machine
Invoke-GPUpdate -Computer "WORKSTATION01" -Force
```

### SYSVOL and NETLOGON

Every domain controller hosts two critical shares:
- **SYSVOL** (`\\domain\SYSVOL`): Contains GPO files, scripts, and policies. Replicated between DCs using **DFS-R** (or the older **FRS** on older servers).
- **NETLOGON** (`\\domain\NETLOGON`): Contains logon scripts. Clients authenticate to SYSVOL/NETLOGON during domain join and policy processing.

---

## Key Concepts

- **Domain Controller (DC)**: A Windows Server running AD DS that stores the `NTDS.dit` database and processes authentication requests. Every domain needs at least one DC; best practice is two or more for redundancy. The **Primary Domain Controller Emulator (PDC Emulator)** FSMO role handles time synchronization and legacy authentication fallback.

- **FSMO Roles (Flexible Single Master Operations)**: Five special roles that must be held by exactly one DC each to prevent conflicting writes. They are: **Schema Master**, **Domain Naming Master** (forest-wide), and **PDC Emulator**, **RID Master**, and **Infrastructure Master** (domain-wide). Loss of the RID Master, for example, eventually prevents new security principals from being created.

- **Group Policy Object (GPO)**: A collection of settings that AD applies to users and/or computers within a site, domain, or OU. GPOs can enforce password policies, deploy software, configure Windows Firewall, map drives, run scripts, and much more. Processing order follows **LSDOU** (Local → Site → Domain → OU), with later GPOs overriding earlier ones unless **Enforced** is set.

- **Trust Relationships**: A mechanism that allows users in one domain to authenticate to resources in another. **Transitive trusts** (the default within a forest) propagate through the domain hierarchy. **External trusts** connect to domains in other forests and are non-transitive. **Forest trusts** connect two entire forests. Trusts represent significant attack surface — a compromise in a trusted domain can pivot into the trusting domain.

- **Security Principal and SID**: Every user, group, and computer is a **security principal** with a unique **Security Identifier (SID)**. SIDs are used in **Access Control Lists (ACLs)** to grant permissions. The **SID History** attribute — designed for migrations — is a well-known abuse vector.

- **Service Principal Name (SPN)**: A unique identifier for a service instance used by Kerberos to associate a service with a service account. SPNs are the prerequisite for [[Kerberoasting]] — any authenticated domain user can request a TGS for any SPN and attempt to crack the service account's password offline.

- **Distinguished Name (DN)**: The full LDAP path that uniquely identifies an object in the directory. Example: `CN=John Smith,OU=Employees,DC=corp,DC=example,DC=com`. Understanding DNs is essential for LDAP queries, scripting, and understanding AD attack tool output.

- **Privileged Groups**: Several built-in AD groups carry significant privileges. **Domain Admins** have full control over the domain. **Enterprise Admins** and **Schema Admins** have forest-wide administrative rights. **Account Operators** can modify most user accounts. **Backup Operators** can bypass file permissions. Membership in these groups is a primary target for attackers.

---

## Security Implications

Active Directory is one of the most attacked services in enterprise environments. Because it is the root of trust for authentication and authorization, a full AD compromise — often called **"owning the domain"** — gives attackers unfettered access to virtually every resource in the organization.

### Credential Attacks

- **[[Pass-the-Hash (PtH)]]**: Because NTLM authentication accepts the hash directly, attackers who dump hashes (e.g., from LSASS memory using Mimikatz) can authenticate as the victim without knowing the plaintext password. Mitigations include Protected Users group, Credential Guard, and disabling NTLM where possible.
- **[[Pass-the-Ticket (PtT)]]**: Stolen Kerberos TGTs or service tickets can be injected into the current session. Tickets are stored in memory and can be exported with tools like Mimikatz (`sekurlsa::tickets`).
- **[[Kerberoasting]]**: Any authenticated domain user can request a TGS for any SPN-registered service account. The TGS is encrypted with the service account's hash and can be cracked offline with Hashcat. Accounts with weak passwords are trivially compromised. Affects every domain with service accounts using RC4 encryption (etype 23).
- **[[AS-REP Roasting]]**: User accounts with **"Do not require Kerberos preauthentication"** enabled will respond to AS-REQ without validating the requester's identity, returning an AS-REP encrypted with the user's hash that can be cracked offline.
- **[[Golden Ticket Attack]]**: If an attacker obtains the `krbtgt` account's NTLM hash (from NTDS.dit or DCSync), they can forge arbitrary TGTs — **Golden Tickets** — for any user, including non-existent ones, with any group membership. These tickets remain valid even after password changes unless `krbtgt` is reset **twice**.
- **[[DCSync Attack]]**: The `DS-Replication-Get-Changes-All` right, normally held only by DCs and Domain Admins, allows an account to replicate all AD objects including password hashes — without ever touching a DC interactively. Detected by monitoring Event ID 4662 for replication rights being exercised by non-DC accounts.

### Privilege Escalation via ACLs

**ACL-based privilege escalation** is extensively documented by BloodHound/SharpHound research (SpecterOps). Common abusable rights include:
- **GenericAll / GenericWrite**: Full control or write access to an object. Can be used to reset passwords, add to groups, or write SPNs to enable Kerberoasting.
- **WriteDACL**: Grants the ability to modify the DACL of an object, enabling self-granting of additional rights.
- **ForceChangePassword**: Allows resetting a user's password without knowing the current one.
- **DCSync rights (DS-Replication-Get-Changes-All)**: As above.

### Notable Incidents and CVEs

- **CVE-2020-1472 (Zerologon)**: A critical flaw in the Netlogon protocol's use of AES-CFB8 encryption allowed an unauthenticated attacker on the local network to set the DC's computer account password to empty, instantly compromising the domain. CVSS 10.0.
- **CVE-2021-42278 / CVE-2021-42287 (NoPac / SamAccountName Spoofing)**: A pair of vulnerabilities allowing any authenticated domain user to impersonate a domain controller and obtain a TGT as `SYSTEM`, fully compromising AD. Patched November 2021.
- **CVE-2022-26923 (Certifried)**: A vulnerability in AD Certificate Services allowing low-privileged users to obtain a certificate that could be used for domain escalation.
- **NotPetya (2017)**: Weaponized EternalBlue + Mimikatz/Mimikatz-derived credential dumping to extract AD credentials and spread laterally across entire forests, causing billions in damages.
- **SolarWinds (2020)**: Attackers used a golden SAML technique (forging SAML tokens by stealing the AD FS signing certificate) to achieve persistent, stealthy access across hybrid AD/Azure AD environments.

### Detection Events (Windows Event IDs)

| Event ID | Description |
|----------|-------------|
| 4624 | Successful logon — track Type 3 (network) and Type 10 (remote interactive) |
| 4625 | Failed logon — high volumes indicate password spray or brute force |
| 4662 | Object operation — monitor for DS-Replication rights (DCSync detection) |
| 4720 | New user account created |
| 4728/4732/4756 | Member added to security-enabled group |
| 4768 | Kerberos TGT request (AS-REQ) — monitor for RC4 etype from non-legacy sources |
| 4769 | Kerberos service ticket request (TGS-REQ) — RC4 requests indicate Kerberoasting |
| 4771 | Kerberos pre-