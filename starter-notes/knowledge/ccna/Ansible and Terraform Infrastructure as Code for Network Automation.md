# Ansible and Terraform: Infrastructure as Code for Network Automation
**Why this matters:** Manual device configuration doesn't scale. These tools enforce configuration standards across entire networks, preventing costly drift and human error—essential for modern enterprise networks.

---

## 25.1 Configuration Management Fundamentals

### What is Configuration Management?

**Simple explanation:** Configuration management is like a recipe book for your network. Instead of cooking each dish differently every time, you write down the exact steps once, then follow them consistently.

**Technical definition:** Configuration management involves maintaining, controlling, and documenting network device configurations to ensure consistency, security, and compliance across the infrastructure.

### 25.1.1 Establishing Configuration Standards

Not all device configurations should be unique. Core elements should be standardized across the network:

| Configuration Element | Purpose | Example |
|---|---|---|
| [[DNS]] servers | Consistent name resolution | `ip name-server 192.168.23.8` |
| [[NTP]] servers | Synchronized time across devices | `ntp server 172.16.1.1` |
| [[Routing Protocol]] | Standardized path selection | `router ospf 1` with same parameters |
| [[QoS]] policies | Uniform traffic treatment | Bandwidth allocation rules |
| [[AAA]] servers | Centralized access control | [[RADIUS]]/[[TACACS+]] integration |
| Security policies | Consistent security posture | ACL rules, encryption standards |
| Logging and monitoring | Centralized visibility | `logging host 172.25.25.12` |

**Why standardization matters:**
- Reduces operator burden in large networks
- Ensures predictable behavior across devices
- Simplifies troubleshooting and auditing
- Enables rapid deployment of new devices
- Improves security compliance

### 25.1.2 Configuration Drift

**Simple explanation:** Configuration drift is like a garden losing its design. You plant flowers in neat rows, but over months of individual adjustments, they scatter randomly. Nobody intentionally changed the whole garden—small changes just accumulated.

**Definition:** The gradual divergence of actual device configurations from documented standards due to manual, ad-hoc changes over time.

**Sources of drift:**
- Different engineers interpreting standards differently
- Emergency fixes that never get documented or reverted
- Mistyped commands that go unnoticed
- Forgotten changes from months ago
- Lack of monitoring to detect deviations

**Problems caused by drift:**

| Problem | Impact |
|---|---|
| Inconsistency | Devices behave unpredictably; troubleshooting becomes complex |
| Error-prone operations | Manual fixes introduce security vulnerabilities |
| Unscalability | Manual verification impossible for 1000+ devices |
| Compliance violations | Audits reveal undocumented deviations |
| Mean time to recovery (MTTR) increases | Engineers spend hours finding non-standard configs |

**Key insight:** Configuration drift is nearly *inevitable* with manual management at scale. This is where automation enters.

---

## 25.2 Configuration Management Tools Overview

### How Configuration Management Tools Work

**Simple explanation:** Instead of calling each person to change their lightbulb, you create a plan saying "all lightbulbs are 60W," then an automated system checks all houses and fixes any that don't match.

**The workflow** (tool-agnostic):

```
1. Admins edit centralized templates/files
   ↓
2. Configuration management server validates files
   ↓
3. Server applies changes to target devices (R1, R2, R3...)
   ↓
4. Devices report back compliance status
```

**Key advantages:**
- Centralized control from one location
- Idempotent operations (safe to run repeatedly)
- Audit trails of all changes
- Rapid deployment to hundreds of devices simultaneously
- Automatic detection and correction of drift

---

## 25.3 Ansible: Agentless Configuration Automation

### What is Ansible?

**Simple explanation:** Ansible is like sending detailed instructions via email to your servers. You don't need special software installed on them—they already understand SSH, which Ansible uses to send commands.

**Technical definition:** An agentless [[Infrastructure as Code]] tool that automates configuration management, application deployment, and IT orchestration using SSH-based communication with target devices.

### 25.3.1 Key Characteristics

| Feature | Benefit |
|---|---|
| **Agentless** | No software installation required on target devices |
| **SSH-based** | Works with standard network protocols; no custom ports needed |
| **Push model** | Control server pushes changes to devices (vs. agents pulling) |
| **YAML syntax** | Human-readable configuration language; minimal learning curve |
| **Idempotent** | Running playbooks multiple times achieves same result safely |
| **Modular** | Built-in modules for network, server, cloud tasks |

### 25.3.2 Core Concepts

#### Playbooks
YAML files containing ordered lists of tasks to execute on devices.

```yaml
---
- name: Configure OSPF on routers
  hosts: routers
  tasks:
    - name: Set router ID
      cisco.ios.config:
        lines:
          - router ospf 1
          - router-id 1.1.1.1

    - name: Enable OSPF on interfaces
      cisco.ios.config:
        lines:
          - ip ospf 1 area 0
        parents: "interface GigabitEthernet0/0"
```

#### Inventory
File listing all managed devices with variables:

```ini
[routers]
R1 ansible_host=192.168.1.1 device_type=cisco_ios
R2 ansible_host=192.168.1.2 device_type=cisco_ios

[switches]
S1 ansible_host=192.168.1.3 device_type=cisco_ios
```

#### Modules
Pre-built tools for specific tasks. Network modules include:
- `cisco.ios.config` – Push CLI configuration
- `cisco.ios.facts` – Gather device information
- `cisco.ios.command` – Execute read-only commands
- `cisco.ios.bgp_global` – Configure BGP specifically

