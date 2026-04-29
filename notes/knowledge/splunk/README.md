# Splunk — From Zero to SOC Analyst
> Splunk appears in 60% of SOC job postings. Learn it before your interview.

Splunk is the dominant SIEM platform in enterprise security operations. Even organizations running Elastic or Microsoft Sentinel often have analysts who know Splunk. It's a data platform first — a search engine for machine data — and a SIEM second. Understanding how Splunk thinks is the foundation for understanding any SIEM.

---

## What Splunk Is

**The short version:** Splunk ingests logs from everywhere (Windows Event Logs, firewalls, proxies, endpoints, cloud), indexes them, and lets you search and visualize them using a query language called SPL (Search Processing Language).

**The data model:**
- **Index** — a named partition of data (like a database). `index=windows`, `index=linux`, `index=firewall`
- **Sourcetype** — what kind of data it is, determines how it's parsed. `WinEventLog:Security`, `syslog`, `access_combined`
- **Source** — the file or input that sent the data. `/var/log/auth.log`, `WinEventLog://Security`
- **Host** — the machine that generated the event. `WORKSTATION01`, `192.168.1.10`
- **Event** — a single log entry. Everything Splunk stores is an event.
- **Fields** — key-value pairs extracted from events. `EventCode=4625`, `Account_Name=jsmith`

**The time index:** Splunk's superpower is time-based search. Every event has a `_time` field. You can search across millions of events in seconds because everything is indexed by time.

---

## SPL — Search Processing Language

SPL reads left to right as a pipeline. Each command filters or transforms the data flowing through it.

```
index=windows EventCode=4625
| stats count by Account_Name
| sort -count
| head 10
```
Read: "Find all failed logon events in the windows index, count them grouped by account name, sort highest first, show top 10."

### Basic Search Syntax

```splunk
/* Search terms (implicit AND) */
index=windows error failed

/* OR, NOT */
index=windows (EventCode=4624 OR EventCode=4625)
index=windows NOT Account_Name=SYSTEM

/* Field=value filtering */
index=windows EventCode=4625 Account_Name=jsmith

/* Wildcards */
index=windows Account_Name=j*

/* Time range (in addition to UI picker) */
index=windows EventCode=4625 earliest=-24h latest=now
index=windows earliest="04/01/2026:00:00:00" latest="04/15/2026:23:59:59"
```

### Filtering and Transforming

```splunk
/* where — filter after search (can use eval expressions) */
index=windows EventCode=4624
| where Logon_Type=3

/* eval — create or transform fields */
index=windows EventCode=4625
| eval hour=strftime(_time, "%H")
| where hour < 6 OR hour > 22

/* rename */
index=windows EventCode=4625
| rename Account_Name as failed_user, Source_Network_Address as src_ip

/* table — pick which fields to display */
index=windows EventCode=4625
| table _time, Account_Name, Source_Network_Address, Failure_Reason
```

### Aggregation — `stats`

The workhorse of SPL analysis.

```splunk
/* count events */
index=windows EventCode=4625
| stats count

/* count by field */
index=windows EventCode=4625
| stats count by Account_Name

/* multiple aggregations */
index=windows EventCode=4624
| stats count, dc(Source_Network_Address) as unique_ips, 
         latest(_time) as last_seen by Account_Name

/* count unique values */
index=windows EventCode=4769
| stats dc(Service_Name) as unique_services by Account_Name
| where unique_services > 20

/* timechart — aggregate over time buckets */
index=windows EventCode=4625
| timechart span=1h count by Account_Name
```

Key `stats` functions:
| Function | Does |
|---|---|
| `count` | Count events |
| `dc(field)` | Count distinct values |
| `values(field)` | List all unique values |
| `latest(field)` | Most recent value |
| `earliest(field)` | Oldest value |
| `sum(field)` | Sum numeric field |
| `avg(field)` | Average |
| `max / min` | Maximum / minimum |

### Sorting, Head, Tail

```splunk
| sort -count          /* descending by count */
| sort +_time          /* ascending by time */
| sort -count, +name   /* multi-field sort */
| head 20              /* first 20 results */
| tail 5               /* last 5 results */
```

### Field Extraction — `rex`

When Splunk hasn't auto-extracted a field you need, extract it with regex.

```splunk
/* Extract IP from a raw log message */
index=firewall
| rex field=_raw "SRC=(?<src_ip>\d+\.\d+\.\d+\.\d+)"

/* Extract username from email */
index=mail
| rex field=_raw "from=<(?<sender>[^@]+)@"
```

### `transaction` — Group Related Events

Group events that belong together (e.g., a login session).

```splunk
/* Group logon/logoff pairs by Logon_ID */
index=windows (EventCode=4624 OR EventCode=4634)
| transaction Logon_ID startswith=EventCode=4624 endswith=EventCode=4634
| eval session_minutes=duration/60
| table Account_Name, Workstation_Name, session_minutes
```

