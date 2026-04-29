# ysoserial.net

## What it is
Like a lockpick set that comes pre-fitted for specific lock brands, ysoserial.net is a proof-of-concept payload generation tool for .NET deserialization vulnerabilities — it crafts malicious serialized objects targeting specific .NET gadget chains (e.g., `ObjectDataProvider`, `TypeConfuseDelegate`) to achieve remote code execution when a vulnerable application deserializes untrusted data.

## Why it matters
In 2019, attackers exploited .NET deserialization flaws in Microsoft Exchange and SharePoint using gadget chains identical to those ysoserial.net demonstrates — sending crafted HTTP requests that triggered RCE without authentication. Defenders use ysoserial.net in penetration tests to confirm whether their applications are vulnerable *before* real attackers do, making it both a weapon and a diagnostic tool.

## Key facts
- **Not the original**: ysoserial.net is the .NET port of the original Java `ysoserial` tool; both exploit deserialization but target different runtimes and gadget chains
- **Gadget chains**: Exploits don't inject new code — they chain together *existing* trusted classes in the application whose methods, when triggered during deserialization, execute attacker-controlled commands
- **Formatters matter**: Different payload types target different .NET formatters — `BinaryFormatter`, `SoapFormatter`, `DataContractSerializer` — each requiring a different ysoserial.net plugin
- **CVE relevance**: Directly maps to CVE-2019-0604 (SharePoint) and CVE-2021-31207 (Exchange), both critical RCE vulnerabilities exploited in the wild
- **Mitigation**: Microsoft deprecated `BinaryFormatter` in .NET 5+ precisely because it cannot be made safe; replacing it is the primary defense

## Related concepts
[[Deserialization Vulnerabilities]] [[Remote Code Execution]] [[Gadget Chains]] [[BinaryFormatter]] [[OWASP A08 Software and Data Integrity Failures]]