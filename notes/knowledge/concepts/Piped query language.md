# Piped query language

## What it is
Like an assembly line where each worker passes a half-finished part to the next, a piped query language chains filtering and transformation commands together using the `|` (pipe) operator, where each stage feeds its output as input to the next. It is a query syntax used in SIEM and log analysis platforms (such as Splunk's SPL or Microsoft Sentinel's KQL) that allows analysts to progressively filter, aggregate, and visualize event data through sequential processing stages.

## Why it matters
During incident response, a SOC analyst investigating lateral movement might write `index=windows EventCode=4624 | where LogonType=3 | stats count by src_ip, dest_host | where count > 10` to surface accounts performing excessive network logons — narrowing millions of raw events to a handful of suspicious hosts within seconds. Without piped syntax, this multi-stage filtering would require nested SQL subqueries or custom scripts, dramatically slowing triage.

## Key facts
- **SPL (Splunk Processing Language)** and **KQL (Kusto Query Language)** are the two most exam-relevant piped query languages in security contexts
- The pipe `|` operator passes the result set from the left command directly into the right command, enabling chaining of `search → filter → transform → visualize` workflows
- Common piped commands include `stats`, `eval`, `where`, `table`, `rex` (regex extraction), and `timechart` for time-series correlation
- Piped queries power SIEM **detection rules and alerts**; a poorly written query (e.g., missing field constraints) can generate false positives that mask real threats
- KQL is specifically used in **Microsoft Sentinel, Defender for Endpoint, and Azure Monitor** — high-value for CySA+ exam scenarios involving cloud-native SOC environments

## Related concepts
[[SIEM]] [[Log Analysis]] [[Threat Hunting]] [[Security Orchestration Automation and Response (SOAR)]] [[Indicators of Compromise (IoC)]]