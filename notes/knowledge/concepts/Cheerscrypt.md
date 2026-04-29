# Cheerscrypt

## What it is
Like a locksmith who learns to crack every safe in a vault by studying one master blueprint, Cheerscrypt is a ransomware family specifically engineered to exploit VMware ESXi hypervisors — compromising dozens of virtual machines simultaneously through a single point of attack. It encrypts VM files (.vmdk, .vmx, .vmem, .vswp, .vmsn) and appends the `.Cheers` extension, leveraging ESXi's built-in command-line tools to gracefully shut down VMs before encrypting them.

## Why it matters
In May 2022, multiple organizations running VMware ESXi discovered their entire virtual infrastructures encrypted within hours, as Cheerscrypt operators gained root access to the hypervisor and ran a single shell script to detonate the ransomware. Because one ESXi host can run 20-100 VMs, attacking the hypervisor layer achieves maximum blast radius with minimal effort — one compromise, total infrastructure loss.

## Key facts
- Cheerscrypt uses the **SOSEMANUK** stream cipher for file encryption and **ECDH** (Elliptic Curve Diffie-Hellman) for key exchange, making decryption without the attacker's private key computationally infeasible
- It shares significant code overlap with the **Babuk ransomware** source code, which leaked in 2021 and seeded multiple Linux/ESXi ransomware families
- Attackers typically gain initial access via **exposed ESXi management interfaces (port 443/902)** or compromised vCenter credentials
- The ransomware deliberately calls `esxcli vm process kill` before encrypting, preventing file-lock conflicts that would block encryption
- Classified as a **double-extortion** ransomware — data is exfiltrated before encryption to pressure victims into paying

## Related concepts
[[VMware ESXi Vulnerabilities]] [[Ransomware-as-a-Service]] [[Babuk Ransomware]] [[Hypervisor Security]] [[Double Extortion]]