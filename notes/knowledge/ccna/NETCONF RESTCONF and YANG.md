# NETCONF RESTCONF and YANG

## What it is

In **Mortal Kombat**, a fatality isn't improvised — it's a precise input string (Down, Forward, Down, Back, Punch) that the game engine recognizes and executes the same way every time. The move list defines what's possible; the controller sends the inputs; the engine performs them deterministically. That's what YANG, NETCONF, and RESTCONF do — YANG is the move list (the schema of what's valid), NETCONF and RESTCONF are the controllers sending the inputs to the device.

**[[YANG]]** is a data modeling language that defines the schema for device configuration and state. **[[NETCONF]]** and **[[RESTCONF]]** are protocols that use those models to read and write configuration programmatically.

## Why it matters

Configuring a thousand routers by SSH and copy-paste is how outages are born. Programmatic configuration is transactional, validated against a schema, and either fully applies or fully rolls back — no half-configured devices left in a coma at 3 AM. On the CCNA, expect questions on which protocol uses which transport, which port, and which encoding.

## Key facts

### YANG — the schema

- **YANG** = *Yet Another Next Generation*. A modeling language ([[RFC 7950]]) that describes the structure of configuration and operational data as a tree.
- Defines **what** can be configured (interfaces, VLANs, BGP neighbors), with data types, constraints, and hierarchy.
- Used by **both** [[NETCONF]] and [[RESTCONF]] — it is protocol-agnostic.
- Two flavors of models:
  - **Open/Standard models** — [[IETF]], [[OpenConfig]] (vendor-neutral).
  - **Native models** — vendor-specific (e.g., Cisco IOS-XE native YANG).
- A YANG module is the schema; the actual data is encoded as **[[XML]]** or **[[JSON]]**.

### NETCONF — the heavyweight

| Property | Value |
|---|---|
| RFC | [[RFC 6241]] |
| Transport | [[SSH]] (mandatory), also TLS |
| Port | **830** |
| Encoding | **[[XML]]** only |
| Style | RPC-based, stateful session |
| Operations | `get`, `get-config`, `edit-config`, `copy-config`, `delete-config`, `lock`, `unlock`, `commit`, `close-session` |
| Datastores | `running`, `candidate`, `startup` |

- **Transactional**: edits go to the **candidate** datastore, then `commit` promotes them to **running**. If the commit fails, **rollback** is automatic.
- **Locking** prevents concurrent writers from corrupting config.
- Enable on Cisco IOS-XE:

```
netconf-yang
```

### RESTCONF — the lightweight

| Property | Value |
|---|---|
| RFC | [[RFC 8040]] |
| Transport | [[HTTP]] / **[[HTTPS]]** |
| Port | **443** (HTTPS) |
| Encoding | **[[JSON]]** or [[XML]] |
| Style | RESTful, stateless |
| Operations | `GET`, `POST`, `PUT`, `PATCH`, `DELETE`, `HEAD`, `OPTIONS` |

- A **subset** of NETCONF functionality exposed over HTTP. No candidate datastore, no locking, no transactional commit/rollback in the NETCONF sense.
- URI structure: `https://<device>/restconf/data/<yang-module>:<container>/...`
- HTTP verb maps to operation:
  - `GET` → retrieve config or state
  - `POST` → create
  - `PUT` → replace
  - `PATCH` → merge/modify
  - `DELETE` → remove
- Enable on Cisco IOS-XE:

```
restconf
ip http secure-server
```

### NETCONF vs RESTCONF vs SNMP vs CLI

| Feature | CLI | [[SNMP]] | NETCONF | RESTCONF |
|---|---|---|---|---|
| Designed for automation | No | Read-mostly | Yes | Yes |
| Transport | SSH/Telnet | UDP 161/162 | SSH/TCP 830 | HTTPS/TCP 443 |
| Encoding | Text | BER | XML | JSON or XML |
| Schema | None | [[MIB]] | [[YANG]] | [[YANG]] |
| Transactional | No | No | **Yes** | No (per-request) |
| Rollback | Manual | No | **Yes** | No |
| Stateful session | Yes | No | Yes | No |

CLI scraping is brittle — change a banner, break the parser. SNMP writes are rare in practice because nobody trusts them. NETCONF and RESTCONF were built for the job.

### ncclient — Python NETCONF client

- **[[ncclient]]** is the de facto Python library for [[NETCONF]] over SSH.
- Skeleton:

```python
from ncclient import manager

with manager.connect(
    host="192.0.2.1",
    port=830,
    username="admin",
    password="cisco",
    hostkey_verify=False
) as m:
    config = m.get_config(source="running")
    print(config)
```

- For [[RESTCONF]], you don't need a special library — `requests` is enough:

```python
import requests
r = requests.get(
    "https://192.0.2.1/restconf/data/ietf-interfaces:interfaces",
    auth=("admin","cisco"),
    headers={"Accept":"application/yang-data+json"},
    verify=False
)
```

### Exam-ready triggers

- **Port 830** → NETCONF.
- **Port 443 + REST verbs** → RESTCONF.
- **XML only** → NETCONF.
- **JSON or XML** → RESTCONF.
- **Schema/data model** → YANG.
- **Commit / rollback / candidate datastore** → NETCONF.

## Related concepts

[[YANG]] · [[NETCONF]] · [[RESTCONF]] · [[SNMP]] · [[ncclient]] · [[OpenConfig]] · [[REST API]] · [[JSON]] · [[XML]] · [[Cisco DNA Center]] · [[Ansible]] · [[Python requests]] · [[RFC 6241]] · [[RFC 8040]] · [[RFC 7950]]

---
*Source: VIRGIL knowledge base*