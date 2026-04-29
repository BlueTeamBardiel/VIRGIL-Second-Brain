# Ubuntu

## What it is
Like a pre-furnished apartment where someone already installed the furniture, plumbing, and security system — Ubuntu is a Debian-based Linux distribution that ships with a configured desktop/server environment, package management (APT), and built-in security tools ready to deploy. It is one of the most widely used Linux distributions in cloud infrastructure, developer workstations, and security lab environments.

## Why it matters
Ubuntu servers are prime targets in cloud breaches because misconfigurations in default installations — such as exposed SSH on port 22 with password authentication enabled — allow brute-force attacks. In the 2020 wave of Kubernetes cluster compromises, many victim nodes ran Ubuntu with unauthenticated API endpoints exposed to the internet, allowing attackers to deploy cryptominers. Defenders use Ubuntu's `ufw` (Uncomplicated Firewall) and `AppArmor` mandatory access control to harden these systems.

## Key facts
- Ubuntu uses **APT (Advanced Package Tool)** for package management; keeping packages updated via `apt upgrade` is a primary patch management control
- **AppArmor** is Ubuntu's default Mandatory Access Control (MAC) framework, confining applications to defined profiles — relevant to least privilege concepts on Security+
- Ubuntu LTS (Long Term Support) releases receive **5 years of security patches**, making them preferred for stable enterprise/server deployments
- Default Ubuntu enables **UFW (Uncomplicated Firewall)**, but it is *inactive* out of the box — a common misconfiguration oversight in hardening checklists
- Ubuntu is the dominant OS in **Kali Linux alternatives** and is the base for many security distributions and SIEM/SOC analyst workstations

## Related concepts
[[Linux Hardening]] [[AppArmor]] [[UFW]] [[Patch Management]] [[SSH Security]]