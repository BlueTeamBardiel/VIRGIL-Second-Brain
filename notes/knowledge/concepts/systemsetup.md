# systemsetup

## What it is
Think of it as the master control panel for a macOS machine — the one only the building superintendent is supposed to touch. `systemsetup` is a macOS command-line utility that configures core system settings including remote login (SSH), remote Apple Events, time servers, startup disk, and sleep behavior, requiring root privileges to execute.

## Why it matters
Attackers with local privilege escalation on macOS can use `systemsetup -setremotelogin on` to silently enable SSH, creating a persistent backdoor that survives reboots without touching the GUI. This technique has appeared in macOS malware families and post-exploitation frameworks like Metasploit's macOS modules, making it a critical artifact to hunt in endpoint logs.

## Key facts
- Requires **root/sudo** to run; unprivileged execution returns an error, making successful invocations high-fidelity indicators of privilege escalation.
- `systemsetup -setremotelogin on` enables **SSH (port 22)** on the host — a one-liner remote access backdoor technique documented in MITRE ATT&CK under **T1021.004** (Remote Services: SSH).
- `systemsetup -setremoteappleevents on` enables **Remote Apple Events**, which can be abused for inter-process scripting across the network.
- All `systemsetup` commands are logged to **unified logging** (`log show`) and can be detected via EDR tools monitoring `systemsetup` process execution.
- Deprecated gradually in newer macOS versions (Ventura+), but still present; Apple is migrating these controls to `systemsettings` and MDM profiles — knowing both is exam-relevant for macOS environments.

## Related concepts
[[Remote Services (T1021)]] [[Privilege Escalation]] [[macOS Persistence]] [[SSH Backdoor]] [[Endpoint Detection and Response]]