# ubuntu-desktop-provision

## What it is
Like a factory reset button that also installs the conveyor belt — ubuntu-desktop-provision is the automated provisioning framework used by Ubuntu to configure and install the desktop environment during initial system setup. It handles first-boot user account creation, disk partitioning, locale settings, and package installation through a unified, scriptable backend that replaced the older ubiquity installer starting with Ubuntu 23.04.

## Why it matters
During enterprise imaging workflows, attackers who compromise a provisioning pipeline can inject malicious packages or backdoored configurations before a single user ever logs in — a supply chain attack at the OS-install layer. A red team that gains access to a PXE server or autoinstall YAML file served via cloud-init can silently add a privileged user or disable auditd before the machine is handed to its owner, leaving no forensic footprint from "after deployment."

## Key facts
- Uses **subiquity** as its backend engine; autoinstall configurations are defined in YAML (`autoinstall:` key) and can be served via HTTP, cloud-init, or embedded ISO
- Runs as a **privileged system process** during installation — any tampered autoinstall YAML effectively has root-level code execution on the target machine
- Supports **cloud-init integration**, meaning provisioning directives can be injected through user-data files on cloud platforms (AWS, Azure, GCP), expanding the attack surface beyond physical media
- Default autoinstall YAML has **no integrity verification** mechanism built in — it is the administrator's responsibility to serve it over HTTPS or verify checksums
- Relevant to **CIS Benchmark hardening**: automated provisioning can enforce SSH key-only auth, disable root login, and apply UFW rules at first boot — or undo them if the YAML is malicious

## Related concepts
[[cloud-init]] [[PXE Boot Attack]] [[Supply Chain Attack]] [[Privileged Access Management]] [[Infrastructure as Code Security]]