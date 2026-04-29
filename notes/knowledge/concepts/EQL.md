# EQL

## What it is
Think of EQL like SQL for attackers' footprints — instead of querying a database of customer orders, you're querying a timeline of process events to find suspicious behavior sequences. Event Query Language (EQL) is a structured query language designed specifically to search, correlate, and sequence endpoint events (like process creation, file writes, and network connections) for threat detection and hunting.

## Why it matters
During a real incident involving a Living-off-the-Land (LotL) attack, a threat hunter might need to find every instance where `cmd.exe` spawned `powershell.exe`, which then made an outbound network connection — all within a 30-second window. EQL's sequence operator lets analysts express exactly that multi-step behavioral chain in a single query, catching what signature-based tools miss entirely.

## Key facts
- EQL was originally developed by Endgame and is now natively integrated into the Elastic Stack (SIEM/Endpoint), making it central to many CySA+ hunting scenarios
- The `sequence` keyword is EQL's superpower — it enforces temporal ordering across multiple event types, enabling detection of attack chains like phishing → macro execution → C2 beacon
- EQL operates on normalized event schemas (process, network, file, registry), meaning queries are portable across data sources that share the same schema
- Unlike regex or keyword searches, EQL is "event-aware" — it understands that a network event and a process event are fundamentally different objects
- MITRE ATT&CK detection rules are frequently expressed in EQL, and the ATT&CK Evals use it as a standard detection language

## Related concepts
[[SIEM]] [[Threat Hunting]] [[MITRE ATT&CK]] [[Behavioral Detection]] [[Elastic Stack]]