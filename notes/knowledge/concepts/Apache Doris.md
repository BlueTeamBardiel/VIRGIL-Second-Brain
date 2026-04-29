# Apache Doris

## What it is
Think of Apache Doris like a high-speed trading floor analyst who can instantly aggregate millions of transactions and hand you a summary in seconds — it's a real-time analytical database (OLAP) designed for high-concurrency queries on massive datasets. Built on a MySQL-compatible interface, Doris allows organizations to run sub-second SQL queries across petabyte-scale data without complex middleware.

## Why it matters
In 2023, security researchers discovered that misconfigured Apache Doris deployments were exposed to the internet with no authentication required, allowing attackers to query sensitive business intelligence data — sales figures, user behavior logs, internal metrics — directly via standard MySQL clients. Because Doris speaks MySQL's wire protocol, attackers could blend into legitimate database traffic, making detection harder for network-based monitoring tools.

## Key facts
- Apache Doris uses a **MySQL-compatible protocol (port 9030)**, meaning standard MySQL client tools and scanners can interact with it without specialized tooling
- Default installations have historically shipped with **weak or no authentication**, making exposed instances trivially exploitable via tools like Shodan
- Doris runs two node types: **Frontend (FE)** handles query parsing/metadata, **Backend (BE)** handles storage/computation — compromising FE gives query-level access to all data
- The **HTTP API (port 8030)** for data ingestion can expose additional attack surface if not firewall-restricted, enabling unauthorized bulk data import or export
- As an OLAP system, Doris often aggregates data from multiple upstream sources (Kafka, Flink, MySQL), so a breach can expose **cross-system data correlation** not visible in individual source databases

## Related concepts
[[Database Security]] [[SQL Injection]] [[Exposed Services]] [[Data Exfiltration]] [[Network Scanning]]