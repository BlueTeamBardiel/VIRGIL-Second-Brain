# Data Synchronization

## What it is
Like two librarians updating their card catalogs after one acquires new books — both must end up with identical records or patrons get conflicting information. Data synchronization is the process of ensuring that two or more data stores maintain consistent, up-to-date copies of the same information across systems, locations, or time intervals.

## Why it matters
In Active Directory environments, domain controllers synchronize via a process called replication. Attackers exploit this with the **DCSync attack**, where a compromised account with replication privileges impersonates a domain controller and requests credential data — including NTLM password hashes — directly from legitimate DCs, enabling offline password cracking without ever touching LSASS memory.

## Key facts
- **DCSync** requires the *Replicating Directory Changes All* and *Replicating Directory Changes* permissions — monitoring who holds these rights is a critical detection control
- Synchronization gaps create **race conditions** — attackers can exploit the window between when a security policy is written and when it replicates to all nodes
- **LDAP replication traffic** (port 389/636) between domain controllers should be monitored and restricted to known DC IP addresses to detect rogue sync requests
- In cloud environments, improper sync configurations can expose sensitive data across regions or tenants — a misconfigured Azure AD Connect is a common attack surface
- **Eventual consistency** models (used in distributed databases like NoSQL) mean data may be stale momentarily — security decisions made on stale data (e.g., revoked tokens not yet synced) can be exploited

## Related concepts
[[Active Directory]] [[DCSync Attack]] [[Race Condition]] [[LDAP]] [[Credential Dumping]]