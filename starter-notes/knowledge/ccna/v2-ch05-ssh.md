# Secure Shell
**Why this matters:** SSH is the industry standard for secure remote device management—it's your primary tool for accessing network devices across the internet and is heavily tested on the CCNA exam.

## Overview
[[Secure Shell (SSH)]] solves the fundamental problem of remote device access. Imagine trying to manage a router on the opposite side of the world—you can't physically walk to its console port. SSH lets you access the CLI over an IP network (like the internet) with encrypted traffic, whereas older protocols like [[Telnet]] send everything in plaintext. This chapter covers the security foundation you need: console port protection, user authentication, and secure remote access.

## 5.1 Console Port Security

### The Problem
Anyone with a console cable can access your device's CLI if they reach it physically. Even with physical security (locked cabinets), you need a second layer: logical access control on the **console line** itself.

### What is a Line?
A **line** is a logical pathway on a Cisco device for CLI access. Think of it as a "door" to the device:
- **Console line (line con 0)**: Physical console port access. Only ONE user can connect at once.
- **VTY lines (line vty 0-15)**: Virtual lines for remote access via [[SSH]] or [[Telnet]]. Typically 16 lines, so 16 simultaneous users.

```
Switch(config)# line con 0
Switch(config-line)#
```
The 0 indicates the first (and only) console line.

### 5.1.1 Line Password Authentication

**Simple approach:** Protect the console line with a single password.

```
SW1(config)# line con 0
SW1(config-line)# password cisco
SW1(config-line)# login
```

| Command | Purpose |
|---------|---------|
| `line con 0` | Enter console line configuration mode |
| `password <password>` | Set the line password |
| `login` | **Required:** Enable password authentication on this line |
| `exec-timeout <minutes>` | Idle timeout before logout (default: 10 minutes) |

**How it works:**
1. User connects via console cable
2. Gets prompt: "User Access Verification"
3. Enters password (not displayed on screen)
4. Enters User EXEC mode (`SW1>`)
5. Issues `enable` to reach Privileged EXEC mode (`SW1#`)

**Weakness:** One password for everyone—no accountability, no per-user auditing.

### 5.1.2 User Account Authentication

**Better approach:** Create individual user accounts with passwords.

```
SW1(config)# username jeremy secret ccna
SW1(config)# line con 0
SW1(config-line)# login local
```

| Command | Purpose |
|---------|---------|
| `username <name> secret <password>` | Create local user account (password hashed) |
| `username <name> password <password>` | ⚠️ **Avoid:** Password stored in cleartext |
| `login local` | **Required:** Force authentication against local user database |

**How it works:**
1. User connects via console
2. Prompted for username AND password
3. Device checks against local user database
4. On successful match → User EXEC mode

**⚠️ CRITICAL EXAM TRAP:**
- `login` and `login local` **cannot coexist**
- If you configure one, it overwrites the other
- `login` = line password required
- `login local` = user account required (line password is ignored)

**Why user accounts are better:**
- Per-user audit trail (who logged in, when)
- Ability to disable individual accounts
- Foundation for AAA ([[Authentication, Authorization, and Accounting]])
- Granular privilege control (see sidebar below)

### Cisco IOS Privilege Levels

Privilege levels control command access (0-15 scale):

| Level | Mode | Default Behavior | Access |
|-------|------|------------------|--------|
| 1 | User EXEC | Default for console/VTY login | Read-only commands |
| 15 | Privileged EXEC | After `enable` command | Full device control |
| 0-14 | Custom | Not used by default | Precise command restrictions |

**Setting user privilege level at login:**
```
SW1(config)# username jeremy privilege 15 secret ccna
```
User jeremy enters Privileged EXEC mode immediately—no `enable` needed.

---

## 5.2 Telnet: The Insecure Remote Access Protocol

### What is Telnet?
[[Telnet]] is the predecessor to SSH. It provides remote CLI access but **sends all traffic in plaintext**, including usernames and passwords. On the CCNA, you should understand it for comparison—but never use it in production.

### VTY Lines for Remote Access
Virtual Terminal (VTY) lines handle Telnet and SSH connections:

```
SW1(config)# line vty 0 15
SW1(config-line)# password cisco123
SW1(config-line)# login
```

| VTY Configuration | Purpose |
|-------------------|---------|
| `line vty 0 15` | Configure all 16 VTY lines at once |
| `line vty 0` | Configure only line 0 |
| `password <password>` | Set line password for Telnet/SSH |
| `login` | Enable password authentication |
| `login local` | Enable user account authentication |

**Telnet Connection Example:**
```bash
PC1> telnet 192.168.1.1
Trying 192.168.1.1...
Connected to 192.168.1.1
SW1>
```

### Why Telnet is a Problem
- **No encryption**: Packet sniffing reveals passwords
- **No authentication verification**: No way to verify you're actually connecting to your device
- **Deprecated**: Not acceptable for production use

**CCNA Exam Reality:** You'll see Telnet in configuration exercises to show you *how to set it up*, but the exam expects you to recognize its vulnerabilities and prefer SSH.

---

## 5.3 Secure Shell (SSH): Encrypted Remote Access

### What is SSH?
[[SSH]] encrypts the entire connection, including login credentials. It uses **public-key cryptography** to authenticate the server and establish a secure tunnel.

