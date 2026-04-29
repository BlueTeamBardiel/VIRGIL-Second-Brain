# Kwampirs

## What it is
Like a spy who slips into a hospital through a side door, copies every file cabinet key, and then radios home for further instructions — Kwampirs is a Remote Access Trojan (RAT) designed for long-term espionage persistence. It infiltrates networks through compromised software supply chains or lateral movement, establishes a backdoor, and beacons out to command-and-control (C2) infrastructure for follow-on tasking.

## Why it matters
In 2018–2020, the FBI warned that Kwampirs was actively targeting healthcare organizations, including hospitals and medical device companies, as well as critical infrastructure sectors. Attackers used it to harvest credentials and map internal networks — a reconnaissance goldmine — without triggering obvious alarms, since it mimicked legitimate administrative traffic patterns. Defenders responding to Kwampirs alerts had to hunt for its characteristic payload dropped into the Windows System32 directory and its self-propagation via network shares.

## Key facts
- **Attribution**: Linked to the threat actor group Orangeworm (possibly state-sponsored), known for targeting healthcare, pharmaceuticals, and industrial control systems
- **Persistence mechanism**: Installs itself as a Windows service and copies its binary across accessible network shares to propagate laterally
- **C2 communication**: Uses HTTP-based beaconing with a hardcoded list of C2 servers embedded in its configuration; traffic can blend with normal web traffic
- **Payload delivery**: Drops a main DLL and a configuration file; the DLL is loaded by a launcher executable registered as a service
- **Detection indicators**: Presence of unusual service names, unexpected files in System32, and outbound HTTP to unknown IPs on irregular intervals are key IOCs

## Related concepts
[[Remote Access Trojan (RAT)]] [[Lateral Movement]] [[Command and Control (C2)]] [[Supply Chain Attack]] [[Persistence Mechanisms]]