# Hosts File

## What it is
Think of it as a sticky note taped to your computer's front door — before asking a directory (DNS) where to find a website, your OS checks this handwritten list first. The hosts file is a local plaintext file that maps hostnames to IP addresses, functioning as a static, pre-DNS lookup override on every major operating system.

## Why it matters
Attackers who gain local access to a machine can modify the hosts file to redirect `bank.com` to a malicious IP they control — a technique called hosts file poisoning — effectively performing a local man-in-the-middle attack without touching the network. Defenders also weaponize this: security tools like Pi-hole and many ad-blockers work by pointing known malicious or ad-serving domains to `0.0.0.0`, silently dropping the connection before any DNS query leaves the machine.

## Key facts
- **Location by OS:** `C:\Windows\System32\drivers\etc\hosts` (Windows), `/etc/hosts` (Linux/macOS)
- **Priority over DNS:** The hosts file is consulted *before* DNS resolvers by default on all major OSes, making it a high-value target for persistence and redirection attacks
- **Common attacker use:** Malware frequently modifies hosts to block security vendor sites (e.g., redirecting `update.microsoft.com` to `127.0.0.1`) to prevent AV updates and OS patches
- **Loopback entry:** Every hosts file contains `127.0.0.1 localhost` by default — this is foundational and required for local services
- **Forensic artifact:** Unexpected entries in the hosts file are a strong IOC (Indicator of Compromise) and should be checked during incident response

## Related concepts
[[DNS Poisoning]] [[Man-in-the-Middle Attack]] [[Indicators of Compromise]] [[Persistence Mechanisms]] [[Local Privilege Escalation]]