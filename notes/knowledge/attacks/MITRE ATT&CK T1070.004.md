# MITRE ATT&CK T1070.004

## What it is
Like a burglar wiping fingerprints off every surface before leaving the house, T1070.004 (File Deletion) describes adversaries removing files from a compromised system to erase evidence of their intrusion. Specifically, attackers delete malware payloads, staged tools, logs, or temporary files after execution to hinder forensic investigation and incident response.

## Why it matters
During the SolarWinds supply chain attack, threat actors (APT29/Cozy Bear) deleted temporary files and cleaned up staging directories after deploying SUNBURST, making post-compromise artifact recovery significantly harder for investigators. Defenders counter this by enabling Volume Shadow Copies, shipping logs to remote SIEMs in real time, and using endpoint detection tools that capture file deletion events before the data is overwritten.

## Key facts
- **Secure deletion vs. standard deletion**: Standard OS deletion only removes directory entries; tools like `sdelete` (Windows) or `shred` (Linux) overwrite file contents, making forensic recovery far more difficult.
- **Common attacker tools**: `cipher /w` (Windows), `rm -rf` (Linux/macOS), and built-in PowerShell commands (`Remove-Item`) are frequently observed in the wild.
- **Timestomping often pairs with this**: Attackers combine file deletion (T1070.004) with timestomping (T1070.006) to maximize anti-forensics coverage.
- **Detection opportunity**: Windows Security Event ID **4663** (file access) and Sysmon Event ID **23** (FileDelete) log deletions and can be forwarded to a SIEM for alerting.
- **Recoverability**: Files deleted without secure wiping can often be recovered using tools like Autopsy or Volatility, making forensic imaging of live systems a critical IR step.

## Related concepts
[[T1070 Indicator Removal]] [[Anti-Forensics]] [[Digital Forensics and Incident Response (DFIR)]] [[Volume Shadow Copy]] [[Sysmon]]