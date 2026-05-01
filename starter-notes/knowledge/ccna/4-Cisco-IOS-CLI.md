---  
tags: [knowledge, ccna, chapter-4]  
created: 2026-04-30  
cert: CCNA  
chapter: 4  
source: rewritten  
---  

# 4. Cisco IOS CLI  
**[Everything you need to navigate, configure, and secure Cisco devices using the command‑line interface]**  

---  

## Terminal Access  

### Connecting via PuTTY  

**Analogy**: Think of PuTTY as a *remote telegraph*—you type messages in one place, and the device receives them as if you were physically beside it.  

**PuTTY**: A popular [[terminal emulator]] that lets you establish a serial or SSH session to a Cisco router or switch.  

**Steps to connect**  
```  
1. Choose Connection → Serial  
2. Set Speed: 9600 bps  
3. Set Data Bits: 8  
4. Set Stop Bits: 1  
5. Parity: None  
6. Flow Control: None  
```  

> *These settings match Cisco’s default console configuration.*

---  

## Modes of Operation  

### User EXEC Mode (Limited Access)  

**Analogy**: Imagine stepping into a *museum exhibit*—you can look around but cannot touch the artifacts.  

**User EXEC Mode** (`Router>`):  
- View‑only interface.  
- Basic diagnostic commands (e.g., `show ip interface brief`).  
- Use `?` to see available commands.  

### Privileged EXEC Mode (Advanced View)  

**Analogy**: Entering the *backstage area* of the museum—now you can see more, but still can’t alter exhibits.  

**Privileged EXEC Mode** (`Router#`):  
- Enter with `enable`.  
- Full command visibility.  
- Can read configuration, reboot, or save changes.  

### Global Configuration Mode (Full Control)  

**Analogy**: Having a *maintenance crew*—you can modify exhibits, change lighting, and install new displays.  

**Global Configuration Mode** (`Router# configure terminal` or `conf t`):  
- Edit interfaces, routing protocols, security settings, and more.  

---  

## Password Security  

### Plain‑Text Enable Password  

**Analogy**: Writing a password on a piece of paper and leaving it in plain view—everyone could read it.  

**enable password**:  
- Syntax: `enable password <password>`  
- Stored in clear text.  
- 3 consecutive failures lock you out.  

### MD5‑Encrypted Enable Secret  

**Analogy**: Locking the same paper inside a vault that requires a key (the hash) to open.  

**enable secret**:  
- Syntax: `enable secret <password>`  
- Uses MD5 hashing, making it far more secure than plain text.  

### Service Password‑Encryption  

**Analogy**: Shifting the plain paper to a *water‑marked* version—still readable, but less obvious.  

**service password-encryption**:  
- Encrypts all passwords except the enable secret.  
- Uses Type 7 (easy to crack) encryption.  
- Turning it off does not decrypt existing passwords.  

---  

## Configuration Management  

| File | Description | Command to View |
|------|-------------|-----------------|
| **Running‑config** | Active, in‑use configuration | `show running-config` |
| **Startup‑config** | Configuration loaded on reboot | `show startup-config` |

### Saving Configuration  

**Analogy**: Pressing *Ctrl‑S* to save your work before closing the application.  

```  
write  
write memory  
copy running-config startup-config  
```  

---  

## Editing and Cancelling Commands  

**Analogy**: Editing a text document—backspace, delete, or clear the line before hitting *Enter*.  

- `Backspace` / `Delete` – erase characters.  
- `Ctrl + U` – clear entire line.  
- `Ctrl + C` – abort the command before it runs.  
- `Ctrl + Z` – exit configuration mode to EXEC mode.  
- `no <command>` – undo a previous configuration.  
  - Example: `no service password-encryption` (prevents future encryption).  

---  

## Cisco Commands Cheat Sheet  

| Command | Purpose |
|---------|---------|
| **enable** | Enter privileged EXEC mode |
| **configure terminal / conf t** | Enter global configuration mode |
| **enable password \<pw\>** | Set a plain‑text password |
| **enable secret \<pw\>** | Set an MD5‑hashed password |
| **service password-encryption** | Encrypt stored passwords (except enable secret) |
| **no \<cmd\>** | Remove a configured command |
| **show running-config** | Display active configuration |
| **show startup-config** | Display saved configuration |
| **write / write memory** | Save running config to startup config |
| **copy running-config startup-config** | Alternate save method |
| **do \<cmd\>** | Execute a privileged command from global config mode |

---  

## Exam Tips  

### Question Type 1: Command Syntax  
- *"Which command will enable privileged EXEC mode?"* → **enable**  
- **Trick**: Candidates often confuse `enable` with `enable password`; the former is simply a mode switch.  

### Question Type 2: Security  
- *"What is the effect of turning off service password-encryption?"* → Passwords remain encrypted; they are not decrypted when disabled.  
- **Trick**: Some may think disabling it removes encryption, but it only stops further encryption of new passwords.  

---  

## Common Mistakes  

### Mistake 1: Confusing enable password and enable secret  

**Wrong**: Thinking both store passwords the same way and choosing the less secure one.  
**Right**: `enable secret` uses MD5 hashing, whereas `enable password` is plain text.  
**Impact on Exam**: May lead to selecting an insecure command in a security‑focused question, costing points.  

---  

## Related Topics  

- [[Routing Protocols]]  
- [[Interface Configuration]]  

---  

*Source: CCNA 200‑301 Study Notes | [[CCNA]]*