# DHCP Relay Helper Address

## What it is

In Mass Effect, when Shepard needs to talk to the Council, the comm signal doesn't physically traverse the relays as a broadcast screaming into the void — it gets relayed through specific transmission channels that know exactly where the Citadel is. That's exactly what an **ip helper-address** does — it grabs a client's broadcast yell for "any DHCP server, please" and forwards it as a directed unicast to a server that actually exists somewhere else.

A DHCP relay agent configured with `ip helper-address` converts client broadcast DHCP messages received on a router interface into unicast (or directed) packets sent to a known DHCP server in another subnet.

## Why it matters

Without it, every subnet needs its own DHCP server — operationally absurd in any network with more than three VLANs. Clients sit there spamming `DHCPDISCOVER` to `255.255.255.255`, the router drops it like every other broadcast, and the helpdesk fields calls about "no internet." On the CCNA, expect a topology where PCs can't get addresses and the answer is one missing helper-address command on the gateway SVI.

## Key facts

### The core mechanic

[[DHCP]] clients with no IP send a [[DHCPDISCOVER]] as a Layer 2 broadcast (`FF:FF:FF:FF:FF:FF`) and Layer 3 broadcast (`255.255.255.255`). [[Routers]] do not forward [[broadcast]] traffic — that's a foundational rule of [[broadcast domains]]. The relay agent is the exception, by configuration.

### What the relay agent actually does

1. Receives the broadcast DHCPDISCOVER on the interface where it's configured.
2. Sets the **giaddr** (gateway IP address) field in the DHCP header to the IP of the receiving interface — this tells the server which subnet to allocate from.
3. Rewrites the destination to the helper-address (unicast to the [[DHCP server]]).
4. Forwards the reply back to the client.

### CLI configuration

Applied on the **interface facing the clients** — typically an SVI or sub-interface, not the interface facing the server.

```
Router(config)# interface vlan 10
Router(config-if)# ip address 10.10.10.1 255.255.255.0
Router(config-if)# ip helper-address 192.168.50.5
```

Multiple servers? Stack them:

```
Router(config-if)# ip helper-address 192.168.50.5
Router(config-if)# ip helper-address 192.168.50.6
```

### Ports and protocols forwarded

By default, `ip helper-address` forwards **eight UDP services**, not just DHCP:

| Port | Service |
|------|---------|
| 37 | Time |
| 49 | TACACS |
| 53 | DNS |
| 67 | DHCP/BOOTP server |
| 68 | DHCP/BOOTP client |
| 69 | TFTP |
| 137 | NetBIOS name |
| 138 | NetBIOS datagram |

Tune with `ip forward-protocol udp <port>` (add) or `no ip forward-protocol udp <port>` (remove).

### When you need it

- DHCP server lives in a **different subnet** from clients (the normal enterprise case).
- Centralized DHCP for many VLANs.
- Not needed when the router itself is the DHCP server (`ip dhcp pool`) or when server and clients share a broadcast domain.

### Verification

```
Router# show ip interface vlan 10 | include Helper
Router# show running-config interface vlan 10
```

### Common exam traps

- Helper-address configured on the **wrong interface** (server side instead of client side). It must sit where the broadcast arrives.
- Forgetting that `giaddr` is how the server picks the [[DHCP scope]] — if the receiving interface IP isn't in a configured pool, allocation fails silently.
- Assuming it only forwards DHCP. It forwards eight UDP services by default.

## Related concepts

[[DHCP]] · [[DHCPDISCOVER]] · [[DORA process]] · [[giaddr]] · [[Broadcast domain]] · [[SVI]] · [[UDP]] · [[ip forward-protocol]] · [[DHCP snooping]]

---
*Source: VIRGIL knowledge base — 2026-05-07*