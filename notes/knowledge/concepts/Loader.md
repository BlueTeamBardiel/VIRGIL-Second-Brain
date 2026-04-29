# Loader

## What it is
Think of a loader like a stage crew that sets up the theater before the actor (malware) walks out — it prepares memory, evades detection, then hands execution off to the real payload. Precisely, a loader is a lightweight piece of malware whose sole purpose is to load, decrypt, and execute a secondary payload in memory or on disk, often without the final payload ever touching the filesystem.

## Why it matters
In the 2020 Emotet campaigns, the Emotet binary itself acted as a loader — it established persistence, fingerprinted the victim machine, and then fetched and injected TrickBot or QakBot into legitimate processes like `explorer.exe`. Defenders who only hunted for the final payload missed the infection entirely; catching the loader's process injection behavior was the only reliable detection point.

## Key facts
- Loaders commonly use **process injection techniques** (e.g., process hollowing, DLL injection) to execute payloads inside trusted processes, bypassing application whitelisting.
- **Fileless loaders** run entirely in memory (often via PowerShell or reflective DLL loading), leaving minimal forensic artifacts on disk — a key evasion advantage.
- Loaders are frequently sold as a **Malware-as-a-Service (MaaS)** commodity on dark web forums, separate from the payload itself (e.g., SmokeLoader, GuLoader).
- Detection strategies focus on **behavioral indicators**: unusual parent-child process relationships, memory regions with RWX permissions, and suspicious network calls from legitimate processes.
- A loader differs from a **dropper**: a dropper writes the payload to disk and exits, while a loader typically injects or executes in memory and may maintain a persistent communication channel.

## Related concepts
[[Process Injection]] [[Dropper]] [[Fileless Malware]] [[Command and Control (C2)]] [[Malware-as-a-Service]]