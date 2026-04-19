# The Cisco IOS CLI
**Tagline:** Master hands-on device configuration—this chapter bridges networking theory to practical CLI skills required for both the exam and real-world engineering.

---

## Overview

This chapter shifts from theoretical networking concepts to practical device configuration. The [[CCNA]] exam requires not just theoretical understanding ("explain," "describe") but also hands-on configuration ability ("configure and verify"). You cannot pass the CCNA without competence in the [[Cisco IOS]] CLI—it's the gateway to configuring every protocol you'll study.

**Core Learning Objectives:**
- Access [[Cisco IOS]] CLI via console connection
- Navigate the [[IOS command hierarchy]]
- Understand IOS modes and their purposes
- Configure and verify device access control
- Save configuration changes properly

---

## Section 1: Shells and Interfaces

### Simple Explanation: What is a Shell?

A **shell** is the translator between you and the device. Think of it like a restaurant server: you (the user) give orders (commands), and the server communicates them to the kitchen (the device). The shell is that server. There are two types: graphical (point-and-click) and text-based (type commands).

### GUI vs CLI: A Comparison

| Aspect | [[GUI]] | [[CLI]] |
|--------|---------|---------|
| **Interface Type** | Visual, graphical elements (windows, buttons, menus) | Text-based, command-driven |
| **Learning Curve** | Intuitive for beginners; discoverable through exploration | Steeper initially; requires command memorization |
| **Speed** | Slower for power users; requires clicking multiple menus | Faster for experienced users; direct command entry |
| **Flexibility** | Limited to pre-built options | Highly flexible; supports advanced scripting |
| **CCNA Relevance** | Wireless LAN Controller (WLC) only | Primary focus: Routers, Switches, IOS devices |
| **Example** | Windows Start Menu, Cisco WLC web interface | Windows Command Prompt, Cisco IOS SSH session |

**Why CLI for CCNA?** Cisco chose the CLI as the standard because it enables precise control, automation, and scales to enterprise environments with hundreds of devices.

---

## Section 2: Accessing the Cisco IOS CLI

### Two Connection Methods

| Method | Protocol/Medium | Range | Use Case |
|--------|-----------------|-------|----------|
| **Console Connection** | Physical console cable | Local only (typically <10 feet) | Initial device setup, out-of-band access |
| **Network Connection** | [[Telnet]] or [[SSH]] | Network-wide | Remote management, production environments |

### Console Port Hardware

**Physical Ports (Device-Dependent):**
- **USB Mini-B**: Modern devices; simplest connection (standard USB cable)
- **RJ45**: Legacy devices; requires specialized [[rollover cable]]

**Important Constraint:** Only ONE console connection allowed at a time per device. The console port is **out-of-band**—it cannot transmit data over the network infrastructure.

### Rollover Cable Wiring Pattern

The [[rollover cable]] (also called a "null modem cable") reverses pin order:

```
Pin Mapping: 1↔8, 2↔7, 3↔6, 4↔5
Reverse order on opposite end.
```

**Visual Reference:**
```
End A:  1 2 3 4 5 6 7 8    |    End B:  8 7 6 5 4 3 2 1
```

This is distinct from [[straight-through cables]] (used for network connections) and [[crossover cables]] (used for device-to-device connections).

### Terminal Emulator Configuration

To access the CLI, you need a **terminal emulator** (software that mimics a hardware terminal). Popular options:
- **PuTTY** (free, Windows/Linux/Mac)
- **SecureCRT**
- **Cisco Packet Tracer** (recommended for CCNA study)

**Critical Serial Port Settings:**

| Setting | CCNA Standard Value | Purpose |
|---------|-------------------|---------|
| **Speed (Baud Rate)** | 9600 bps | Data transmission speed |
| **Data Bits** | 8 | Bits per character |
| **Stop Bits** | 1 | Frame delimiter |
| **Parity** | None | Error detection (not needed at 9600 bps) |
| **Flow Control** | None | Buffer management |

**Syntax Example (PuTTY):**
```
Connection Type: Serial
Serial line: COM3 (Windows) or /dev/ttyUSB0 (Linux)
Speed: 9600
Data bits: 8
Stop bits: 1
Parity: None
Flow control: None
Click: Open
```

---

## Section 3: The IOS Command Hierarchy

### Understanding Modes: A Hierarchy Analogy

The [[Cisco IOS]] organizes commands into **modes**—different security levels with different command sets. Think of it like a building:
- **User Exec Mode** = Lobby (view-only, limited access)
- **Privileged Exec Mode** = Manager office (full control)
- **Global Configuration Mode** = Engineering department (change network-wide settings)
- **Interface Configuration Mode** = Specific workstation (change one interface)

Each mode is nested; you must pass through security gates (passwords) to advance upward.

### The Five Primary Modes

| Mode | Prompt | Purpose | Access Method |
|------|--------|---------|---|
| **User EXEC** | `Router>` | View basic device info; ping, traceroute | Default upon login |
| **Privileged EXEC** | `Router#` | Advanced viewing, reload, copy files | `enable` command |
| **Global Config** | `Router(config)#` | Edit running configuration | `configure terminal` (or `config t`) |
| **Interface Config** | `Router(config-if)#` | Configure specific interface | `interface [type] [number]` |
| **Line Config** | `Router(config-line)#` | Configure console/vty lines | `line console 0`, `line vty 0 4` |

