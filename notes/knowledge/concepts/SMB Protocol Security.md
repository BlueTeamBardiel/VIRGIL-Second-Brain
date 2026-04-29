# SMB Protocol Security

## What it is
Think of SMB like a file-sharing librarian inside a corporate building — it hands out documents, printers, and named pipes to anyone who asks politely enough. Server Message Block (SMB) is a network file-sharing protocol that allows clients to read, write, and request services from servers across a LAN. It operates over TCP port 445 and has evolved through versions SMB1, SMB2, and SMB3, each with dramatically different security postures.

## Why it matters
In 2017, the EternalBlue exploit weaponized a critical SMB1 vulnerability (MS17-010), allowing WannaCry ransomware to spread autonomously across networks without any user interaction — a true worm. Organizations that had disabled SMB1 or applied Microsoft's patch were immune, making this a defining case study in legacy protocol risk and patch management urgency.

## Key facts
- **SMB1 is dangerously obsolete** — it lacks encryption, mutual authentication, and is vulnerable to EternalBlue; Microsoft disabled it by default starting with Windows Server 2016
- **SMB Signing** prevents man-in-the-middle relay attacks (NTLM relay) by cryptographically validating packet integrity; required by default on Domain Controllers but not workstations
- **SMB3 introduced end-to-end encryption** (AES-128-CCM), protecting data in transit even on untrusted networks
- **Port 445 should never be exposed to the internet** — firewall rules blocking external SMB access are a baseline hardening requirement
- **Pass-the-Hash and NTLM relay attacks** frequently abuse SMB authentication weaknesses to move laterally without cracking credentials

## Related concepts
[[NTLM Authentication]] [[Lateral Movement]] [[EternalBlue Exploit]] [[Network Segmentation]] [[Patch Management]]