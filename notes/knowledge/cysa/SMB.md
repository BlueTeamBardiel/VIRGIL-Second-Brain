# SMB — Server Message Block

## What it is

In **Dota 2**, the courier is how your team shares resources across the map. It runs from the fountain to your mid laner with a Bottle, to your offlaner with a Stick, to the carry's jungle stash with a TP scroll. Everyone uses it, it's always running, and when Roshan-pit ganks happen the courier is often the first thing the enemy snipes — because killing the supply line breaks the team. That's exactly what SMB is on a Windows network: the courier that ferries files, printer jobs, and IPC between every host in the domain. And just like the courier, it's the first thing attackers go after, because if you own SMB you own lateral movement.

**SMB (Server Message Block)** is the application-layer protocol Windows uses for file sharing, printer sharing, and named-pipe IPC between hosts. Modern SMB runs directly over TCP **445**. Legacy SMB used NetBIOS over TCP — ports **137/138/139** — and the presence of those ports outbound from a workstation is almost always either a misconfigured host or an attacker living off the land. SMB exists in three major versions: **SMBv1** (deprecated, vulnerable, should not exist on your network), **SMBv2** (Vista/2008), and **SMBv3** (Windows 8/2012+, supports encryption, signing, and pre-auth integrity).

## Why it matters

SMB is on the CySA+ blueprint under **Objective 1.3** because it shows up in nearly every Windows-environment intrusion. EternalBlue (MS17-010) ransacked SMBv1 in 2017 and powered **WannaCry** and **NotPetya** — billions in damages, hospitals offline, Maersk re-imaging 45,000 endpoints. PrintNightmare, PetitPotam, and SMBGhost (CVE-2020-0796) all rode SMB. Pass-the-hash, lateral movement via `admin$` and `ipc$` shares, and Cobalt Strike's `psexec` pivot — all SMB.

On the exam, expect SMB to appear in scenario questions about packet capture interpretation, suspicious port activity, lateral movement detection, and ransomware propagation. Knowing the ports cold (445 vs 139) and the version differences (which versions support encryption, which is exploitable) is table stakes.

## Key facts

### Ports and protocol stack

| Port | Protocol | Purpose | Disposition |
|------|----------|---------|-------------|
| 137/UDP | NetBIOS Name Service | Name resolution | Legacy, block at perimeter |
| 138/UDP | NetBIOS Datagram | Browse service | Legacy, block at perimeter |
| 139/TCP | NetBIOS Session | SMB over NetBIOS | SMBv1 era, block at perimeter |
| 445/TCP | SMB direct | Modern SMB transport | Internal only — **never** allow inbound from internet |

If you see 445 inbound from the public internet on a firewall log, that's a finding. If you see 445 outbound from a workstation to a non-domain external IP, that's a probable C2 or exfil channel.

### SMB versions and what they break

- **SMBv1 (CIFS)** — 1996 vintage. No pre-auth integrity, no encryption, vulnerable to EternalBlue and downgrade attacks. Microsoft disabled it by default starting Windows 10 1709. Finding SMBv1 enabled on a modern host is a [[vulnerability scan]] finding.
- **SMBv2** — Windows Vista/Server 2008. Signing optional. No encryption.
- **SMBv2.1** — Windows 7/Server 2008 R2. Adds opportunistic locking improvements.
- **SMBv3.0** — Windows 8/Server 2012. Adds **AES-CCM encryption**, secure dialect negotiation.
- **SMBv3.1.1** — Windows 10/Server 2016. Adds pre-auth integrity (SHA-512), AES-GCM, blocks downgrade attacks.

The version negotiation happens in the very first packets — `Negotiate Protocol Request` and `Negotiate Protocol Response`. In **Wireshark**, filter `smb2.cmd == 0` to see it.

### Common SMB-borne attacks

- **EternalBlue (MS17-010)** — SMBv1 buffer overflow in `srv.sys`. Remote code execution as SYSTEM. Patch is from March 2017. If you still have unpatched hosts, you have bigger problems than this note.
- **SMBGhost (CVE-2020-0796)** — SMBv3 compression bug. Pre-auth RCE on SMBv3.1.1.
- **Pass-the-hash via SMB** — attacker dumps NTLM hashes (Mimikatz, lsass dump), then authenticates to remote SMB shares using `pth-winexe` or `impacket-psexec`. No password required, just the hash.
- **NTLM relay / PetitPotam** — attacker coerces a target to authenticate to attacker-controlled SMB, then relays the NTLM challenge to AD CS or LDAP. Domain compromise from an unauth network position.
- **Ransomware lateral movement** — Ryuk, Conti, LockBit all enumerate SMB shares, copy themselves via `\\target\admin$`, and execute via remote service creation or WMI. SMB is the highway.

### Detection — what to look for

**Packet capture (Wireshark filters):**
- `smb || smb2` — all SMB traffic
- `smb2.cmd == 5` — Tree Connect requests (which shares are being touched)
- `smb2.cmd == 3` — Session Setup (authentication attempts)
- `smb2.filename contains "admin$"` — administrative share access (always suspicious from non-admin tooling)
- Look for one host hitting `\\*\admin$` or `\\*\ipc$` across many destinations in minutes — classic lateral movement fan-out

