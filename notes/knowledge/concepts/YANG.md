# YANG

## What it is
Think of YANG as the blueprints for a building — it doesn't describe what the building looks like right now, just the precise rules for what *can* be built and how the rooms must connect. YANG (Yet Another Next Generation) is a data modeling language used to define the structure, syntax, and semantics of data sent via NETCONF and RESTCONF protocols for network device configuration and management. It specifies exactly what configuration parameters exist, their types, constraints, and relationships.

## Why it matters
An attacker who understands a device's YANG models can craft precisely valid NETCONF RPC calls to modify firewall rules, routing tables, or interface configurations without triggering format-validation errors — effectively using the device's own "legal vocabulary" against it. Defenders use YANG model validation as a whitelist control, rejecting any configuration payload that doesn't conform to the expected schema, limiting the blast radius of compromised management credentials.

## Key facts
- YANG is defined in **RFC 6020** (original) and **RFC 7950** (YANG 1.1), and is the mandatory data model for NETCONF (RFC 6241) and RESTCONF (RFC 8040)
- Data is hierarchical — YANG organizes network configuration into **modules, containers, lists, and leaf nodes**, similar to a typed XML/JSON schema
- YANG models are vendor-neutral but vendors publish proprietary extensions; exploiting undocumented vendor YANG modules is a real attack surface
- NETCONF operates over **SSH (port 830)** by default — compromised YANG-based management interfaces provide authenticated, structured access to full device configuration
- OpenConfig and IETF publish standardized YANG models to reduce vendor lock-in and improve auditable, machine-readable network configuration

## Related concepts
[[NETCONF]] [[RESTCONF]] [[Network Device Hardening]]