---
domain: "Identity and Access Management"
tags: [active-directory, windows-server, identity-management, authentication, ldap, group-policy]
---
# Active Directory Management

**Active Directory (AD)** is Microsoft's directory service built on [[LDAP]] and [[Kerberos]] protocols, providing centralized **authentication, authorization, and identity management** for Windows domain environments. First introduced with Windows 2000 Server, it has become the backbone of enterprise identity infrastructure, used by over 90% of Fortune 500 companies. Administrators interact with AD through tools like **Active Directory Users and Computers (ADUC)**, PowerShell, and the **Active Directory Administrative Center (ADAC)** to manage users, computers, groups, and policies at scale.

---

## Overview

Active Directory stores and organizes information about network resources — users, computers, printers, shared folders, and security policies — in a hierarchical, distributed database called the **directory**. The logical structure of AD is composed of **forests**, **trees**, and **domains**, while the physical structure relies on **Domain Controllers (DCs)** and **sites**. Every object in the directory has attributes described by a **schema**, which defines what types of objects can exist and what properties they can have. The schema is forest-wide and shared across all domains in the forest, making schema changes a high-impact administrative action.

At the heart of AD authentication is the **Kerberos v5** protocol, which uses a ticket-based system to authenticate users without transmitting passwords over the network. When a user logs in, the **Key Distribution Center (KDC)** — running on every Domain Controller — issues a **Ticket-Granting Ticket (TGT)**, which is then exchanged for **service tickets** to access specific resources. Legacy environments also support **NTLM authentication** for backward compatibility, though NTLM is significantly weaker and a common attack target. DNS is deeply integrated; AD relies almost entirely on **Dynamic DNS (DDNS)** for resource location, and a misconfigured or absent DNS service will break AD authentication entirely.

The **organizational unit (OU)** is the fundamental administrative container within a domain, allowing administrators to delegate control and apply **Group Policy Objects (GPOs)** to specific subsets of users and computers. This delegation model enables large organizations to distribute administrative responsibilities — for example, allowing a helpdesk team to reset passwords in the `Helpdesk` OU without granting domain-wide admin rights. **Group Policy** is one of the most powerful AD management tools, capable of enforcing security settings, software deployment, logon scripts, and hundreds of other configurations across thousands of machines simultaneously.

**Replication** keeps all Domain Controllers synchronized. AD uses a **multi-master replication model**, meaning changes can be made on any DC and will propagate to all others. However, certain operations are restricted to a single DC at a time via **Flexible Single Master Operations (FSMO) roles**. There are five FSMO roles: Schema Master, Domain Naming Master (both forest-wide), and RID Master, PDC Emulator, and Infrastructure Master (each domain-wide). Understanding FSMO roles is critical for troubleshooting replication failures and planning DC decommissioning.

Modern environments increasingly integrate AD with **Azure Active Directory (Azure AD / Entra ID)** through **Azure AD Connect**, creating hybrid identity environments. This synchronizes on-premises identities to the cloud, enabling single sign-on (SSO) to Microsoft 365 and other SaaS applications. The distinction between on-premises AD and cloud-based Entra ID is important: they are different products with different management tools, trust models, and attack surfaces, though they are often confused by practitioners new to the field.

---

## How It Works

### Logical and Physical Structure

Active Directory's logical structure separates administrative boundaries from physical network topology:

- **Forest**: The top-level security boundary. All domains in a forest share a common schema, global catalog, and two-way transitive trust relationships.
- **Tree**: One or more domains sharing a contiguous DNS namespace (e.g., `corp.example.com`, `dev.corp.example.com`).
- **Domain**: The primary administrative unit. Contains users, computers, and groups. Has its own security policies and is the replication boundary for most data.
- **OU (Organizational Unit)**: A container within a domain used for GPO application and administrative delegation. Does NOT create a security boundary.
- **Sites**: Physical topology objects representing IP subnets with fast connectivity. Used to control replication traffic and direct login requests to the nearest DC.

### Authentication Flow (Kerberos)

```
1. User enters credentials at workstation (WORKSTATION01)
2. Workstation contacts KDC (Domain Controller) on port 88/TCP+UDP
3. KDC validates pre-authentication (encrypted timestamp using user's NTLM hash)
4. KDC issues TGT (Ticket Granting Ticket), encrypted with krbtgt account hash
5. User requests access to FILE-SERVER01
6. Workstation presents TGT to KDC's Ticket Granting Service (TGS)
7. KDC issues Service Ticket for FILE-SERVER01, encrypted with the server's hash
8. Workstation presents Service Ticket to FILE-SERVER01 — access granted
```

**Key ports used by Active Directory:**

