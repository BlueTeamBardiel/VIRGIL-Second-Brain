# NETCONF

## What it is
Think of NETCONF as SSH for your router's brain — instead of a human typing commands into a CLI, it's a structured, machine-to-machine conversation that lets software automatically read and rewrite network device configurations. Precisely: NETCONF (Network Configuration Protocol) is an IETF protocol (RFC 6241) that uses XML-encoded RPCs over SSH (port 830) to programmatically manage network device configurations, replacing fragile screen-scraping of CLI output.

## Why it matters
In 2020, researchers demonstrated that misconfigured NETCONF deployments on enterprise routers exposed writable configuration endpoints with weak or default credentials — an attacker with port 830 access could push malicious ACL changes or create backdoor accounts across an entire fleet of devices simultaneously. Defenders monitoring for unauthorized NETCONF sessions on port 830 can detect lateral movement by threat actors attempting to persistence through network infrastructure rather than endpoints.

## Key facts
- Runs over **SSH on TCP port 830** by default (distinguishes it from SNMP/port 161)
- Uses **XML** for encoding configuration data and **RPC** (Remote Procedure Call) for operations: `<get>`, `<get-config>`, `<edit-config>`, `<delete-config>`
- Supports **candidate, running, and startup** configuration datastores — attackers can stage malicious configs in candidate before committing
- Authentication relies entirely on **SSH mechanisms** (keys or passwords) — no native NETCONF auth layer, making SSH hardening critical
- Often paired with **YANG** data models (RFC 7950), which define the schema of what configurations are valid — a misconfigured YANG model can allow unauthorized parameter injection

## Related concepts
[[SNMP]] [[SSH]] [[Network Device Hardening]] [[RESTCONF]] [[Infrastructure as Code Security]]