---

## Essential SOC Searches

### Failed Logon Attempts by User (Brute Force Detection)
```splunk
index=windows EventCode=4625 earliest=-1h
| stats count by Account_Name, Source_Network_Address
| where count > 10
| sort -count
```

### Password Spray Detection (Many Accounts, Few Attempts Each)
```splunk
index=windows EventCode=4625 earliest=-1h
| stats dc(Account_Name) as unique_accounts, count by Source_Network_Address
| where unique_accounts > 10
| sort -unique_accounts
```

### Logons at Unusual Hours
```splunk
index=windows EventCode=4624 Logon_Type=2
| eval hour=strftime(_time, "%H")
| where hour >= 22 OR hour <= 5
| table _time, Account_Name, Workstation_Name, hour
| sort -_time
```

### PowerShell Script Block Logging — Suspicious Executions
```splunk
index=windows EventCode=4104
| eval script=lower(ScriptBlockText)
| where match(script, "downloadstring|invoke-expression|iex|frombase64|-enc|-nop|amsibypass|mimikatz|credential")
| table _time, Computer, UserID, ScriptBlockText
| sort -_time
```

### New Scheduled Tasks (Persistence)
```splunk
index=windows EventCode=4698
| table _time, Account_Name, Task_Name, Task_Content
| sort -_time
```

### Account Lockouts (Origin Hunting)
```splunk
index=windows EventCode=4740
| stats count by Account_Name, Caller_Computer_Name
| sort -count
```

### Privilege Group Membership Changes
```splunk
index=windows (EventCode=4728 OR EventCode=4732 OR EventCode=4756)
| eval group=coalesce(Group_Name, Target_Group_Name)
| where match(group, "(?i)domain admin|enterprise admin|administrators")
| table _time, Account_Name, Member_Security_ID, group
```

### Large Data Transfer (Potential Exfiltration)
```splunk
index=firewall
| stats sum(bytes_out) as total_bytes by src_ip, dest_ip
| eval gb=round(total_bytes/1073741824, 2)
| where gb > 1
| sort -gb
```

### Lateral Movement via Network Logons (Workstation-to-Workstation)
```splunk
index=windows EventCode=4624 Logon_Type=3
| where NOT match(Computer, "(?i)dc|domain.?controller|server")
| where NOT match(Account_Name, "(?i)\$$|machine|computer")
| stats count dc(Computer) as targets by Account_Name, Source_Network_Address
| where targets > 2
| sort -count
```

---

## Lookups and Threat Intelligence

Splunk can enrich events with threat intel. For example, check source IPs against a known-bad list:

```splunk
index=windows EventCode=4624
| lookup threat_intel_ips ip as Source_Network_Address OUTPUT threat_category
| where isnotnull(threat_category)
| table _time, Account_Name, Source_Network_Address, threat_category
```

Lookups are CSV files or KV stores uploaded to Splunk. In production, this powers IOC matching against Shodan data, VirusTotal results, or internal blacklists.

---

## Free Training Resources

| Resource | Cost | What You Get |
|---|---|---|
| **Splunk Fundamentals 1** | Free (requires account) | Official intro course, ~9 hours, covers core SPL |
| **Boss of the SOC (BOTS)** | Free (requires Splunk account) | CTF-style investigation scenarios with real log data |
| **TryHackMe Splunk 101** | Free room | Hands-on intro, walkthrough format |
| **TryHackMe Investigating with Splunk** | Free room | SOC investigation scenario |
| **Splunk Free Trial** | Free 60 days or 500MB/day | Full enterprise Splunk to practice on |

**Fastest path to interview-ready:**
1. Splunk Fundamentals 1 (understand the concepts)
2. TryHackMe Splunk 101 (hands-on basics)
3. Boss of the SOC Dataset 1 (real investigation practice)
4. Build SPL one-liners from the Essential Searches section above

---

## Setting Up Splunk Free for Practice

```bash
# Download Splunk Enterprise free (Linux)
wget -O splunk.tgz 'https://download.splunk.com/products/splunk/releases/9.x.x/linux/splunk-9.x.x-Linux-x86_64.tgz'
tar xvzf splunk.tgz -C /opt
/opt/splunk/bin/splunk start --accept-license

# Web UI at http://localhost:8000
# Default: admin / changeme

# Send Windows Event Logs: install Universal Forwarder on Windows,
# point it to your Splunk instance port 9997
```

---

## Tags
`[[Splunk]]` `[[SIEM]]` `[[Windows Event IDs]]` `[[Incident Response]]` `[[CySA+]]` `[[SOC]]` `[[SPL]]` `[[Log Analysis]]`