**Log sources:**
- **Windows Event ID 5140** — network share accessed
- **Event ID 5145** — detailed file share access (off by default, expensive, but gold for IR)
- **Event ID 4624 logon type 3** — network logon, the SMB authentication footprint
- **Event ID 4672** — special privileges assigned (when an admin equivalent hits the share)

**SIEM correlation rules worth writing:**
- One source IP authenticating to `admin$` or `c$` on **N>5 destinations** within 10 minutes → lateral movement candidate
- SMB traffic from a workstation to a workstation (peer-to-peer) during business hours when policy forbids it → policy violation or compromise
- SMBv1 dialect negotiation observed anywhere → either legacy app discovery or attacker downgrade attempt

### Hardening checklist

1. **Disable SMBv1 everywhere.** `Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol` via [[PowerShell]], or push via GPO.
2. **Require SMB signing** on all hosts — blocks NTLM relay. GPO: `Microsoft network server: Digitally sign communications (always) = Enabled`.
3. **Enable SMB encryption** on sensitive shares (`Set-SmbShare -Name Finance -EncryptData $true`).
4. **Block 445 and 139 at the perimeter** — both directions. If a cloud service needs SMB, use Azure Files with private endpoint, not public 445.
5. **Network segmentation** — workstations should not need to talk SMB to other workstations. Host-based firewall rule: deny inbound 445 except from server VLANs and admin jump hosts.
6. **LAPS** — randomize local admin passwords. Even if an attacker dumps a hash, it doesn't work on the next box.
7. **Credential Guard** on Windows 10/11 Enterprise — protects LSASS, defeats pass-the-hash dumps.

### CompTIA exam traps

> **CompTIA exam trap:** SMB ports. CompTIA loves to ask which port modern SMB uses. The answer is **445/TCP**, not 139. Port 139 is NetBIOS Session Service used by **legacy** SMB. If the question mentions "Windows file sharing" without qualifying legacy, the answer is 445.

> **CompTIA exam trap:** SMB vs CIFS vs Samba. **CIFS** is the old Microsoft name for SMBv1 — a specific dialect, not a separate protocol. **Samba** is the open-source Linux implementation of SMB. If a Linux host is exposing 445, it's running Samba. They're all the same wire protocol family.

> **CompTIA exam trap:** Lateral movement indicators. A single Event ID 4624 logon type 3 is benign — that's any network logon. The indicator is the **pattern**: one account hitting many hosts on type 3 in a short window, especially against `admin$` or `ipc$`. CompTIA will offer "4624 detected" as a distractor; the right answer is the correlation pattern, not the single event.

> **CompTIA exam trap:** EternalBlue is **SMBv1 only**. SMBGhost is **SMBv3.1.1 only**. Don't mix them. If the scenario says "SMBv1 disabled but the host was compromised via SMB," EternalBlue is the wrong answer — look at SMBGhost or NTLM relay.

### Tools you'll actually use

- **[[Wireshark]]** — packet capture and dialect inspection. Filter `smb2` and walk the conversation.
- **[[Nmap]]** — `nmap --script smb-protocols,smb-security-mode,smb-vuln-* -p445 <target>` enumerates dialect, signing, and known CVEs.
- **smbclient / smbmap** — list shares, check anonymous access. `smbmap -H <ip> -u guest -p ''` finds null sessions.
- **Impacket suite** — `psexec.py`, `wmiexec.py`, `secretsdump.py`. Red team's bread and butter, blue team needs to recognize the artifacts.
- **Sysmon Event ID 3** — network connection. Filter for destination port 445 from unexpected processes (anything not `System` PID 4 on a workstation is suspicious).

## SOC reality

- The 3am alert: SIEM correlation rule fires — `svc_backup` account just authenticated to `admin$` on 14 hosts in 8 minutes. Service accounts don't fan out like that. L1 acknowledges, pulls the source host, checks if the account password rotated recently or if this is the start of something bad.
- IR lead's first three questions: **scope** (how many hosts touched?), **credentials** (whose hash or password is the attacker holding?), and **evidence** (do we have packet capture and Event ID 5140 logs preserved before we start isolating?).
- Containment call you'll make: block 445 between workstation VLANs at the switch, disable the compromised account, force kerberos ticket purge across the domain. Do **not** reboot the source host until LSASS memory is captured — you lose the live evidence.
- What never to promise leadership: "SMB is contained." SMB authentication can ride cached Kerberos tickets for 10 hours. Until tickets expire and accounts are disabled at the KDC, the attacker may still pivot. Tell leadership "we have stopped new authentications and are working through ticket lifetime now."
- The handoff: L1 confirms the pattern → L2 pulls packet capture and Sysmon logs → IR team scopes accounts and hosts → identity team disables and resets → forensics images source host → post-incident produces the GPO change that should have been in place six months ago.

## Related concepts

[[Lateral movement]] · [[Pass-the-hash]] · [[NTLM relay]] · [[EternalBlue]] · [[Wireshark]] · [[Sysmon]] · [[Event ID 4624]] · [[Network segmentation]] · [[Credential Guard]] · [[LAPS]] · [[Cobalt Strike]] · [[Ransomware propagation]] · [[Kerberos]] · [[MITRE ATT&CK T1021.002]]

*Source: VIRGIL knowledge base — 2026-05-11*