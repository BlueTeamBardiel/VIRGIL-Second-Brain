# Mandatory Integrity Control

## What it is
Think of it like a building with colored security badges — even if you have a master key (admin rights), guards still block you from entering rooms above your clearance color. Mandatory Integrity Control (MIC) is a Windows security mechanism introduced in Vista that assigns integrity levels to processes and objects, enforcing that lower-integrity processes cannot write to or tamper with higher-integrity ones. It operates *below* discretionary access controls (DACLs), meaning it applies regardless of explicit permissions granted.

## Why it matters
MIC is the core reason a compromised browser process (running at Low integrity) cannot silently modify Windows system files or inject code into a privileged application running at High integrity — a protection that directly limits drive-by download attacks. When malware exploits a browser vulnerability, MIC containment forces attackers to perform a *privilege escalation* step before causing broader system damage, giving defenders a detection opportunity.

## Key facts
- Windows defines four primary integrity levels: **Low, Medium, High, and System** — standard users run at Medium, elevated processes at High, SYSTEM services at System
- Internet Explorer's **Protected Mode** and Microsoft Edge's sandbox use Low integrity to isolate the renderer process from the filesystem
- MIC is enforced via **integrity level SIDs** embedded in process and object security descriptors, not traditional ACLs
- The **No-Write-Up policy** is the default rule: lower integrity processes cannot write to higher integrity objects even if DACL permits it
- UAC (User Account Control) works *with* MIC — clicking "Run as Administrator" elevates a process from Medium to High integrity level

## Related concepts
[[User Account Control (UAC)]] [[Least Privilege]] [[Process Isolation]] [[Windows Access Control]] [[Privilege Escalation]]