# Active Directory Schema

## What it is
Think of it like the master blueprint at a city planning office — before any building (object) can exist, its type must first be defined in the blueprint (schema). The Active Directory Schema is the formal definition of every object class (like users, computers, groups) and every attribute (like `samAccountName`, `userPrincipalName`) that can exist within an AD forest. It lives in a dedicated partition replicated to every domain controller and is enforced forest-wide.

## Why it matters
One of the most dangerous AD attacks — **BloodHound-assisted privilege escalation via schema abuse** — targets writable schema attributes. More critically, attackers with **Schema Admin** privileges can add attributes to privileged object classes, enabling persistent backdoors that survive password resets and even domain controller rebuilds. Defenders monitor schema modification events (Event ID 5137) because legitimate schema changes are extremely rare and almost always warrant investigation.

## Key facts
- The Schema is stored in the `CN=Schema,CN=Configuration` naming context, replicated to **all DCs** in the forest — changes are irreversible without a full forest recovery
- Only members of the **Schema Admins** group can modify the schema; this group should be empty when not actively in use
- Each object class is defined by a unique **OID (Object Identifier)** — Microsoft and third parties (e.g., Exchange) extend the schema during product installation
- Schema version can be queried via the `objectVersion` attribute on the schema naming context — useful for auditing and detecting unauthorized extensions
- The **Schema Master** is the single FSMO role holder that processes all schema write operations; if compromised, an attacker can poison the entire forest's object model

## Related concepts
[[Active Directory FSMO Roles]] [[Privileged Access Management]] [[LDAP]] [[BloodHound]] [[Windows Event Auditing]]