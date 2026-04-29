# nf_conntrack_sip

## What it is
Like a bilingual interpreter who knows that when someone says "let's meet at the coffee shop," they'll need to arrange a separate reservation — `nf_conntrack_sip` is a Linux kernel helper module that inspects SIP signaling traffic and automatically opens firewall ports for the RTP media streams those calls will create. Precisely, it is a connection tracking helper within Netfilter that performs deep packet inspection on SIP (Session Initiation Protocol) traffic to identify and permit dynamically negotiated data channels that stateful firewall rules alone cannot anticipate.

## Why it matters
In a VoIP infrastructure attack, adversaries exploit the SIP ALG (Application Layer Gateway) behavior that `nf_conntrack_sip` enables — specifically, researchers have demonstrated that malformed SIP packets can trick the helper into opening unintended ports on the firewall, effectively punching holes in perimeter defenses. This was observed in attacks against enterprise PBX systems where manipulated SDP payloads caused the conntrack helper to expose high-numbered UDP ports to arbitrary external hosts, bypassing NAT and firewall rules entirely.

## Key facts
- Loaded as a kernel module (`modprobe nf_conntrack_sip`); monitors UDP port 5060 and TCP port 5060/5061 by default
- Parses SDP (Session Description Protocol) bodies inside SIP messages to predict and pre-authorize RTP media port ranges (typically ephemeral UDP ports 10000–20000)
- Known vulnerability class: **SIP ALG bypass** — crafted SIP/SDP payloads can manipulate conntrack into opening firewall holes for attacker-controlled addresses
- Disabling it (`options nf_conntrack_sip disable=1`) can harden firewalls but breaks NAT traversal for VoIP, requiring explicit RTP proxy solutions instead
- Relevant in CySA+ contexts as an example of stateful inspection limitations when application-layer helpers introduce attack surface

## Related concepts
[[SIP Protocol Security]] [[Network Address Translation]] [[Stateful Packet Inspection]] [[VoIP Security]] [[Netfilter]]