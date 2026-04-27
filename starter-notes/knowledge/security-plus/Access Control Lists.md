---
domain: "network security"
tags: [access-control, networking, firewall, authorization, packet-filtering, security-policy]
---
# Access Control Lists

An **Access Control List (ACL)** is an ordered set of rules that defines which users, systems, or network traffic are permitted or denied access to a resource. ACLs operate at multiple layers of the technology stack — from [[Filesystem Permissions]] on operating systems to [[Packet Filtering]] on routers and switches — making them one of the most foundational and widely deployed [[Access Control]] mechanisms in computing. They implement the principle of [[Least Privilege]] by explicitly enumerating what is allowed and blocking everything else.

---

## Overview

Access Control Lists exist because modern networks and systems must make rapid, policy-driven decisions about whether to allow an action to proceed. Without ACLs, every user would have equal access to every resource, and every packet would flow freely through network infrastructure — a condition completely incompatible with security, privacy, or regulatory compliance. ACLs solve this by attaching a list of permissions directly to the object being protected (filesystem ACLs) or to the interface through which traffic passes (network ACLs).

In the networking context, ACLs are most closely associated with Cisco IOS routers and Layer 3 switches, though equivalent constructs exist on every major network operating system including Juniper JunOS, Arista EOS, and Linux's `iptables`/`nftables`. A router applies its ACL rules sequentially to each packet, comparing the packet's attributes (source IP, destination IP, protocol, port) against each rule in the list. The first matching rule determines the action — permit or deny — and processing stops. This **first-match** behavior is one of the most important and misunderstood aspects of ACL operation.

Filesystem ACLs extend the traditional Unix permissions model (owner/group/other with read/write/execute) by allowing fine-grained per-user and per-group permissions on individual files and directories. POSIX ACLs on Linux and Windows NTFS ACLs follow this model, enabling an administrator to grant a specific user read access to a file without changing the file's ownership or its permissions for the group. This granularity is essential in enterprise environments where access patterns don't align neatly with group membership.

Network ACLs come in two main forms: **standard ACLs**, which filter only on source IP address, and **extended ACLs**, which can filter on source IP, destination IP, protocol (TCP, UDP, ICMP, etc.), source port, and destination port. Extended ACLs are far more useful in practice because they allow policy statements like "permit TCP traffic from the accounting VLAN to the database server on port 1433, deny everything else." This specificity is what makes ACLs a practical tool for [[Network Segmentation]] and [[Defense in Depth]].

In cloud environments, ACLs appear as **Network Access Control Lists (NACLs)** in AWS VPC architecture, where they function as stateless firewall rules applied at the subnet level. Unlike [[Security Groups]], which are stateful and instance-level, NACLs require explicit rules for both inbound and outbound traffic, including return traffic. This distinction is a common source of misconfiguration in cloud deployments and a frequent exam topic.

---

## How It Works

### Network ACLs (Cisco IOS Example)

ACLs on Cisco devices are configured globally and then applied to one or more interfaces in an inbound (`in`) or outbound (`out`) direction.

**Standard ACL (numbered 1–99 or 1300–1999):**
Filters on source IP address only.

```ios
! Create a standard ACL numbered 10
access-list 10 permit 192.168.1.0 0.0.0.255
access-list 10 deny   any

! Apply it to interface GigabitEthernet0/1 inbound
interface GigabitEthernet0/1
 ip access-group 10 in
```

**Extended ACL (numbered 100–199 or 2000–2699):**
Filters on source IP, destination IP, protocol, and ports.

```ios
! Permit TCP from 10.10.1.0/24 to 10.20.1.50 on port 443 only
ip access-list extended RESTRICT_WEB
 permit tcp 10.10.1.0 0.0.0.255 host 10.20.1.50 eq 443
 permit tcp 10.10.1.0 0.0.0.255 host 10.20.1.50 eq 80
 deny   ip any any log

interface GigabitEthernet0/0
 ip access-group RESTRICT_WEB out
```

**Named ACLs** (preferred in modern configurations for readability):
```ios
ip access-list extended BLOCK_TELNET
 deny tcp any any eq 23 log
 permit ip any any
```

### Processing Logic

1. Packet arrives at the interface.
2. Router checks if an ACL is applied in the relevant direction (in/out).
3. Rules are evaluated **top to bottom**, one at a time.
4. First matching rule's action (permit/deny) is applied; processing stops.
5. If no rule matches, the **implicit deny all** at the end of every ACL drops the packet.
6. Denied packets can optionally be logged with the `log` keyword, generating syslog entries.

### The Implicit Deny

Every ACL ends with an invisible `deny ip any any` rule. This means an ACL with only permit rules for specific traffic will silently drop everything else. Failing to account for this is the single most common ACL configuration mistake.

