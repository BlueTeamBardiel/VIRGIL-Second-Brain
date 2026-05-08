# SD-Access

## What it is

In Death Stranding, Sam doesn't just walk to Edge Knot City — he uses the Chiral Network. Once a region is connected, every porter sees the same roads, the same zip-lines, the same shared structures, and BTs are tracked from a unified map. The terrain didn't change; the *abstraction layer over it* did. That's exactly what SD-Access does — it overlays a programmable, policy-aware fabric on top of your existing campus wiring so the network stops being a pile of independent switches and starts behaving like one coordinated system.

**SD-Access** is Cisco's intent-based campus SDN solution that uses [[LISP]] for the control plane, [[VXLAN]] for the data plane, [[Cisco TrustSec]] for policy, and [[Cisco DNA Center]] as the orchestrator to deliver an automated, segmented fabric over any underlay.

## Why it matters

Traditional campus networks pin identity to IP address and segmentation to VLAN/ACL sprawl — change a user's location and policy breaks; add a guest network and you're editing 40 switches by hand. SD-Access decouples identity from topology: a user gets the same policy whether they plug in on floor 2 or floor 12, and segmentation follows them via [[SGT]] tags rather than subnet gymnastics. **CCNA exam angle**: know the four planes (underlay, overlay, control, policy), the protocols mapped to each (IS-IS, VXLAN, LISP, TrustSec), and the role of DNA Center vs. ISE.

## Key facts

### Fabric architecture — the four planes

| Plane | Function | Technology |
|---|---|---|
| **Underlay** | Physical IP reachability between fabric nodes | Routed access, typically [[IS-IS]] |
| **Overlay** | Virtual network carrying user traffic | [[VXLAN]] tunnels |
| **Control** | Maps endpoints to locations | [[LISP]] |
| **Policy** | Group-based access enforcement | [[Cisco TrustSec]] / [[SGT]] |

### Fabric node roles

- **[[Fabric Edge Node]]** — access switch where endpoints connect; encapsulates traffic into VXLAN.
- **[[Fabric Border Node]]** — gateway to networks outside the fabric (WAN, data center, internet).
- **[[Fabric Control Plane Node]]** — runs the LISP **Map-Server / Map-Resolver** ([[MS/MR]]); the database of "who is where."
- **[[Intermediate Node]]** — pure underlay router; forwards IP, no fabric awareness.
- **[[Fabric WLC]]** — wireless controller integrated into the fabric; APs tunnel to edge nodes via VXLAN, not CAPWAP-to-WLC.

### LISP — control plane

[[LISP]] (Locator/ID Separation Protocol) splits an endpoint's identity (**EID** — what it is) from its location (**RLOC** — where it is). The Control Plane Node holds the EID-to-RLOC mapping. When an edge node sees an unknown destination, it queries the MS/MR instead of flooding.

- No more "MAC table everywhere" — endpoints register on connect.
- Roaming = re-register, not re-architect.

### VXLAN — data plane

[[VXLAN]] (Virtual Extensible LAN) wraps the original Ethernet frame in UDP (port **4789**) and adds a **VNI** (VXLAN Network Identifier, 24-bit, ~16M segments vs. VLAN's 4,094). SD-Access uses **VXLAN-GPO** (Group Policy Option) to also carry the **SGT** in the header — segmentation rides with the packet.

### Cisco TrustSec — policy plane

- Endpoints classified into [[Security Group Tag]]s (SGTs) at ingress, typically by [[Cisco ISE]] after [[802.1X]] authentication.
- Policy is a matrix: *Source SGT × Destination SGT → permit/deny*.
- Enforced at the egress edge node — no ACL editing on every switch.

### Cisco DNA Center — orchestrator

[[Cisco DNA Center]] (now [[Cisco Catalyst Center]]) is the single pane of glass:

- **Design** — sites, IP pools, AAA.
- **Policy** — define SGTs and the access matrix (pushed to ISE).
- **Provision** — assigns device roles, builds underlay via [[LAN Automation]], stitches the fabric.
- **Assurance** — telemetry, path trace, root-cause analysis.

DNA Center talks **NETCONF/YANG** south to devices; integrates with **ISE** via [[pxGrid]] for identity.

### Two-box partnership

| Box | Owns |
|---|---|
| **DNA Center** | Network automation, fabric provisioning, assurance |
| **[[Cisco ISE]]** | Identity, authentication, SGT assignment, policy authority |

## Related concepts

[[SDN]] · [[LISP]] · [[VXLAN]] · [[Cisco TrustSec]] · [[SGT]] · [[Cisco DNA Center]] · [[Cisco ISE]] · [[802.1X]] · [[IS-IS]] · [[Underlay vs Overlay]] · [[SD-WAN]]

---
*Source: VIRGIL knowledge base — 2026-05-07*