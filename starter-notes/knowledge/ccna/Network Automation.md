# Network Automation
**Why This Matters:** Automation transforms networks from manually-configured collections of individual devices into intelligently managed systems that scale to thousands of nodes—reducing human error, cutting operating expenses, and enabling modern enterprise agility.

## 22.1 The Benefits of Network Automation

### What Is Network Automation?

Think of network automation like switching from hand-delivering mail to every address in a city (manual) versus sending a truck with a sorted route (automated). Network automation uses **software to perform repetitive network tasks without human intervention**—from simple scripting to complex multi-device orchestration platforms.

**Simple analogy first:** Instead of SSHing into 1,000 routers individually to add a new Syslog server, you write one script that does it to all 1,000 in minutes.

**The detail:** Network automation encompasses:
- Configuration management across heterogeneous devices
- Provisioning and deployment workflows
- Policy enforcement at scale
- Monitoring and alerting integration
- Remediation of network issues without manual tickets

### Key Benefits

| Benefit | Impact |
|---------|--------|
| **Accuracy** | Eliminates typos, misconfigurations, and human error in repetitive tasks |
| **Speed** | Deploys changes to hundreds/thousands of devices in minutes instead of weeks |
| **Reduced OpEx** | Fewer engineer hours required per operational task |
| **Scalability** | Networks can grow beyond manual management capacity |
| **Consistency** | Every device receives identical configurations and policy enforcement |
| **Auditability** | All changes tracked and versioned through code repositories |

### The Real-World Scenario

Adding a new Syslog server to 1,000 devices manually:
```
R1# configure terminal
R1(config)# logging host 192.0.2.1
R1(config)# snmp-server host 192.0.2.1 version 2c ComMun1tyS7R1ng!
R1(config)# end
R1# copy running-config startup-config
```

Repeated 1,000 times = weeks of work + inevitable errors.

**With Python automation** (using [[Netmiko]] library):
```python
from netmiko import ConnectHandler

devices = [
    {"device_type": "cisco_ios", "host": "R1", "username": "admin", "password": "pW12!"},
    {"device_type": "cisco_ios", "host": "R2", "username": "admin", "password": "pW12!"}
]

commands = [
    "logging host 192.0.2.1",
    "snmp-server host 192.0.2.1 version 2c ComMun1tyS7R1ng!"
]

for device in devices:
    print(f"Connecting to {device['host']}...")
    try:
        with ConnectHandler(**device) as net_connect:
            output = net_connect.send_config_set(commands)
            print(output)
            net_connect.save_config()
    except Exception as e:
        print(f"Failed to connect to {device['host']}: {e}")

print("Configuration complete.")
```

Result: 1,000 devices configured in minutes with guaranteed consistency.

**Important distinction:** Automation reduces **OpEx** (operating expenses—labor, time) but NOT **CapEx** (capital expenses—hardware, infrastructure).

---

## 22.2 Software-Defined Networking (SDN)

### Core Concept

SDN is the **separation of the network's intelligence (brain) from its forwarding capability (brawn)**, centralizing control in software controllers rather than distributing it across every device.

**Simple analogy:** Traditional networks = every mail carrier decides their own route independently. SDN = one central dispatcher tells all mail carriers the optimal routes.

**The detail:** In traditional networks, each router/switch runs its own routing protocols, makes independent decisions about traffic forwarding, and requires individual configuration. SDN decouples this into [[Controller-Based Architecture|controller-based architecture]] where:
- A **centralized controller** computes all forwarding decisions
- Network devices become **simple forwarders** that execute controller directives
- Intelligence is programmable, not embedded in hardware

