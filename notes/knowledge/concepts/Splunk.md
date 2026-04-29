# Splunk

## What it is
Think of Splunk as a Google search engine bolted onto every log file your organization has ever generated — it indexes the chaos and lets you query it in seconds. Precisely, Splunk is a Security Information and Event Management (SIEM) platform that ingests, indexes, correlates, and visualizes machine-generated data from across an IT environment in real time.

## Why it matters
During the 2020 SolarWinds supply chain attack, defenders who had Splunk deployed could search across months of network logs to identify anomalous SUNBURST beacon traffic to command-and-control domains — without Splunk, analysts would have been manually sifting through terabytes of raw logs. This kind of retroactive threat hunting is only possible because Splunk stores and indexes historical data, not just live streams.

## Key facts
- Splunk uses its own query language called **SPL (Search Processing Language)** — knowing `index=`, `sourcetype=`, `stats`, and `rex` commands is essential for CySA+ scenarios
- Data is ingested via **forwarders** (Universal or Heavy), which ship logs from endpoints to a central indexer
- Splunk alerts can trigger on **threshold-based rules** (e.g., >5 failed logins in 60 seconds) to automate detection of brute-force attacks
- The **Common Information Model (CIM)** normalizes data from different sources so log formats from firewalls, endpoints, and cloud services can be compared consistently
- Splunk's **Enterprise Security (ES)** app adds a purpose-built SOC interface with risk-based alerting and a notable events queue, elevating it to a full SIEM

## Related concepts
[[SIEM]] [[Log Management]] [[Threat Hunting]] [[Security Operations Center (SOC)]] [[Indicators of Compromise (IoCs)]]