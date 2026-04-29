# Firewall Rules

## What it is
Like a bouncer with a clipboard at an exclusive club — traffic only gets in or out if its name matches the list, in the exact right order. A firewall rule is a conditional instruction that tells a firewall to **permit**, **deny**, or **drop** network traffic based on criteria like source/destination IP, port, protocol, and direction. Rules are evaluated sequentially, and the first match wins — making order critical.

## Why it matters
In 2021, attackers exploited a misconfigured firewall rule that left RDP port 3389 exposed to the internet, enabling brute-force attacks against a water treatment facility in Oldsmar, Florida. A single deny rule blocking inbound RDP from external IPs would have prevented the operator from remotely altering chemical levels. This illustrates that a missing or misplaced rule can be as dangerous as no firewall at all.

## Key facts
- **Implicit deny** (deny-all by default) means any traffic not explicitly permitted is blocked — the safest baseline posture and a core Security+ concept
- Rules are processed **top-down**; a broad "allow all" rule placed above a specific deny rule will override it, nullifying your intent
- Stateful firewalls track connection state, so a single "allow outbound" rule automatically permits the return traffic — unlike stateless (ACL-based) firewalls, which require explicit rules in both directions
- **Ingress filtering** blocks spoofed packets with internal source IPs arriving on external interfaces; **egress filtering** prevents internal hosts from initiating unauthorized outbound connections
- The principle of **least privilege** applied to firewall rules means opening only the minimum ports and protocols required — every unnecessary open port is an attack surface

## Related concepts
[[Defense in Depth]] [[Network Access Control]] [[DMZ Architecture]] [[Stateful Inspection]] [[ACL (Access Control List)]]