This is similar to [[Wireless LAN Architecture#Split-MAC Architecture|WLC split-MAC architecture]] you've seen with wireless networks.

---

## 22.3 The Three Logical Planes

Every networking device performs functions that fall into three logical categories:

### Data Plane (Forwarding Plane)
- **Responsibility:** Actual packet/frame forwarding based on current tables
- **Functions:**
  - Forwarding decisions using routing/MAC tables
  - Physical transmission of data
  - QoS marking and queue management
  - Stateless, high-speed operations
- **Devices:** Linecards, ASICs, forwarding engines
- **Timing:** Microsecond latency required

### Control Plane
- **Responsibility:** Building the tables and policies that Data Plane uses
- **Functions:**
  - Running routing protocols ([[OSPF]], [[BGP]], [[EIGRP]])
  - Building ARP tables via [[ARP|Address Resolution Protocol]]
  - Computing spanning tree topology ([[RSTP]])
  - Processing control messages ([[ICMP]], routing updates)
  - Managing neighbor relationships
- **Devices:** Router/switch CPU
- **Timing:** Second-scale convergence acceptable

### Management Plane
- **Responsibility:** Configuring and monitoring devices
- **Functions:**
  - [[SSH]], Telnet, console access for CLI configuration
  - [[SNMP]] for monitoring and statistics collection
  - [[Syslog]] for logging device events
  - [[NTP]] for time synchronization
  - TFTP/FTP for file transfers
- **Devices:** Administrative terminals, management servers
- **Timing:** No strict latency requirement

| Plane | Purpose | Examples | Time-Sensitive? |
|-------|---------|----------|-----------------|
| **Data** | Forward traffic | Switching, routing lookups, QoS | YES (microseconds) |
| **Control** | Build forwarding decisions | OSPF, BGP, STP, ARP | SOMEWHAT (seconds) |
| **Management** | Configure & monitor | SSH, SNMP, Syslog, NTP | NO (minutes) |

### Visual Example: Three Routers

```
R1 ←OSPF→ R2 ←OSPF→ R3

Management Plane: Admin uses SSH to enable OSPF and adjust timers
Control Plane: Routers exchange OSPF hellos, build routing tables
Data Plane: R1 forwards packets destined for R3's network toward R2
```

---

## 22.4 SDN Architecture: Separation of Planes

### The Traditional Approach (Tightly Coupled)

```
┌─────────────────────────┐
│  Router/Switch Device   │
├─────────────────────────┤
│   Management Plane      │  } All three planes
│   Control Plane         │  } run on the same
│   Data Plane            │  } physical device
└─────────────────────────┘
```

Each device independently:
- Decides how to route packets (Control Plane)
- Forwards those packets (Data Plane)
- Gets configured via CLI (Management Plane)

**Problem:** Scale and flexibility. Adding thousands of devices means thousands of independent decision-makers, hard to coordinate.

### The SDN Approach (Decoupled)

```
┌────────────────────────────────┐
│    SDN Controller              │
│  (Management + Control Planes) │
└──────────────┬─────────────────┘
               │
    ┌──────────┼──────────┐
    │          │          │
┌───▼──┐  ┌───▼──┐  ┌───▼──┐
│ R1   │  │ R2   │  │ R3   │
│(DP)  │  │(DP)  │  │(DP)  │
└──────┘  └──────┘  └──────┘

DP = Data Plane only (dumb forwarders)
```

**Benefit:** One intelligent decision-maker controls all forwarding across the entire network. Changes propagate instantly to all devices.

### Key Architectural Separation

**North-Bound APIs** ([[North-Bound API]])
- Interface between **controller and applications/administrators**
- Applications tell controller what network policy should be
- Typically REST-based, JSON/XML payloads
- Examples: Cisco DNA Center's REST API, OpenDaylight Northbound

**South-Bound APIs** ([[North-Bound API]])
- Interface between **controller and network devices**
- Controller tells devices how to forward packets
- Typically standardized protocols like [[OpenFlow]], [[NETCONF]], [[YANG]]
- Examples: OpenFlow for switch tables, NETCONF for device configuration

| API Direction | Connects | Purpose | Example Protocol |
|---------------|----------|---------|------------------|
| **North-Bound** | Apps ↔ Controller | Applications declare policy | REST/JSON |
| **South-Bound** | Controller ↔ Devices | Controller pushes forwarding rules | OpenFlow, NETCONF |

---

## 22.5 SDN Architectures: Overlay, Underlay, Fabric

### Underlay Network
- **Definition:** The physical network infrastructure that carries all traffic
- **Responsibility:** Basic IP connectivity between all nodes
- **Unchanged by SDN:** Still uses standard routing protocols ([[OSPF]], [[BGP]])
- **Analogy:** Pipes in a building—they exist whether or not you add a smart control system

### Overlay Network
- **Definition:** Virtual network built on top of the underlay using tunneling
- **Encapsulation:** Data Plane packets wrapped in additional headers
- **Purpose:** Allows SDN controller to create virtual topologies independent of physical topology
- **Common Protocols:** [[VLAN]] (Virtual eXtensible LAN), [[GRE]] (Generic Routing Encapsulation)
- **Benefit:** Decouples application network design from physical constraints

**Example:** 
```
Application asks for east-west connectivity between VMs in different data centers.
Controller creates VXLAN tunnel across underlay network.
VM packets are encapsulated in VXLAN headers.
Physical network (underlay) just sees IP packets between tunnel endpoints.
```

### Fabric
- **Definition:** The unified, programmable control of both overlay and underlay
- **Concept:** Controller manages the entire network as a single entity
- **Similar to:** Cisco's [[Cisco SD-Access|SD-Access]] architecture, which programs access switches, distribution switches, and creates overlay VNs simultaneously
- **Benefit:** End-to-end intent-based networking with centralized policy

---

## 22.6 Cisco DNA Center-Enabled Network Management

### What Is Cisco DNA Center?

[[Cisco DNA Center]] (Cisco Digital Network Architecture Center) is Cisco's platform for intent-based networking—translating **business intent into network policy automatically**.

**Simple analogy:** You tell it "Sales group needs 100 Mbps guaranteed to the internet" and it automatically configures QoS, security policies, and segmentation across all switches.

### Key Components

| Component | Function |
|-----------|----------|
| **Dashboard** | Real-time network health, topology visualization |
| **Assurance** | AI-powered anomaly detection, network analytics |
| **Automation** | Workflow builder for device provisioning and policy |
| **Integration** | REST APIs for third-party tool integration |
| **Network Analytics** | Historical data, capacity planning, performance trending |

### Controller-Based vs. Traditional Management

| Aspect | Traditional | Controller-Based (DNA Center) |
|--------|-----------|------|
| **Configuration** | Manual CLI on each device | Intent-based policies applied to device groups |
| **Visibility** | Device-by-device SNMP queries | Centralized real-time topology and flows |
| **Change deployment** | Manual (hundreds of commands) | Automated workflows |
| **Issue detection** | Reactive (device alerts) | Proactive (AI identifies problems before impact) |
| **Compliance** | Manual auditing | Automated policy enforcement auditing |

### DNA Center Licensing Tiers

- **Essentials:** Basic provisioning and monitoring
- **Advantage:** + Assurance (AI analytics) and automation workflows
- **Premier:** + Advanced automation, multi-site management

---

## 22.7 Artificial Intelligence and Machine Learning in Network Operations

###

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 22 | [[CCNA]]*
