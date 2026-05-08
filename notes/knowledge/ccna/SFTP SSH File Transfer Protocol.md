# SFTP SSH File Transfer Protocol

## What it is

In Civilization, when you establish an Embassy with another civilization, every diplomatic exchange — trade deals, tech sharing, intelligence — flows through that single secured channel instead of shouting proposals across the map for every other civ to intercept. That's exactly what SFTP does — it tunnels file transfers through one already-encrypted SSH connection so nothing leaks in transit.

**SFTP (SSH File Transfer Protocol)** is a file transfer protocol that runs as a subsystem of [[SSH]] over a single TCP connection on **port 22**, providing encrypted authentication, file transfer, and remote filesystem operations.

## Why it matters

Plain [[FTP]] sends usernames, passwords, and file contents in cleartext across two ports (20 and 21), which is how credentials end up in someone's Wireshark capture and on a forum. SFTP replaces FTP for any sane network: one encrypted port, firewall-friendly, no separate data channel to misconfigure. On the CCNA, expect to recognize SFTP as the secure file-transfer option alongside SSH, and to distinguish it from FTPS and SCP.

## Key facts

### Protocol mechanics

- Runs over **TCP port 22** — same as [[SSH]].
- **One connection** carries control and data (unlike FTP's two-channel mess).
- Authentication via SSH: passwords or **public-key** auth.
- Full encryption of credentials, commands, and payload.
- Supports interactive operations: `ls`, `cd`, `mkdir`, `rm`, `rename`, resume transfers, directory listings.

### SFTP vs FTPS vs SCP

| Feature | **SFTP** | **FTPS** | **SCP** |
|---|---|---|---|
| Underlying protocol | [[SSH]] | [[FTP]] + [[TLS]] | [[SSH]] |
| Port(s) | 22 | 21 + ephemeral data ports (or 990 implicit) | 22 |
| Connections | 1 | 2 (control + data) | 1 |
| Firewall-friendly | Yes | No (NAT/data port pain) | Yes |
| Interactive commands | Yes | Yes | No (one-shot copy) |
| Resume transfers | Yes | Yes | No |
| Directory operations | Yes | Yes | No |
| Typical use | General secure transfer | Legacy FTP needing TLS | Quick scripted copy |

### Why it replaces FTP

- **One port** (22) — no PASV/PORT mode gymnastics through [[NAT]] and firewalls.
- **Encrypted by default** — no STARTTLS afterthought.
- **Single auth model** — same SSH keys you already use for shell access.
- **No anonymous-by-default footgun.**

### Interactive command examples

```
sftp admin@192.168.1.1
sftp> ls
sftp> cd /flash
sftp> get running-config backup.cfg
sftp> put new-image.bin
sftp> bye
```

### On Cisco IOS

Copy a file from a device using SFTP as client:

```
Router# copy flash:running-config sftp://admin@192.168.1.50/backups/rtr1.cfg
```

Or pull an image in:

```
Router# copy sftp://admin@192.168.1.50/images/c2900.bin flash:
```

SSH must be configured first (RSA keys, `ip ssh version 2`, local or AAA auth).

### Common gotchas

- SFTP is **not** FTP-over-SSH-tunnel and **not** FTPS. Different protocol entirely.
- SFTP is **not** SCP, though both ride SSH. SCP is a simpler copy tool with no interactive session.
- If port 22 is blocked, SFTP is blocked. There is no fallback.

## Related concepts

[[SSH]] · [[FTP]] · [[FTPS]] · [[SCP]] · [[TFTP]] · [[TLS]] · [[Public-key authentication]] · [[Cisco IOS file management]]

---
*Source: VIRGIL knowledge base — 2026-05-07*