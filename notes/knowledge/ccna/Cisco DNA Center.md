# Cisco DNA Center

## What it is

In Factorio, by hour forty you stop placing individual inserters and start drawing **blueprints** — entire factory blocks the construction robots stamp out automatically, while alerts scream when a mining outpost runs dry or biters chew through a wall. That's exactly what Cisco DNA Center does — you describe the network you want, and a centralized controller pushes the config to every switch and tells you the moment something starts bleeding.

**Cisco DNA Center** (rebranded **Catalyst Center** in 2023) is Cisco's on-premises controller appliance for intent-based management, automation, and assurance of enterprise campus networks running Catalyst 9000 hardware.

## Why it matters

Configuring 400 access switches by hand via SSH is how careers end and outages begin. DNA Center collapses that into template-driven provisioning, continuous telemetry-based health scoring, and one-click SD-Access fabric deployment — the difference between a network engineer and a ticket-closing button. For the CCNA, expect questions distinguishing **traditional CLI management** from **controller-based / intent-based networking**, and identifying DNA Center's role as the SD-Access control plane manager.

## Key facts

### The four pillars

| Pillar | What it does |
|---|---|
| **Design** | Site hierarchy, IP pools, AAA, DNS, SNMP — the network blueprint |
| **Policy** | Group-based access via [[Cisco ISE]] and [[SGT]] (Scalable Group Tags) |
| **Provision** | Push configs to devices, deploy [[SD-Access]] fabric, onboard via [[PnP]] |
| **Assurance** | Telemetry, health scores (0–10), root cause analysis, [[ML]]-driven insights |

### Assurance

- Pulls **streaming telemetry**, [[NetFlow]], [[Syslog]], [[SNMP]], and wireless data
- Produces **client, network, and application health scores** on a 1–10 scale
- **AI Network Analytics** baselines normal behavior and flags anomalies
- "Why was Bob's Zoom bad at 2:14pm?" — answered without packet captures

### Automation

- **LAN Automation** — uses [[PnP]] + [[IS-IS]] to onboard greenfield switches with zero CLI
- **Templates** — Jinja2/Velocity for parameterized config
- **Software Image Management (SWIM)** — IOS-XE upgrades at scale
- **Plug and Play** — new device contacts DNAC, downloads image and config

### Intent-Based Networking ([[IBN]])

The CCNA-favorite phrase. Three loops:
1. **Translation** — business intent → device config
2. **Activation** — push config to fabric
3. **Assurance** — verify intent is being met, remediate drift

### Northbound REST API

- DNAC exposes a **northbound [[REST API]]** to ITSM, orchestration, and custom tooling (ServiceNow, Ansible, Python scripts)
- Auth via **token** from `/dna/system/api/v1/auth/token`
- Returns **JSON** over **HTTPS/TCP 443**
- Southbound to devices uses [[NETCONF]], [[RESTCONF]], [[SNMP]], [[CLI]], [[Telnet]] (please don't), and [[SSH]]

```
POST https://<dnac>/dna/system/api/v1/auth/token
Authorization: Basic <base64(user:pass)>
```

```
GET https://<dnac>/dna/intent/api/v1/network-device
X-Auth-Token: <token>
```

### ISE Integration

- **pxGrid** integration with [[Cisco ISE]] carries identity and [[SGT]] mappings
- DNAC handles **macro-segmentation** (Virtual Networks / [[VRF]]s)
- ISE handles **micro-segmentation** (group-based policy via SGTs)
- Together they enforce **policy by user/device identity**, not IP

### Role in SD-Access fabric

DNA Center is the **fabric controller and orchestrator** — it does not sit in the data path. The fabric itself uses:

| Plane | Protocol |
|---|---|
| **Control plane** | [[LISP]] (endpoint-to-location mapping) |
| **Data plane** | [[VXLAN]] (overlay encapsulation, carries SGT) |
| **Policy plane** | [[CTS]] / SGT from [[Cisco ISE]] |

DNAC provisions fabric roles: **Control Plane Node**, **Border Node**, **Edge Node**, **Fabric WLC**, **Fabric AP**, **Extended Node**.

### Exam-ready contrasts

| Traditional | Controller-based (DNAC) |
|---|---|
| Per-device CLI | Centralized intent |
| SNMP polling | Streaming telemetry |
| Manual VLAN sprawl | [[VXLAN]] overlay over IP underlay |
| ACLs by IP | [[SGT]]-based policy |
| Reactive troubleshooting | Predictive assurance |

## Related concepts

[[SD-Access]] · [[Cisco ISE]] · [[LISP]] · [[VXLAN]] · [[SGT]] · [[Intent-Based Networking]] · [[REST API]] · [[NETCONF]] · [[Plug and Play]] · [[Catalyst 9000]] · [[Software-Defined Networking]] · [[pxGrid]]

---
*Source: VIRGIL knowledge base — 2026-05-07*