| Service | Port | Protocol |
|---|---|---|
| Kerberos | 88 | TCP/UDP |
| LDAP | 389 | TCP/UDP |
| LDAPS | 636 | TCP |
| Global Catalog | 3268 | TCP |
| Global Catalog SSL | 3269 | TCP |
| DNS | 53 | TCP/UDP |
| SMB (SYSVOL/NETLOGON) | 445 | TCP |
| RPC Endpoint Mapper | 135 | TCP |
| NetBIOS | 137-139 | TCP/UDP |
| WinRM (Remote Mgmt) | 5985/5986 | TCP |

### Common Administrative Tasks via PowerShell

**Create a new user:**
```powershell
New-ADUser -Name "Jane Smith" `
           -SamAccountName "jsmith" `
           -UserPrincipalName "jsmith@corp.example.com" `
           -Path "OU=Finance,DC=corp,DC=example,DC=com" `
           -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) `
           -Enabled $true `
           -PasswordNeverExpires $false `
           -ChangePasswordAtLogon $true
```

**Create a security group and add members:**
```powershell
New-ADGroup -Name "Finance-ReadOnly" `
            -GroupScope Global `
            -GroupCategory Security `
            -Path "OU=Groups,DC=corp,DC=example,DC=com"

Add-ADGroupMember -Identity "Finance-ReadOnly" -Members "jsmith","bwilliams"
```

**Query AD for all disabled accounts:**
```powershell
Search-ADAccount -AccountDisabled -UsersOnly | 
    Select-Object Name, SamAccountName, LastLogonDate | 
    Sort-Object LastLogonDate
```

**Find accounts with passwords that never expire (security risk):**
```powershell
Get-ADUser -Filter {PasswordNeverExpires -eq $true -and Enabled -eq $true} `
           -Properties PasswordNeverExpires, LastLogonDate |
           Select-Object Name, SamAccountName, LastLogonDate
```

**Force replication between DCs:**
```powershell
# Using repadmin
repadmin /syncall /AdeP

# Check replication status
repadmin /replsummary
```

**LDAP query using ldapsearch (Linux/Kali):**
```bash
ldapsearch -x -H ldap://dc01.corp.example.com \
           -D "jsmith@corp.example.com" \
           -w 'P@ssw0rd123!' \
           -b "DC=corp,DC=example,DC=com" \
           "(objectClass=user)" cn sAMAccountName mail
```

### Group Policy Application Order

GPOs are processed in a specific order, remembered by the acronym **LSDOU**:
```
1. Local Policy       (applied first, lowest precedence)
2. Site Policy
3. Domain Policy
4. Organizational Unit Policy (applied last, highest precedence)
   - Child OU GPOs override parent OU GPOs
```

Later-applied GPOs win in case of conflict. The `gpresult` command shows the **Resultant Set of Policy (RSoP)**:

```powershell
# Show applied GPOs for current user and computer
gpresult /R

# Generate HTML report
gpresult /H C:\GPReport.html /F

