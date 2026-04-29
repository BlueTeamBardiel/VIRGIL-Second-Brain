# enum4linux

## What it is
Think of it as a nosy neighbor who peeks through every window of a Windows house by pretending to be a casual visitor — enum4linux is a Linux-based tool that wraps around Samba utilities (smbclient, rpcclient, net) to automatically extract information from Windows and Samba systems via SMB/NetBIOS, typically without authentication via null sessions.

## Why it matters
During a penetration test against a corporate network, an attacker runs enum4linux against an unpatched Windows Server and retrieves a full list of usernames, group memberships, password policies, and open shares — all without a single valid credential. This user list then becomes the foundation for a targeted password spraying attack, turning an anonymous probe into domain compromise.

## Key facts
- Operates primarily over **ports 139 and 445** (NetBIOS/SMB) and port **137** (NetBIOS Name Service)
- Exploits **null sessions** — unauthenticated SMB connections that older Windows and misconfigured Samba servers allow by default
- Enumerates: **users, groups, shares, password policies, OS version, domain/workgroup info, and RID cycling** (brute-forcing user RIDs to discover accounts)
- Originally a Perl wrapper; **enum4linux-ng** is the modern Python rewrite with better output formats (JSON/YAML) and improved reliability
- Null session access was largely disabled by default starting with **Windows XP SP2 and Server 2003**, but misconfigured legacy systems and Samba shares still expose this vector

## Related concepts
[[SMB (Server Message Block)]] [[Null Session Attack]] [[NetBIOS]] [[RID Cycling]] [[Network Enumeration]]