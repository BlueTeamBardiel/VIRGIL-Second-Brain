# Ammyy Admin

## What it is
Think of it as a spare key hidden under the doormat — legitimate on its face, but dangerously convenient for anyone who knows it's there. Ammyy Admin is a remote desktop access tool (RAT-adjacent) that allows users to remotely control another computer over the internet using a simple ID-based connection system. Because it requires no installation and bypasses many firewall rules, it became a favorite dual-use tool for both IT helpdesks and threat actors.

## Why it matters
The FIN7 threat group (linked to large-scale financial fraud) weaponized Ammyy Admin by bundling it inside malicious email attachments disguised as legitimate business documents. Once a victim opened the file, FIN7 established persistent remote access to point-of-sale systems, ultimately stealing millions of payment card records from restaurant and hospitality chains. Defenders learned to flag Ammyy Admin as a potentially unwanted application (PUA) even when no malware signature was present.

## Key facts
- Ammyy Admin is classified as a **Potentially Unwanted Application (PUA/PUP)** by most modern AV/EDR platforms, not always as outright malware
- It operates over **TCP port 443** (HTTPS), making traffic blend in with normal encrypted web traffic and evade simple port-based firewall rules
- The tool uses a **client ID system** rather than IP addresses, making connections harder to block via traditional ACLs
- Associated with the **FIN7 / Carbanak** threat actor campaigns targeting retail and financial sectors (2015–2018)
- Its legitimate use in helpdesk scenarios makes **allowlisting vs. blocklisting decisions** a real operational challenge for defenders

## Related concepts
[[Remote Access Trojans (RAT)]] [[Potentially Unwanted Applications (PUA)]] [[Living off the Land (LotL)]] [[FIN7 Threat Group]] [[Defense Evasion]]