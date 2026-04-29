# ATT&CK T1542.003

## What it is
Like a burglar who bribes the building superintendent to get a master key *before* the security cameras turn on, this technique hijacks code that runs before the operating system even loads. Bootkit is a sub-technique of Pre-OS Boot where adversaries infect the Master Boot Record (MBR), Volume Boot Record (VBR), or bootloader to execute malicious code prior to OS initialization, making it invisible to most security tools.

## Why it matters
The Necurs botnet and the infamous Mebroot/Sinowal banking trojan used MBR-level bootkits to survive complete OS reinstalls — victims wiped their drives and the malware came back because the infection lived *below* the OS layer. Defenders need to validate boot integrity using Secure Boot and Trusted Platform Module (TPM) measurements, since traditional AV products cannot inspect pre-boot memory during normal runtime.

## Key facts
- Bootkits persist in sectors read before the OS kernel loads, meaning they survive OS reinstalls if the disk's boot sectors aren't explicitly wiped
- UEFI Secure Boot is the primary defensive control — it validates cryptographic signatures on bootloader components before execution
- Detection typically requires offline forensic tools or integrity checks using TPM-stored measurements compared against known-good baselines
- Adversaries often require physical access or kernel-level (Ring 0) privileges to write to boot sectors on modern systems
- UEFI-level implants (a related evolution) can survive even full drive replacements if firmware itself is compromised — making this technique a potential stepping stone to T1542.001

## Related concepts
[[Secure Boot]] [[UEFI Firmware Implants]] [[Rootkit]] [[TPM Attestation]] [[Pre-OS Boot T1542]]