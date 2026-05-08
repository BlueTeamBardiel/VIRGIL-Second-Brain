# Northbound and Southbound Interfaces

## What it is

In Far Cry 3, you climb a radio tower, the map de-fogs, and suddenly the outposts, hunting zones, and supply drops appear as icons you can act on. The radio tower is the **southbound interface** (it talks to the terrain below); the map UI Jason reads is the **northbound interface** (it talks to the player making decisions). That's exactly what an SDN controller does — it pulls raw state from devices through one door and serves a clean, programmable view through the other.

**Northbound Interface (NBI)** = controller-to-application; **Southbound Interface (SBI)** = controller-to-network-device.

## Why it matters

If the NBI breaks, your orchestrator, automation scripts, and intent-based tools go blind — no provisioning, no policy push, no telemetry to dashboards. If the SBI breaks, the controller cannot program flows, push configs, or read operational state, and the fabric falls back to whatever last-known state the devices held. CCNA expects you to identify which protocol lives on which side and map it to the correct plane.

## Key facts

### Direction and audience

| Interface | Faces | Talks to | Plane |
|---|---|---|---|
| **Northbound** | Up | Apps, orchestrators, [[SDN]] controllers' consumers | [[Management Plane]] / application |
| **Southbound** | Down | Switches, routers, APs | [[Control Plane]] to [[Data Plane]] devices |

### Northbound Interface (NBI)

- Almost always a **[[REST API]]** over **HTTPS** (TCP **443**).
- Encodes payloads in **[[JSON]]** (sometimes **[[XML]]**).
- Consumed by [[Cisco DNA Center]] apps, [[Ansible]], [[Python]] scripts, [[ServiceNow]], custom dashboards.
- Operations follow CRUD verbs: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`.
- Example call:
  ```
  GET https://dnac.example.com/dna/intent/api/v1/network-device
  Authorization: Bearer <token>
  ```

### Southbound Interface (SBI)

| Protocol | Transport | Encoding | Notes |
|---|---|---|---|
| **[[OpenFlow]]** | TCP **6653** | Binary | Pure SDN; programs flow tables directly |
| **[[NETCONF]]** | SSH TCP **830** | XML | Config + operational state; uses [[YANG]] models |
| **[[RESTCONF]]** | HTTPS TCP **443** | JSON/XML | REST-style wrapper over YANG |
| **[[OpFlex]]** | TCP **8009** | XML/JSON | Cisco [[ACI]] declarative policy |
| **[[SNMP]]** | UDP **161/162** | BER | Legacy; mostly read/telemetry |
| **CLI/SSH** | TCP **22** | Text | The "screen-scraping" SBI of last resort |

### Plane mapping

- **NBI traffic** = [[Management Plane]] (intent in, telemetry out).
- **SBI traffic** = controller's **[[Control Plane]]** instructing each device's **[[Data Plane]]** (or its local control plane, depending on architecture).
- In a pure [[OpenFlow]] model, the controller owns the control plane outright; devices are reduced to forwarding silicon.
- In hybrid models (Cisco [[SD-Access]], [[ACI]]), devices keep a local control plane and the SBI distributes policy/intent.

### Memory aid

- **North = humans and apps.** REST/JSON. Easy to read.
- **South = silicon and configs.** OpenFlow/NETCONF/RESTCONF. Closer to the metal.

### Exam traps

- "Which interface does an orchestrator use?" → **Northbound**.
- "Which protocol is southbound?" → OpenFlow, NETCONF, RESTCONF — **not** REST API by itself.
- RESTCONF appears on **both** sides in practice, but on CCNA it's classified **southbound** (controller-to-device).
- [[SNMP]] is southbound, even though it predates SDN.

## Related concepts

[[SDN Architecture]] · [[Cisco DNA Center]] · [[OpenFlow]] · [[NETCONF]] · [[RESTCONF]] · [[YANG]] · [[REST API]] · [[Control Plane]] · [[Data Plane]] · [[Management Plane]] · [[ACI]] · [[SD-Access]]

---
*Source: VIRGIL knowledge base — 2026-05-07*