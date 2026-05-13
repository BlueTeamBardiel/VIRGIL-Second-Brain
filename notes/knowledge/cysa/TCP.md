# TCP — Transmission Control Protocol

## What it is

In **Half-Life**, when Gordon Freeman pushes the cart into the anti-mass spectrometer at the start of the Black Mesa incident, the scientists go through a fixed sequence — push the sample in, confirm it's seated, raise the beam power, confirm the readings, *then* run the test. Every step gets a verbal handshake. "Set rotation to fifty percent," "rotation at fifty," "very good." If a step is skipped or the response doesn't come back, the experiment doesn't proceed. That's TCP. Every packet gets acknowledged, every sequence is tracked, and if a response doesn't come back the conversation stalls until it does.

In plain English: TCP is the protocol that makes the internet feel reliable. It guarantees packets arrive, arrive in order, and arrive without corruption — or it tells the sender to try again.

**Technical definition (CS0-003):** Transmission Control Protocol is a connection-oriented, stateful Layer 4 transport protocol that provides reliable, ordered, error-checked delivery of byte streams between hosts. It uses a three-way handshake (SYN → SYN/ACK → ACK) to establish sessions, sequence and acknowledgment numbers to track delivery, and a four-way teardown (FIN/ACK pairs) to close cleanly. Defined in RFC 793.

## Why it matters

The CySA+ exam treats TCP fluency as table stakes. You can't read a [[packet capture]] in [[Wireshark]], you can't interpret a [[firewall]] log, you can't write a [[SIEM]] correlation rule, and you can't recognize [[command and control]] beaconing if you don't know what a TCP session looks like in flight and at the wire.

CS0-003 Objective 1.3 puts TCP analysis inside the broader "determine malicious activity" toolkit. The exam will hand you a packet capture, a netstat output, or a firewall log and ask what's happening. Half the answers depend on whether you can read TCP flags and state.

In the war room, TCP is how you tell the difference between a port scan, an active session, a half-open connection from a [[SYN flood]], and a covert C2 channel beaconing every 60 seconds.

## Key facts

### The TCP header — what's actually on the wire

| Field | Size | Why the analyst cares |
|---|---|---|
| Source port | 16 bits | Identifies the client-side socket |
| Destination port | 16 bits | The service being contacted (80, 443, 22, 3389) |
| Sequence number | 32 bits | Byte offset of this segment in the stream |
| Acknowledgment number | 32 bits | Next byte expected from the peer |
| Flags | 9 bits | SYN, ACK, FIN, RST, PSH, URG, ECE, CWR, NS |
| Window size | 16 bits | Flow control — how much buffer the receiver has |
| Checksum | 16 bits | Integrity check |
| Urgent pointer | 16 bits | Rarely used legitimately; sometimes abused for covert channels |
| Options | variable | MSS, SACK, timestamps, window scaling |

The flags are where threat hunting lives. Memorize them cold.

### TCP flags — the exam-critical six

- **SYN** — synchronize. "I want to start a conversation." Sets the initial sequence number.
- **ACK** — acknowledge. "I got your byte X, send me byte X+1 next."
- **FIN** — finish. "I'm done sending; closing my half."
- **RST** — reset. "This connection is broken or unwanted, tear it down now."
- **PSH** — push. "Don't buffer this, hand it to the application immediately."
- **URG** — urgent. Legacy, mostly unused. Suspicious if you see it.

### The three-way handshake

```
Client  ──SYN (seq=x)──────────────►  Server
Client  ◄──SYN/ACK (seq=y, ack=x+1)── Server
Client  ──ACK (ack=y+1)─────────────► Server
        [session established, data flows]
```

When you see a SYN with no SYN/ACK back, the destination is filtered, down, or scanning is being blocked. When you see SYN/ACK without the final ACK, it's a **half-open** connection — the signature of [[SYN flood]] DoS or stealth scanning.

### The four-way teardown

