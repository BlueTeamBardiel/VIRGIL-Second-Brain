# SID

## What it is
Like a Social Security Number that never changes even if you legally change your name, a Security Identifier (SID) is a unique, immutable value Windows assigns to every user, group, and computer account. Even if you rename or delete and recreate an account, the SID changes — it is the true identity Windows uses for all access control decisions, not the username.

## Why it matters
Attackers exploit SID history in Active Directory migrations to escalate privileges: when an account is migrated between domains, the old SID can be added to the `SIDHistory` attribute, and Windows will grant that account the permissions of the *original* SID. An attacker who compromises a low-privilege migrated account with a Domain Admin SID in its history silently inherits admin access — a technique called SID History injection.

## Key facts
- SIDs follow the format `S-1-5-21-<domain>-<RID>`, where the Relative Identifier (RID) at the end distinguishes accounts (e.g., RID 500 = built-in Administrator, RID 501 = Guest)
- Well-known SIDs are universal: `S-1-1-0` always means "Everyone," regardless of the domain or OS installation
- Windows access tokens carry the user's SID and all group SIDs — ACLs on objects compare these tokens, not usernames
- Deleting and recreating an account with the same username generates a *new* SID, breaking all previous ACL-based permissions
- SID filtering (also called domain quarantine) is a defense that strips foreign SIDs from authentication tokens during cross-domain access, blocking SID History attacks

## Related concepts
[[Access Control List (ACL)]] [[Active Directory]] [[Privilege Escalation]] [[Access Token]] [[Kerberos]]