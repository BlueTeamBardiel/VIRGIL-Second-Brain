# Remote Desktop Protocol

## What it is
Like a remote-control toy car where you hold the controller but the car does the moving, RDP lets you see and operate a Windows machine from across the network as if you were sitting in front of it. Technically, it is Microsoft's proprietary protocol (port 3389/TCP) that transmits keyboard input, mouse movements, and display output between a client and a remote Windows host using an encrypted channel.

## Why it matters
In 2021, RDP exposure was the single largest attack vector for ransomware deployment — attackers would scan the internet for port 3389, brute-force weak credentials, gain a session, and then manually detonate ransomware across the network. Defenders counter this by placing RDP behind a VPN, enforcing Network Level Authentication (NLA), and monitoring for anomalous login times or source IPs.

## Key facts
- RDP operates on **TCP port 3389** by default; changing this port offers minimal security (security through obscurity)
- **Network Level Authentication (NLA)** forces credential verification *before* a full RDP session is established, reducing exposure to unauthenticated exploits like BlueKeep (CVE-2019-0708)
- **BlueKeep** was a critical wormable RDP vulnerability affecting older Windows systems that allowed unauthenticated remote code execution — a textbook Security+ example of a pre-auth RCE flaw
- RDP sessions can be **pass-the-hash** targets: attackers with stolen NTLM hashes can authenticate without knowing the plaintext password using tools like Mimikatz
- Legitimate RDP traffic can mask **lateral movement**; security teams look for RDP connections originating from non-admin workstations or unusual hours in SIEM alerts

## Related concepts
[[Network Level Authentication]] [[BlueKeep CVE-2019-0708]] [[Pass-the-Hash Attack]] [[Lateral Movement]] [[VPN]]