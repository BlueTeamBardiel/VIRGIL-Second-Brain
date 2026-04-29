# zero-day vulnerabilities

## What it is
Imagine a bank robber who discovers a secret tunnel into a vault that the bank architects don't even know exists — they can't board it up because they don't know it's there. A zero-day vulnerability is a software flaw unknown to the vendor, meaning zero days have elapsed for them to develop and release a patch, leaving all users exposed with no official defense available.

## Why it matters
In 2021, the Microsoft Exchange Server zero-days (ProxyLogon/ProxyShell) were exploited by nation-state actors to install web shells on tens of thousands of unpatched servers *before* Microsoft could issue fixes — organizations had no patch to apply because none existed yet. Defenders had to rely entirely on compensating controls like network segmentation and anomaly detection rather than remediation.

## Key facts
- A **zero-day exploit** is the weaponized code that attacks the zero-day vulnerability — the vulnerability and the exploit are distinct concepts.
- Zero-days are valuable commodities: brokers like Zerodium pay upwards of **$2.5 million** for iOS zero-days, reflecting their scarcity and offensive utility.
- Once a vendor is notified but *before* a patch is released, the flaw is still called a zero-day; after patch release it becomes an **n-day vulnerability**.
- Mitigations without a patch include: **virtual patching** (WAF/IPS rules), attack surface reduction, least privilege enforcement, and network segmentation.
- Zero-days used by nation-states are tracked under APT activity; Stuxnet famously chained **four simultaneous zero-days** — an extraordinarily rare and expensive operation.

## Related concepts
[[exploit development]] [[patch management]] [[threat intelligence]] [[advanced persistent threats]]