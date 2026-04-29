# FortiSwitchManager

## What it is
Think of it as the air traffic control tower for a fleet of network switches — one centralized cockpit that directs every plane (switch) on the runway. FortiSwitchManager is Fortinet's standalone centralized management platform for FortiSwitch devices, allowing administrators to configure, monitor, and manage multiple FortiSwitch units from a single interface without requiring a FortiGate firewall as the controller.

## Why it matters
In October 2022, Fortinet disclosed **CVE-2022-40684**, a critical authentication bypass vulnerability (CVSS 9.8) affecting FortiSwitchManager (versions 7.0.0 and 7.2.0) alongside FortiGate and FortiProxy. An unauthenticated attacker could send a specially crafted HTTP/HTTPS request to the management interface and perform admin-level operations — essentially walking into the control tower and rerouting every plane. CISA added this to its Known Exploited Vulnerabilities catalog as active exploitation was confirmed in the wild.

## Key facts
- **CVE-2022-40684** is the defining vulnerability — authentication bypass via HTTP header manipulation using a forged `Forwarded` header to impersonate a trusted source
- Affected versions: FortiSwitchManager **7.0.0** and **7.2.0**; patched in 7.0.1 and 7.2.1
- The attack vector is **network-accessible management interfaces** — a core reason why exposing management planes to the internet is a critical misconfiguration
- Exploitation allowed attackers to modify admin SSH keys, creating persistent backdoor access even after patching
- Mitigation (before patching): disable HTTP/HTTPS management access or restrict via local-in policies — defense-in-depth through **network segmentation**

## Related concepts
[[Authentication Bypass]] [[CVE Exploitation]] [[Management Plane Security]] [[Network Segmentation]] [[Privileged Access Management]]