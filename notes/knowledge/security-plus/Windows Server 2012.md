# Windows Server 2012

## What it is
Think of it like a city's central utility hub — water, power, and communications all managed from one building. Windows Server 2012 is Microsoft's server operating system released in September 2012, built on the Windows 8 kernel, designed to centrally manage network infrastructure, Active Directory, virtualization (Hyper-V), and file services in enterprise environments.

## Why it matters
Windows Server 2012 reached End of Support on October 10, 2023, meaning no further security patches are issued — making any unpatched deployment an immediate high-value target. Attackers specifically hunt for legacy servers running exploitable services like SMBv1 or unpatched RDP (CVE-2019-0708, "BlueKeep"), which can enable unauthenticated remote code execution and lateral movement across a network.

## Key facts
- **End of Support: October 10, 2023** — running it without Extended Security Updates (ESUs) violates most compliance frameworks (PCI-DSS, HIPAA)
- Introduced **ReFS (Resilient File System)** alongside NTFS, offering improved data integrity for large-scale storage
- Native **Hyper-V 3.0** support enabled live VM migration and network virtualization — critical to understand for virtualization attack surfaces
- **Active Directory enhancements** included fine-grained password policies made easier to configure, a common exam topic around privilege management
- Vulnerable to **Pass-the-Hash attacks** by default if configured without Protected Users security group or Credential Guard (features not introduced until Server 2016)

## Related concepts
[[Active Directory]] [[End of Life Software]] [[Pass-the-Hash Attack]] [[SMBv1 Vulnerability]] [[Patch Management]]