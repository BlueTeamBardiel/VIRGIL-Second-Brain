# ATT&CK T1078

## What it is
Imagine a burglar who finds a spare key to a house—they can now enter any time, no matter who the homeowner is.  
T1078 – Valid Accounts – is the ATT&CK technique that describes adversaries using legitimate user credentials (local, domain, or cloud) to access systems, providing the same level of entry as a legitimate user.

## Why it matters
In the 2019 ransomware incident at a major university, attackers harvested domain admin credentials via phishing, then leveraged those accounts to move laterally and deploy ransomware across campus networks. Defenders that monitor unusual logins to high‑privilege accounts were able to stop the spread before critical systems were encrypted.

## Key facts
- **Scope**: Covers local, domain, and cloud accounts, each with its own sub‑technique (T1078.001, T1078.002, T1078.003).  
- **Persistence**: Valid accounts are a common persistence vector because they survive OS reboots and many security controls.  
- **Detection**: Look for anomalous logon times, geolocations, or user‑agent strings, especially on privileged accounts.  
- **Defense**: Multi‑factor authentication (MFA) and least‑privilege principles drastically reduce the risk.  
- **Mitigation**: Regularly rotate passwords, monitor for credential dumping tools