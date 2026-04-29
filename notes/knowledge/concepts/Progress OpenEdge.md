# Progress OpenEdge

## What it is
Think of it like a specialized filing cabinet that comes with its own lock, key system, and retrieval clerk built in — except the clerk speaks a proprietary language called ABL. Progress OpenEdge is a commercial application development platform combining a relational database (OpenEdge RDBMS) with a 4GL programming language (ABL/Progress 4GL), commonly used in enterprise business applications like ERP and healthcare systems.

## Why it matters
In 2023, a critical SQL injection vulnerability (CVE-2023-34362) in Progress MOVEit Transfer — a file transfer product built on the OpenEdge ecosystem — was exploited by the Cl0p ransomware group in a massive supply-chain attack affecting hundreds of organizations including government agencies. This demonstrates how vulnerabilities in enterprise middleware platforms can cascade into catastrophic data breaches across entire industries.

## Key facts
- **CVE-2023-34362**: A critical (CVSS 9.8) SQL injection vulnerability in MOVEit Transfer allowed unauthenticated remote code execution, leading to mass exploitation by Cl0p ransomware gang.
- OpenEdge uses **port 20931** (AppServer) and **port 8080/8443** (PAS for OpenEdge) by default — these are common attack surface targets during reconnaissance.
- The ABL language can execute **OS-level commands**, meaning code injection in OpenEdge applications may lead directly to system compromise.
- OpenEdge databases use **proprietary `.db` file format**, which can be difficult to audit with standard database security tooling.
- Patch management is critical: Progress OpenEdge products have historically suffered from delayed patching cycles in enterprise environments due to application compatibility concerns.

## Related concepts
[[SQL Injection]] [[Supply Chain Attack]] [[Remote Code Execution]]