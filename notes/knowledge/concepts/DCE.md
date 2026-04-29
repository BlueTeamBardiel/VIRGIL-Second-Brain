# DCE

## What it is
Like a telephone operator in the 1970s who patched calls between incompatible phone systems, DCE (Distributed Computing Environment) is a framework developed by the Open Group that provides middleware services — including remote procedure calls (RPC), directory services, and authentication — enabling communication between different operating systems and hardware across a network.

## Why it matters
Microsoft built its own RPC implementation heavily on DCE/RPC, which became the backbone of Windows domain communication. The MS-RPC stack has been a persistent attack surface — the 2003 Blaster worm exploited a buffer overflow in the Windows DCOM/RPC service (MS03-026), compromising millions of machines by sending malicious packets to TCP port 135, the DCE endpoint mapper port.

## Key facts
- DCE/RPC uses **port 135** as the endpoint mapper — clients query it to discover which dynamic port hosts a specific service, making port 135 a critical firewall control point
- The **UUID (Universally Unique Identifier)** system in DCE/RPC uniquely identifies interfaces; attackers use tools like `rpcdump` and `impacket` to enumerate exposed RPC interfaces
- DCE includes **Kerberos-based authentication** as part of its security model, making it a historical ancestor of modern Windows Kerberos implementations
- Microsoft's MSRPC extends DCE/RPC with DCOM (Distributed Component Object Model), significantly expanding the attack surface for lateral movement
- DCE/RPC traffic is often **tunneled inside SMB** (over port 445), meaning firewall rules blocking 135 don't fully eliminate exposure

## Related concepts
[[RPC]] [[SMB]] [[Kerberos]] [[DCOM]] [[Port Scanning]]