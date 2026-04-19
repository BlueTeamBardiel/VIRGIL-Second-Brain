---
domain: "network security"
tags: [access-control, networking, firewall, authorization, network-security, cisco]
---
# Access Control Lists (ACLs)

**Access Control Lists (ACLs)** are ordered sets of rules that define which network traffic or system resources are **permitted or denied** based on defined criteria such as source/destination IP addresses, ports, and protocols. ACLs operate at the intersection of [[Network Security]] and [[Authorization]], serving as a foundational mechanism for enforcing [[Least Privilege]] across both network infrastructure and file systems. They are implemented in routers, switches, firewalls, and operating systems to control the flow of data and access to resources.

---

## Overview

ACLs were originally developed as a mechanism to provide basic packet filtering on routers, predating dedicated firewalls. As networks grew in complexity, ACLs became a standard tool embedded in virtually every network operating system, from Cisco IOS to Linux iptables. Their fundamental purpose is to act as a gatekeeper: examining each packet or access request and comparing it against an ordered list of rules to determine whether it should be allowed to proceed.

There are two primary contexts in which ACLs appear: **network ACLs** and **filesystem ACLs**. Network ACLs filter traffic passing through routers, switches, and firewalls by inspecting packet headers. Filesystem ACLs (such as POSIX ACLs on Linux or NTFS ACLs on Windows) control which users or groups can read, write, or execute specific files and directories. Both types share the same conceptual framework — an ordered list of entries that are evaluated sequentially until a match is found.

In network environments, ACLs are applied to router or switch interfaces and specify either an **inbound** (ingress) or **outbound** (egress) direction. Inbound ACLs filter traffic before it enters the routing process, while outbound ACLs filter traffic after routing decisions have been made but before the packet leaves the interface. This distinction is critical because placing an ACL in the wrong direction can allow unintended traffic to traverse segments of the network.

A key characteristic of all ACLs is the **implicit deny all** rule at the end of every list. If a packet does not match any explicitly defined rule, it is automatically dropped. This behavior embodies the security principle of default-deny and means administrators must be deliberate and thorough when writing ACL rules — failing to include a necessary permit statement will silently drop legitimate traffic, which can be challenging to troubleshoot.

ACLs are not a replacement for stateful firewalls, [[Intrusion Detection Systems (IDS)]], or [[Next-Generation Firewalls (NGFW)]]. They are stateless by nature in their traditional implementation: each packet is evaluated individually without awareness of connection state. This means a standard ACL cannot distinguish between a legitimate return packet for an established TCP session and a spoofed packet crafted to look like one. Extended ACLs with established keywords and stateful devices address this limitation.

---

## How It Works

### ACL Rule Structure

Each entry in an ACL is called an **Access Control Entry (ACE)**. An ACE typically contains:
- **Action**: `permit` or `deny`
- **Protocol**: IP, TCP, UDP, ICMP, etc.
- **Source address** (with wildcard or subnet mask)
- **Destination address** (with wildcard or subnet mask)
- **Source/Destination port** (for extended ACLs)
- **Optional conditions**: `established`, `log`, `time-range`

ACEs are evaluated top-down. The first matching ACE is applied and evaluation stops — subsequent rules are not checked. This **first-match** logic makes rule ordering critically important.

### Standard vs. Extended ACLs (Cisco IOS)

**Standard ACLs** filter based on source IP address only. They are numbered 1–99 and 1300–1999.

```bash
! Standard ACL - permit traffic from 192.168.1.0/24
Router(config)# access-list 10 permit 192.168.1.0 0.0.0.255
Router(config)# access-list 10 deny any

! Apply to interface (inbound)
Router(config-if)# ip access-group 10 in
```

**Extended ACLs** filter on source/destination IP, protocol, and port. They are numbered 100–199 and 2000–2699.

```bash
! Extended ACL - permit HTTP from any source to 10.0.0.5
Router(config)# access-list 110 permit tcp any host 10.0.0.5 eq 80
Router(config)# access-list 110 permit tcp any host 10.0.0.5 eq 443
Router(config)# access-list 110 deny ip any any log

! Apply to interface (outbound toward server)
Router(config-if)# ip access-group 110 out
```

### Named ACLs

Named ACLs provide human-readable identifiers and allow individual entries to be deleted or added without rewriting the entire list:

```bash
Router(config)# ip access-list extended BLOCK_TELNET
Router(config-ext-nacl)# deny tcp any any eq 23 log
Router(config-ext-nacl)# permit ip any any
Router(config-if)# ip access-group BLOCK_TELNET in
```

### Wildcard Masks

Cisco ACLs use **wildcard masks** (inverse of subnet masks) to define ranges. A `0` bit means "must match," a `1` bit means "any value."

