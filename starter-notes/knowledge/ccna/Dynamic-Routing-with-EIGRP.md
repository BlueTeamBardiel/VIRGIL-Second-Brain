---
tags: [knowledge, ccna, chapter-0]
created: 2026-04-30
cert: CCNA
chapter: 0
source: rewritten
---

# Dynamic Routing with EIGRP
**EIGRP enables routers to automatically discover and share network paths instead of requiring manual route configuration.**

---

## Understanding EIGRP Fundamentals

### What is Dynamic Routing?

**Analogy**: Think of dynamic routing like a group chat where delivery drivers constantly text each other about the best routes. Instead of following a printed map (static routing), they share real-time information so everyone knows the fastest path to any destination.

**[[EIGRP]] (Enhanced Interior Gateway Routing Protocol)**: An advanced dynamic [[routing]] protocol that allows routers to automatically exchange information about which networks they can reach, calculate the best paths using distance and delay metrics, and adapt when the network topology changes.

| Feature | Static Routing | Dynamic Routing ([[EIGRP]]) |
|---------|----------------|--------------------------|
| Configuration | Manual per route | Configured once per network |
| Scalability | Poor (many routes = tedious) | Excellent (self-discovers) |
| Adaptation | None (broken links stay broken) | Automatic failover to backup paths |
| Overhead | Minimal CPU usage | Uses bandwidth and processing |
| Best for | Small, stable networks | Medium to large enterprise networks |

---

## Lab: From Broken Routes to Dynamic Discovery

### Step 1: Configure WAN Interface (RouterA)

**Analogy**: Before routers can talk, they need phone numbers (IP addresses). The WAN interface is RouterA's "phone line" to RouterB.

```ios
enable
configure terminal
hostname RouterA
interface serial 0/0
ip address 10.1.1.5 255.255.255.252
clock rate 64000
no shutdown
exit
exit
show ip interface brief
```

**Expected Result**: `Serial0/0` transitions from `administratively down` → `up/up`

**Verification**:
```ios
ping 10.1.1.6
```
✔ Ping succeeds (RouterB is reachable over WAN)

---

### Step 2: Configure LAN Interface (RouterA)

**Analogy**: The LAN interface is like your home's front door — it connects to your local neighborhood (the LAN).

```ios
configure terminal
interface fastethernet 0/0
ip address 192.168.100.1 255.255.255.0
no shutdown
exit
exit
show ip interface brief
```

**Expected Result**: `FastEthernet0/0` becomes `up/up`

**Verification**:
```ios
ping 192.168.100.2
ping 192.168.100.3
```
✔ Local PCs respond

---

### Step 3: Observe the Routing Problem

**Analogy**: Right now, RouterA is like someone who only knows the addresses of neighbors on their street, not people across town. When asked for directions to the other side of town, they just shrug.

**Test from PC1**:
```ios
ping 192.168.200.2
ping 192.168.200.3
```
❌ **Fails completely** — RouterA has no idea where `192.168.200.0/24` is!

**Check RouterA's routing table**:
```ios
show ip route
```

**Expected Output**:
```
C    10.1.1.4/30 is directly connected, Serial0/0
L    10.1.1.5/32 is directly connected, Serial0/0
C    192.168.100.0/24 is directly connected, FastEthernet0/0
L    192.168.100.1/32 is directly connected, FastEthernet0/0
```

**Key Observation**: Only **C** (connected) and **L** (local) routes exist. RouterB's LAN (`192.168.200.0/24`) is completely missing! 🚫

---

### Step 4: Enable EIGRP and Share Routes

**Analogy**: Enabling [[EIGRP]] is like forming a delivery network agreement where both drivers automatically text each other about all the locations they serve. Instead of one driver getting lost, both drivers update their mental maps in real-time.

**Start [[EIGRP]] Process**:
```ios
configure terminal
router eigrp 100
```

**Tell EIGRP which networks to advertise**:
```ios
network 10.0.0.0
network 192.168.100.0
exit
exit
```

