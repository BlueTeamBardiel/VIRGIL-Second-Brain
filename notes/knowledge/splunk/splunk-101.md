# Splunk 101

A TryHackMe room covering foundational Splunk concepts and log analysis techniques. This room introduces security analysts to Splunk's core functionality for searching, parsing, and visualizing security event data.

## Overview

[[Splunk]] is a powerful platform for searching, monitoring, and analyzing machine‑generated big data. This introductory room teaches:

- Log ingestion and indexing
- [[SPL|Splunk Processing Language]] (SPL) fundamentals
- Searching and filtering event data
- Data visualization and dashboards
- Security monitoring use cases

## Key Topics

- **Log Sources**: Understanding data inputs from various systems
- **Indexing**: How Splunk processes and stores log data
- **Search Queries**: Basic and intermediate SPL syntax
- **Fields & Events**: Extracting and working with structured data
- **Alerts & Dashboards**: Creating automated detections and visualizations

## Skills Gained

- Log analysis fundamentals
- Security event investigation
- Query construction
- Data‑driven security insights

## Tags

#splunk #log-analysis #siem #security-operations #tryhackme

---

## What Is It? (Feynman Version)

Splunk is like a universal library that scans every book you hand it, notes every word, and writes a master index so you can ask any question—whether "Who logged in from IP 192.168.1.15?" or "What HTTP status codes were returned in the last week?"—and get instant answers.  
In plain English, Splunk is a platform that ingests machine‑generated data, stores it in an indexed format, and lets you query, visualize, and alert on that data.

## Why Does It Exist?

Before Splunk, system logs were kept in plain text files on individual servers. Security analysts had to grep through dozens of files, manually correlate timestamps, and write custom scripts to detect patterns. The 2013 Equifax breach showed the cost of missing a critical log: a single misconfigured Apache log meant attackers’ lateral movement went undetected for months. Splunk solves this by automating ingestion, normalizing data into searchable events, and providing a single pane of glass for real‑time monitoring.

## How It Works (Under The Hood)

1. **Data Ingestion**  
   - A **Universal Forwarder** (lightweight agent) runs on a host, tails logs or pulls from APIs, and streams raw events to a **Indexer**.  
   - The Indexer receives events over TCP/UDP or via HTTP Event Collector (HEC) and assigns them a **sourcetype** (e.g., `syslog`, `wineventlog`, `access_combined`).

2. **Event Parsing & Indexing**  
   - The Indexer extracts a timestamp (or falls back to the ingestion time), splits the event into fields based on regex or predefined field extractions, and writes the event into a compressed, indexed file on disk.  
   - Each event is stored in an **index** (logical partition). Splunk’s internal data structure allows binary search over the timestamped event stream.

3. **Search Execution**  
   - The **Search Head** receives an SPL query, parses it into a search pipeline, and dispatches it to the indexer (or indexes) that hold the relevant data.  
   - Events are retrieved, piped through SPL commands (`search`, `stats`, `eval`, `chart`, etc.), and the final results are returned to the user.

4. **Visualization & Alerts**  
   - Results can be plotted in dashboards (bar charts, line graphs, tables).  
   - Alerts are defined as scheduled searches with thresholds; when a search’s result set meets the criteria, an action (email, webhook, script) is triggered.

## What Breaks When It Goes Wrong?

- **Index Corruption**: A disk failure or power outage during indexing can leave an index partially written. Analysts may get incomplete data, leading to false negatives in detection.  
- **High CPU/Memory Usage**: Poorly written SPL queries or indexing too much data can saturate the indexer. The whole SIEM slows down, and critical alerts may miss their window.  
- **Misconfigured Field Extraction**: If a sourcetype isn’t correctly parsed, key data (like IP addresses) may be missing, causing analysts to miss lateral movement.  
- **Alert Noise**: A loose threshold can flood analysts with false positives, causing alert fatigue. The real threat may go unnoticed because teams ignore alerts.  
- **License Exhaustion**: Splunk’s licensed search head will stop returning results once the daily indexed volume exceeds the purchased quota, effectively silencing the security team.

Human cost: delayed detection of breaches, regulatory fines for non‑compliance, loss of customer trust, and expensive incident‑response efforts.

## Lab Relevance

1. **Set Up Splunk in a Homelab**  
   - Download the free Splunk Enterprise installer (Linux/Windows).  
   - Run `splunk enable boot-start` and `splunk start` to get the web UI at `http://localhost:8000`.  
   - Install a **Universal Forwarder** on a VM or the host itself.  
   - Configure the forwarder to tail local `/var/log/syslog` or Windows Event Log.

2. **Hands‑On Commands**  
   - **Create an index**: `splunk create index lab_index`.  
   - **Add a data input**: In the UI, set “Data Inputs → Files & directories” pointing to `/var/log/*.log`.  
   - **Basic SPL query**:  
     ```spl
     index=lab_index | head 20
     ```
   - **Field extraction example**:  
     ```spl
     index=lab_index sourcetype=syslog | rex field=_raw "(?<message>.+) $"
     ```
   - **Dashboard**: Drag “Event Count” over time into a new panel.  
   - **Alert**: Search `index=lab_index sourcetype=auth | stats count by user | where count > 5` and set a scheduled alert to email on threshold.

3. **Watch for Issues**  
   - Monitor CPU and memory on the indexer; Splunk’s `indexer_stability` dashboard can surface spikes.  
   - Verify the health of your data inputs: `splunk list inputs` should show all forwarders connected.  
   - Test alert thresholds by generating a burst of logs and watching if the alert fires correctly.

4. **COCYTUS Context**  
   - In a containerized environment, point Splunk’s HEC to Docker log endpoints (`docker logs --follow <container>`).  
   - Use Splunk’s `docker-forwarder` image to collect logs from multiple containers and index them under a shared sourcetype like `container_log`.  
   - Build dashboards that correlate container events with host system activity, aiding in rapid isolation of compromised workloads.

--- 

_Ingested: 2026‑04‑15 20:45 | Source: https://tryhackme.com/room/splunk101_