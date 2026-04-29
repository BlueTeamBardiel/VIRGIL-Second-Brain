---
domain: "Network Security"
tags: [access-control, networking, firewall, authorization, security-fundamentals, network-hardening]
---
# Access Control List (ACL)

An **Access Control List (ACL)** is an ordered set of rules that defines which users, systems, or network traffic are permitted or denied access to a resource. In networking, ACLs are applied to [[Router]] interfaces and [[Firewall]] rulesets to filter [[Packet]] traffic based on criteria such as source/destination IP, protocol, and port number. In operating systems, ACLs govern file and directory permissions at a granular level beyond traditional [[Discretionary Access Control (DAC)]] models.

---

## Overview

ACLs exist as a foundational access control mechanism across two primary domains: **network ACLs** and **filesystem ACLs**. In networking, they serve as the primary mechanism for traffic filtering on routers, switches, and firewalls. Every packet traversing a router interface is evaluated against the ACL rules in sequential order until a match is found, at which point the packet is either permitted or denied. If no rule matches, an implicit **deny-all** rule — present in virtually all implementations — drops the packet silently. This default-deny posture is a core tenet of [[Defense in Depth]].

Network ACLs were popularized by Cisco's IOS router platform in the late 1980s and have since become a universal concept implemented across vendors including Juniper, Palo Alto, Fortinet, and cloud providers like AWS, Azure, and GCP. They operate primarily at Layer 3 (network) and Layer 4 (transport) of the [[OSI Model]], inspecting IP addresses and TCP/UDP port numbers. **Standard ACLs** filter only on source IP address, while **extended ACLs** can filter on source IP, destination IP, protocol, source port, and destination port simultaneously, enabling much more precise traffic control.

In operating systems, filesystem ACLs supplement or replace traditional Unix permission triplets (owner/group/other) by associating a list of principals — users or groups — with specific permission entries on each file or directory. Windows NTFS uses a rich ACL model with [[Access Control Entry (ACE)]] objects inside a **Discretionary ACL (DACL)**, while Linux supports POSIX ACLs via `getfacl`/`setfacl` commands. This allows an administrator to grant read access to a specific user without granting it to an entire group, providing fine-grained authorization.

Cloud environments have extended the ACL concept into **Security Groups**, **Network ACLs** (as distinct from security groups), and **IAM policies** in platforms like [[AWS]]. AWS VPC Network ACLs are stateless — return traffic must be explicitly permitted — whereas Security Groups are stateful. Understanding this distinction is critical for practitioners building cloud infrastructure and is a frequent source of misconfiguration vulnerabilities.

ACLs are not a substitute for deep-packet inspection or application-layer controls, but they remain a critical first line of defense in **network segmentation**, [[VLAN]] isolation, and perimeter security. They enforce the principle of [[Least Privilege]] at the infrastructure level by explicitly defining what communication is authorized.

---

## How It Works

### Network ACL Processing Logic

When a packet arrives at a router interface, the device processes the ACL bound to that interface in the direction specified (inbound or outbound). Rules are evaluated **top-down, sequentially**. The first matching rule terminates processing — this is called **first-match semantics**. If no rule matches, the implicit `deny any any` at the end drops the packet.

```
Packet arrives at interface GigabitEthernet0/1 (inbound)
        │
        ▼
Rule 1: permit tcp 10.0.0.0/24 any eq 443  → Match? → PERMIT
        │ (no match)
        ▼
Rule 2: permit tcp 10.0.0.0/24 any eq 80   → Match? → PERMIT
        │ (no match)
        ▼
Rule 3: deny ip 192.168.100.0/24 any        → Match? → DENY
        │ (no match)
        ▼
Implicit: deny ip any any                   → DENY (all remaining)
```

### Cisco IOS ACL Configuration

**Standard ACL** (filters source IP only, numbered 1–99 or 1300–1999):
```cisco
! Create standard ACL permitting only 10.10.10.0/24
Router(config)# access-list 10 permit 10.10.10.0 0.0.0.255
Router(config)# access-list 10 deny any

! Apply to interface (inbound traffic from LAN)
Router(config)# interface GigabitEthernet0/0
Router(config-if)# ip access-group 10 in
```

**Extended ACL** (named, filters on src/dst IP, protocol, ports):
```cisco
! Create named extended ACL
Router(config)# ip access-list extended CORP_POLICY

! Permit HTTPS from 10.0.1.0/24 to any destination
Router(config-ext-nacl)# permit tcp 10.0.1.0 0.0.0.255 any eq 443

! Permit DNS queries to specific DNS server
Router(config-ext-nacl)# permit udp 10.0.0.0 0.0.255.255 host 8.8.8.8 eq 53

! Deny all ICMP from untrusted subnet
Router(config-ext-nacl)# deny icmp 172.16.0.0 0.0.255.255 any

! Permit established TCP sessions (return traffic)
Router(config-ext-nacl)# permit tcp any 10.0.0.0 0.0.255.255 established

! Implicit deny — this rule exists automatically but can be explicit
Router(config-ext-nacl)# deny ip any any log

! Apply outbound on WAN interface
Router(config)# interface GigabitEthernet0/1
Router(config-if)# ip access-group CORP_POLICY out
```

