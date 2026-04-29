# Sysprep

## What it is
Like a factory resetting a phone before boxing it for sale — stripping out the previous owner's fingerprints — Sysprep (System Preparation Tool) generalizes a Windows installation by removing machine-specific data so the same image can be deployed to multiple systems. It strips the Security Identifier (SID), removes hardware-specific drivers, and resets Windows Activation, producing a clean "gold image" ready for mass deployment.

## Why it matters
Attackers target poorly managed Sysprep workflows because organizations sometimes leave unattended answer files (`unattend.xml`) on disk after imaging — these XML files can contain plaintext or Base64-encoded administrator credentials. A penetration tester on an internal engagement might find `C:\Windows\Panther\unattend.xml` sitting readable by low-privileged users, instantly yielding domain-level credentials and full compromise.

## Key facts
- Sysprep answer files (`unattend.xml`, `autounattend.xml`) are a well-known credential exposure vector; common locations include `C:\Windows\Panther\`, `C:\Windows\System32\Sysprep\`, and `C:\Windows\Setup\Scripts\`
- After Sysprep, the machine SID is regenerated on first boot — critical because duplicate SIDs in a domain can cause authentication and access control issues
- Sysprep must be run before capturing a Windows image with tools like MDT, SCCM/MECM, or WDS to ensure each deployed machine gets a unique identity
- Windows limits Sysprep generalization to a maximum of **3 times** on the same installation before requiring a fresh OS install
- Metasploit includes the module `post/windows/gather/credentials/unattend` specifically to hunt for credentials left in Sysprep answer files post-exploitation

## Related concepts
[[Credential Exposure]] [[Windows Imaging and Deployment]] [[Privilege Escalation]] [[Unattended Installation Files]] [[SID (Security Identifier)]]