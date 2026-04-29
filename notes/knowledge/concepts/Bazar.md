# Bazar

## What it is
Like a locksmith who breaks in quietly, leaves a hidden door unlocked, and then calls in a demolition crew — Bazar is a modular malware family (BazarLoader/BazarBackdoor) that silently establishes persistence and hands off access to secondary payloads. Developed by the TrickBot group (Wizard Spider), it operates as an initial access broker and backdoor, commonly delivering ransomware as its final payload.

## Why it matters
In 2021, multiple healthcare organizations were compromised via BazarLoader delivered through phishing emails with malicious Google Docs links; the backdoor then facilitated Conti ransomware deployment within hours. Defenders monitoring for unusual PowerShell activity, LOLBins abuse, and beaconing to Emercoin DNS (.bazar domains) can detect and interrupt this kill chain before ransomware executes.

## Key facts
- **Delivery method**: Typically spread via phishing emails using call-back phishing (BazarCall) where victims are tricked into calling a fake number, then directed to download a malicious executable
- **C2 infrastructure**: Uses Emercoin blockchain-based DNS (.bazar TLD) for command-and-control, making traditional domain takedowns ineffective
- **Payload chain**: BazarLoader → BazarBackdoor → Cobalt Strike beacon → Conti or Ryuk ransomware; each stage is modular and fileless-capable
- **Evasion techniques**: Abuses legitimate signed binaries (LOLBins), uses process injection, and leverages WMI for persistence — all to evade signature-based detection
- **Attribution**: Linked to Wizard Spider (aka UNC1878), the same threat actor behind TrickBot and Ryuk, classified as a sophisticated financially motivated cybercriminal group

## Related concepts
[[TrickBot]] [[Ransomware-as-a-Service]] [[Command and Control (C2)]] [[BazarCall]] [[LOLBins]]