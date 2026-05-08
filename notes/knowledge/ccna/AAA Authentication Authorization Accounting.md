# AAA Authentication Authorization Accounting

## What it is

In **Mortal Kombat**, the character select screen confirms you actually own Shang Tsung before letting you pick him, the match settings decide which stages and finishers you're allowed to use, and the post-fight stats screen logs every combo, brutality, and koin you earned. That's exactly what [[AAA]] does — three separate checks that prove who you are, decide what you can touch, and write down everything you did.

**AAA** is a Cisco framework that splits device access control into three independent services: [[Authentication]] (identity), [[Authorization]] (permissions), and [[Accounting]] (audit log).

## Why it matters

Without AAA, every router and switch becomes its own little fiefdom with a shared password sticky-noted to the monitor. When the network engineer quits, you're rotating credentials on 400 devices by hand — or you're not, and they still have access. AAA centralizes identity, enforces least privilege at the command level, and gives you a forensic trail when someone fat-fingers `no router ospf 1` at 3 AM. CCNA loves to ask which protocol does what and which port number goes with which.

## Key facts

### The three A's

| Service | Question it answers | Example |
|---|---|---|
| **Authentication** | Who are you? | Username + password, certificate, token |
| **Authorization** | What are you allowed to do? | Can run `show` but not `configure terminal` |
| **Accounting** | What did you do? | Logged commands, session duration, bytes transferred |

### Local vs server-based AAA

- **Local AAA** — credentials live in the device's running-config (`username admin secret ...`). Fine for a lab, miserable to scale. Think single-player [[Minecraft]] world.
- **Server-based AAA** — device asks an external [[AAA server]] (e.g., [[Cisco ISE]]). Centralized, scalable, auditable. Think MMO login server.

### TACACS+ vs RADIUS

The exam will ask this. Memorize it.

| Feature | [[TACACS+]] | [[RADIUS]] |
|---|---|---|
| Vendor origin | Cisco proprietary | Open standard ([[IETF]]) |
| Transport | **TCP 49** | **UDP 1812** (auth), **UDP 1813** (acct) |
| Encryption | **Entire packet** encrypted | **Password only**; rest is cleartext |
| AAA separation | Authentication, Authorization, Accounting are **separate** | Authentication and Authorization **bundled** |
| Granularity | **Per-command** authorization (fine-grained) | Coarse — service-level only |
| Typical use | Device admin / [[CLI]] access | End-user network access (802.1X, VPN, Wi-Fi) |

Mnemonic: **T**ACACS+ for **T**erminal admin, **R**ADIUS for **R**emote users.

### Enabling AAA

Nothing works until you flip the master switch:

```
Router(config)# aaa new-model
```

This enables AAA globally and disables the legacy `login` and `enable password` behaviors on lines.

### Method lists with fallback

A [[method list]] is an ordered list of where to check credentials. Tried left to right; falls through only if the previous method is **unreachable** (not if it returns "denied").

```
aaa authentication login default group tacacs+ local
aaa authentication login CONSOLE_LIST local enable
```

- First line: try TACACS+ servers, fall back to local user database.
- Second line: a named list `CONSOLE_LIST` — try local users, fall back to the [[enable secret]].

Apply named lists to lines:

```
line console 0
 login authentication CONSOLE_LIST
```

The `default` list applies everywhere unless overridden. Forgetting a fallback and losing TACACS+ reachability is the classic way to lock yourself out of your own router.

### Privilege levels 0–15

Cisco IOS has 16 [[privilege levels]]:

| Level | Meaning |
|---|---|
| **0** | Bare minimum — `disable`, `enable`, `exit`, `help`, `logout` |
| **1** | User EXEC mode — the `Router>` prompt, mostly `show` commands |
| **2–14** | Custom levels — assign specific commands as needed |
| **15** | Privileged EXEC — full `Router#` god mode |

Assign with:

```
username techops privilege 5 secret 0 ...
privilege exec level 5 ping
```

TACACS+ command authorization makes privilege levels look like training wheels — it can authorize or deny individual commands per user without juggling levels 2–14.

## Related concepts

[[802.1X]] · [[Cisco ISE]] · [[enable secret]] · [[SSH]] · [[VTY lines]] · [[Privilege levels]] · [[Method list]] · [[RADIUS]] · [[TACACS+]] · [[Network device hardening]]

---
*Source: VIRGIL knowledge base*