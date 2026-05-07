# TFTP & FTP: File Transfer Protocols for Network Device Management

## What it is

Dropping a care package in Helldivers 2 vs. running a full Tarkov raid with extraction — that's the gap between TFTP and FTP.

TFTP (Trivial File Transfer Protocol) is the care package: you call it in, it lands, you grab it, done. No login, no inventory check, no questions about what else is on the map. It's a barebones file transfer service running over UDP that exists for one job — moving a known file between two machines on a trusted network.

FTP (File Transfer Protocol) is the full raid: you authenticate at the entry, navigate the map, list what's in the stash, decide what to extract, and the whole thing runs over reliable TCP connections so nothing gets lost in transit.

Both protocols solve the same surface problem ("get this file from there to here"), but they're built for completely different threat models and use cases. Network engineers reach for them constantly when shoving IOS images onto switches or yanking config backups off routers.

## Why it matters

When a Cisco switch's flash memory needs a new IOS image at 2 AM during a maintenance window, you're not opening Dropbox. You're spinning up a TFTP server on your laptop, plugging into the management network, and running `copy tftp: flash:`. That's the workflow. Every network engineer learns it because every vendor supports it.

The choice between TFTP and FTP is a security and capability tradeoff. TFTP is fast to set up and works on devices with almost no resources — but it has zero authentication, so anyone who can reach UDP port 69 can read or overwrite files. FTP gives you usernames, passwords, directory browsing, and TCP reliability — but it's chattier, needs more configuration, and its dual-port design fights with NAT and firewalls like a bad matchmaking lobby.

Knowing which one to weaponize, and how to recover when an image upgrade goes sideways, is the difference between a clean reload and a bricked device sitting in a closet.

## Key facts

### TFTP — the lightweight option

- **Runs over UDP port 69.** UDP because the protocol handles its own retransmits at the application layer. Like Among Us emergency meetings — short, stateless, everyone yells once and moves on.
- **No authentication, no permissions.** Whoever can reach the server can read or write. This is why TFTP belongs on isolated management networks, never the public internet.
- **Stateless and lightweight.** Tiny enough to fit in a router's bootloader ROM, which is exactly why PXE boot and IOS recovery rely on it.
- **Transfers in 512-byte blocks.** Each block gets a sequential number starting at 1. Think of it like Pokémon HM moves — fixed, predictable, in order.
- **RRQ and WRQ initiate transfers.** Read Request to download, Write Request to upload. Client sends one, server responds.
- **DATA / ACK ping-pong.** Server sends a DATA block, client ACKs it, server sends the next. Lockstep. No sliding window.
- **~5 second retransmit timeout.** If no ACK arrives, the sender resends the block.
- **End-of-transfer = a DATA block smaller than 512 bytes.** That's literally how both sides know it's over. If the file size is an exact multiple of 512, the last block sent is empty (0 bytes).
- **Two modes: netascii and octet (binary).** Octet for IOS images, firmware, anything you don't want mangled.
- **No directory listing.** You must know the exact filename. There's no `ls`, no `dir`, no autocomplete. Fat-finger the filename and you get nothing.
- **No session state.** Each transfer is a one-shot deal.
- **Default serve directory:** `/tftpboot/` on Linux, `C:\tftpboot\` on Windows.
- **Firewall rule:** allow UDP/69 inbound to the server.

### FTP — the full-featured option

- **Two TCP ports: 21 (control) and 20 (data).** Port 21 is the chat channel where commands fly back and forth; port 20 is the cargo bay where actual file bytes move. Like a Discord call where you're talking strategy in voice (21) but file uploads go through a separate attachment system (20).
- **Connection-oriented over TCP.** Reliability, ordering, and flow control are inherited from TCP — no application-level retransmit logic needed.
- **Real authentication.** Username and password required (or `anonymous` if the server allows it).
- **Command vocabulary** (sent over the control channel):
  - `CWD` — Change Working Directory (navigate folders)
  - `LIST` — directory listing
  - `RETR` — retrieve (download) a file
  - `STOR` — store (upload) a file
  - `DELE` — delete a file
  - `RMD` — remove a directory
- **Active mode:** server connects back to the client on port 20 to deliver data. Breaks behind NAT because the client's "real" IP isn't reachable — like trying to invite a friend to your Minecraft LAN world when you forgot to port forward.
- **Passive mode:** client opens both connections to the server. Works cleanly through NAT, which is why it's the default for most modern clients.
- **Firewall rule:** allow TCP/21, plus TCP/20 (active) or a passive port range.

### Cisco IOS commands you'll actually type

- `copy tftp: flash:` — pull a file from a TFTP server into flash memory.
- `copy flash: tftp:` — push a file from flash up to a TFTP server (config backups, image archiving).
- `copy ftp: flash:` — same idea but over FTP, prompting for credentials.
- `copy flash: ftp:` — upload from flash to an FTP server.
- `show flash:` — list flash contents and free space. Always run this *before* downloading a 200 MB IOS image onto a device with 180 MB free.
- `show version` — reveals the currently running image and its path.
- `boot system flash:<filename>` — tells the device which image to boot next time. Skip this and your shiny new IOS image just sits there while the old one keeps loading.
- `verify /md5 flash:<filename> <expected-hash>` — checksums the file against the vendor-published hash. Skipping this is how you brick a device with a corrupted image.

### IOS upgrade workflow (the speedrun route)

1. `show flash:` — confirm there's room.
2. `copy tftp: flash:` (or FTP) — pull the new image down.
3. `verify /md5 flash:<image>` — match the hash against vendor's published value.
4. `boot system flash:<new-image>` — set the boot pointer.
5. `write memory` — save config so the boot statement persists.
6. `reload` — reboot into the new image.

Skip step 3 and you might be reloading into a corrupted image with no rollback. Skip step 4 and the device cheerfully boots the old image, leaving you wondering why nothing changed.

## Related concepts

[[SCP and SFTP]] — the encrypted, modern replacements that should be your default outside of bootloader scenarios
[[Cisco IOS file system]]
[[Flash memory and boot process]]
[[NAT traversal]]
[[UDP vs TCP]]
[[MD5 and SHA file integrity verification]]
[[PXE boot]]
[[Out-of-band management networks]]
[[Configuration backup and archive]]