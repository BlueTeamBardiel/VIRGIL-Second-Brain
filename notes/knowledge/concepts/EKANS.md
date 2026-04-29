# EKANS

## What it is
Like a wrecking ball that specifically targets the control room before demolishing a factory, EKANS is ransomware engineered to kill industrial control system (ICS) processes *before* encrypting files. EKANS (SNAKE spelled backwards) is a Windows-based ransomware strain first observed in 2019–2020 that contains a hardcoded list of ICS/SCADA-related processes to terminate, making it uniquely dangerous to operational technology (OT) environments.

## Why it matters
In June 2020, Honda was forced to halt manufacturing operations globally after EKANS infected its network, disrupting assembly plants across multiple continents. The attack demonstrated that ransomware had evolved beyond encrypting business data — adversaries were now deliberately targeting the operational technology layer to maximize production downtime and pressure victims into paying ransoms faster.

## Key facts
- Contains a hardcoded list of ~64 ICS/SCADA processes to kill (e.g., GE Proficy, Honeywell HMI, SIMATIC WinCC) before encrypting files
- Written in Go (Golang), which simplifies cross-compilation and complicates reverse engineering
- Checks for a specific domain name before executing; if the domain resolves, it exits — functioning as an internal kill switch
- Deletes Volume Shadow Copies (VSS) to prevent file recovery, a common ransomware technique
- Classified under MITRE ATT&CK for ICS as using **Inhibit Response Function (T0816)** to disable safety and monitoring processes

## Related concepts
[[Ransomware]] [[ICS/SCADA Security]] [[MITRE ATT&CK for ICS]] [[Operational Technology Security]] [[Volume Shadow Copy Deletion]]