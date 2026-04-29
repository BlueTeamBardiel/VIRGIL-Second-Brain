# Global Catalog

## What it is
Think of it as the "airport departures board" for an entire Active Directory forest — instead of showing full flight details, it shows a condensed summary of every object across all domains so you can quickly find what you need without querying each terminal individually. Technically, the Global Catalog (GC) is a partial-attribute replica of all objects in an Active Directory forest, hosted on designated Domain Controllers called Global Catalog servers. It enables cross-domain authentication and object searches without requiring referrals to every domain's full directory.

## Why it matters
During Active Directory reconnaissance, attackers frequently query the Global Catalog (default port **3268/TCP**) using LDAP enumeration tools like BloodHound or ldapsearch to rapidly harvest user accounts, group memberships, and SPNs across the *entire forest* in a single query — far more efficient than hitting each domain controller individually. Defenders should monitor for anomalous LDAP queries against port 3268, particularly bulk enumeration patterns, as an early indicator of credential-access or lateral-movement staging.

## Key facts
- Global Catalog servers listen on **port 3268** (LDAP) and **port 3269** (LDAPS — encrypted)
- GC holds a *partial* attribute set for all objects in the forest, but a *full* attribute set for objects in its own domain
- Required for Universal Group membership resolution during user logon — if no GC is reachable, logon can fail (except for domain admins)
- The first Domain Controller in a forest is automatically assigned the GC role; additional GC servers are manually designated
- Kerberoasting reconnaissance often targets the GC to enumerate Service Principal Names (SPNs) across all forest domains efficiently

## Related concepts
[[Active Directory]] [[LDAP]] [[Kerberoasting]] [[BloodHound]] [[Domain Controller]]