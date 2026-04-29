# persistence

## What it is
Like a squatter who installs a hidden spare key so they can re-enter a house even after being evicted, persistence is a technique attackers use to maintain access to a compromised system across reboots, credential changes, and remediation attempts. Precisely: persistence encompasses any mechanism that allows malicious code or access to survive system restarts or user logoffs without requiring re-exploitation.

## Why it matters
The 2020 SolarWinds attack (SUNBURST) demonstrated persistence masterfully — the malware embedded itself as a trojanized DLL loaded during the legitimate Orion software update process, ensuring it re-executed every time the service restarted across thousands of enterprise networks. Defenders who only killed the running process without removing the DLL remained compromised indefinitely.

## Key facts
- **Common persistence locations on Windows:** Registry Run keys (`HKCU\Software\Microsoft\Windows\CurrentVersion\Run`), Scheduled Tasks, Services, and Startup folders
- **Linux persistence vectors** include cron jobs, `.bashrc`/`.bash_profile` modifications, systemd unit files, and SSH authorized_keys injection
- **MITRE ATT&CK Tactic TA0003** categorizes persistence with over 20 techniques and sub-techniques, making it a major exam topic
- **Living-off-the-land persistence** (e.g., using `schtasks.exe` or `reg.exe`) blends into normal system activity and evades signature-based detection
- Rootkits achieve **deep persistence** by modifying the bootloader or kernel, surviving even OS reinstalls if the firmware (UEFI) is compromised

## Related concepts
[[rootkit]] [[privilege escalation]] [[lateral movement]] [[scheduled tasks]] [[registry]]