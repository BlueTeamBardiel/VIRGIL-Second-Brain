# Active Directory Domain Services Overview

Active Directory Domain Services (AD DS) is a directory service that stores information about network objects and provides methods for administrators and users to access this data. It enables centralized management of user accounts, resources, and network policies through a single username and password.

## What Is It? (Feynman Version)
Imagine a city’s central post office that keeps a master list of every resident, every address, and every package type. AD DS is that post office for a Windows network: it holds a catalog of every user, computer, printer, and shared file, and it tells anyone who asks where each one is and what they can do.

## Why Does It Exist?
Before AD DS, each workstation logged in with its own local user file. If a developer moved to a new machine, the engineer had to recreate their account on that machine and copy over passwords, secrets, and permissions. In a large company, this led to dozens of broken logins, orphaned credentials, and security gaps that attackers could exploit. AD DS solved this by centralizing authentication and authorization, so one change—like a password reset—propagates to every resource instantly.

## How It Works (Under The Hood)
1. **Directory Data Store** – AD uses a database (NTDS.dit) that is a B‑tree of entries. Each entry is an object (user, computer, group) with attributes (name, SID, password hash).
2. **Schema** – A blueprint that says what attributes each object type can have, and what data types they hold. Think of it as a legal code that guarantees every object follows the same rules.
3. **Global Catalog** – A partial replica on every domain controller that holds the most essential attributes for all objects in the forest. It speeds up logon and searches across domains.
4. **LDAP** – Lightweight Directory Access Protocol is the language AD speaks to clients. When a user types a username, the client sends an LDAP bind request to a domain controller; the controller verifies the password hash and returns the user's SID.
5. **Kerberos** – Once the user is authenticated, Kerberos issues a Ticket‑Granting Ticket (TGT). This ticket proves the user’s identity to other services without re‑sending the password.
6. **Replication** – The Replication Service runs the Multi‑Master Replication protocol (MS‑RDP). It compares changes, resolves conflicts, and pushes updates to all domain controllers within a domain and across the forest.
7. **Group Policy** – Objects in the directory have Group Policy Objects (GPOs) attached. When a computer boots, it queries the GPOs applied to its OU and downloads the configuration.

## What Breaks When It Goes Wrong?
- **Authentication Failure** – If replication is broken, one controller might have an old password hash; users can’t log in on other machines. That stops developers from building, testers from testing, and operations from monitoring.
- **Loss of Global Catalog** – Without the GC, domain joins, OU searches, and fast authentication collapse. Everyone notices a slowdown, and the domain controller that holds the GC may be overwhelmed with traffic.
- **Replication Lag or Conflicts** – A slow network or misconfigured site link can cause stale passwords, misassigned group membership, or broken file shares. The blast radius can reach every user in the domain, causing downtime and data loss.
- **Misconfigured Schema** – Adding an object type without proper attribute definitions can corrupt the database, leading to crashes of domain controllers and a cascading outage.

## Lab Relevance
| What to Do | Why It Matters | Watch Out For |
|------------|----------------|---------------|
| **Spin up a Virtual DC** | `New-ADDSDomainController` or `dcpromo` (older Server) installs AD DS in a VM. | Verify that the DC is reachable via DNS and LDAP. |
| **Create Users and Groups** | `New-ADUser`, `New-ADGroup`, `Add-ADGroupMember` demonstrate account creation and membership. | Password policies and SID filtering must be checked. |
| **Configure Replication** | `repadmin /showrepl` shows replication status; `repadmin /syncall` forces sync. | Look for replication errors (e.g., `0x80070005` – Access denied). |
| **Test Group Policy** | Apply a simple GPO that disables a local admin account. | Verify policy applied with `gpresult /r`. |
| **Simulate a DC Failure** | Shut down a DC, observe how other DCs handle authentication. | Watch for authentication delays and fallback to GC. |
| **Audit with `ldp.exe`** | Manually bind to the directory to see raw LDAP traffic. | Use filters to spot anomalies or misconfigured attributes. |

These exercises mirror real‑world scenarios: deploying a new DC, troubleshooting replication lag, or applying a security hardening policy. By walking through them, you see how AD DS turns a chaotic set of local accounts into a coherent, centrally managed identity ecosystem.

---

**Supported Versions**

Applies to: Windows Server 2025, Windows Server 2022, Windows Server 2019, Windows Server 2016

**Tags**

#ad-ds #active-directory #identity #directory-services #windows-server

_Ingested: 2026-04-15 20:20 | Source: https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview_

<!-- preserved: [[Active Directory Replication Concepts]] -->
<!-- preserved: [[Active Directory Schema]] -->
<!-- preserved: [[Active Directory Search and Publication Technologies]] -->
<!-- preserved: [[Active Directory Structure and Storage Technologies]] -->
<!-- preserved: [[DNS Group Policy Settings]] -->
<!-- preserved: [[Domain Controller Roles]] -->
<!-- preserved: [[Trust Management]] -->