**Verify ACL operation:**
```cisco
Router# show access-lists
Router# show ip interface GigabitEthernet0/1
Router# show ip access-lists CORP_POLICY
```

### Wildcard Masks

Cisco ACLs use **wildcard masks** (inverse of subnet masks) rather than CIDR notation:
```
Subnet mask:   255.255.255.0  →  Wildcard: 0.0.0.255  (/24 network)
Subnet mask:   255.255.0.0    →  Wildcard: 0.0.255.255 (/16 network)
Single host:   255.255.255.255→  Wildcard: 0.0.0.0    (host keyword)
Any host:      0.0.0.0        →  Wildcard: 255.255.255.255 (any keyword)
```

### Linux Filesystem ACL

```bash
# View ACL on a file
getfacl /srv/shared/report.pdf

# Grant user 'alice' read-only access without modifying group permissions
setfacl -m u:alice:r-- /srv/shared/report.pdf

# Grant group 'devteam' read+execute on a directory, recursively
setfacl -R -m g:devteam:r-x /srv/webapp/

# Set a default ACL (inherited by new files in directory)
setfacl -d -m u:bob:rwx /srv/projects/

# Remove a specific ACE
setfacl -x u:alice /srv/shared/report.pdf

# Verify mask and effective permissions
getfacl /srv/shared/report.pdf
# Output example:
# file: report.pdf
# owner: root
# group: staff
# user::rw-
# user:alice:r--
# group::r--
# mask::r--
# other::---
```

### Windows NTFS ACL (PowerShell)

```powershell
# View current ACL
Get-Acl C:\Shares\Finance | Format-List

# Grant read access to a specific user
$acl = Get-Acl "C:\Shares\Finance"
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
    "DOMAIN\jsmith", "Read", "ContainerInherit,ObjectInherit", "None", "Allow"
)
$acl.SetAccessRule($rule)
Set-Acl "C:\Shares\Finance" $acl
```

---

## Key Concepts

- **Standard ACL**: Filters traffic based solely on the **source IP address**. Applied close to the *destination* to avoid inadvertently blocking legitimate traffic. Cisco numbered range: 1–99.
- **Extended ACL**: Filters on **source IP, destination IP, protocol (TCP/UDP/ICMP), source port, and destination port**. Applied close to the *source* to stop unwanted traffic as early as possible. Cisco numbered range: 100–199.
- **Implicit Deny**: The **hidden final rule** in virtually every ACL implementation that drops all traffic not explicitly matched by a preceding rule. Embodies the default-deny security posture. Must be remembered when troubleshooting unexpected blocked traffic.
- **Wildcard Mask**: A **bitmask used in Cisco ACLs** where 0 bits mean "must match" and 1 bits mean "ignore." The inverse of a subnet mask. `0.0.0.255` matches any host in a /24 network.
- **Stateless vs. Stateful**: A **stateless ACL** (like AWS VPC Network ACLs and classic router ACLs) evaluates each packet independently without tracking connection state, requiring explicit rules for return traffic. A **stateful** mechanism (like firewall [[Connection Tracking]]) automatically permits return traffic for established sessions.
- **DACL vs. SACL**: On Windows, the **Discretionary ACL (DACL)** controls *who* has access, while the **System ACL (SACL)** controls *auditing* — which access attempts generate [[Security Event Log]] entries. Both live within the file's security descriptor.
- **ACE (Access Control Entry)**: An **individual rule within an ACL**, specifying a principal (user/group/IP), a permission or action (permit/deny), and optional conditions (port, protocol, time). ACLs are composed of ordered lists of ACEs.

---

## Exam Relevance

**Security+ SY0-701 Exam Tips:**

The ACL concept appears under **Domain 4.0: Security Operations** and **Domain 2.0: Threats, Vulnerabilities, and Mitigations**. Key exam focus areas include:

