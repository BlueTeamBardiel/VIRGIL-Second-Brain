# Wireless LAN Architectures
**Master 802.11 frame structure and AP deployment models—the foundation for enterprise wireless networks**

---

## 19.1 802.11 Frames and Message Types

### Simple Explanation First
Think of 802.11 frames like letters in the mail: Ethernet only needs a sender address and destination address because cables are bounded (like a single mailroom). But wireless is unbounded—your letter might need to go through multiple handlers (like mail to a remote village). So 802.11 frames need extra address fields to specify who's sending it NOW (TA), who receives it NOW (RA), who originally sent it (SA), and who it's ultimately going to (DA).

### The 802.11 Frame Format

The key difference from [[Ethernet]] frames: **802.11 has UP TO FOUR address fields instead of two**, and optional fields depending on the message type.

| Field | Size (bytes) | Purpose |
|-------|--------------|---------|
| Frame Control | 2 | Message type, subtype, flags |
| Duration/ID | 2 | Channel reservation time OR association identifier |
| Address 1 | 6 | Receiver Address (RA) or BSSID |
| Address 2 | 6 | Transmitter Address (TA) or Source Address (SA) |
| Address 3 | 6 | Destination Address (DA) or BSSID |
| Address 4 | 0 or 6 | Optional—used in WDS scenarios |
| Sequence Control | 2 | Fragment reassembly, retransmission detection |
| QoS Control | 0 or 2 | Traffic prioritization (802.11e) |
| HT Control | 0 or 2 | High Throughput (802.11n+) support |
| Frame Body | Variable | Encapsulated payload (IP packets) |
| FCS | 4 | Frame Check Sequence (CRC-32) |

### The Four Address Fields Explained

Why four addresses? **Wireless requires distinguishing the immediate link partner from the ultimate destination.**

- **[[BSSID]]** (Basic Service Set Identifier): The AP's MAC address. Identifies which AP/BSS owns the frame.
- **DA** (Destination Address): The *final* recipient of the frame.
- **SA** (Source Address): The *original* sender of the frame.
- **RA** (Receiver Address): The *immediate* recipient (who receives this frame next).
- **TA** (Transmitter Address): The *immediate* sender (who sent this frame just now).

**Real example:** PC1 → AP1 → PC2

| Direction | Addr 1 (RA) | Addr 2 (TA) | Addr 3 (DA) | Purpose |
|-----------|-------------|-------------|------------|---------|
| PC1 to AP | AP1 MAC | PC1 MAC | PC2 MAC | PC1 tells AP1 to forward to PC2 |
| AP to PC2 | PC2 MAC | AP1 MAC | PC1 MAC | AP1 forwards with original sender info |

**Critical detail:** Clients on the same BSS cannot communicate directly—all frames route through the AP, even if clients are physically adjacent. This is why you need RA ≠ DA.

---

### The Client Association Process

Before any data flows, a client must complete **three-stage handshake**:

#### Stage 1: Discovery (Scanning)
Client finds available APs using one of two methods:

**[[Active Scanning]]**: Client sends **Probe Request** → APs respond with **Probe Response**
- Faster AP discovery
- Higher power consumption (battery drain)
- Used by default on most devices

**[[Passive Scanning]]**: Client listens for **Beacon** frames from APs
- APs periodically broadcast beacons (typically every 100ms)
- Lower power consumption
- Slower to discover new networks
- Used when connected and looking for roaming opportunities

#### Stage 2: Authentication
Client sends **Authentication Request** → AP sends **Authentication Response**
- Proves client is allowed to join this BSS
- [[802.11 Open Authentication|Open auth]] (no verification), [[WEP]], [[WPA]], or [[WPA2/WPA3]] (see Chapter 20)
- Does NOT associate yet—just proves legitimacy

#### Stage 3: Association
Client sends **Association Request** → AP sends **Association Response**
- AP allocates resources (association ID, queues, etc.)
- Client receives [[AID]] (Association Identifier) - used in power-save mode
- **Only after association can data frames flow**

---

### 802.11 Message Types

802.11 defines **three message categories**:

#### Management Messages
**Purpose:** Establish and maintain wireless communications

| Message | Direction | Function |
|---------|-----------|----------|
| Beacon | AP → Broadcast | Advertise BSS (SSID, rates, channel, security settings) every ~100ms |
| Probe Request | Client → Broadcast | "Are there any APs here?" |
| Probe Response | AP → Unicast | "Yes, I'm here!" (AP responds with capabilities) |
| Authentication Request | Client → AP | Prove identity |
| Authentication Response | AP → Client | Accept or deny |
| Association Request | Client → AP | Request membership in this BSS |
| Association Response | AP → Client | Grant membership (or deny) + assign AID |
| Disassociation | Client or AP → Other | End the association cleanly |
| Deauthentication | Client or AP → Other | Force termination (no longer authenticated) |
| Reassociation Request | Client → AP | Roam to new AP while keeping IP association |

#### Control Messages
**Purpose:** Manage frame delivery on the shared medium (reduce collisions)

| Message | Used In | Function |
|---------|---------|----------|
| RTS (Request to Send) | Client → AP | "May I transmit?" |
| CTS (Clear to Send) | AP → Client | "Yes, you may transmit" |
| Ack (Acknowledgment) | Receiver → Sender | "I got your frame" |
| Block Ack | Receiver → Sender | "I got frames X-Y" (batched acknowledgment) |
| CF-End | AP → Client | "Contention-free period ending" |

**RTS/CTS mechanism:** Reduces hidden node problem by having AP grant explicit permission before transmission.

