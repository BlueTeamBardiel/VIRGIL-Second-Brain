# OpenText RightFax

## What it is
Think of it as a postal sorting office that converts digital documents into fax transmissions — sitting quietly in enterprise networks, routing sensitive documents over phone lines without anyone paying attention. OpenText RightFax is an enterprise fax server platform that centralizes fax transmission and reception, integrating with email clients, ERPs, and document management systems to automate high-volume fax workflows.

## Why it matters
In 2023, a critical unauthenticated remote code execution vulnerability (CVE-2023-32566) was discovered in RightFax's web interface, allowing attackers to execute arbitrary commands on the server without credentials. Because RightFax servers frequently handle healthcare records, legal documents, and financial data — and are often overlooked in patch management cycles — a compromised RightFax instance can serve as a quiet exfiltration channel, leaking regulated data through a protocol most security teams aren't monitoring.

## Key facts
- RightFax communicates over the PSTN (Public Switched Telephone Network), meaning fax traffic bypasses standard network DLP and firewall controls almost entirely
- Common attack surface includes its **FaxUtil web client**, **ConnectPlus module**, and **BoardRoom fax broadcast** component — each carrying separate CVE histories
- Default or weak credentials on the admin web console are a persistent finding in enterprise penetration tests
- RightFax is widely deployed in **HIPAA-regulated environments** (healthcare), making data exposure incidents potentially reportable breaches
- Patch cadence is often poor because fax infrastructure is treated as legacy/stable, creating long windows of exposure

## Related concepts
[[Enterprise Fax Security]] [[Remote Code Execution]] [[Legacy System Attack Surface]] [[Data Loss Prevention]] [[HIPAA Compliance]]