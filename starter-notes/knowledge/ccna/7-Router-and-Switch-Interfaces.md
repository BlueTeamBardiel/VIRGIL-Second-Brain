---
tags: [knowledge, ccna, chapter-7]
created: 2026-04-30
cert: CCNA
chapter: 7
source: rewritten
---

# 7. Router and Switch Interfaces
**A quick tour of how routers and switches handle and configure their physical interfaces**

---

## Configuring Interfaces

### Unmanaged vs. Managed Switches

**Analogy**: Think of an unmanaged switch as a vending machine that dispenses snacks automatically—no settings needed. A managed switch is like a customizable smart thermostat that you can tweak for temperature, schedule, and performance.

**Unmanaged Switch**: A plug‑and‑play device that performs basic switching with no configuration options.  
**Managed Switch**: Offers advanced features such as VLANs, QoS, and port security, requiring administrator configuration.

| Feature | Unmanaged | Managed |
|---------|-----------|---------|
| Configuration | None | CLI, SNMP, web UI |
| VLAN support | No | Yes |
| Port security | No | Yes |
| QoS | No | Yes |

---

### Interface Descriptions

**Analogy**: Imagine labeling each road on a map so drivers know which city each street leads to.  

**Description**: A text string you attach to an interface to identify its purpose or connected device.  
You assign it with the `description` command.

```plaintext
Switch(config)# interface GigabitEthernet1/0/5
Switch(config-if)# description Server-Backup-Connection
```

Multiple interfaces can be described simultaneously using `interface range`:

```plaintext
Switch(config)# interface range GigabitEthernet1/0/1 - 24
Switch(config-if-range)# description Uplink-to-Core-Router
```

| Part | Meaning | Example |
|------|---------|---------|
| **Type** | Ethernet family (e.g., `FastEthernet`, `GigabitEthernet`) | `FastEthernet0/1` |
| **Slot** | First number after the type | `1` in `GigabitEthernet1/0/5` |
| **Port** | Second number | `5` in `GigabitEthernet1/0/5` |

To view descriptions:

```plaintext
Switch# show interfaces description
```

On switches, `show interfaces status` also lists descriptions.

---

### Interface Speed

**Analogy**: Speed is like the width of a highway—bigger lanes let more cars (data) travel at once.  

**Interface Speed**: The maximum data transfer rate a port can support, measured in bits per second (bps).

| Speed | Typical Port | Duplex Default |
|-------|--------------|----------------|
| 10 Mbps | 10/100 Ethernet | Half |
| 100 Mbps | 10/100 Ethernet | Half |
| 1 Gbps | GigabitEthernet | Full |
| 10 Gbps+ | 10G/40G/100G | Full |

Use the `speed` command to override autonegotiation:

```plaintext
Router(config)# interface GigabitEthernet0/1
Router(config-if)# speed 100
```

---

### Autonegotiation Process

**Analogy**: Two dancers exchanging steps before a routine—each tells the other which moves they can perform, then agree on the best choreography.  

**Autonegotiation**: The automatic handshake where devices exchange capabilities and choose the optimal speed and duplex settings.

| Default Behavior | 10/100 Mbps | 1000 Mbps+ |
|------------------|-------------|------------|
| Duplex | Half | Full |
| On failure | Fall back to lowest speed | Often to 10 Mbps half |

Keep autonegotiation enabled unless diagnosing speed or duplex issues.

```plaintext
Router(config)# interface GigabitEthernet0/1
Router(config-if)# no shutdown
Router(config-if)# no speed
```

---

### Duplex Mode

**Analogy**: A two‑way conversation vs. a one‑way lecture—full duplex is like a chat where both can speak simultaneously, half duplex is like taking turns.  

**Half‑duplex**: Only one direction of data transmission allowed at a time.  
**Full‑duplex**: Simultaneous bidirectional data flow.  
Modern networks almost always use full‑duplex.

---

### Speed and Duplex Mismatches

**Analogy**: Two cars trying to drive on a road that can only accommodate one speed—one slows down, the other speeds, causing congestion.  

| Mismatch Type | Resulting Interface State | Performance Impact |
|---------------|---------------------------|--------------------|
| **Speed mismatch** | Down/Down | No traffic |
| **Duplex mismatch** | Up/Up | Collisions, errors, slow throughput |

Typical symptoms of a duplex mismatch include:

- Collisions
- Late collisions
- CRC errors
- High retransmission rates

**Tip**: If you see collisions or CRC errors, check both sides for duplex consistency.

---

## Interface Status and Troubleshooting

### Viewing Interface Status

**Analogy**: A maintenance crew inspecting all traffic lights in a city to see which ones are functioning, which are stalled, and why.  

- `show interfaces`: Detailed statistics for every port.  
- `show interfaces status`: Quick summary (switches only).  
- `show ip interface brief`: IP addresses and interface status for routers.

```plaintext
Router# show ip interface brief
Interface              IP-Address      OK? Method Status                Protocol
Gig0/1                  192.168.1.1     YES  manual up                    up
Gig0/2                  unassigned      YES  manual administratively down down
```

---

### Common Interface Issues

**Analogy**: A faulty appliance can cause a cascade of problems—if the outlet is out, all connected devices fail.  

| Issue | Description | Fix |
|-------|-------------|-----|
| Speed/Duplex Mismatch | One side set to 100 Mbps, other 1000 Mbps or different duplex | Align both settings |
| Interface Down/Disabled | Administrative shutdown | `shutdown` / `no shutdown` |
| Err‑disabled | Security violation or error threshold hit | Reset with `shutdown` + `no shutdown` |

```plaintext
Switch(config)# interface GigabitEthernet0/1
Switch(config-if)# shutdown
Switch(config-if)# no shutdown
```

---

## Interface Errors

**Analogy**: A mail delivery system where some letters are too small, too large, or have garbled stamps—these are the error types that need sorting.  

| Error | Meaning |
|-------|---------|
| **Runts** | Frames < 64 bytes |
| **Giants** | Frames > 1518 bytes |
| **CRC Errors** | Failed CRC check |
| **Frames** | Malformed frame format |
| **Input Errors** | Total of the above on inbound traffic |
| **Output Errors** | Failed outbound frames |
| **Collisions** | Should be 0 on a switched network |
| **Late Collisions** | Collision after 64 bytes, usually due to duplex mismatch |

A high count of late collisions is a red flag for duplex problems.

---

## Best Practices & Exam Tips

### Exam Tips

#### Question Type 1: Interface Configuration
- *"Which command disables a router interface?"* → `shutdown`  
- **Trick**: Many routers have interfaces disabled by default, so a question might ask which command *enables* it; answer `no shutdown`.

### Common Mistakes

#### Mistake 1: Assuming All Interfaces Are Enabled
- **Wrong**: Believing that a router interface is operational just because the cable is plugged in.  
- **Right**: Recognize that interfaces are `administratively down` by default; they must be `no shutdown`.  
- **Impact on Exam**: A question may present an interface showing `administratively down/down`; the correct answer will involve enabling it.

---

## Related Topics
- [[VLANs]]
- [[Port Security]]

---

*Source: CCNA 200-301 Study Notes | [[CCNA]]*