# TACACS+ and RADIUS

## What it is

In **Silent Hill**, the radio doesn't just hiss randomly — when a creature approaches, the static confirms *what's out there*, the flashlight decides *whether you're allowed to see it*, and your save points at the red squares record *that you were here, at this time, doing this*. That's [[AAA]]: **Authentication** (you are who you claim), **Authorization** (you can do what you're trying to do), and **Accounting** (we wrote it down). TACACS+ and RADIUS are the two protocols that let a network device ask a central server those three questions instead of trusting a local password file — because trusting the fog to identify what's coming at you is how you end up dead.

**TACACS+** is Cisco's proprietary AAA protocol over TCP/49 that encrypts the entire payload and separates the three A's into independent exchanges. **RADIUS** is the IETF open-standard AAA protocol (RFC 2865) over UDP/1812+1813 that encrypts only the password and bundles authentication with authorization.

## Why it matters

Without centralized [[AAA]], every router and switch keeps its own local user database — which means when an admin leaves the company, you're SSH-ing into 400 devices to delete their account, and you will miss one. That missed account is how breaches start. The CCNA exam will ask you which protocol does what, which ports they use, and which encrypts more than just the password. Get the table below into long-term memory.

## Key facts

### Side-by-side comparison

| Feature | **TACACS+** | **RADIUS** |
|---|---|---|
| Transport | **TCP** | **UDP** |
| Port(s) | **49** | **1812** (authn/authz), **1813** (accounting) |
| Standard | **Cisco proprietary** | **IETF RFC 2865** (open) |
| Encryption | **Entire packet payload** | **Password only** |
| AAA separation | **Authn, Authz, Acct are independent** | **Authn + Authz combined**; Acct separate |
| Per-command authorization | **Yes** (granular) | **No** (not natively) |
| Primary use case | **Device administration** (router/switch CLI) | **Network access** (Wi-Fi, [[802.1X]], VPN) |
| Multivendor support | Limited | Universal |

### Why the separation matters

TACACS+ splitting [[Authentication]] from [[Authorization]] means you can authenticate against one source (say, [[Active Directory]]) and authorize commands from a different policy entirely — and check authorization on **every command typed**. RADIUS hands you a service profile at login and walks away.

### Encryption reality check

- **RADIUS** encrypts only the User-Password attribute using an MD5-based scheme with a shared secret. Username, authorized services, and accounting data travel in cleartext. A packet capture is a treasure map.
- **TACACS+** encrypts everything after the header. Same shared secret model, but the attacker sees nothing useful without it.

### When to choose which

- **TACACS+** → controlling who can log into network devices and what commands they can run. Per-command authorization is the killer feature.
- **RADIUS** → authenticating end-users to the network ([[802.1X]] port-based authentication, wireless WPA2/3-Enterprise, VPN concentrators). It's what every non-Cisco vendor speaks.
- **Both** → not unusual. TACACS+ for admin plane, RADIUS for user plane.

### Server group configuration (IOS)

Define the server, then group it, then point AAA methods at the group.

```
! TACACS+ server
tacacs server TAC-SRV-1
 address ipv4 10.1.1.10
 key SuperSecret123

! RADIUS server
radius server RAD-SRV-1
 address ipv4 10.1.1.20 auth-port 1812 acct-port 1813
 key SuperSecret456

! Server groups
aaa group server tacacs+ TAC-GROUP
 server name TAC-SRV-1

aaa group server radius RAD-GROUP
 server name RAD-SRV-1

! Enable AAA and bind methods
aaa new-model
aaa authentication login default group TAC-GROUP local
aaa authorization exec default group TAC-GROUP local
aaa accounting exec default start-stop group TAC-GROUP
```

The trailing `local` is the fallback method — if every TACACS+ server is dead, you can still log in with the local account. Forget this and watch yourself get locked out of a production switch at 2 AM.

### Exam traps

- "Encrypts the entire packet" → **TACACS+**. "Encrypts only the password" → **RADIUS**.
- TCP/49 → TACACS+. UDP/1812 → RADIUS authn. UDP/1813 → RADIUS acct.
- "Per-command authorization" → TACACS+ exclusively.
- RADIUS combines authn and authz in one exchange. TACACS+ keeps them separate.

## Related concepts

[[AAA]] · [[Authentication]] · [[Authorization]] · [[Accounting]] · [[802.1X]] · [[Active Directory]] · [[ISE (Identity Services Engine)]] · [[Shared Secret]] · [[SSH]] · [[Privilege Levels]] · [[Local Authentication]]

---
*Source: VIRGIL knowledge base*