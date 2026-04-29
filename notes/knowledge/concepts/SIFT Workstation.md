# SIFT Workstation

## What it is
Like a fully-stocked forensics lab already assembled in a single box — scalpels, microscopes, and evidence bags included — SIFT (SANS Investigative Forensic Toolkit) is a free, open-source Ubuntu-based virtual machine pre-loaded with dozens of digital forensic and incident response tools maintained by SANS Institute.

## Why it matters
When a ransomware attack hits a hospital network, investigators need to rapidly image drives, analyze memory dumps, and reconstruct timelines without contaminating evidence. SIFT gives responders a court-ready, reproducible environment where tools like Volatility, Autopsy, and log2timeline are already configured and version-controlled — meaning findings are defensible in legal proceedings because the analysis environment itself is documented and standardized.

## Key facts
- **Free and maintained by SANS**: Distributed as a VMware/VirtualBox OVA file or installable script on Ubuntu; regularly updated to align with SANS FOR508 and FOR500 courses
- **Dual-boot/VM isolation principle**: Running SIFT as a VM prevents investigative tools from modifying the host system, preserving evidence integrity (chain of custody)
- **Key included tools**: Volatility (memory forensics), Autopsy/Sleuth Kit (disk forensics), log2timeline/Plaso (timeline analysis), Wireshark, and RegRipper (Windows registry analysis)
- **Read-only mounting**: SIFT supports write-blocking via read-only mount options (`mount -o ro`) to prevent accidental evidence alteration — critical for forensic soundness
- **CySA+ relevance**: Represents the "forensic workstation" concept tested under incident response procedures; understanding its role demonstrates knowledge of proper evidence collection environments

## Related concepts
[[Digital Forensics]] [[Chain of Custody]] [[Volatility Framework]] [[Incident Response]] [[Memory Forensics]]