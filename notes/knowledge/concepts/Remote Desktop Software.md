# Remote Desktop Software

## What it is
Like handing someone a live feed of your steering wheel, pedals, and dashboard — they can drive your car from their living room. Remote desktop software transmits screen output and accepts keyboard/mouse input over a network, allowing full graphical control of a system from a remote location. Common implementations include RDP (port 3389), VNC, and commercial tools like TeamViewer or AnyDesk.

## Why it matters
In the 2021 Colonial Pipeline attack aftermath, investigators found RDP exposed directly to the internet was a primary entry vector used in the broader ransomware campaign ecosystem. Attackers routinely scan for open port 3389, brute-force credentials, and drop ransomware or establish persistent footholds — making exposed RDP one of the most consistently exploited attack surfaces in enterprise environments.

## Key facts
- **RDP runs on TCP/UDP port 3389** by default; changing this port provides minimal security through obscurity but is not a real control
- **BlueKeep (CVE-2019-0708)** is a critical wormable RDP vulnerability in Windows systems prior to Windows 8 that allows unauthenticated remote code execution
- **Credential stuffing and brute-force attacks** against RDP are mitigated by enabling Network Level Authentication (NLA), which requires authentication before a full session is established
- **RDP session hijacking** can occur when an attacker with SYSTEM privileges takes over disconnected sessions without needing the user's credentials
- Legitimate remote desktop tools (TeamViewer, AnyDesk) are frequently abused as **living-off-the-land** persistence mechanisms because they blend into normal traffic and are whitelisted by many firewalls

## Related concepts
[[Brute Force Attacks]] [[Network Level Authentication]] [[Lateral Movement]] [[VPN]] [[Credential Stuffing]]