### Linux iptables Equivalent

```bash
# Block inbound Telnet (port 23) on eth0
iptables -A INPUT -i eth0 -p tcp --dport 23 -j DROP

# Allow established/related traffic (stateful rule)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH from management subnet only
iptables -A INPUT -s 10.0.0.0/24 -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP

# List current rules with line numbers
iptables -L INPUT --line-numbers -n -v
```

### Windows NTFS ACL (PowerShell)

```powershell
# View ACL on a directory
Get-Acl -Path "C:\Sensitive\HR_Data" | Format-List

# Grant a specific user read-only access
$acl = Get-Acl "C:\Sensitive\HR_Data"
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
    "DOMAIN\jsmith", "Read", "ContainerInherit,ObjectInherit", "None", "Allow"
)
$acl.SetAccessRule($rule)
Set-Acl -Path "C:\Sensitive\HR_Data" -AclObject $acl
```

### AWS NACL Structure

AWS NACLs evaluate rules in **ascending rule number order** (100, 200, 300...) and are **stateless** — return traffic must be explicitly permitted. Rule numbers should be spaced (100, 200, 300) to allow insertion without renumbering.

---

## Key Concepts

- **Implicit Deny**: Every ACL terminates with an unwritten rule that denies all traffic not matched by a preceding permit rule. This is a security default — anything not explicitly allowed is forbidden. Administrators must consciously add catch-all permits if they only want to deny specific traffic.

- **First-Match Processing**: ACL rules are evaluated sequentially, and the action of the *first* matching rule is applied immediately. Rule ordering is therefore critical — a broad `permit any` placed before a specific `deny` will nullify the deny rule entirely. More specific rules should always precede general ones.

- **Stateless vs. Stateful ACLs**: Traditional router ACLs are **stateless** — they evaluate each packet independently without tracking connection state. This means return traffic from a permitted outbound connection must be explicitly permitted inbound. **Stateful** firewalls (and `iptables` with the `conntrack` module) track connection state and automatically permit established return traffic.

- **Standard vs. Extended ACLs**: Standard ACLs filter only on source IP and should be placed **close to the destination** to avoid inadvertently blocking traffic to other destinations. Extended ACLs filter on source IP, destination IP, protocol, and port, and should be placed **close to the source** to drop unwanted traffic as early as possible.

- **Wildcard Masks**: Cisco ACLs use **wildcard masks** (inverse subnet masks) rather than subnet masks. A wildcard mask of `0.0.0.255` matches any value in the last octet, equivalent to a `/24` network. `0.0.0.0` means exact match (equivalent to the `host` keyword). `255.255.255.255` means match any address (equivalent to the `any` keyword).

- **DACL (Downloadable ACL)**: In 802.1X network authentication environments, a DACL is pushed from a [[RADIUS]] server (such as Cisco ISE) to a switch port after successful authentication, applying per-user access policy dynamically without static interface configuration.

- **SACL (System Access Control List)**: In Windows security, a SACL defines auditing policy for an object — which access attempts (successful, failed, or both) generate security log events. SACLs complement DACLs, which control access; SACLs control *auditing* of access.

---

## Exam Relevance

**SY0-701 Exam Tips:**

The Security+ exam tests ACLs primarily in the context of **network security controls**, **firewall rules**, and **least privilege implementation**. Key areas to focus on:

- **ACLs as a compensating control**: Know that ACLs on routers/switches are a network-layer access control mechanism and are distinct from host-based firewalls. Both can coexist as part of Defense in Depth.

- **Implicit deny vs. explicit deny**: The exam may ask why traffic is being dropped unexpectedly — the answer is often the implicit deny. Always expect an explicit `permit ip any any` if the intent is to allow unmatched traffic.

- **Placement logic**: Extended ACLs should be placed **near the source** (to conserve bandwidth by dropping early). Standard ACLs should be placed **near the destination** (because they only filter on source and could incorrectly block traffic to other hosts).

- **Stateless vs. stateful**: ACL-based packet filtering is stateless. Stateful inspection is a feature of proper firewalls. The exam will ask you to distinguish these concepts when choosing appropriate controls.

- **Cloud NACLs**: Know that AWS NACLs are stateless and subnet-level, while Security Groups are stateful and instance-level. This architectural distinction appears in cloud security scenario questions.

- **Common distractors**: The exam often conflates ACLs with other access control mechanisms. An ACL is a *mechanism*, while [[MAC (Mandatory Access Control)]], [[DAC (Discretionary Access Control)]], and [[RBAC (Role-Based Access Control)]] are *models*. ACLs most commonly implement DAC.

