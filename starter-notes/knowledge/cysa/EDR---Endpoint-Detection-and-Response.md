---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# EDR - Endpoint Detection and Response
**Your endpoint's personal security camera that watches everything happening on a device and lets you stop threats in real time.**

---

## Overview

[[EDR]] is like having a security guard stationed inside every computer, laptop, and server in your organization—constantly recording what processes run, where data flows, and what files get touched. Security analysts need to understand [[EDR]] because it's the fastest way to zoom from a foggy [[SIEM]] alert into crystal-clear visibility of what's actually happening on a compromised machine. Without it, you're flying blind during an active incident.

---

## Key Concepts

### Continuous Endpoint Monitoring

**Analogy**: Think of it like a doorbell camera for your computer—it records everything that happens (who entered, what they touched, where they went), and you can rewind and watch the footage anytime.

**Definition**: [[EDR]] runs lightweight sensors on every endpoint that constantly capture process execution, network traffic, file modifications, memory activity, and user behavior. This data streams to a central server where it's stored and analyzed, giving analysts a complete historical record of endpoint activity. Common platforms include [[Carbon Black]], [[SentinelOne]], and [[FireEye HX]].

### Real-Time Visibility vs. Historical Investigation

**Analogy**: Real-time visibility is like watching a live concert; historical investigation is like reviewing the concert recording days later to catch details you missed.

**Definition**: [[Real-time visibility]] lets you see what's happening *right now* on an endpoint (current processes, active connections), while [[historical investigation]] allows you to rewind through hours or days of endpoint activity to trace how an attacker moved through a system.

---

## Analyst Relevance

You're working the SOC night shift when [[SIEM]] fires an alert: "Suspicious PowerShell execution from workstation-42." The alert is vague—could be legitimate, could be malware. Without [[EDR]], you're stuck reopening tickets. With [[EDR]]? You click two buttons and instantly see:

- The exact PowerShell command that ran
- What process spawned it (was it Explorer.exe or something sketchy?)
- Where it tried to connect (internal file server or attacker C2?)
- Whether it dropped files, modified registry, or injected into other processes
- The complete chain of events 10 minutes before and after

Within 60 seconds you've either closed the ticket or you've isolated the machine and started containment. [[EDR]] collapses investigation time from hours to minutes because you have the *full story* of what happened on that endpoint.

---

## Key Capabilities

### Threat Hunting Across All Endpoints

**Analogy**: Like having a search warrant that lets you check every filing cabinet in every office at once—"Show me all machines that have ever touched this suspicious file hash."

**Definition**: [[IOC]] (Indicator of Compromise) hunting in [[EDR]] means searching your entire fleet of endpoints for a single artifact: a file hash, domain name, IP address, process name, or registry key. If one endpoint got infected, you instantly know if the threat spread to 50 others. This [[endpoint search]] capability is one of the highest-impact tools an analyst owns.

| Search Type | Use Case | Speed |
|-------------|----------|-------|
| **File Hash** | Found malware sample, hunt for all systems with that executable | Seconds |
| **Domain/IP** | C2 callback detected, find all beaconing hosts | Seconds |
| **Process Name** | Suspicious utility (psexec, mimikatz), hunt for execution | Seconds |
| **Filename** | Webshell or persistence script, find all systems with it | Seconds |

### Host Visibility (The Complete Picture)

**Analogy**: Like a full autopsy report—you get to see every organ, tissue, and system of the body to understand what went wrong.

**Definition**: [[EDR]] gives analysts complete inventory and behavioral data on an endpoint:
- Running processes (with parent-child relationships showing how they spawned)
- Network connections (what IP/port the machine is talking to)
- File system activity (what was created, modified, deleted)
- Services and startup items (persistence mechanisms)
- Browser history and cache
- User login history

This [[host visibility]] is what transforms a SIEM alert from a question mark into a storyline.

### Live Remote Investigation

**Analogy**: Like being able to call your friend on vacation and ask them to describe their house in detail without you having to fly there in person.

**Definition**: Many [[EDR]] platforms allow analysts to remotely connect to a compromised endpoint and execute live commands—dump memory, pull specific log files, execute scripts, capture network traffic in real-time—without needing physical access. This [[live investigation]] keeps the machine isolated while you gather forensic evidence.

### Containment and Network Isolation

**Analogy**: Like slamming the emergency brake on a runaway train—you stop the threat from spreading without crashing the train.

**Definition**: [[Network isolation]] or [[network containment]] is an automated response where [[EDR]] cuts an infected endpoint off from the broader network. The machine can still reach the [[EDR]] server (so you can keep investigating) but cannot reach other internal systems, file shares, or internet—preventing lateral movement and C2 callbacks. This happens in seconds, often before an attacker realizes they've been caught.

---

## Analyst Relevance

**Real SOC Scenario**: 3 AM, your team gets a phishing alert. One user opened a malicious attachment. Here's your workflow:

