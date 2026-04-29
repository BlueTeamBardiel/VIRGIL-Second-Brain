# Honeypots

## What it is
Like a glowing jar of honey left on a kitchen counter to catch flies — you're not blocking the pest, you're *luring* it to a known location so you can study its behavior. A honeypot is a deliberately vulnerable decoy system designed to attract attackers, log their tactics, and waste their time, while keeping real assets untouched.

## Why it matters
In 2015, security researchers deployed honeypots mimicking industrial SCADA systems and documented hundreds of intrusion attempts within days — revealing that attackers were specifically targeting Modbus and DNP3 protocols used in power grids. This intelligence directly informed defensive hardening of real infrastructure before those same attacks could succeed on live systems.

## Key facts
- **Honeynet** = a network of multiple honeypots, providing broader attack surface and richer behavioral data than a single decoy
- **Production honeypots** are deployed inside real environments to detect internal threats; **research honeypots** are isolated and used purely for threat intelligence gathering
- A **honeypot does not generate false positives** — any traffic to it is inherently suspicious, making alerts high-fidelity
- **Legal risk**: Honeypots can raise *entrapment* concerns if they actively lure attackers from outside; legal review is recommended before deployment
- **Canary tokens** are lightweight honeypot variants — fake credentials, URLs, or files that silently alert defenders when touched, requiring no dedicated infrastructure

## Related concepts
[[Intrusion Detection Systems]] [[Threat Intelligence]] [[Deception Technology]] [[Network Traffic Analysis]] [[Defense in Depth]]