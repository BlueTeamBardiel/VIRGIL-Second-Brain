# SYSTEM

## What it is
Think of SYSTEM as the skeleton key that opens every door in a building — not issued to any employee, but held by the building itself. In Windows environments, SYSTEM is the highest-privilege local account, more powerful than any Administrator, used by the operating system kernel and core services to perform privileged operations. It has no password, cannot be logged into directly, and operates entirely within the OS process space.

## Why it matters
Privilege escalation attacks frequently target SYSTEM-level access because owning it means owning the machine completely. A classic example is exploiting an unpatched Windows Print Spooler vulnerability (PrintNightmare, CVE-2021-1675), which allowed low-privilege users to execute code as SYSTEM by abusing a service that runs under that account — enabling full domain compromise in Active Directory environments.

## Key facts
- SYSTEM (NT AUTHORITY\SYSTEM) outranks local Administrator accounts; it can read SAM database entries and interact with hardware-level resources that Admins cannot
- Services configured with SYSTEM privileges are high-value attack targets — a vulnerable service running as SYSTEM hands attackers the keys to the entire host
- Malware achieving SYSTEM access can disable security tools, dump credentials via LSASS, and move laterally across networks
- Unlike user accounts, SYSTEM has no interactive logon session by default — attackers must use techniques like token impersonation to leverage it
- On Security+/CySA+ exams, SYSTEM-level compromise signals the final stage of local privilege escalation before lateral movement or persistence

## Related concepts
[[Privilege Escalation]] [[Access Control]] [[Token Impersonation]] [[LSASS]] [[Windows Security Architecture]]