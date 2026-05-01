---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 065
source: rewritten
---

# Port Security
**Network access control that authenticates users and devices before granting them permission to communicate through physical or wireless connection points.**

---

## Overview
Port security represents a critical defensive layer that operates at the network's edge—controlling who and what can actually use individual switch ports and wireless access points. For Security+, understanding port security matters because it's one of the most practical ways organizations prevent unauthorized devices from accessing network resources, whether through wired or wireless infrastructure. You've likely experienced this yourself when joining a corporate WiFi network and being prompted for credentials before gaining internet access.

---

## Key Concepts

### Extensible Authentication Protocol (EAP)
**Analogy**: Think of [[EAP]] as a universal translator for security. Just like different countries can use the same translation framework to communicate across borders, different network manufacturers can use EAP as a common authentication language—whether they build wireless systems or physical switches—so everything speaks the same security dialect.

**Definition**: [[EAP]] is a flexible authentication framework that acts as a container for various credential verification methods. It allows diverse network devices to implement standardized login procedures across multiple platforms and connection types.

**Key Characteristics**:
- Protocol-agnostic (works with many underlying authentication methods)
- Flexible and extensible for future security needs
- Vendor-independent standard

### 802.1X (Port-Based Network Access Control)
**Analogy**: Imagine a nightclub where the bouncer checks your ID before letting you through the velvet rope—that rope is 802.1X. The bouncer (authenticator) won't open access until you prove who you are, and only then can you enjoy the venue's amenities.

**Definition**: [[802.1X]], also known as [[NAC]] (Network Access Control) or [[PBNAC]] (Port-Based Network Access Control), is the IEEE standard that enforces authentication requirements on individual [[switch ports]] and [[wireless access points]]. It acts as a gatekeeper that blocks all network traffic until proper [[credentials]] are verified.

**How It Works**:
- User/device attempts to connect to a port
- Port remains in "unauthorized" state
- Authentication challenge is issued
- Credentials sent to [[RADIUS]] server or authentication backend
- Port transitions to "authorized" only after successful verification

### Port Security Components

| Component | Role | Example |
|-----------|------|---------|
| **Supplicant** | Device requesting network access | Your laptop or smartphone |
| **Authenticator** | Switch/WAP enforcing authentication | Cisco switch or Aruba access point |
| **Authentication Server** | Backend verifies credentials | [[RADIUS]], [[LDAP]], or [[Active Directory]] |

---

## Exam Tips

### Question Type 1: Identifying Port Security Protocols
- *"Which IEEE standard implements port-based network access control?"* → [[802.1X]]
- *"Your organization needs a flexible authentication framework that works across both wired and wireless networks. What should you implement?"* → [[EAP]]
- **Trick**: Candidates confuse [[EAP]] (the flexible framework) with [[802.1X]] (the specific standard that uses EAP). Remember: 802.1X *uses* EAP, not the reverse.

### Question Type 2: Port Security Scenario
- *"A user plugs into a switch port. Nothing happens until they enter credentials. What technology enforces this?"* → [[802.1X]] with [[EAP]] authentication
- **Trick**: Don't mistake port security for [[MAC filtering]]—port security requires active authentication, not just address-based blocking.

### Question Type 3: Authentication Flow
- *"Where are the actual credentials verified in a port-based network access control scenario?"* → Authentication Server ([[RADIUS]]/[[LDAP]]), not the switch itself
- **Trick**: The switch is the enforcer, not the validator. It blocks traffic until the backend server confirms legitimacy.

---

## Common Mistakes

### Mistake 1: Confusing EAP with 802.1X
**Wrong**: "802.1X is the authentication protocol we use on our network."
**Right**: "802.1X is the standard that *enforces* port access, and it uses EAP as the authentication *framework*."
**Impact on Exam**: You might select the wrong technology when asked what provides "flexible, extensible authentication" versus what "controls port access."

### Mistake 2: Believing the Switch Validates Credentials
**Wrong**: "The switch checks your username and password against its local database."
**Right**: "The switch simply blocks the port and forwards your credentials to a [[RADIUS]] or [[LDAP]] server for verification."
**Impact on Exam**: Questions testing the authentication flow will trip you up if you think the authenticator is also the validator.

### Mistake 3: Assuming Port Security Only Works on Wireless
**Wrong**: "Port security is primarily a wireless network feature."
**Right**: "Port security applies equally to wired [[Ethernet]] ports on [[network switches]] and wireless access points—it's a connection-agnostic concept."
**Impact on Exam**: Scenario questions might present a wired network scenario and you'll miss it if you mentally file port security under "wireless only."

### Mistake 4: Overlooking the Port States
**Wrong**: "Once connected, users have full access."
**Right**: "Ports start in 'unauthorized' state and remain locked until 802.1X authentication succeeds."
**Impact on Exam**: You need to understand the port transitions (unauthorized → authorized) to answer questions about what happens before authentication completes.

---

## Related Topics
- [[802.1X]]
- [[EAP]] (EAP-TLS, EAP-TTLS, PEAP)
- [[RADIUS]]
- [[Network Access Control]]
- [[MAC Filtering]]
- [[Wireless Security]]
- [[Authentication Protocols]]
- [[Switch Security]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*