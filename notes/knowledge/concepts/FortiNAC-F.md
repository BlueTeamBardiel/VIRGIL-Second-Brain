# FortiNAC-F

## What it is
Think of it as a bouncer at a club who doesn't just check IDs at the door but also continuously watches guests inside, kicking out anyone who starts acting suspicious. FortiNAC-F is Fortinet's Network Access Control solution that enforces zero-trust policies by profiling, authenticating, and continuously monitoring every device attempting to join a network. The "-F" designation indicates the purpose-built appliance form factor variant of the platform.

## Why it matters
In 2023, a critical vulnerability (CVE-2023-33299, CVSS 9.6) was discovered in FortiNAC-F that allowed unauthenticated remote code execution via a Java deserialization flaw in the service listening on port 1050. An attacker on the same network segment could send a crafted payload to gain root-level control of the NAC appliance itself — the very device meant to be enforcing trust — demonstrating that security enforcement tools can become high-value attack targets.

## Key facts
- FortiNAC-F performs **device profiling** using passive fingerprinting (DHCP, HTTP user-agent, MAC OUI) and active scanning to classify endpoints without requiring an agent
- Enforces **802.1X** and non-802.1X authentication, placing non-compliant devices into quarantine VLANs automatically
- CVE-2023-33299 is a **Java deserialization vulnerability** (CWE-502) — a recurring class of flaw worth recognizing for CySA+ exam scenarios
- Supports **IoT/OT device visibility**, making it relevant in healthcare and industrial environments where unmanaged devices proliferate
- Integrates with Fortinet Security Fabric, sharing threat intelligence with FortiGate firewalls for **automated response** (isolate, notify, remediate)

## Related concepts
[[Network Access Control (NAC)]] [[802.1X Authentication]] [[Zero Trust Architecture]] [[Java Deserialization Vulnerabilities]] [[CVE and CVSS Scoring]]