- **Rule order matters**: Questions often test whether you know that ACLs are processed top-to-bottom and that a broad permit rule placed before a specific deny rule will negate the deny. The most specific rules should appear *first*.
- **Implicit deny**: Expect at least one question scenario where traffic is unexpectedly blocked. The answer is almost always that no explicit permit rule exists and the implicit deny is dropping the traffic.
- **Standard vs. Extended placement**: The exam tests the Cisco best practice — standard ACLs near the *destination*, extended ACLs near the *source*. Know the reason: standard ACLs only filter on source IP, so placing them near the source might block legitimate traffic to other destinations.
- **Stateful vs. Stateless**: Know that traditional router ACLs are stateless and require `established` keyword or explicit return-traffic rules. Firewalls using connection tracking are stateful. This distinction directly maps to the exam's firewall and network security topics.
- **Context: Filesystem vs. Network**: The exam may present scenarios involving both types. Recognize when a question is about network traffic filtering vs. file permission management.

**Common gotchas:**
- Wildcard masks are *not* subnet masks — confusing them is a classic trap.
- ACLs on routers apply per-interface, per-direction. One interface can have one ACL inbound and one outbound simultaneously.
- `permit tcp any any established` does not create new sessions; it only allows return packets for existing TCP sessions (ACK/RST flags set).

---

## Security Implications

**Misconfiguration Risks:**
- **Overly permissive rules**: Using `permit ip any any` to "fix" a connectivity issue effectively disables ACL filtering. This is among the most common misconfigurations found during security audits.
- **Rule shadowing**: A broad rule appearing before a specific rule may shadow (override) the specific rule, making the specific rule unreachable. Automated ACL auditing tools specifically check for this.
- **Incorrect placement direction**: Applying an inbound ACL as outbound or vice versa leaves the intended traffic unfiltered, creating silent security gaps.

**Attack Vectors:**
- **ACL Bypass via Fragmentation**: Historically, attackers fragmented packets to bypass ACLs that only inspected the first fragment for port information. RFC 1858 and modern IOS versions address this, but legacy devices may remain vulnerable.
- **IP Spoofing**: Standard ACLs filtering on source IP can be evaded by spoofing the source address. [[Unicast Reverse Path Forwarding (uRPF)]] is a complementary control to mitigate this.
- **VLAN Hopping + ACL gaps**: In environments where [[VLAN]] segmentation relies on ACLs rather than physical or logical isolation, VLAN hopping attacks (via [[802.1Q]] double-tagging) can bypass intended ACL boundaries.

**Real-World Incidents:**
- The **Capital One breach (2019)** involved a misconfigured AWS WAF and overly permissive IAM roles — functionally analogous to ACL misconfigurations — allowing a [[Server-Side Request Forgery (SSRF)]] attack to pivot to metadata services and S3 buckets.
- **Cisco CVE-2020-3454**: A vulnerability in Cisco FXOS and NX-OS allowed authenticated attackers to bypass ACL rules through crafted packets, demonstrating that even ACL engines themselves can have flaws.
- Numerous [[PCI DSS]] audit failures involve organizations that have broad `permit any any` rules on internal segments that should enforce cardholder data environment isolation.

---

## Defensive Measures

**ACL Hardening Best Practices:**

1. **Default-deny posture**: Always build ACLs with an explicit `deny ip any any log` as the final rule so denials are logged, not silently dropped.

2. **Least-privilege traffic policy**: Define exactly which protocols and ports are needed for each network segment. Deny everything else. Use a traffic matrix documentation approach before writing rules.

3. **Regular ACL audits**: Tools like **Tufin**, **AlgoSec**, and **FireMon** automate ACL analysis to detect shadowed rules, overly permissive entries, and unused rules. Free options include manual review with `show access-lists` hit counters.

4. **Enable logging on deny rules**:
   ```cisco
   Router(config-ext-nacl)# deny ip any any log
   ```
   Forward logs to a [[SIEM]] such as [[Splunk]] or [[Elastic Stack]] for alerting.

5. **Anti-spoofing ACLs (ingress filtering per RFC 2827)**:
   ```cisco
   ! On external-facing interface — deny RFC 1918 addresses inbound from internet
   ip access-list extended ANTI_SPOOF
    deny ip 10.0.0.0 0.255.255.255 any
    deny ip 172.16.0.0 0.15.255.255 any
    deny ip 192.168.0.0 0.0.255.255 any
    deny ip 127.0.0.0 0.255.255.255 any
    permit ip any any
   ```

6. **Separate management plane ACLs**: Use Control Plane Policing (CoPP) on Cisco devices to protect the router's CPU from flood attacks targeting management protocols.

7. **Cloud-specific**: In AWS, use both Security Groups (stateful) AND Network ACLs (stateless) in a layered approach. Network ACLs can block specific IPs at the subnet boundary before Security Groups evaluate them.

8. **Document every rule**: Cisco named ACLs support remarks. Use them:
   ```cisco
   ip access-list extended CORP_POLICY
    remark --- Permit HTTPS from corporate LAN ---
    permit tcp 10.0.1.0 0.0.0.255 any eq 443
   ```

---

## Lab / Hands