**Common question pattern**: A scenario describes unexpected traffic being blocked or permitted — trace the logic through first-match processing and the implicit deny to find the answer.

---

## Security Implications

### Attack Vectors and Weaknesses

**ACL Bypass via IP Spoofing**: Attackers can forge source IP addresses to match permitted ranges in standard ACLs. Without [[Ingress Filtering]] (BCP38) at network edges, spoofed packets may traverse ACLs that filter only on source IP. Extended ACLs with destination and port filtering reduce this risk but don't eliminate it.

**ACL Misconfiguration**: Overly permissive rules are among the most common causes of network breaches. A well-publicized example is the Capital One breach (2019), where a misconfigured AWS WAF and overly permissive IAM/NACL rules allowed an attacker to execute SSRF attacks and exfiltrate data from S3. CVE-adjacent misconfigurations rather than software vulnerabilities are frequently the root cause.

**ACL Sprawl**: In large networks, ACLs grow organically over years, accumulating contradictory, redundant, and orphaned rules. Auditing becomes impractical, and shadow rules (unreachable rules blocked by earlier matches) silently fail. Security teams may believe a rule is blocking traffic when it is in fact unreachable.

**Fragmentation Attacks**: Older ACL implementations could be bypassed by sending fragmented IP packets. The TCP header (with port information) only appears in the first fragment; subsequent fragments match permit rules because the ACL couldn't inspect their ports. Modern implementations reassemble fragments before ACL evaluation, but legacy devices remain vulnerable.

**VLAN Hopping and ACL Interaction**: In networks where [[VLAN]] segmentation is enforced by ACLs on Layer 3 interfaces (SVIs) rather than physical separation, [[VLAN Hopping]] attacks can bypass the intended segmentation by manipulating 802.1Q tagging.

**IPv6 ACL Gaps**: Many network engineers apply rigorous IPv4 ACLs but neglect equivalent IPv6 ACLs. Attackers with IPv6 access to a network may find that IPv6 traffic is not subject to the same filtering, effectively bypassing security policy entirely.

---

## Defensive Measures

### Design Principles

1. **Default-deny posture**: Start with `deny ip any any` and add specific permits only for documented, necessary traffic. Never use a default-permit posture on security-critical interfaces.

2. **Principle of least privilege**: ACL rules should permit only the minimum necessary source IPs, destination IPs, protocols, and ports. Avoid `permit ip any any` except on explicitly low-risk internal segments.

3. **Place ACLs at network boundaries**: Apply inbound ACLs on all external-facing interfaces to block RFC 1918 addresses (private IPs) arriving from the internet (anti-spoofing), known malicious IP ranges, and traffic to management interfaces.

### Specific Recommended Configurations

**Anti-spoofing ACL on external interface:**
```ios
ip access-list extended ANTI_SPOOF_INBOUND
 deny ip 10.0.0.0 0.255.255.255 any log
 deny ip 172.16.0.0 0.15.255.255 any log
 deny ip 192.168.0.0 0.0.255.255 any log
 deny ip 127.0.0.0 0.255.255.255 any log
 deny ip 0.0.0.0 0.255.255.255 any log
 permit ip any any
```

**Block management plane access from non-management networks:**
```ios
ip access-list standard MGMT_ACCESS
 permit 10.0.0.0 0.0.0.255
 deny any log

line vty 0 4
 access-class MGMT_ACCESS in
```

### Regular Auditing

- Use tools like **Tufin**, **AlgoSec**, or **Firemon** for enterprise ACL lifecycle management and conflict detection.
- On Linux, periodically export and review `iptables -L -n -v` or `nft list ruleset`.
- On Cisco devices, use `show ip access-lists` to view hit counters — rules with zero hits for extended periods may be dead rules (or attacks are being missed).

```ios
show ip access-lists RESTRICT_WEB
Extended IP access list RESTRICT_WEB
    10 permit tcp 10.10.1.0 0.0.0.255 host 10.20.1.50 eq 443 (1547 matches)
    20 permit tcp 10.10.1.0 0.0.0.255 host 10.20.1.50 eq 80 (234 matches)
    30 deny ip any any log (89 matches)
```

### Documentation and Change Management

Every ACL rule should reference a change ticket number in its remark:
```ios
ip access-list extended RESTRICT_WEB
 remark CHG-20240315: Permit HTTPS to web server per ticket INC-4492
 permit tcp 10.10.1.0 0.0.0.255 host 10.20.1.50 eq 443
```

---

## Lab / Hands-On

### Lab 1: Cisco IOS ACLs in GNS3 or Packet Tracer

**Topology**: Router R1 with two interfaces — `Gi0/0` (LAN 192.168.1.0/24) and `Gi0/1` (DMZ 10.0.