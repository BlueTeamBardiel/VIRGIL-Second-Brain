# cloud-init

## What it is
Like a hotel room pre-set with your preferred pillow firmness and TV channels before you arrive, cloud-init is the system that automatically configures a cloud VM on its very first boot. It's an industry-standard multi-distribution package that handles early initialization tasks — injecting SSH keys, setting hostnames, running scripts, and installing packages — using metadata retrieved from the cloud provider's instance metadata service (IMDS).

## Why it matters
Attackers who achieve SSRF (Server-Side Request Forgery) can query the IMDS endpoint (e.g., `http://169.254.169.254/latest/user-data`) to retrieve cloud-init user-data scripts, which frequently contain hardcoded credentials, API keys, or database connection strings left by developers. The 2019 Capital One breach involved an SSRF that pivoted through the IMDS to steal AWS credentials — a textbook example of cloud-init misconfigurations enabling lateral movement and data exfiltration.

## Key facts
- cloud-init reads configuration from **user-data** (operator-supplied scripts) and **metadata** (provider-supplied instance info like IP, hostname, and IAM roles)
- The IMDS endpoint `169.254.169.254` is a link-local address accessible only from within the instance; IMDSv2 (AWS) requires session-oriented tokens to mitigate SSRF abuse
- cloud-init supports **#cloud-config** YAML files, shell scripts, and Gzip-compressed content — each detected by magic header bytes
- Sensitive data placed in user-data is **stored in plaintext** on the instance at `/var/lib/cloud/instance/user-data.txt` and readable by root
- cloud-init runs in distinct **stages**: detect, local, network, config, and final — each phase can be targeted or abused if an attacker gains early-boot persistence

## Related concepts
[[Instance Metadata Service (IMDS)]] [[Server-Side Request Forgery (SSRF)]] [[Infrastructure as Code (IaC)]] [[Privilege Escalation]] [[Secrets Management]]