1. **Alert lands in SIEM** → "Office macro detected"
2. **Jump to EDR** → Search for the attachment hash across all 5,000 endpoints
3. **Results** → Only 3 machines have it; only 1 executed it
4. **Drill into that host** → See the macro spawned cmd.exe, which tried to connect to 192.168.50.99
5. **Containment** → Hit "isolate" button; endpoint goes dark from the network in 8 seconds
6. **Investigation** → Attacker's C2 server still tries to beacon; you capture the traffic and block the IP
7. **Scope** → Search for that C2 IP across all endpoints; find 2 more infected machines

**Without EDR**: You'd be asking IT to pull logs, waiting hours for forensics, hoping you found everything.  
**With EDR**: You contained the threat and identified the full scope in 20 minutes.

---

## Exam Tips

### Question Type 1: Identifying EDR Use Cases
- *"A SOC analyst discovers suspicious PowerShell execution on a server. What should they do first to gather detailed endpoint activity data?"* → Use [[EDR]] to query the endpoint's process tree, network connections, and file modifications from the time before/after execution.
- **Trick**: Don't confuse [[EDR]] with [[antivirus]]—[[EDR]] *investigates*, [[antivirus]] *blocks*. The question might ask about investigation, not prevention.

### Question Type 2: IOC Hunting Scenarios
- *"You receive an MD5 hash of malware. You need to determine if it's on any endpoints. What EDR feature do you use?"* → [[Endpoint search]] or [[threat hunting]] capability to search the hash across all devices.
- **Trick**: Remember that [[EDR]] shows *historical* execution, not just current presence. A file might exist but never have run, or it might have been deleted but you can still see it ran yesterday.

### Question Type 3: Containment and Response
- *"An endpoint is confirmed compromised. You need to stop it from reaching the attacker's C2 server and infecting other systems. Which EDR action is most immediate?"* → [[Network isolation]]/containment to disconnect it from the network.
- **Trick**: Don't confuse isolation with deletion. Isolation keeps the machine accessible for investigation; deletion loses evidence.

### Question Type 4: EDR vs. SIEM Distinction
- *"You received an alert from SIEM about suspicious network traffic. How do you validate this alert on the endpoint?"* → Use [[EDR]] to see which process generated that traffic and what triggered the process execution.
- **Trick**: [[SIEM]] = network-level visibility; [[EDR]] = endpoint-level visibility. Use both together to confirm an attack.

---

## Common Mistakes

### Mistake 1: Thinking EDR Is Only for Malware Detection
**Wrong**: "EDR is just an advanced antivirus that catches malware."  
**Right**: [[EDR]] is an *investigation and response platform*. It doesn't necessarily catch threats (that's [[endpoint protection]] or [[antivirus]]). It gives analysts deep visibility so they can *hunt* for threats, validate alerts, and respond to incidents in real-time.  
**Impact on Exam**: You might see questions asking what to do *after* a threat is detected (not how to detect it). Answering "EDR will block it" is wrong; answering "EDR will show you the full attack chain and let you isolate the machine" is right.

### Mistake 2: Confusing Endpoint Search with Network Search
**Wrong**: "I'll search EDR for all traffic from that attacker IP."  
**Right**: [[EDR]] searches *local endpoint data* (processes, files, hashes, *local* connections). If you need network-wide traffic analysis, that's [[SIEM]] or [[network detection and response]]. [[EDR]] shows you which endpoint connected to that IP, but [[SIEM]] shows you the network-wide conversation.  
**Impact on Exam**: A question asking "Search the network for all connections to IP 10.10.10.10" might be testing whether you know [[SIEM]], not [[EDR]].

### Mistake 3: Thinking Isolation Means You Lose Investigation Access
**Wrong**: "If I isolate the endpoint, I can't investigate it anymore."  
**Right**: [[Network isolation]] cuts the endpoint off from the *network*, but it still communicates with the [[EDR]] server. You can run live commands, pull memory, capture files—you just can't spread to other systems or reach the attacker's C2.  
**Impact on Exam**: Don't hesitate to isolate in incident response scenarios. It's not a last resort; it's a *protective measure* that still lets you investigate.

### Mistake 4: Assuming EDR Data Is Always Complete
**Wrong**: "If EDR shows no suspicious activity, the endpoint is clean."  
**Right**: [[EDR]] relies on sensors that can be disabled, uninstalled, or bypassed by sophisticated attackers. It's powerful but not foolproof. [[Memory-only malware]], [[kernel-level rootkits]], and [[anti-forensics tools]] can evade [[EDR]].  
**Impact on Exam**: Questions might test whether you understand [[EDR]] limitations. It's a tool, not a guarantee.

---

## Related Topics
- [[SIEM]] (alerts that trigger endpoint investigation)
- [[Endpoint Protection]] (blocking vs. investigating)
- [[Threat Hunting]] (proactive searching vs. reactive response)
- [[Incident Response]] (EDR as a key IR tool)
- [[Indicators of Compromise]] (IOCs you search for in EDR)
- [[Network Detection and Response]] (NDR—similar concept, different layer)
- [[Memory Analysis]] (some EDR platforms capture process memory)
- [[Lateral Movement Detection]] (what EDR reveals about attacker movement)

---

*Source: CySA+ CS0-003 Study Notes | [[CySA+]] | [[Incident Response]] Playbook*