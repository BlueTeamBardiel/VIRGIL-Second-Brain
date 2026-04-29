# Blue Mockingbird

## What it is
Like a squatter who breaks into an empty warehouse to run an illegal power-hungry mining operation on the landlord's electricity bill, Blue Mockingbird is a threat actor group that hijacks enterprise servers to mine Monero cryptocurrency. Specifically, it is a financially motivated cluster of activity first identified in December 2019, known for exploiting Telerik UI vulnerabilities and misconfigured XMRIG deployments across Windows systems.

## Why it matters
In 2020, Blue Mockingbird compromised thousands of IIS servers running vulnerable ASP.NET applications by chaining a Telerik UI deserialization flaw (CVE-2019-18935) with privilege escalation to deploy XMRIG miners via malicious DLL side-loading. Defenders responding to unexplained CPU spikes on web servers discovered the group had achieved persistence through COM object hijacking in the CLSID registry, making detection non-trivial and demonstrating how cryptomining attacks can masquerade as normal server load.

## Key facts
- **Initial access vector:** Exploits CVE-2019-18935, a critical .NET deserialization vulnerability in Telerik UI for ASP.NET AJAX (CVSS 9.8)
- **Persistence mechanism:** Uses COM object hijacking by modifying CLSID registry keys to load malicious DLLs without requiring elevated write permissions
- **Payload:** Deploys XMRIG to mine Monero (XMR), chosen for its privacy features that complicate transaction tracing
- **Lateral movement:** Uses Mimikatz-derived credential dumping and Windows Management Instrumentation (WMI) for spreading across internal networks
- **Detection indicator:** Abnormally high and sustained CPU utilization on internet-facing IIS/Windows servers is the primary behavioral red flag

## Related concepts
[[Cryptojacking]] [[COM Hijacking]] [[CVE-2019-18935]] [[XMRIG]] [[Deserialization Vulnerabilities]]