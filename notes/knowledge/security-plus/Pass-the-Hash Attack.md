# Pass-the-Hash Attack

## What it is
Imagine a bouncer who accepts a photocopy of your ID instead of the real thing — the hash *is* the credential, so stealing it is as good as stealing the password. Pass-the-Hash (PtH) is a lateral movement technique where an attacker captures a password hash from memory and replays it directly against authentication systems without ever cracking the underlying plaintext password.

## Why it matters
In the 2014 Sony Pictures breach, attackers used PtH techniques after gaining an initial foothold to move laterally across Windows systems, harvesting NTLM hashes from LSASS memory and authenticating to machine after machine. This is why Microsoft introduced Protected Users security group and Credential Guard — specifically to prevent hashes from being extractable from memory.

## Key facts
- **NTLM is the enabler**: PtH works because Windows NTLM authentication accepts the hash directly as proof of identity; Kerberos is generally resistant (though "Pass-the-Ticket" is the Kerberos equivalent)
- **Mimikatz** is the canonical tool used to dump NTLM hashes from the LSASS process in memory (`sekurlsa::logonpasswords`)
- **Privilege requirement**: Attackers typically need local administrator or SYSTEM rights to dump LSASS — meaning PtH is a post-exploitation, not initial-access, technique
- **Mitigations include**: Enabling Windows Defender Credential Guard, disabling NTLM where possible, implementing least privilege, and using Local Administrator Password Solution (LAPS) to prevent identical local admin hashes across machines
- **Detection signature**: Unusual lateral authentication events — specifically Event ID 4624 (Logon Type 3) with NTLM appearing from unexpected sources — are key indicators in SIEM monitoring

## Related concepts
[[NTLM Authentication]] [[Lateral Movement]] [[Mimikatz]] [[Credential Dumping]] [[Kerberos Pass-the-Ticket]]