# Group Policy Preferences Abuse

## What it is
Imagine an IT admin leaving a master key under the doormat for every machine in the building, then publishing the doormat's location in a shared directory — that's essentially what GPP credential storage did. Group Policy Preferences (GPP) allowed admins to push local account passwords across a domain by embedding AES-256 encrypted credentials in SYSVOL XML files, but Microsoft published the decryption key publicly, making the encryption meaningless.

## Why it matters
During a penetration test against a legacy Windows domain, an attacker with any authenticated domain account can read SYSVOL (world-readable by design), locate `Groups.xml` or similar GPP files, and use tools like `Get-GPPPassword` or Metasploit's `smb_enum_gpp` to instantly decrypt embedded credentials. These credentials often belong to local Administrator accounts, enabling lateral movement across every machine where that policy was applied — a single file becomes a skeleton key.

## Key facts
- The AES-256 key Microsoft published (KB2962486) is the same for every Windows environment, making all GPP-stored passwords trivially decryptable
- Affected XML files include: `Groups.xml`, `Services.xml`, `Scheduledtasks.xml`, `DataSources.xml`, and `Printers.xml`
- Microsoft patched this in MS14-025 (May 2014), which removed the ability to set new passwords via GPP — but existing files in SYSVOL were **not** cleaned up automatically
- The encrypted password field in XML is labeled `cpassword`; its presence is the red flag
- Defenders should audit SYSVOL for `cpassword` strings using PowerShell or BloodHound to find residual exposure in patched environments

## Related concepts
[[SYSVOL Enumeration]] [[Active Directory Privilege Escalation]] [[Lateral Movement]] [[Credential Harvesting]] [[Pass-the-Hash]]