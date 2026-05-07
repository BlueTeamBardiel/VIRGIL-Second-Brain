# Secure Shell

## What it is

Telnet is like shouting your Netflix password across a crowded coffee shop — anyone listening on the network grabs your credentials in plaintext. SSH is the same conversation happening through a sealed, encrypted tunnel where even if someone records every packet, they get unreadable noise.

Secure Shell (SSH) is a protocol for remote command-line access to network devices and servers. It encrypts everything — the login handshake, your username, your password, every command you type, and every byte of output coming back. It runs on TCP port 22 by default and authenticates the server to the client using public-key cryptography, so you also know you're talking to the real device and not an impostor pretending to be your switch.

On Cisco gear, SSH is how you replace the legacy Telnet workflow. You connect to a "line" — a logical pathway into the CLI, like a queue slot at a Chipotle counter. The console line (`line con 0`) is the physical port you plug a rollover cable into and only serves one person at a time. The VTY lines (`line vty 0 15`) are 16 virtual slots for remote sessions over the network.

## Why it matters

Running Telnet in production today is the equivalent of streaming your Discord screen-share with your password manager open. Every packet capture along the path — a compromised switch, a malicious Wi-Fi hotspot, a rogue employee with Wireshark — yields full credentials and full session content. That's not a theoretical risk; it's a one-tcpdump risk.

SSH plus per-user accounts also gives you something Telnet's shared line password fundamentally cannot: an audit trail. When Beatrice logs in and reloads a core switch at 2 AM, the logs say "Beatrice did this," not "somebody who knew the VTY password did this." If she leaves Limbo Capital, you disable her account — you don't have to rotate a shared secret across every device and tell the whole team the new one in a group chat.

## Key facts

### Lines and access modes
- A **line** is a logical CLI pathway. Think of it as a save slot — finite in number, each one tracking its own session.
- **Console line** (`line con 0`): physical access, one user at a time. The local co-op seat.
- **VTY lines** (`line vty 0 15`): 16 simultaneous remote sessions. The online lobby.
- **Privilege level 1** = User EXEC mode, read-only — the spectator role.
- **Privilege level 15** = Privileged EXEC mode, full control — the lobby host with kick powers.
- **`exec-timeout`** auto-logs idle sessions. Default is 10 minutes. Like Steam marking you Away.

### Authentication commands
- **`login`**: prompts for a password set on the line itself (shared secret, no username).
- **`login local`**: authenticates against the local user database (real accounts).
- The two cannot coexist on the same line — pick one matchmaking mode.
- **`username <name> secret <pw>`**: stores a hash of the password. Safe-ish.
- **`username <name> password <pw>`**: stores it in cleartext in the config. Don't.
- Telnet can run with only a line password — no user account required, so no individual accountability.
- SSH **requires** user accounts, which is why it gives you per-user audit logs and granular privilege control.

### SSH versions and crypto
- **SSH v1 is deprecated** — known cryptographic weaknesses, treat it like WEP Wi-Fi.
- **SSH v2 is the current standard.** Always use it.
- **`ip ssh version 2`** locks the device to v2 only.
- **Default port: 22.**
- Each session negotiates **fresh ephemeral encryption keys** — like every Among Us round generating a new map seed, so cracking one session doesn't compromise the next.

### RSA key generation
- **`crypto key generate rsa`** creates the device's RSA keypair used for server authentication.
- The key name is derived from `hostname` + `ip domain-name`, so both must be set first or the command fails.
- **Modulus size** is measured in bits — bigger modulus, harder to factor.
- **1024 bits**: bare minimum.
- **2048 bits**: recommended. The "play on Hard difficulty" setting.
- **`show crypto key mypubkey rsa`** dumps the public key.
- **`show ip ssh`** shows SSH status and active version.

### Restricting what the VTY lines accept
The `transport input` command on a VTY line is the bouncer at the door:
- **`transport input telnet ssh`**: lets both in. Mixed lobby — fine for migration, bad as a final state.
- **`transport input ssh`**: SSH only. The correct production setting.
- **`transport input none`**: nobody gets in remotely. Useful for hardening unused lines.

## Related concepts
[[Telnet]] · [[AAA (Authentication, Authorization, Accounting)]] · [[RSA Cryptography]] · [[Public Key Infrastructure]] · [[Cisco IOS Privilege Levels]] · [[Console and AUX Ports]] · [[Device Hardening]] · [[TACACS+ and RADIUS]] · [[Password Hashing]] · [[Out-of-Band Management]]