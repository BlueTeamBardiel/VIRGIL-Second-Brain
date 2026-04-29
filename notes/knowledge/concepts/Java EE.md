# Java EE

## What it is
Think of Java EE (Enterprise Edition) as a pre-built skyscraper frame — developers just add the walls and furniture instead of pouring concrete from scratch. Precisely, Java EE (now rebranded as Jakarta EE) is a set of specifications and APIs extending standard Java (SE) to support large-scale, multi-tier enterprise applications, including web services, distributed computing, and transaction management. It provides standardized components like Servlets, JSPs, EJBs, and JPA running inside application servers such as JBoss, WebLogic, or GlassFish.

## Why it matters
Java EE applications are frequent targets for deserialization attacks — most infamously demonstrated by the Apache Commons Collections exploit chain that compromised WebLogic, WebSphere, and JBoss servers worldwide. Attackers send crafted serialized Java objects over exposed endpoints (often port 7001 for WebLogic), triggering Remote Code Execution (RCE) before any authentication occurs. Defenders must patch application servers aggressively and filter or disable Java object deserialization wherever possible.

## Key facts
- **Deserialization vulnerabilities** are endemic to Java EE — CVE-2015-4852 (WebLogic) and CVE-2017-10271 are classic exam-relevant examples of RCE via malicious serialized objects.
- Java EE application servers expose management consoles (e.g., WebLogic Admin Console on port 7001) that are high-value attack targets if left internet-facing.
- **JNDI injection** (used in Log4Shell/CVE-2021-44228) exploits Java EE's naming and directory interface to load remote malicious classes — a critical concept for CySA+.
- Java EE uses **role-based access control** declared in `web.xml` and `ejb-jar.xml`, misconfigurations of which lead to privilege escalation.
- Application servers running Java EE should be hardened by disabling unused services, applying vendor security patches, and running with least-privilege OS accounts.

## Related concepts
[[Deserialization Attacks]] [[JNDI Injection]] [[Log4Shell]] [[Remote Code Execution]] [[Application Server Hardening]]