# RPC

## What it is
Like calling a friend and asking them to open your garage door from across town — you make a request, they execute it locally, and send back the result. Remote Procedure Call (RPC) is a protocol that allows a program on one machine to execute a subroutine on a remote system as if it were a local function call, abstracting away the underlying network communication.

## Why it matters
The MS03-026 vulnerability (exploited by the Blaster worm in 2003) targeted a buffer overflow in Windows RPC, infecting hundreds of thousands of machines by simply sending a malformed RPC request to port 135. Defenders must ensure RPC ports (135, 137-139, 445) are firewalled from external access, as exposed RPC services remain a persistent attack surface in enterprise environments.

## Key facts
- Windows RPC uses **port 135** as the endpoint mapper — clients query it to discover which dynamic port a specific RPC service is listening on
- **DCE/RPC** (Distributed Computing Environment) is the foundational standard; Microsoft's MSRPC is a proprietary extension of it
- RPC attacks include **buffer overflows**, **null session exploitation**, and **authentication bypass** — all historically weaponized against Windows systems
- **WMI and Active Directory replication** both rely on RPC underneath, making it a critical protocol in Windows domain environments
- Blocking port 135 externally is a baseline hardening step; internally, monitoring for unusual RPC traffic can detect lateral movement (e.g., PsExec uses RPC)

## Related concepts
[[Buffer Overflow]] [[SMB]] [[Lateral Movement]] [[Port Scanning]] [[Windows Active Directory]]