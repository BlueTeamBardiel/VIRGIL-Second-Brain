---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 14
source: rewritten
---

# Network Devices
**The specialized hardware that directs traffic, connects segments, and keeps your network talking to itself.**

---

## Overview

Think of a network like a city—you need traffic lights, roads, and delivery trucks all working together. Network devices are the infrastructure that makes data flow intelligently across your organization. For the A+ exam, you absolutely need to understand what each device does, which [[OSI Model]] layer it operates on, and when to use one versus another.

---

## Key Concepts

### Routers

**Analogy**: A router is like a postal sorting facility. Just as mail gets sorted by ZIP code and sent down the right truck route, routers examine the destination address and decide which physical path your packet should take.

**Definition**: A [[router]] operates at [[OSI Layer 3]] (Network Layer) and makes forwarding decisions based on [[IP address|destination IP addresses]]. It maintains a [[routing table]] that acts as an internal map, telling it which [[interface]] to send traffic out of based on the destination subnet.

**Key Functions**:
- Routes between different [[IP subnet|IP subnets]]
- Connects dissimilar network types ([[Ethernet]] to [[wireless]], copper to [[fiber]], etc.)
- Makes intelligent forwarding decisions using routing tables

```
Router Decision Process:
1. Packet arrives at router
2. Router reads destination IP address
3. Router checks routing table
4. Router forwards packet out correct interface
5. Packet travels toward next hop
```

---

### Layer 3 Switches

**Analogy**: A Layer 3 switch is like having a postal worker AND a delivery truck driver be the same person—it can do both switching and routing jobs simultaneously.

**Definition**: A [[Layer 3 switch]] combines the functionality of a traditional [[switch]] (Layer 2) and a [[router]] (Layer 3) into one device. Organizations use these to improve performance when routing must happen frequently within the same physical location.

| Feature | Traditional Router | Layer 3 Switch |
|---------|-------------------|----------------|
| **OSI Layer** | Layer 3 only | Layers 2 AND 3 |
| **Speed** | Moderate | Very fast |
| **Use Case** | Connect different subnets | High-speed inter-VLAN routing |
| **Cost** | Lower | Higher |

---

### Switches

**Analogy**: A switch is like a receptionist who knows everyone's office number and connects calls directly to the right person instead of routing everything through the main switchboard.

**Definition**: A [[switch]] operates at [[OSI Layer 2]] (Data Link Layer) and forwards frames based on [[MAC address|MAC addresses]]. It creates direct paths between ports to minimize collisions and maximize bandwidth.

**Key Benefit**: Switches allow multiple devices to communicate simultaneously without sharing bandwidth (unlike [[hub|hubs]]).

---

### Access Points

**Analogy**: An access point is like a radio transmitter that broadcasts a signal so anyone nearby with a compatible receiver can connect wirelessly.

**Definition**: An [[access point]] (AP) is a wireless device that operates at [[OSI Layer 2]] and allows [[wireless]] devices to join the network. It bridges the gap between wireless clients and the wired network infrastructure.

**Common Misconception**: Your home router is NOT just a router—it's a combo device containing a router, switch, access point, AND firewall all in one box.

---

### Firewalls

**Analogy**: A firewall is like a security guard at a building entrance—it checks every person's credentials and decides whether they should be allowed inside.

**Definition**: A [[firewall]] examines traffic at various [[OSI Model|OSI layers]] and applies rules to allow or block packets based on source, destination, protocol, and port. Firewalls protect networks from unauthorized access.

**Types**:
- **Stateless**: Examines each packet independently
- **Stateful**: Remembers previous connections and makes decisions based on connection state

---

### Modems

**Analogy**: A modem is like a translator—it takes the signal from your ISP (which might be cable, fiber, or telephone lines) and translates it into data your computer can understand, and vice versa.

**Definition**: A [[modem]] (modulator-demodulator) converts analog signals from your [[ISP]] into digital data and back again. It's the gateway between your home/office network and the external internet.

**Common Setup**: Many residential connections use a modem + wireless router combo, or a modem feeding into a separate router.

---

### Hubs (Legacy)

**Analogy**: A hub is like an old-school PA system that broadcasts everything to everyone in the building at once, whether they need to hear it or not.

**Definition**: A [[hub]] operates at [[OSI Layer 1]] (Physical Layer) and simply repeats all incoming signals to all ports. It creates a shared collision domain, meaning only one device can transmit at a time.

**Why It Matters**: Hubs are essentially obsolete and replaced by [[switch|switches]], but you should recognize them on the exam as inferior to modern alternatives.

