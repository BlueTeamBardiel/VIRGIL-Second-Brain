# ETW

## What it is
Think of ETW as the nervous system of Windows — a high-speed internal telegraph network where every process, driver, and kernel component can send status messages that security tools can silently intercept. Event Tracing for Windows (ETW) is a kernel-level logging framework built into Windows that allows providers (applications, drivers, OS components) to emit structured events that consumers (like EDR tools or SIEM agents) can subscribe to in real time with minimal performance overhead.

## Why it matters
Modern EDRs like Microsoft Defender for Endpoint rely heavily on ETW to detect malicious behavior — for example, subscribing to the `Microsoft-Windows-Threat-Intelligence` provider to catch process injection events that bypass traditional API hooks. Attackers counter this by "patching" ETW in memory — writing a `RET` instruction into `EtwEventWrite()` inside a target process — effectively cutting the telegraph wire so the process goes silent to defenders without triggering obvious alarms.

## Key facts
- ETW has three components: **Providers** (emit events), **Controllers** (start/stop sessions), and **Consumers** (read events); all three must align for logging to work.
- The `Microsoft-Windows-Threat-Intelligence` ETW provider requires **PPL (Protected Process Light)** trust level to subscribe — only trusted security software can access it.
- **ETW patching** (nullifying `EtwEventWrite`) is a common in-memory evasion technique used by malware like Cobalt Strike to blind EDRs.
- ETW sessions can be enumerated with `logman query -ets` — attackers use this to identify what security tools are monitoring.
- ETW is the data source behind many **Windows Event Log entries**, but ETW itself is faster and more granular than the Event Log, which is just one possible consumer.

## Related concepts
[[Windows Event Logs]] [[EDR Evasion]] [[Process Injection]] [[API Hooking]] [[SIEM]]