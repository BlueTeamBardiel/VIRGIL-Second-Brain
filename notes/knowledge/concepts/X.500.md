# X.500

## What it is
Think of it as a global phone book standard — a hierarchical naming system where every person, organization, or device gets a unique address in a tree-shaped directory. X.500 is an ITU/ISO standard defining a distributed directory service model, using a hierarchical namespace called the Directory Information Tree (DIT) to store and retrieve information about network objects.

## Why it matters
X.500's naming conventions are the direct ancestor of LDAP and Active Directory, meaning attackers who understand Distinguished Names (DNs) like `CN=John,OU=Finance,DC=corp,DC=com` can craft precise LDAP injection attacks or enumerate directory structure to map an organization's internal hierarchy. During a red team engagement, querying an exposed LDAP service with X.500-style filters can reveal usernames, group memberships, and email addresses — all without authentication if anonymous bind is enabled.

## Key facts
- X.500 uses **Distinguished Names (DNs)** built from components: CN (Common Name), OU (Organizational Unit), O (Organization), DC (Domain Component), C (Country)
- The actual protocol defined by X.500 for querying directories is **DAP (Directory Access Protocol)** — LDAP was created as a lightweight TCP/IP alternative to DAP
- X.500 is the foundation for **Public Key Infrastructure (PKI)** certificate subject fields — the "Subject" in an X.509 certificate uses X.500 DN format
- The standard defines the **Directory System Agent (DSA)** (server) and **Directory User Agent (DUA)** (client) as the two communicating roles
- X.500 directories are **read-heavy by design** — optimized for lookups, not frequent writes, which is why LDAP inherited the same assumption

## Related concepts
[[LDAP]] [[Active Directory]] [[X.509 Certificates]] [[PKI]] [[LDAP Injection]]