#### Variables
Parameterize configurations for reusability:

```yaml
---
ntp_server: 172.16.1.1
dns_servers:
  - 192.168.23.8
  - 8.8.8.8
logging_host: 172.25.25.12
```

### 25.3.3 Ansible Advantages

| Advantage | Why It Matters |
|---|---|
| Low learning curve | Network engineers adopt faster; minimal Python knowledge needed |
| No agent overhead | Reduces security surface; no background processes on devices |
| Broad platform support | Works with Cisco, Juniper, Arista, cloud, servers, etc. |
| Large community | Extensive playbooks and documentation available |
| Event-driven | Can trigger configuration changes automatically on alerts |
| Version control friendly | Playbooks stored in Git; full change history and rollback capability |

---

## 25.4 Terraform: Infrastructure as Code for Multi-Layer Environments

### What is Terraform?

**Simple explanation:** Terraform is like a blueprint for your entire infrastructure. You describe what you want (2 routers, 3 switches, security rules), and it builds the whole thing automatically—then can destroy or modify it just as easily.

**Technical definition:** A declarative [[Infrastructure as Code]] tool that provisions and manages infrastructure across cloud providers, on-premises equipment, and software-defined networking using a desired-state model.

### 25.4.1 Key Characteristics

| Feature | Benefit |
|---|---|
| **Declarative** | Define desired state; Terraform handles the "how" |
| **Multi-cloud** | Manages AWS, Azure, GCP, Cisco devices, Juniper, etc. with same language |
| **State management** | Tracks current infrastructure state; detects and corrects drift |
| **Modular** | Providers and modules enable code reuse across projects |
| **Plan before apply** | `terraform plan` shows exactly what will change before execution |
| **Immutable infrastructure** | Destroy and recreate rather than patch (best practice) |

### 25.4.2 Core Concepts

#### Providers
Plugins that manage specific infrastructure platforms:

```hcl
terraform {
  required_providers {
    cisco-ios = {
      source = "CiscoDevNet/iosxe"
    }
  }
}

provider "cisco-ios" {
  host     = "192.168.1.1"
  username = "admin"
  password = var.device_password
}
```

#### Resources
Infrastructure objects to be managed:

```hcl
resource "cisco-ios_interface" "GigabitEthernet0_0" {
  device_name  = "R1"
  name         = "GigabitEthernet0/0"
  ip_address   = "192.168.12.1"
  subnet_mask  = "255.255.255.252"
  enabled      = true
}

resource "cisco-ios_routing_ospf" "ospf_config" {
  device_name      = "R1"
  process_id       = 1
  router_id        = "1.1.1.1"
  ref_bandwidth    = 10000
}
```

#### State Files
Terraform maintains a `.tfstate` file tracking all deployed resources:
- Enables drift detection (comparing desired vs. actual state)
- Allows safe destroy operations
- **Security note:** Contains sensitive data; must be protected in remote backends

#### Modules
Reusable configuration templates:

```hcl
module "branch_router" {
  source = "./modules/cisco_router"
  
  device_ip    = "192.168.1.1"
  ospf_id      = 1
  router_id    = "1.1.1.1"
  ntp_servers  = ["172.16.1.1"]
}
```

### 25.4.3 Terraform vs. Ansible: Key Differences

| Aspect | Terraform | Ansible |
|---|---|---|
| **Model** | Declarative (desired state) | Procedural (step-by-step) |
| **Agent required** | No (API-based) | No (SSH-based) |
| **State tracking** | Yes, explicit state files | No |
| **Idempotency** | Enforced by platform | Depends on module design |
| **Use case** | Infrastructure provisioning | Configuration management |
| **Learning curve** | Moderate (HCL language) | Low (YAML) |
| **Rollback** | `terraform destroy` or prior state | Manual revert playbook |
| **Network focus** | High-level infrastructure design | Device-level configuration |

---

## 25.5 Infrastructure as Code (IaC) Principles

### Definition
**[[Infrastructure as Code]]** is the practice of managing and provisioning infrastructure through machine-readable configuration files rather than manual processes.

### Core Benefits

| Benefit | Example |
|---|---|
| **Reproducibility** | Deploy identical environments in dev, test, production |
| **Version control** | Track all changes in Git; review before applying |
| **Auditability** | Complete history of who changed what and when |
| **Disaster recovery** | Rebuild entire network from code in hours, not days |
| **Cost optimization** | Prevent drift; identify and remove unused resources |
| **Collaboration** | Multiple engineers review and approve changes via pull requests |
| **Compliance** | Enforce security baselines automatically across all infrastructure |

---

## 25.6 Template-Based Configuration

### What Are Templates?

**Simple explanation:** A template is a document with placeholders. You fill in the device-specific information, and the system generates the final configuration automatically.

**Technical example:** Instead of manually writing configs for 100 routers, write one template and supply 100 different variable files.

### Jinja2 Templates

Most automation tools use [[Jinja2]] templating language:

```jinja2
hostname {{ device_name }}

ntp server {{ ntp_server }}
{% for dns in dns_servers %}
ip name-server {{ dns }}
{% endfor %}

router ospf {{ ospf_id }}
 router-id {{ router_id }}

interface {{ interface_name }}
 ip address {{ ip_address }} {{ subnet_mask }}
 ip ospf {{ ospf_id }} area {{ ospf_area }}
```

With variables:
```yaml
device_name: R1
ntp_server: 172.16

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 25 | [[CCNA]]*
