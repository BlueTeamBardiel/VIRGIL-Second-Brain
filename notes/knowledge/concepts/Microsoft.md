# Microsoft

## What it is
Like a landlord who owns most of the apartment buildings in a city — if they have a faulty master key, nearly every tenant is at risk. Microsoft is the dominant enterprise software and cloud services vendor whose products (Windows, Active Directory, Azure, Office 365) form the backbone of most corporate IT environments worldwide.

## Why it matters
In 2021, the Microsoft Exchange Server ProxyLogon vulnerability (CVE-2021-26855) allowed unauthenticated attackers to perform server-side request forgery and chain it with additional CVEs to achieve remote code execution — compromising tens of thousands of organizations before patches were applied. Understanding Microsoft's ecosystem is essential because attackers specifically target its ubiquity: owning Active Directory means owning the entire enterprise.

## Key facts
- **Microsoft Patch Tuesday** occurs the second Tuesday of each month; defenders must track CVEs released via the Microsoft Security Response Center (MSRC)
- **Active Directory (AD)** is Microsoft's identity and access management service; its compromise is the primary goal in most enterprise intrusions (e.g., Kerberoasting, Pass-the-Hash attacks)
- **Microsoft Defender** is the built-in EDR/AV solution in Windows 10/11; its telemetry feeds into **Microsoft Sentinel** (cloud-native SIEM) for Security+ and CySA+ exam relevance
- **Windows Security Baseline** configurations are published by Microsoft via Group Policy Objects (GPOs) and are CIS Benchmark-aligned
- **Azure AD (Entra ID)** extends on-premises AD to the cloud; misconfigured conditional access policies are a frequent attack surface in hybrid environments

## Related concepts
[[Active Directory]] [[Patch Management]] [[Kerberoasting]] [[SIEM]] [[Vulnerability Management]]