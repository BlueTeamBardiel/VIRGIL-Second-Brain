# Telnet vs SSH

## What it is

In Doom, picking up the BFG-9000 in plain sight on E2M8 means every Cyberdemon, Cacodemon, and Imp in the level watches you grab it and knows exactly what you're holding. **Telnet is that — every keystroke, every password, every config change broadcast across the network in cleartext for anyone with Wireshark to grab.** SSH is the same weapon, but you teleported to it through a sealed corridor nobody else can see into.

**Telnet** is an unencrypted remote terminal protocol over **TCP 23**. **SSH** (Secure Shell) is its cryptographically-protected replacement over **TCP 22**, providing confidentiality, integrity, and server authentication via host keys.

## Why it matters

Anyone with a SPAN port, a tap, or a compromised switch between you and a Telnet-managed device captures the enable password in cleartext on the first login. That is not a theoretical attack — it is a `tshark -Y telnet` one-liner. Running Telnet on production infrastructure in 2026 is malpractice; the CCNA expects you to know SSH is mandatory, version 2 only, and that configuring it requires generating RSA keys and setting `transport input ssh` on the VTY lines.

## Key facts

### Protocol comparison

| Attribute | [[Telnet]] | [[SSH]] |
|---|---|---|
| TCP port | **23** | **22** |
| Encryption | None (cleartext) | Symmetric (AES, ChaCha20) |
| Integrity | None | HMAC / AEAD |
| Server auth | None | [[Host key]] verification |
| Client auth | Password only | Password **or** [[public key authentication]] |
| Replay protection | None | Yes |
| RFC | 854 (1983) | 4251–4254 (2006) |

### How SSH actually protects you

- **[[Diffie-Hellman key exchange]]** establishes a shared session key over the untrusted network.
- **[[Host key]]** — the server's public key, fingerprinted on first connect. If it changes, the client screams (the "REMOTE HOST IDENTIFICATION HAS CHANGED" warning). This defeats [[man-in-the-middle attack|MITM]].
- **Symmetric cipher** (negotiated, e.g. AES-CTR, AES-GCM) encrypts the session.
- **MAC or AEAD** ensures nobody flipped bits in transit.

### Password vs key authentication

- **Password auth** — what you type. Encrypted in transit, but still a password. Brute-forceable, phishable, reusable.
- **[[Public key authentication]]** — client proves possession of a private key matching a public key in the server's `authorized_keys`. No secret crosses the wire. Preferred for automation and humans who can be trusted with a passphrase.

### Configuring SSH on a Cisco IOS device

```
hostname R1
ip domain-name example.lab
crypto key generate rsa modulus 2048
ip ssh version 2
ip ssh time-out 60
ip ssh authentication-retries 3
username admin privilege 15 secret StrongP@ss
line vty 0 4
 transport input ssh
 login local
```

### Critical points

- **`crypto key generate rsa`** — without RSA keys, SSH cannot start. Modulus **≥ 768** is required for SSHv2; **2048** is the sane minimum.
- **`ip ssh version 2`** — SSHv1 is broken (insertion attacks, weak integrity). Always force v2.
- **`transport input ssh`** — explicitly disables Telnet on the VTY lines. `transport input all` or `telnet` is the malpractice setting.
- **`login local`** with a `username` database, or AAA. No more shared `password` on the line.
- A **hostname** and **domain-name** are prerequisites — RSA key generation refuses to run otherwise (the key is named `hostname.domain`).

### Verification

```
show ip ssh
show ssh
show running-config | section vty
```

`show ip ssh` confirms version 2 and key length. `show ssh` lists active sessions.

### Exam angles

- Telnet = **TCP 23**, SSH = **TCP 22**. Memorize.
- SSH requires: **hostname, domain-name, RSA keys, local user or AAA, `transport input ssh`**.
- SSHv2 explicitly enabled with `ip ssh version 2`.
- `transport input ssh` on VTY = Telnet blocked.

## Related concepts

[[VTY lines]] · [[AAA]] · [[Public key authentication]] · [[Host key]] · [[RSA]] · [[Out-of-band management]] · [[Console port]] · [[Privilege levels]] · [[enable secret]] · [[Wireshark]]

---
*Source: VIRGIL knowledge base — 2026-05-07*