# Force immediate Group Policy refresh
gpupdate /force
```

---

## Key Concepts

- **Domain Controller (DC)**: A Windows Server running the AD DS (Active Directory Domain Services) role. Hosts the Kerberos KDC, LDAP directory, and DNS services. Every domain should have at least two DCs for redundancy. The first DC installed in a forest holds all five FSMO roles initially.

- **FSMO Roles (Flexible Single Master Operations)**: Five special roles where only one DC at a time can perform certain critical operations. The **Schema Master** controls schema changes; the **PDC Emulator** handles password changes, time synchronization (critical for Kerberos), and legacy authentication; the **RID Master** allocates pools of Relative Identifiers used to create SIDs; the **Infrastructure Master** updates cross-domain object references; and the **Domain Naming Master** manages forest-wide domain additions/removals.

- **Group Policy Object (GPO)**: A collection of settings that can be linked to a site, domain, or OU to enforce configuration across users and computers. GPOs consist of **Computer Configuration** (applied at boot) and **User Configuration** (applied at logon). They are stored in the `SYSVOL` share on every DC and replicated via **DFSR** (Distributed File System Replication).

- **Security Identifier (SID)**: A unique identifier assigned to every AD security principal (user, group, computer). The SID never changes even if the account is renamed. It takes the format `S-1-5-21-<domain-identifier>-<RID>`. The **RID 500** always identifies the built-in Administrator account; **RID 512** identifies Domain Admins.

- **Privileged Groups**: Several built-in groups carry extraordinary permissions. **Domain Admins** have full control over all objects in the domain. **Enterprise Admins** (forest-wide) can make changes affecting the entire forest. **Schema Admins** can modify the AD schema. **Account Operators** can create/modify non-privileged accounts. Membership in these groups should be tightly controlled and regularly audited.

- **Trusts**: Relationships between domains or forests that allow authentication to cross boundaries. An automatic **two-way transitive trust** exists between all domains in a forest. **External trusts** (to other domains) and **forest trusts** are one-way or two-way, transitive or non-transitive, and must be manually created by administrators.

- **Global Catalog (GC)**: A DC that stores a partial replica of all objects in the entire forest (not just its own domain). Used to resolve User Principal Names (UPNs) during logon and to search forest-wide. Listens on ports 3268 (LDAP) and 3269 (LDAPS).

---

## Exam Relevance

**Security+ SY0-701 Exam Tips:**

Active Directory concepts appear throughout multiple SY0-701 domains, particularly in **Domain 4.0 (Security Operations)** and **Domain 2.0 (Threats, Vulnerabilities, and Mitigations)**.

**Common question patterns:**

- **Least privilege with OU delegation**: Questions will present scenarios where you need to grant a technician the ability to reset passwords without making them a Domain Admin. The answer involves delegating control at the OU level, NOT adding them to privileged groups.

- **GPO vs. local policy**: Remember that domain policies override local policies. If a question asks why a local policy change is not taking effect, the answer is almost always that a domain GPO is overriding it.

- **Kerberos vs. NTLM**: The exam expects you to know Kerberos is the preferred protocol, uses tickets, and requires DNS. NTLM is challenge-response, weaker, and used as a fallback. A question describing ticket-based authentication refers to Kerberos.

- **Federation vs. synchronization**: **SAML/OAuth/OIDC federation** allows cloud apps to trust your AD without copying credentials. **Azure AD Connect sync** copies password hashes to the cloud. These are fundamentally different architectures with different risk profiles.

- **SID history attacks**: Know that when migrating accounts between domains, SID History can be abused to retain access to resources in the source domain — this is an attack vector, not just a migration feature.

**Gotchas:**
- OUs are **NOT** security boundaries — forests are. Don't confuse them.
- The **PDC Emulator** is the most important FSMO role for day-to-day operations (time sync, password replication, lockout processing).
- **LDAP uses port 389** (unencrypted), **LDAPS uses 636**. Binding with plain LDAP transmits credentials in cleartext — a common exam and real-world finding.
- `Domain Admins` membership grants full local admin on **all domain-joined computers** by default, not just on servers.

---

## Security Implications

Active Directory is the single highest-value target in most enterprise environments. Compromising AD means compromising everything connected to it. The attack surface is enormous and well-understood by adversaries.

**Key attack vectors:**

- **Pass-the-Hash (PtH)**: NTLM authentication can be abused by capturing and replaying NTLM hashes without cracking them. Tools like **Mimikatz** extract hashes from LSASS memory (`sekurlsa::logonpasswords`). Enabled by the weakness of NTLM's challenge-response design.

- **Pass-the-Ticket (PtT)**: Kerberos tickets (TGTs or service tickets) stolen from memory can be injected into a session to authenticate as another user. Mimikatz's `kerberos::ptt` command accomplishes this.

- **Golden Ticket Attack**: If an attacker compromises the **krbtgt** account password hash (achievable via DCSync or direct DC compromise), they can forge arbitrary TGTs for any user in the domain, including non-existent ones, with any group memberships, valid for up to 10 years. This persistence technique survives password resets of individual accounts.

- **Silver Ticket Attack**: Forging service tickets using the hash of a **service account** rather than krbtgt. More limited scope than Golden Tickets but harder to detect since they never touch the KDC after initial creation.

- **DCSync Attack**: Abusing the Directory Replication Service (DRS) protocol to request password hashes for any account, including krbtgt and Domain Admins, from a DC — without needing to be physically on the DC. Requires `DS-Replication-Get-Changes-All` rights, which Domain Admins and certain service accounts possess. Mimikatz: `lsadump::dcsync /domain:corp.example.com /user:krbtgt`

- **Kerberoasting**: Requesting service tickets for accounts with **Service Principal Names (SPNs)** set (service accounts). The ticket is encrypted with the service account's hash and can be brute-forced offline. Requires only a valid domain user account to execute.

- **AS-REP Roasting**: Targeting accounts with **"Do not require Kerberos pre-authentication"** enabled. An attacker can request an AS-REP without authentication and crack the encrypted portion offline.

- **BloodHound / SharpHound**: Tool used by attackers (and defenders) to map AD permissions and identify **attack paths** to Domain Admin through ACL abuse, group membership chains, and delegation rights. **CVE-2021-42278 / CVE-2021-42287 (noPac)** demonstrated how misconfigured machine account creation privileges could lead to domain compromise in one step.

**Notable incidents:**
- The **SolarWinds attack (2020)** leveraged Golden Tickets and AD forged authentication to move laterally across government networks after initial supply chain compromise.
- **Ryuk/Conti ransomware operators** routinely target AD as the pivot point for mass ransomware deployment — once they have Domain Admin, they can push ransomware via GPO to every machine simultaneously.

---

## Defensive Measures

**Tier Model / Privileged Access Workstations (PAW):**