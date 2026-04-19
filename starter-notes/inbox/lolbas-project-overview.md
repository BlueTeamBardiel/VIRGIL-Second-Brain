# LOLBAS Project

Living Off The Land Binaries, Scripts and Libraries (LOLBAS) is a curated collection of legitimate system binaries, scripts, and libraries that can be abused by attackers for malicious purposes, documented with [[MITRE ATT&CK]] technique mappings.

## Overview

The LOLBAS project catalogs Windows binaries and tools that can be weaponized as part of living-off-the-land attack techniques, enabling [[sysadmin]] and security teams to understand lateral movement, execution, and evasion vectors using legitimate tools already present on target systems.

## Key Resources

- **Main Site**: https://lolbas-project.github.io/
- **Contribution Guide**: Available on project site
- **Criteria**: Formal definition of what qualifies as a LOLBin/Script/Lib
- **API Access**: Programmatic access to project data
- **ATT&CK Navigator**: Current [[MITRE ATT&CK]] mappings

## Related Projects

- **Unix Binaries**: [[GTFOBins]] (gtfobins.github.io)
- **Drivers**: [[LOLDrivers]] (loldrivers.io)

## Example Binaries Tracked

Common Windows LOLBins include:

| Binary | Functions | ATT&CK Techniques |
|--------|-----------|-------------------|
| [[AddinUtil.exe]] | Execute (.NetObjects) | [[T1218]] |
| [[AppInstaller.exe]] | Download (INetCache) | [[T1105]] |
| [[Aspnet_Compiler.exe]] | AWL bypass | [[T1127]] |
| [[At.exe]] | Execute (CMD) | [[T1053.002]] |
| [[Bitsadmin.exe]] | Download, Copy, Execute, ADS | [[T1105]], [[T1218]], [[T1564.004]] |
| [[Certutil.exe]] | Download (GUI) | [[T1105]] |

## Key Concepts

- **AWL Bypass**: Application Whitelist evasion using legitimate tools
- **Download**: Network-based file retrieval capabilities
- **Execute**: Code execution methods
- **Alternate Data Streams (ADS)**: [[T1564.004]] - data hiding technique

## Tags

#lolbas #living-off-the-land #att&ck #windows #lateral-movement #evasion #sysadmin #security

---
_Ingested: [[2026-04-15]] 22:04 | Source: https://lolbas-project.github.io/_
