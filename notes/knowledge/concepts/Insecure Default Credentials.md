# Insecure Default Credentials

## What it is
Like buying a padlock that ships with "0000" as the combination and never changing it — default credentials are the factory-set usernames and passwords embedded in devices and software that administrators fail to update before deployment. Specifically, these are pre-configured authentication pairs (e.g., `admin/admin`, `admin/password`) baked into routers, IoT devices, databases, and web consoles by manufacturers for initial setup convenience.

## Why it matters
The 2016 Mirai botnet attack weaponized exactly this vulnerability — it scanned the internet for IoT devices using a hardcoded list of ~60 default credential pairs, compromised over 600,000 devices, and launched the largest DDoS attack ever recorded at the time, taking down DNS provider Dyn and disrupting Twitter, Netflix, and Reddit. A defender would prevent this by enforcing credential rotation during provisioning and using network scanners like Shodan or Nmap with NSE scripts to audit exposed devices before attackers do.

## Key facts
- Default credentials are catalogued publicly on sites like **DefaultPassword.us** and in tools like **Hydra** wordlists, making attacks trivially scriptable
- OWASP lists insecure default credentials under **A07:2021 – Identification and Authentication Failures**
- Many industrial control systems (ICS/SCADA) ship with defaults that are *intentionally unchangeable*, making compensating controls (network segmentation) critical
- CIS Controls and NIST SP 800-82 both mandate default credential auditing as a baseline hardening step
- Shodan's search filters (e.g., `default password`) actively index internet-facing devices still using factory credentials

## Related concepts
[[Authentication Failures]] [[Credential Stuffing]] [[IoT Security]] [[Hardening and Baseline Configuration]] [[Botnet]]