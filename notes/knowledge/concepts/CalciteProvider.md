# CalciteProvider

## What it is
Like a universal power adapter that lets your devices plug into foreign sockets, CalciteProvider is a query federation abstraction layer in Apache Calcite that allows disparate data sources to be queried through a unified SQL interface. It acts as the translation bridge between a standard SQL query engine and heterogeneous backends — databases, files, streams — by implementing a provider pattern that registers schemas and tables dynamically.

## Why it matters
In security data lake architectures (common in SIEM and threat-hunting platforms), CalciteProvider enables analysts to run unified SQL queries across log stores, threat intel feeds, and asset databases without moving data. An attacker who compromises the query federation layer gains read access to every connected backend simultaneously — making the provider itself a high-value lateral movement target. Defenders must treat the CalciteProvider configuration and its schema registry as sensitive infrastructure, applying least-privilege access controls to registered data sources.

## Key facts
- CalciteProvider implements Apache Calcite's `SchemaFactory` or `Schema` interfaces to expose external data as queryable relational tables
- Because it abstracts multiple backends, a misconfigured provider can inadvertently expose sensitive schemas that were intentionally siloed
- SQL injection risks multiply in federated query layers — input sanitization must occur *before* Calcite translates queries to backend-specific languages
- Provider configurations (typically JSON or YAML model files) often contain embedded credentials for backend connections — these files require strict file-system ACLs
- Used in security tools like Apache Drill, Dremio, and custom SIEM query engines that leverage Calcite's optimizer for cross-source analytics

## Related concepts
[[SQL Injection]] [[Data Federation Security]] [[Least Privilege Access]] [[SIEM Architecture]] [[Schema Enumeration]]