#### Data Messages
**Purpose:** Carry the actual payload (IP packets, ARP, DNS, etc.)

- Standard data frame: Contains [[QoS]] information (802.11e) to prioritize voice/video
- Null frame: No payload—used only for power management signaling
- QoS Null frame: Power management for priority traffic

---

## 19.2 Wireless LAN Controller Architectures

### Simple Explanation First
Imagine managing 50 APs scattered across a building. You could configure each one individually (tedious, error-prone) OR use a **Wireless LAN Controller (WLC)** to manage them all centrally—like a single control center for your entire wireless network. The WLC pushes configurations, monitors health, and handles complex logic (roaming, security, QoS).

### Architecture Types

#### 1. **Autonomous (Standalone) AP Architecture**

**Definition:** Each AP is independently configured and managed.

**Characteristics:**
- Each AP has its own management IP address
- Administrator must log into each AP individually (via SSH/HTTP/Telnet)
- Each AP runs the complete 802.11 stack (authentication, encryption, roaming logic)
- Each AP independently makes decisions about client association
- No central security policy or user database

**Deployment:**
- Small offices (1-5 APs)
- Branch locations with minimal IT staff
- Guest networks

**Pros:**
- Simple for small networks
- No WLC licensing cost
- Low latency for local decisions

**Cons:**
- Doesn't scale (managing 50+ APs individually)
- No roaming optimization
- No centralized security policy
- Configuration inconsistencies
- Manual firmware updates per AP

---

#### 2. **Lightweight AP Architecture (with WLC)**

**Definition:** APs are "lightweight" and controlled by a centralized WLC. Cisco calls this **Unified Wireless Architecture**.

**How it works:**
- **Lightweight AP (LAP)** runs minimal OS; most intelligence in WLC
- LAP and WLC communicate via [[CAPWAP]] (Control and Provisioning of Wireless Access Points)
- WLC handles: authentication, encryption, roaming decisions, QoS policies
- LAP handles: RF transmission/reception, some data encryption offload

**CAPWAP Tunnel:**
- UDP port 5246 (control messages)
- UDP port 5247 (data frames)
- Encapsulates 802.11 frames from LAPs to WLC
- Encrypted with DTLS (Datagram TLS) optional

**Deployment:**
- Enterprise LANs (tens to hundreds of APs)
- Multiple buildings/campuses
- [[Roaming]] across APs
- Guest networks with captive portal

**Pros:**
- Central management and policy enforcement
- Seamless roaming (WLC coordinates)
- Easy firmware updates (push to all APs at once)
- Scalable (one WLC per 100-400 APs depending on model)
- Consistent security policies

**Cons:**
- WLC is a single point of failure (though redundancy available)
- Higher licensing cost
- More complex to deploy initially
- CAPWAP overhead (encapsulation)

**Typical Deployment:**
```
Internet
    ↓
[Distribution Layer Switch with WLC]
    ↓
[Access Layer Switches]
    ↓
[Lightweight APs] ← CAPWAP tunnel to WLC
```

---

#### 3. **Cloud-Based (Cisco Meraki) Architecture**

**Definition:** APs report to a cloud service instead of on-premises WLC.

**How it works:**
- APs still run lightweight firmware
- APs tunnel to Cisco Meraki cloud (HTTPS on port 443)
- Configuration, monitoring, and policy pushed from cloud
- No on-premises WLC hardware required
- Uses existing internet uplink

**Deployment:**
- Multi-site organizations (branches, retail locations)
- Organizations without IT staff at each site
- Disaster recovery scenarios

**Pros:**
- No WLC hardware to maintain
- Automatic updates
- Cloud-based analytics and troubleshooting
- Easy to add sites (just ship AP, power it on)
- Integrated with cloud management (Meraki dashboard)

**Cons:**
- Ongoing subscription cost
- Dependent on internet connectivity
- Latency for local decisions (authentication)
- Data leaves your network

---

### Comparison Table: AP Architectures

| Feature | Autonomous | Lightweight + WLC | Cloud-Based |
|---------|-----------|-------------------|-------------|
| Management | Per-AP | Centralized WLC | Cloud service |
| Scalability | Poor (1-10 APs) | Excellent (100s APs) | Excellent |
| Roaming | Poor (no coordination) | Excellent | Good |
| Setup Complexity | Simple | Moderate | Easy |
| Licensing | Free (except AP) | WLC license + AP | Subscription |
| Single Point of Failure | No | WLC | Internet connection |
| Typical Enterprise Use | No | Yes | Branch offices |

---

## 19.3 Physical Infrastructure Connections

### WLC Deployment Models

#### **Centralized Model**
- One WLC in data center
- All LAPs across campus/WAN tunnel back to data center
- CAPWAP tunnels traverse WAN links
- Works for large, well-connected environments

#### **Distributed Model**
- One WLC per building/floor
- Reduces CAPWAP tunnel traffic
- Easier roaming within building (local)
- Used in large campuses

#### **Hybrid Model**
- Primary WLC in data center
- Failover WLC in branch locations
- APs choose closest WLC at boot-up

---

### Physical Connections of WLAN Components

#### **AP Power and Data**

| Connection Type | Speed | Use Case |
|-----------------|-------|----------|
| PoE (802.3af) | 15.4W | Lightweight APs, autonomous APs in small areas |
| PoE+ (802.3at) | 30W | Most Cisco APs (includes internal antenna, cooling) |
| High-Power PoE (Cisco) |

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 19 | [[CCNA]]*