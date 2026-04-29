# Windows Defender Application Control

## What it is
Think of it as a bouncer with a strict VIP list — only pre-approved executables get past the door, and everything else is turned away regardless of how convincing it looks. WDAC is a Windows kernel-level policy engine that enforces which applications, drivers, and scripts are permitted to run on a system. Unlike antivirus, it doesn't scan for malware signatures — it simply blocks anything not explicitly trusted.

## Why it matters
In the 2020 SolarWinds supply chain attack, attackers executed malicious code through trusted software update mechanisms — a signed, legitimate-looking binary. A properly configured WDAC policy using strict signer rules or hash-based allowlisting could have prevented the malicious payload from executing even if the signing certificate appeared valid, because the specific binary hash wouldn't have matched the allowlist.

## Key facts
- WDAC operates at the **kernel level** (enforced by Windows itself, not a user-mode agent), making it significantly harder to bypass than AppLocker, which runs as a service
- Policies are defined in **XML files** and can be deployed via Group Policy, MDM (Intune), or SCCM
- Supports **multiple policy modes**: Audit Mode (log only, no blocking) and Enforced Mode (active blocking) — useful for staged rollouts
- Can restrict based on **file hash, publisher certificate, file path, or a combination** — publisher + version range is the most maintainable approach at scale
- WDAC is the **Microsoft-recommended replacement for AppLocker** for new deployments on Windows 10/11 and Server 2016+; both can coexist but WDAC takes precedence when both policies apply

## Related concepts
[[AppLocker]] [[Application Whitelisting]] [[Least Privilege]] [[Code Signing]] [[Attack Surface Reduction]]