```
Network: 192.168.10.0/24
Subnet mask:   255.255.255.0
Wildcard mask:   0.0.0.255

Specific host: 10.1.1.1
Wildcard mask:   0.0.0.0  (or use keyword "host")
Any address:   0.0.0.0
Wildcard mask: 255.255.255.255  (or use keyword "any")
```

### Linux iptables ACL Equivalent

On Linux, iptables rules function as ACLs for the kernel's [[Netfilter]] framework:

```bash
# Block inbound Telnet (port 23)
iptables -A INPUT -p tcp --dport 23 -j DROP

# Permit SSH from management subnet only
iptables -A INPUT -p tcp -s 192.168.100.0/24 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP

# Log and drop everything else
iptables -A INPUT -j LOG --log-prefix "ACL-DROP: "
iptables -A INPUT -j DROP

# Save rules
iptables-save > /etc/iptables/rules.v4
```

### NTFS ACL (Windows Filesystem)

Windows uses Discretionary ACLs (DACLs) and System ACLs (SACLs) to control file/folder access:

```powershell
# View ACL on a file
Get-Acl C:\SensitiveData | Format-List

# Set read-only permission for a user
$acl = Get-Acl "C:\SensitiveData"
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
    "DOMAIN\jsmith", "Read", "Allow")
$acl.SetAccessRule($rule)
Set-Acl "C:\SensitiveData" $acl
```

### Placement Best Practices