```
Client  ──FIN───────► Server
Client  ◄──ACK─────── Server
Client  ◄──FIN─────── Server
Client  ──ACK───────► Server
```

Or one side sends **RST** and the conversation dies immediately. RSTs from your servers to external IPs are noise. RSTs *to* your servers from unexpected sources at scale are a clue someone is mapping you.

### TCP vs UDP — the comparison CompTIA will test

| Property | TCP | UDP |
|---|---|---|
| Connection | Connection-oriented | Connectionless |
| Reliability | Guaranteed delivery, retransmission | Best effort |
| Ordering | In-order via sequence numbers | No ordering |
| Handshake | Three-way | None |
| Overhead | 20-byte header minimum | 8-byte header |
| Use cases | HTTP/S, SSH, SMTP, RDP, SMB | DNS queries, DHCP, NTP, VoIP, streaming |
| Stateful inspection | Tracks session state | No state to track |

### Common TCP ports the exam will throw at you

| Port | Service | Why the SOC cares |
|---|---|---|
| 20/21 | FTP | Cleartext credentials, data exfil vector |
| 22 | SSH | Brute force target, legit admin channel |
| 23 | Telnet | Should not exist in 2026 |
| 25 | SMTP | Outbound mail, spam relay abuse |
| 53 | DNS (TCP for zone transfers, large responses) | DNS tunneling for C2 |
| 80 | HTTP | Web traffic, malware download |
| 110 | POP3 | Legacy mail retrieval |
| 135/139/445 | RPC/NetBIOS/SMB | Lateral movement, ransomware |
| 143 | IMAP | Mail retrieval |
| 389 | LDAP | Directory queries, recon |
| 443 | HTTPS | Where 80% of C2 hides now |
| 636 | LDAPS | Encrypted directory |
| 993/995 | IMAPS/POP3S | Encrypted mail |
| 1433 | MSSQL | Database, SQLi pivot |
| 3306 | MySQL | Database |
| 3389 | RDP | Ransomware initial access king |
| 5985/5986 | WinRM | PowerShell remoting, lateral movement |

### TCP states (netstat / ss output)

`LISTEN`, `SYN_SENT`, `SYN_RECEIVED`, `ESTABLISHED`, `FIN_WAIT_1`, `FIN_WAIT_2`, `CLOSE_WAIT`, `TIME_WAIT`, `CLOSED`.

Two states to flag:
- **`SYN_RECEIVED`** piling up on a server = potential SYN flood or scan in progress
- **`ESTABLISHED`** to a low-reputation external IP from a workstation = potential C2

### TCP behaviors attackers exploit

- **SYN flood** — flood half-open connections, exhaust the server's connection table. SYN cookies mitigate.
- **Stealth scans** — `nmap -sS` (SYN scan) never completes the handshake, leaves no application-layer log. `nmap -sF/-sN/-sX` (FIN/NULL/Xmas) send unusual flag combinations to bypass naive filters.
- **TCP session hijacking** — predicting sequence numbers to inject traffic. Modern OS randomization makes this hard but not impossible.
- **RST injection** — forging RST packets to kill legitimate sessions (Great Firewall does this).
- **Slowloris-style** — keep TCP sessions open with minimal data, exhaust the server's worker pool.
- **Covert channels** — encoding data in sequence numbers, urgent pointers, or option fields.

### TCP in [[Wireshark]] — the analyst's view

Filter cheat sheet for the exam:

```
tcp.flags.syn == 1 and tcp.flags.ack == 0    # SYN only — scan or new conn
tcp.flags.reset == 1                          # RSTs — broken/refused
tcp.analysis.retransmission                   # Network problems or evasion
tcp.port == 443 and ip.dst == 1.2.3.4         # Session to a specific host
tcp.stream eq 7                               # Follow one full conversation
```

`Follow → TCP Stream` reassembles the byte stream so you can read what the application actually sent — HTTP requests, SQL queries, cleartext credentials, malware C2 commands.