**What just happened**:
1. RouterA's [[EIGRP]] process activates on Serial0/0 (matches `10.0.0.0`)
2. RouterA's [[EIGRP]] process activates on FastEthernet0/0 (matches `192.168.100.0`)
3. RouterA sends "hello" packets to find neighbors
4. RouterB responds with its own network advertisements
5. Both routers exchange complete topology information

---

### Step 5: Verify End-to-End Connectivity

**Test from PC1 again**:
```ios
ping 192.168.200.2
ping 192.168.200.3
```
✔ **Success!** Pings now succeed instantly!

**Check updated routing table**:
```ios
show ip route
```

**New Output**:
```
C    10.1.1.4/30 is directly connected, Serial0/0
L    10.1.1.5/32 is directly connected, Serial0/0
D    192.168.200.0/24 [90/2681856] via 10.1.1.6, 00:00:15, Serial0/0
C    192.168.100.0/24 is directly connected, FastEthernet0/0
L    192.168.100.1/32 is directly connected, FastEthernet0/0
```

**Notice the `D` route!**
- **D** = EIGRP-learned route
- **[90/2681856]** = [[EIGRP]] metric (feasibility distance)
- **via 10.1.1.6** = RouterB's WAN address
- **00:00:15** = How long ago the route was learned

**Why it works now**: RouterA automatically learned the path to RouterB's LAN and now forwards traffic correctly instead of dropping it. 🎯

---

## Exam Tips

### Question Type 1: Routing Table Analysis
- *"Why does `show ip route` show no routes to remote networks before enabling [[EIGRP]]?"* → Because [[routing]] is static by default—routers only know directly connected networks until you enable dynamic [[routing]].
- **Trick**: Students confuse "interface up" with "route learned." An interface can be up without knowing remote networks!

### Question Type 2: EIGRP Configuration
- *"Which command enables [[EIGRP]] process 100?"* → `router eigrp 100`
- **Trick**: The number (100) is the Autonomous System number—it must match on both routers or they won't become neighbors!

### Question Type 3: Network Statements
- *"What does `network 192.168.100.0` accomplish in [[EIGRP]]?"* → Enables [[EIGRP]] on all interfaces matching that network and advertises those networks to neighbors.
- **Trick**: You need BOTH the WAN and LAN network statements, or the routers can't communicate AND advertise local networks!

---

## Common Mistakes

### Mistake 1: Forgetting `no shutdown`
**Wrong**: Configure interfaces but leave them administratively down, then wonder why pings fail.
**Right**: Always end interface configuration with `no shutdown` to enable the port.
**Impact on Exam**: You'll lose connectivity and fail the entire scenario. Always verify with `show ip interface brief`.

### Mistake 2: Missing Network Statement for WAN
**Wrong**: Only advertise LAN networks in [[EIGRP]], forgetting the WAN link.
**Right**: Include BOTH `network 10.0.0.0` (WAN) AND `network 192.168.100.0` (LAN) so routers can form neighborships and advertise routes.
**Impact on Exam**: Routers won't become [[EIGRP]] neighbors and routes won't exchange—complete failure.

### Mistake 3: Wrong AS Number
**Wrong**: Configure `router eigrp 100` on RouterA but `router eigrp 200` on RouterB.
**Right**: Use the same AS number (e.g., 100) on all routers in the same network.
**Impact on Exam**: Routers silently ignore each other's advertisements. You'll see no neighbors and no learned routes despite correct commands.

### Mistake 4: Misinterpreting Route Codes
**Wrong**: Seeing a `C` route and thinking it's automatically reachable from all networks.
**Right**: `C` routes are ONLY directly connected; remote networks need dynamic [[routing]] or static [[routing]].
**Impact on Exam**: You might incorrectly analyze why connectivity fails and choose the wrong troubleshooting step.

---

## Key Takeaway

> [[EIGRP]] doesn't magically create routes—it's a **communication protocol** that teaches routers about each other's networks. Without it, routers are isolated islands. With it, they form a mesh of knowledge.

---

## Related Topics
- [[EIGRP Metrics and Path Selection]]
- [[EIGRP Neighbors and Adjacency]]
- [[Static Routing]]
- [[Routing Fundamentals]]
- [[CCNA]]

---

*Source: CCNA 200-301 Study Notes | [[CCNA]] | Lab-Based Learning*