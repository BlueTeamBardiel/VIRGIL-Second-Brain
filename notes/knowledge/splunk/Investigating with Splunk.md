# Investigating with Splunk

TryHackMe room covering security investigations and threat analysis using [[Splunk]] as a SIEM platform for log analysis and forensic investigation.

## Overview

This room teaches practical skills in using [[Splunk]] to investigate security incidents, parse logs, and identify malicious activity through searches and visualizations.

## Key Topics

- [[Splunk]] fundamentals and interface
- Log ingestion and indexing
- [[SPL]] (Splunk Processing Language) query syntax
- Security event investigation
- Threat detection and analysis
- Log correlation and pattern matching
- Creating dashboards and alerts

## Investigation Techniques

- Searching historical logs
- Filtering and drilling down into events
- Identifying indicators of compromise (IOCs)
- Timeline analysis
- User and host-based investigations

## Tools & Concepts

- [[Splunk]] Enterprise/Cloud
- [[SIEM]] platforms
- Log aggregation
- Security investigations
- Incident response

## Tags

#tryhackme #splunk #siem #security-investigation #threat-analysis #log-analysis #incident-response

## What Is It? (Feynman Version)

Imagine a library that stores every book (log entry) ever written by your computer systems. [[Splunk]] is the librarian that indexes those books so you can quickly pull out the chapter you need, look for patterns, and spot the author who wrote something suspicious.

## Why Does It Exist?

Before SIEMs, security analysts had to sift through raw log files on individual machines, hunting for the same error message or failed login in isolation. A breach could spread across a network unnoticed because the logs were scattered and unstructured. [[Splunk]] unifies these disparate logs, giving analysts a single searchable view that turns a chaotic pile of text into actionable intelligence—much like turning a scattered set of receipts into a clear expense report.

## How It Works (Under The Hood)

1. **Data ingestion** – A forwarder runs on each host, pushing log lines (e.g., `/var/log/auth.log`) over the network to the Splunk indexer.  
2. **Parsing & indexing** – The indexer splits each line into fields, stores the raw event, and builds inverted indexes for each field value. Think of it as cataloguing each word in a book and noting every page it appears on.  
3. **Search & query** – Users write [[SPL]] queries that translate to a combination of `search`, `eval`, `stats`, etc. The engine executes the query against the indexes, retrieving matching events and optionally aggregating results.  
4. **Correlation** – Splunk can join events from different sources on common keys (e.g., `user` or `host`) and time-window them, creating a composite view of an attack’s timeline.  
5. **Visualization & alerting** – Results are rendered in dashboards; thresholds can trigger alerts that push to email, Slack, or an incident response platform.

## What Breaks When It Goes Wrong?

If the forwarder stops sending logs, the indexer has stale data, and analysts may miss a critical event. Misconfigured field extractions can mask an IOC, allowing a threat actor to blend in. Overloaded indexes can degrade query performance, delaying detection—essentially giving attackers more time to exfiltrate data. In the worst case, corrupted indexes mean a forensic trail disappears entirely, making a breach irreproducible.

## Lab Relevance

- **Deploy a local Splunk Enterprise instance** (or use the cloud demo) to ingest sample logs from a virtual machine.  
- **Configure the Universal Forwarder** on a Windows guest:  
  ```bash
  cd C:\Program Files\SplunkUniversalForwarder\bin
  .\splunk.exe install apps\Splunk_TA_win-eventlog
  .\splunk.exe set pass4symmkey mySecretKey
  .\splunk.exe start
  ```  
- **Create an index** for application logs:  
  ```spl
  index=app_logs sourcetype=app_error
  ```  
- **Run an SPL query** to find failed logins in the last hour:  
  ```spl
  index=auth_logs sourcetype=linux_secure "Failed password" | stats count by user, host
  ```  
- **Watch for pitfalls**: confirm the forwarder’s connectivity (`splunk list forwarder`), verify field extraction for `user`, and monitor index size to avoid throttling.

---

_Ingested: 2026-04-15 20:45 | Source: https://tryhackme.com/room/investigating-with-splunk_