### CompTIA exam traps

> **CompTIA exam trap:** TCP vs UDP use-case swap. The exam will ask which protocol DNS uses and the trap answer is "UDP only." DNS uses **UDP/53 for normal queries and TCP/53 for zone transfers and responses larger than 512 bytes**. Same for syslog — UDP/514 by default, but TCP/6514 for reliable syslog over TLS.

> **CompTIA exam trap:** Three-way handshake order. The sequence is SYN → SYN/ACK → ACK. Not "SYN → ACK → SYN/ACK." CompTIA will reorder it on a drag-and-drop question and watch you misclick.

> **CompTIA exam trap:** "Stateful" vs "stateless" firewall. TCP is stateful by nature, so a stateful firewall tracks the session and allows return traffic automatically. A stateless ACL has to permit both directions explicitly. The exam tests this distinction.

> **CompTIA exam trap:** Encrypted ≠ safe. HTTPS on TCP/443 is encrypted, which means your [[IDS]] can see metadata (source, destination, timing, byte counts) but not payload. Beaconing analysis works on metadata alone — don't assume TLS hides the attacker.

### Behavioral patterns — what TCP tells the threat hunter

[[Command and control]] traffic on TCP usually looks like:
- **Beaconing** — regular outbound connections at fixed intervals (60s, 300s, 3600s) with low jitter. The session is short, the byte count is small, the destination is rarely visited by anything else.
- **Long-lived sessions** — RAT keeping a TCP session open for hours.
- **Off-hours activity** — TCP sessions to external IPs at 3am from a workstation.
- **Unusual port/protocol pairs** — TCP/443 traffic that doesn't parse as TLS (no SNI, no certificate exchange).

User behavior analysis correlates these patterns with account activity. A workstation that beacons to a Russian IP on TCP/443 every 90 seconds while the user is logged in from two countries simultaneously ([[impossible travel]]) is not a tuning problem.

*The protocol doesn't lie. The application layer can be obfuscated, the payload encrypted, the domain DGA-generated — but the TCP metadata (timing, byte counts, flag patterns) is mathematically present on the wire. Hunt the shape, not the content.*

## SOC reality

- L1 sees a [[SIEM]] alert: "Outbound TCP/443 to known-malicious IP, host WKSTN-0421." First action: pivot to the [[EDR]] on that endpoint, get the process tree, identify the parent of the connection. Was it chrome.exe or powershell.exe? That answer determines whether you sip coffee or call the on-call.
- The IR lead asks three questions on every TCP-related ticket: *"Is the session still active? What process owns it? When did it first appear in the netflow data?"* If you can't answer all three in under five minutes, your tooling is broken.
- Never promise the CISO "we blocked it at the firewall" until you've verified the [[firewall]] log shows the deny *and* the endpoint shows no `ESTABLISHED` state to the destination. A blocked-but-still-trying connection is loud. A blocked-and-gone connection is contained.
- The handoff to L2 happens when the TCP session correlates with other indicators: process lineage, file write, registry persistence. One weird TCP session is noise; one weird TCP session plus a freshly-dropped binary plus a scheduled task is an incident.
- 80% of TCP/443 outbound is legitimate cloud SaaS. The 20% that matters hides in the noise. Tune your SIEM on byte-count ratios and timing entropy, not on destination IP alone.

## Related concepts

[[UDP]] · [[IP]] · [[ICMP]] · [[Three-way handshake]] · [[SYN flood]] · [[Port scanning]] · [[Nmap]] · [[Wireshark]] · [[Packet capture]] · [[NetFlow]] · [[Firewall]] · [[IDS/IPS]] · [[SIEM]] · [[EDR]] · [[Command and control]] · [[Beaconing]] · [[TLS]] · [[DNS]] · [[Impossible travel]] · [[User behavior analysis]]

*Source: VIRGIL knowledge base — 2026-05-11*