### Mode Navigation Flowchart

```
         User EXEC (Router>)
              ↓
         [enable] ← Password required
              ↓
      Privileged EXEC (Router#)
              ↓
    [configure terminal]
              ↓
    Global Config (Router(config)#)
              ↓
    [interface FastEthernet0/0]
              ↓
    Interface Config (Router(config-if)#)
```

### Exiting Modes

| Command | Effect | Works In |
|---------|--------|----------|
| `exit` | Move up one level | Any mode except User EXEC |
| `end` or `Ctrl+Z` | Jump directly to Privileged EXEC | Any configuration mode |
| `quit` | Logout completely | User EXEC, Privileged EXEC |

---

## Lab Relevance: Essential IOS Commands

### Mode Navigation Commands

```bash
# Enter Privileged EXEC (requires enable password)
Router> enable
Password: [enter enable password]
Router#

# Enter Global Configuration Mode
Router# configure terminal
Router(config)#

# Navigate to interface configuration
Router(config)# interface FastEthernet0/0
Router(config-if)#
Router(config-if)# interface GigabitEthernet0/1
Router(config-if)#

# Navigate to line configuration (console)
Router(config)# line console 0
Router(config-line)#

# Navigate to line configuration (virtual terminal)
Router(config)# line vty 0 4
Router(config-line)#

# Exit configuration and return to Privileged EXEC
Router(config-if)# end
Router#

# Exit down one mode
Router(config)# exit
Router>
```

### Password Configuration Commands

```bash
# Set enable password (unencrypted - avoid in production)
Router(config)# enable password [password]

# Set enable secret (encrypted - CCNA standard)
Router(config)# enable secret [password]

# Set console port password
Router(config)# line console 0
Router(config-line)# password [password]
Router(config-line)# login

# Set VTY (telnet/SSH) password
Router(config)# line vty 0 4
Router(config-line)# password [password]
Router(config-line)# login

# Exit line configuration
Router(config-line)# end
Router#
```

### Viewing Configuration Commands

```bash
# View running configuration (in memory)
Router# show running-config

# View startup configuration (NVRAM)
Router# show startup-config

# View abbreviated output of running config
Router# show running-config | include [keyword]

# View device information
Router# show version

# View current mode and interfaces
Router# show interfaces

# View routing table
Router# show ip route
```

### Saving Configuration Commands

```bash
# Copy running config to startup config
Router# copy running-config startup-config
Destination filename [startup-config]? [press Enter]
1234 bytes copied

# Save using legacy syntax
Router# write memory

# Erase startup configuration (factory reset)
Router# erase startup-config
Erasing the nvram filesystem will remove all files! Continue? [confirm]
[OK]
Router# reload

# Copy configuration to TFTP server for backup
Router# copy running-config tftp://192.168.1.1/backup.cfg
```

### Command Shortcuts and Helpers

```bash
# Autocomplete: Press Tab
Router(config)# int[TAB]    → auto-completes to "interface"

# Command history: Up/Down arrows
Router# [Up Arrow] → shows previous command

# Partial command history search: Ctrl+R
Router# [Ctrl+R]re → searches for commands starting with "re"

# Help: ? character
Router# ?                 → lists all commands available in mode
Router# show ?            → lists all options for "show" command
Router# show running-config ?  → shows parameters for this command

# Abbreviated commands
Router# show run           → equivalent to "show running-config"
Router# conf t             → equivalent to "configure terminal"
Router# int f0/0           → equivalent to "interface FastEthernet0/0"
Router# no shutdown        → enables interface (inverse of "shutdown")

# Disable a feature with "no"
Router(config)# no enable password  → removes enable password
Router(config-if)# no ip address    → removes IP address
```

---

## Section 4: Configuration Files and Storage

### Where IOS Configurations Live

| Location | Name | When Used | Persistence |
|----------|------|-----------|-------------|
| **RAM** | Running-config | Currently active; all changes made here | Lost on reboot |
| **NVRAM** | Startup-config | Loaded at boot; fallback if corruption | Survives reboot |
| **Flash Memory** | IOS image file (e.g., `c2900-universalk9-mz.169-3.SPA.bin`) | Bootloader loads this | Survives reboot |

### The Configuration Workflow

```
Startup-config (NVRAM) 
       ↓ [Device boots]
Running-config (RAM) ← You edit here
       ↓ [Your commands live here temporarily]
[Device reloads or loses power]
       ↓
    DATA LOST (if you didn't save!)
```

**Critical Concept:** Changes made in the CLI are stored in **running-config** only. To make changes persistent across reboots, you must **copy running-config to startup-config**.

### Configuration Save Workflow

```bash
Router# configure terminal
Router(config)# enable secret MySecretPassword
Router(config)# exit
Router#

# Changes are now in running-config but NOT in startup-config
# Device reboot = changes lost

# Save configuration
Router# copy running-config startup-config

# Now on reboot, the device will load these settings from startup-config
Router# reload
```

---

## Section 5: Password Protection and Access Control

### Password Hierarchy and Encryption

The [[enable secret]] command uses MD5 encryption; [[enable password]] does not. Always use [[enable secret]] in production.

```bash
# Weak (unencrypted) - avoid for exams and production
Router(config)# enable password cisco

# Strong (encrypted with MD5) - CCNA standard
Router(

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 5 | [[CCNA]]*
