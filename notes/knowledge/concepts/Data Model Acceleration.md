# Data Model Acceleration

## What it is
Like a chef who preps and chops vegetables in the morning so dinner service is instant rather than cooking from scratch per order, Data Model Acceleration pre-processes and indexes raw event data into optimized summary datasets. In Splunk specifically, it runs saved searches on a schedule to build accelerated data models, dramatically reducing query time for pivot-based reports and dashboards. The result is faster analytics on large datasets without re-scanning raw logs every time.

## Why it matters
A SOC analyst investigating lateral movement needs to query millions of Windows authentication events across 30 days in near-real-time. Without acceleration, that Splunk pivot report might time out or take 10+ minutes; with acceleration enabled on the Authentication data model, the same query returns in seconds — meaning threat hunters can actually iterate on hypotheses during an active incident rather than waiting on infrastructure.

## Key facts
- Data Model Acceleration is a core feature of **Splunk Enterprise Security (ES)** and underpins most of its pre-built correlation searches and dashboards
- Accelerated data models store pre-computed summaries in a **tsidx (time-series index)** format, separate from raw index buckets
- The **Common Information Model (CIM)** defines the normalized field names that data models depend on — CIM compliance is required for acceleration to work correctly across different data sources
- Acceleration is configured per data model with a **summary range** (e.g., 1 month, 3 months) — longer ranges consume more disk space
- For **CySA+/Security+** context: data model acceleration is an example of a *performance optimization* control that directly enables scalable SIEM-based continuous monitoring

## Related concepts
[[SIEM Tuning]] [[Common Information Model (CIM)]] [[Correlation Search]] [[Log Aggregation]] [[Threat Hunting]]