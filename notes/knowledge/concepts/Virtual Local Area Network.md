# Virtual Local Area Network

## What it is
Think of a large open-plan office where you hang invisible curtains between departments — accounting can't shout across to engineering even though they share the same floor. A VLAN is a logical network segment configured on a switch that groups devices into isolated broadcast domains regardless of their physical location. Traffic between VLANs requires routing through a Layer 3 device, enforcing deliberate segmentation on shared physical infrastructure.

## Why it matters
A hospital network uses VLANs to isolate medical IoT devices (IV pumps, monitors) from the general staff Wi-Fi. Without this separation, a phishing victim on the staff network could pivot laterally and directly probe unpatched medical equipment — a real attack pattern seen in healthcare breaches. VLANs force that lateral movement to cross a router or firewall where it can be inspected and blocked.

## Key facts
- VLANs are defined by **802.1Q** tagging, which inserts a 4-byte tag into Ethernet frames to identify VLAN membership across trunk links
- **VLAN hopping** attacks (via switch spoofing or double-tagging) allow an attacker to send frames to a VLAN they shouldn't access — mitigated by disabling DTP and never using the native VLAN for user traffic
- The **native VLAN** (default VLAN 1) is a common misconfiguration risk — best practice is to change it to an unused VLAN
- Inter-VLAN routing requires a **Layer 3 switch or router** — traffic cannot cross VLAN boundaries at Layer 2 alone
- VLANs are a core **network segmentation** control mapped to CIS Control 12 and are frequently tested as a defense against lateral movement

## Related concepts
[[Network Segmentation]] [[Trunk Port]] [[802.1Q]] [[Lateral Movement]] [[Defense in Depth]]