- **Standard ACLs**: Place close to the **destination** (they can't filter by destination, so placing close to source would block too broadly)
- **Extended ACLs**: Place close to the **source** to prevent unwanted traffic from consuming network bandwidth

---

## Key Concepts

- **Access Control Entry (ACE)**: A single rule within an ACL that specifies a permit or deny action along with matching criteria (source/destination IP, protocol, port). ACEs are the atomic units of access control policy.

- **Implicit Deny All**: Every ACL terminates with an invisible `deny any any` rule. Any traffic not matching an explicit permit statement is silently dropped. This is a core security default and a frequent source of misconfiguration issues.

- **Wildcard Mask**: The inverse of a subnet mask used in Cisco ACLs to specify address ranges. Bits set to `0` must match exactly; bits set to `1` are ignored. A wildcard of `0.0.0.255` matches any host in a /24 network.

- **Stateless Filtering**: Traditional ACLs evaluate each packet independently without tracking connection state. They cannot distinguish between a TCP SYN packet initiating a connection and a spoofed ACK. The `established` keyword is a partial workaround, checking only for TCP ACK/RST flags.

- **DACL (Discretionary ACL)**: In Windows security, a DACL defines which users and groups are allowed or denied access to an object (file, registry key, etc.). The object owner controls the DACL, distinguishing it from a SACL.

- **SACL (System ACL)**: A Windows ACL that specifies which access attempts generate audit log entries. SACLs are controlled by administrators and feed into the Windows Security Event Log, making them essential for [[Security Auditing]].

- **VLAN ACL (VACL)**: A Cisco construct that applies ACL filtering to all traffic within a VLAN, including traffic that is switched (not routed) between hosts in the same VLAN — something standard interface ACLs cannot do.

- **Port ACL (PACL)**: Applied directly to a Layer 2 switch port to filter traffic entering that specific port, allowing per-device access control at the edge of the network.

---

## Exam Relevance

**SY0-701 Domain Mapping**: ACLs appear primarily in **Domain 4.0 – Security Operations** (network hardening) and **Domain 2.0 – Threats, Vulnerabilities, and Mitigations** (network segmentation controls).

**Common Question Patterns**:
- Questions asking which type of ACL to use when filtering by source IP only vs. source/destination IP and port (standard vs. extended)
- Scenarios involving placement of ACLs on router interfaces — always remember extended near source, standard near destination
- Questions about the **implicit deny** and what happens to unmatched traffic
- ACLs used in conjunction with [[Network Segmentation]], [[DMZ]] architecture, or [[Zero Trust]] concepts
- Distinguishing ACLs from stateful firewalls — ACLs are typically stateless

**Gotchas**:
- The exam may present ACLs as a "firewall" alternative — know that ACLs are stateless and lack application-layer inspection unless paired with a NGFW
- Remember that on Cisco devices, an interface with no ACL applied **permits all traffic** — the implicit deny only applies when an ACL exists
- VLAN ACLs (VACLs) filter intra-VLAN traffic; interface ACLs do not — a common trick question
- Filesystem ACLs (NTFS, POSIX) and network ACLs share the same concept but apply to entirely different contexts; the exam tests both
- The `established` keyword in a Cisco ACL is **not** stateful inspection — it only checks for TCP ACK or RST flags and can be spoofed

---

## Security Implications

### Attack Vectors Targeting ACL Weaknesses

**ACL Bypass via IP Spoofing**: Traditional stateless ACLs filter on source IP. An attacker who spoofs a permitted source IP address may bypass ingress ACLs. Egress filtering (BCP38/RFC 2827) helps mitigate this by blocking traffic with invalid source addresses leaving a network.

**Fragmentation Attacks**: Some older ACL implementations only inspect the first fragment of a fragmented IP packet. Subsequent fragments may lack port information and pass through ACLs unchecked, potentially reassembling into malicious payloads at the destination. Modern implementations handle fragment reassembly before ACL evaluation.

**ACL Rule Order Manipulation**: If an attacker gains access to network device management interfaces, they can insert permit rules at the top of an ACL to bypass security controls. This was a factor in multiple Cisco IOS exploitation incidents where unauthorized administrative access led to ACL tampering.

**Overly Permissive Rules**: A common misconfiguration is using `permit ip any any` as a catchall during troubleshooting and forgetting to remove it. This effectively disables the ACL. Automated configuration auditing tools can detect such rules.

**CVE-2021-1609 (Cisco Small Business Routers)**: This vulnerability allowed remote attackers to bypass authentication and ACL controls on Cisco RV series routers through crafted HTTP requests. It demonstrated that ACLs implemented in software can be undermined by application-layer vulnerabilities in the management plane.

**VLAN Hopping**: If VACLs or trunk port configurations are misconfigured, attackers can use [[VLAN Hopping]] techniques (double-tagging or switch spoofing) to bypass ACLs enforced on a per-VLAN basis.

### Detection

ACL violations can be detected by enabling the `log` keyword on deny rules in Cisco IOS:
```bash
access-list 110 deny ip any any log
```
This sends syslog messages for every dropped packet, which can be forwarded to a [[SIEM]] for alerting and correlation.

---

## Defensive Measures

### Network ACL Hardening

1. **Apply egress and ingress filtering**: Do not rely solely on ingress ACLs. Egress ACLs prevent spoofed or malformed traffic from leaving your network, implementing [[BCP38]].

2. **Block RFC 1918 addresses at the perimeter**: Prevent private IP addresses from entering or leaving on public-facing interfaces.

```bash
ip access-list extended BOGON_FILTER
 deny ip 10.0.0.0 0.255.255.255 any
 deny ip 172.16.0.0 0.15.255.255 any
 deny ip 192.168.0.0 0.0.255.255 any
 deny ip 127.0.0.0 0.255.255.255 any
 permit ip any any
```

3. **Use named ACLs** for all production configurations — they are easier to audit, modify, and document.

4. **Enable ACL logging** on all deny rules and forward syslogs to a centralized SIEM such as [[Splunk]] or [[Elastic Stack]].

5. **Implement VLAN ACLs** for inter-host traffic within sensitive VLANs that does not traverse a routed interface.

6. **Audit ACLs regularly** using tools like Cisco's Network Configuration Manager, Nipper Studio, or open-source tools like `acl-audit` to detect shadowed rules, overly permissive entries, or rules that conflict with security policy.

### Filesystem ACL Hardening

7. **Remove world-writable permissions**: On Linux, find and remediate files with unsafe permissions:
```bash
find / -perm -0002 -type f -not -path "/proc/*" 2>/dev/null
```

8. **Audit NTFS DACLs** on Windows servers for sensitive directories:
```powershell
Get-ChildItem "C:\SensitiveData" -Recurse | Get-Acl | 
    Select-Object Path, AccessToString | Export-Csv acl_audit.csv
```

9. **Apply the principle of least privilege**: Grant only the minimum permissions required. Prefer explicit deny over relying on the implicit deny for intentional blocks (for clarity in audits).

10. **Use Group Policy Objects (GPOs)** on Windows to enforce consistent ACL templates across systems in a domain environment, preventing local administrators from weakening security settings.

---

## Lab / Hands-On

### Lab 1: Standard and Extended ACLs on a Virtual Router

**Tools needed**: GNS3 or Cisco Packet Tracer (free), or a physical Cisco router with IOS.

```bash
# Topology: PC1 (192.168.1.10) -> R1 -> Server (10.0.0.5)

# Step 1: Create extended ACL to allow only HTTP/HTTPS to the server
R1(config)# ip access-list extended WEBONLY
R1(config-ext-nacl)# permit tcp any host 10.0.0.5 eq 80
R1(config-ext-nacl)# permit tcp any host 10.0.0.5 eq 443
R1(config-ext-nacl)# permit icmp any any
R1(config-ext-nacl)# deny ip any any log

# Step 2: Apply ACL to the inbound interface facing the LAN
R1(config)# interface