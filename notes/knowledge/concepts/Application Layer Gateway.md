# Application Layer Gateway

## What it is
Think of a customs officer who doesn't just check your passport but opens your luggage and reads every letter inside — an Application Layer Gateway (ALG) is a firewall component that inspects and translates traffic at Layer 7, understanding the specific protocol's commands and data rather than just its port and address. Unlike a standard packet filter that sees only headers, an ALG fully parses application-layer protocols like FTP, SIP, or H.323 to make intelligent allow/deny decisions and perform Network Address Translation (NAT) on embedded IP addresses within the payload itself.

## Why it matters
FTP's active mode embeds the client's IP address and port number inside the data stream — a standard NAT firewall would corrupt this, breaking the connection. An ALG intercepts the FTP PORT command, rewrites the embedded private IP to the public NAT address, and dynamically opens the required data channel port, preventing both breakage and uncontrolled port exposure. Without this, administrators often resort to passive FTP or punching broad firewall holes, both of which introduce risk.

## Key facts
- ALGs operate at **OSI Layer 7** and must understand each protocol they inspect; a SIP ALG is useless for FTP
- They rewrite **payload content** during NAT translation, not just packet headers — critical for protocols that embed addressing information
- SIP ALGs are notorious for **breaking VoIP** calls when misconfigured because they misinterpret SDP body fields
- ALGs can perform **protocol validation**, rejecting malformed commands that might indicate exploitation attempts (e.g., FTP command injection)
- Enabling an ALG dynamically opens **pinhole ports** in the firewall — these should be logged and audited as they bypass normal rule sets

## Related concepts
[[Stateful Inspection Firewall]] [[Network Address Translation]] [[Deep Packet Inspection]] [[Session Initiation Protocol]] [[Next-Generation Firewall]]