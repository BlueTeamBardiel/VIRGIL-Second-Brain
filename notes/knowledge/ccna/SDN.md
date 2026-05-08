# SDN

## What it is

In Witcher 3, Geralt doesn't decide tactics mid-swing. He stands at the menu, pauses time, picks the sign — Igni, Quen, Aard — assigns the bomb, queues the potion. Then he unpauses and his body executes what his mind already decided. The brain plans; the sword arm just swings. That's exactly what **SDN** does — it rips the "thinking" out of every individual network device and hands it to one central brain that tells the dumb muscle what to do.

**Software-Defined Networking** is an architecture that decouples the network control plane from the data plane, centralizing control-plane logic in a programmable controller that pushes forwarding instructions to devices via standardized APIs.

## Why it matters

Traditional networks make every switch and router a tiny independent kingdom — each runs its own [[OSPF]], [[STP]], and [[ARP]] tables, each configured by hand. Change a VLAN across 200 switches and you're SSHing for a week, hoping no one fat-fingers a `no` command. SDN collapses that into one API call. When it goes wrong, the controller becomes the single point of failure — kill the brain and the body keeps swinging on cached instructions until the timers expire, then everything goes dark. **Exam angle:** know the three planes, know which API points which direction, and know that [[OpenFlow]] is the canonical southbound protocol.

## Key facts

### The three planes

| Plane | Job | Traditional location | SDN location |
|---|---|---|---|
| **Data plane** | Forwards packets at line rate. ASIC work. | On each device | Stays on each device |
| **Control plane** | Decides *where* packets go — runs [[routing protocols]], builds [[FIB]]/[[MAC address table]] | On each device | Centralized in controller |
| **Management plane** | Configures and monitors devices — [[SSH]], [[SNMP]], [[Syslog]], [[NETCONF]] | On each device | Centralized |

Also called the **forwarding plane**, the data plane is the one Geralt's sword arm — it just swings. No thinking.

### Centralized controller

The **SDN controller** is the brain. It holds a global view of the topology, computes paths, and programs the forwarding tables of every device underneath it. Examples: [[Cisco DNA Center]], [[Cisco APIC]] (ACI), [[OpenDaylight]], [[ONOS]].

- One controller, many devices.
- Loses the controller, loses the ability to make *new* decisions. Existing flows keep forwarding.

### Southbound APIs (controller → devices)

Points *down* toward the dumb muscle. The controller uses these to push forwarding rules.

- **[[OpenFlow]]** — the original, standardized by the [[Open Networking Foundation]]. Defines flow tables with match/action entries.
- **[[NETCONF]]** — uses [[YANG]] data models over [[SSH]], port **830**.
- **[[RESTCONF]]** — same YANG, but over HTTPS/REST.
- **[[OpFlex]]** — Cisco ACI's southbound protocol.
- **[[Cisco OnePK]]** — legacy Cisco SDK.

### Northbound APIs (apps → controller)

Points *up* toward applications, orchestrators, and humans who want to tell the brain what outcome they want. Almost always **REST APIs** using **JSON** or **XML** over **HTTPS** (port **443**).

- An app says "give me a path between A and B with low latency."
- The controller figures out *how* and programs the devices.

### OpenFlow specifics

- Defined by the [[ONF]].
- Controller talks to switch over **TCP port 6653** (older deployments: **6633**).
- Switch maintains a **flow table**: match fields (MAC, IP, port, VLAN…) → action (forward, drop, modify, send to controller).
- Unknown flow? Switch punts to controller, controller decides, installs rule.

### Programmability and automation benefits

- **Consistency** — one config source of truth, not 200 running-configs drifting apart.
- **Speed** — provision a VLAN across the fabric in seconds via API call.
- **Intent-based networking** — declare *what* you want; controller figures out *how*. See [[Cisco DNA Center]].
- **Telemetry** — model-driven streaming via [[gNMI]] beats polling [[SNMP]] every 5 minutes.
- **Tools** — [[Python]] with `requests`, [[Ansible]], [[Terraform]], [[Postman]] for hitting REST endpoints.

```
# Example REST call to a controller (conceptual)
curl -X GET https://controller.example.com/api/v1/network-device \
     -H "Content-Type: application/json" \
     -H "X-Auth-Token: <token>"
```

### SDN architectures on the CCNA

| Model | Style | Example |
|---|---|---|
| **Imperative** | Controller dictates exact forwarding rules | OpenFlow |
| **Declarative** | Devices retain some intelligence; controller declares intent | Cisco ACI, DNA Center |
| **Overlay** | SDN runs on top of a traditional underlay | [[VXLAN]] + [[EVPN]] |

## Related concepts

[[OpenFlow]] · [[NETCONF]] · [[RESTCONF]] · [[YANG]] · [[Cisco DNA Center]] · [[Cisco APIC]] · [[REST API]] · [[JSON]] · [[Ansible]] · [[Python]] · [[Control plane]] · [[Data plane]] · [[Management plane]] · [[Intent-based networking]] · [[VXLAN]]

---
*Source: VIRGIL knowledge base — 2026-05-07*