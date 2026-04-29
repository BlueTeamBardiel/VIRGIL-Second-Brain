# esxcli

## What it is
Think of it as the SSH terminal bolted directly onto a VMware hypervisor's engine room — bypassing the web interface entirely. `esxcli` is a command-line framework built into VMware ESXi that allows administrators to configure, monitor, and manage the hypervisor and its virtual machines directly from the ESXi Shell or remotely via vSphere CLI.

## Why it matters
In the 2021 ESXiArgs ransomware campaign, attackers who gained root access to exposed ESXi hosts used commands equivalent to `esxcli vm process list` and `esxcli vm process kill` to enumerate and forcibly shut down running VMs before encrypting their flat disk files. Defenders rely on `esxcli` to audit running VMs, inspect firewall rules (`esxcli network firewall ruleset list`), and verify patch levels on hypervisors that sit outside traditional endpoint agent coverage.

## Key facts
- **Runs on the hypervisor itself** — operates at the Type-1 bare-metal level, meaning compromising it grants control over *all* hosted VMs simultaneously
- **Authentication bypass risk** — if ESXi Shell is left enabled and SSH is open, `esxcli` becomes accessible without vCenter, bypassing centralized IAM controls
- **Common attack command**: `esxcli storage vmfs extent list` is used by threat actors to locate VM disk files for targeted encryption or exfiltration
- **Hardening baseline**: CIS VMware ESXi benchmarks recommend disabling ESXi Shell and SSH by default, directly limiting `esxcli` remote access
- **Audit trail gap**: commands run via local ESXi Shell may not forward to a SIEM unless syslog is explicitly configured with `esxcli system syslog config set`

## Related concepts
[[Hypervisor Security]] [[Privileged Access Management]] [[Log Forwarding and SIEM]]