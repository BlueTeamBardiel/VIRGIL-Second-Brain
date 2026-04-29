# SPL

## What it is
Think of SPL like SQL for security logs — it's the query language you use to interrogate mountains of event data the same way a detective cross-references witness statements. SPL (Search Processing Language) is Splunk's proprietary query language used to search, filter, correlate, and visualize log and event data in a SIEM environment. It processes data in a pipeline fashion, passing results from one command to the next like an assembly line.

## Why it matters
During an incident response to a suspected lateral movement attack, an analyst can write an SPL query to correlate failed logins across multiple hosts within a 10-minute window, flagging accounts that authenticated successfully on one machine after failing on three others — the classic pass-the-hash fingerprint. Without SPL proficiency, that pattern stays buried in millions of raw log lines. The query `index=windows EventCode=4625 | stats count by src_ip, user | where count > 5` can surface brute-force attempts in seconds.

## Key facts
- SPL uses a **pipe (`|`) syntax** to chain commands: `search → stats → eval → where → table` is a common workflow pattern
- The **`stats` command** is the workhorse for aggregation — counting events, calculating averages, and grouping by field values
- **`index=`** is always the starting filter — pointing SPL at the right data bucket before any other processing
- SPL supports **lookup tables** to enrich raw logs with threat intelligence (e.g., matching source IPs against known-bad lists)
- CySA+ expects analysts to **read and interpret** SPL queries, not just write them — focus on understanding `eval`, `rex`, `transaction`, and `stats`

## Related concepts
[[SIEM]] [[Log Analysis]] [[Threat Hunting]] [[Incident Response]] [[Correlation Rules]]