**Simple analogy:** Telnet is like sending a postcard through the mail (anyone can read it). SSH is like putting that postcard in a locked safe—encrypted, authenticated, private.

### Why SSH Matters
- **Encryption**: All traffic is encrypted (even if intercepted, unusable)
- **Server authentication**: Client verifies it's connecting to the real device
- **No plaintext credentials**: Passwords protected by encryption
- **Industry standard**: Required for all production networks
- **CCNA-tested**: You must be able to configure SSH

### SSH Architecture: Keys and Versions

**SSH uses two cryptographic keys:**
1. **Server's RSA key pair**: Unique to each device; proves the device is authentic
2. **Session encryption keys**: Generated fresh for each connection

**SSH Versions:**

| Version | Status | Security | CCNA Relevance |
|---------|--------|----------|-----------------|
| SSH v1 | Deprecated | Weak | Know why it's obsolete |
| SSH v2 | Current standard | Strong | **Configure this** |

```
SW1(config)# ip ssh version 2
```

### SSH Configuration Step-by-Step

**Step 1: Generate RSA Keys (One-time setup)**
```
SW1(config)# crypto key generate rsa
The name for the keys will be: SW1.example.com
How many bits in the modulus [512]: 1024
```

The device generates a unique key pair. Larger modulus = stronger security (1024+ bits minimum; 2048 recommended).

| Parameter | Purpose |
|-----------|---------|
| Modulus size | Determines RSA key strength (bits) |
| Key name | Derived from hostname and domain name |

**Step 2: Configure Username and Password**
```
SW1(config)# username jeremy secret ccna
```
User accounts are required for SSH (unlike Telnet, which could use just a line password).

**Step 3: Configure VTY Lines for SSH**
```
SW1(config)# line vty 0 15
SW1(config-line)# login local
SW1(config-line)# transport input ssh
```

| Command | Purpose |
|---------|---------|
| `login local` | Require user account authentication |
| `transport input ssh` | **Accept only SSH** (blocks Telnet) |
| `transport input telnet ssh` | Allow both (not recommended) |
| `transport input none` | Block all remote access |

**Step 4: Verify SSH is Working**
```
SW1(config)# exit
SW1# show crypto key mypubkey rsa
```

**Complete SSH Configuration Example:**
```
SW1(config)# crypto key generate rsa
SW1(config)# ip ssh version 2
SW1(config)# username jeremy secret ccna
SW1(config)# line vty 0 15
SW1(config-line)# login local
SW1(config-line)# transport input ssh
SW1(config-line)# exit
SW1(config)# exit
SW1# show crypto key mypubkey rsa
```

### SSH Connection Process (From a Client)

**From Linux/Mac:**
```bash
ssh -l jeremy 192.168.1.1
# or
ssh jeremy@192.168.1.1
```

**What happens behind the scenes:**
1. Client connects to device on **port 22** (SSH default)
2. Device sends its public key
3. Client verifies the key (or accepts it on first connection)
4. Both establish encrypted session
5. Client prompted for username and password
6. Credentials verified against local user database
7. User enters CLI in Privileged or User EXEC mode (depending on privilege level)

---

## Lab Relevance

### Console Port Security Commands
```
Switch(config)# line con 0
Switch(config-line)# password <password>
Switch(config-line)# login
Switch(config-line)# exec-timeout 5                 ! 5-minute idle timeout
Switch(config-line)# exit

Switch(config)# username <name> secret <password>
Switch(config)# line con 0
Switch(config-line)# login local
```

### VTY Line Configuration (Telnet & SSH)
```
Switch(config)# line vty 0 15
Switch(config-line)# password <password>
Switch(config-line)# login                          ! For line password auth
Switch(config-line)# login local                    ! For user account auth
Switch(config-line)# transport input telnet ssh     ! Allow both protocols
Switch(config-line)# transport input ssh            ! SSH only (recommended)
```

### SSH Configuration Commands
```
Switch(config)# crypto key generate rsa
                 ! Follow prompts: accept hostname or enter domain name
                 ! Enter modulus size (1024, 2048, etc.)

Switch(config)# ip ssh version 2
Switch(config)# username <name> secret <password>
Switch(config)# line vty 0 15
Switch(config-line)# login local
Switch(config-line)# transport input ssh
Switch(config-line)# exit

! Verification commands:
Switch# show crypto key mypubkey rsa               ! Display public key
Switch# show ip ssh                                ! SSH status and version
Switch# show users                                 ! Connected users
```

### Common Lab Scenario
You need to set up secure console access AND remote SSH access:
```
Switch(config)# username admin secret P@ssw0rd123
Switch(config)# line con 0
Switch(config-line)# login local
Switch(config-line)# exit

Switch(config)# crypto key generate rsa
Switch(config)# ip ssh version 2
Switch(config)# line vty 0 15
Switch(config-line)# login local
Switch(config-line)# transport input ssh
```

---

## Exam Tips

### What the CCNA Specifically Tests on SSH

**1. Configuration Sequence (Very Common)**
- **Question type:** "What commands would you use to enable SSH?"
- **Tricky part:** Students forget RSA key generation (Step 1)
- **Exam expectation:** Know the exact order:
  1. `crypto key generate rsa`
  2. `username` creation

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 5 | [[CCNA]]*