---

### Media Converters

**Analogy**: A media converter is like an adapter that lets you plug a USB device into an Ethernet port—it bridges two incompatible connection types.

**Definition**: A [[media converter]] allows you to connect different [[cabling]] types (e.g., [[copper]] to [[fiber]], or different fiber types) by converting signals from one format to another.

**Use Case**: Extending networks across long distances using fiber while maintaining existing copper infrastructure in the building.

---

### PoE Injectors and Switches

**Analogy**: A PoE device is like an electrical outlet built into a network cable—it carries both data AND power down the same wire.

**Definition**: [[Power over Ethernet]] (PoE) allows network cables to deliver electrical power to devices like [[access point|access points]], [[IP camera|IP cameras]], and [[VoIP]] phones. A [[PoE injector]] adds power to standard Ethernet cables; a [[PoE switch]] does this from every port automatically.

**Standard Levels**:
- **PoE**: Up to 15.4 watts
- **PoE+**: Up to 30 watts
- **PoE++**: Up to 90 watts

---

## Exam Tips

### Question Type 1: Device Identification
- *"Which device makes forwarding decisions based on destination IP address?"* → [[Router]] (or [[Layer 3 switch]])
- *"Which device forwards based on MAC addresses?"* → [[Switch]]
- *"Which device broadcasts wireless signals to connect clients?"* → [[Access point]]

**Trick**: The exam loves asking you to identify devices by their OSI layer. Memorize: Layer 1 = [[hub]], Layer 2 = [[switch]], Layer 3 = [[router]].

### Question Type 2: Choosing the Right Device
- *"You need to connect two buildings using fiber. Which device do you need?"* → [[Router]] (plus possibly a [[media converter]])
- *"Your wireless users need high-speed internet access. What do you install?"* → [[Access point]] (or [[wireless router]] combo)

**Trick**: Don't confuse "connecting devices on the same network" (use a [[switch]]) with "connecting different networks" (use a [[router]]).

### Question Type 3: PoE Questions
- *"Which standard provides up to 30 watts over Ethernet?"* → [[PoE+]]
- *"You're installing IP cameras. What injector specifications do you need?"* → Check camera power draw; typically PoE or PoE+ is sufficient

**Trick**: The exam might ask which device supports PoE—remember that PoE switches include the injector functionality.

---

## Common Mistakes

### Mistake 1: Confusing Routers and Switches
**Wrong**: "I'll use a switch to connect two office buildings."
**Right**: Switches work within a single broadcast domain. Routers connect different networks/subnets and make decisions based on IP addresses.
**Impact on Exam**: This is tested constantly. One question might ask "What device connects two IP subnets?" and the answer is [[router]], not [[switch]].

---

### Mistake 2: Thinking Your Home Router Is Just a Router
**Wrong**: "My home router only routes traffic."
**Right**: Residential routers combine four devices: [[router]], [[switch]], [[access point]], and [[firewall]].
**Impact on Exam**: The exam describes a "device that routes, switches, provides wireless, and has security rules"—recognize this as a combo device, not a pure router.

---

### Mistake 3: Forgetting About OSI Layers
**Wrong**: "I don't need to memorize which layer each device works on."
**Right**: Hub = Layer 1, Switch = Layer 2, Router = Layer 3. This is foundational to understanding what each device does.
**Impact on Exam**: Many questions test OSI layer knowledge implicitly. If you don't know the layers, you can't reason through which device to use.

---

### Mistake 4: Misunderstanding PoE Power Limitations
**Wrong**: "Any PoE port can power any device."
**Right**: Different PoE standards deliver different wattages. Check device specs against your [[PoE]] standard (standard, +, or ++).
**Impact on Exam**: You might see a scenario where a device needs 25 watts and you must choose between PoE (15.4W—too low) and PoE+ (30W—sufficient).

---

### Mistake 5: Confusing Access Points with Routers
**Wrong**: "An access point is a wireless router."
**Right**: An [[access point]] only handles wireless connectivity. A wireless [[router]] includes routing, switching, and security functions combined.
**Impact on Exam**: If you install just an AP in a network, it won't route between subnets—you still need the router.

---

## Related Topics
- [[OSI Model]]
- [[IP addressing and Subnetting]]
- [[Ethernet Standards]]
- [[Wireless Networking]]
- [[Network Topology]]
- [[Cabling Standards]]
- [[Firewalls and Security Appliances]]
- [[VLAN|Virtual LANs]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) Network Devices Lecture | [[A+]] | [[CompTIA A+ Core 1 (220-1201)]]*