---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 14
source: rewritten
---

# Windows Network Technologies
**Master file and resource sharing across networks using Windows shares and drive mapping.**

---

## Overview

Windows enables you to broadcast resources—files, folders, printers, and devices—across a network so remote computers can access them as if they were local. This capability is foundational to Windows networking and appears constantly on A+ exams because real IT work revolves around troubleshooting access, permissions, and connectivity issues. Understanding how shares work, how to map them, and how to hide them is essential for the 220-1202 exam.

---

## Key Concepts

### Windows Shares

**Analogy**: Think of a Windows share like opening a door in your house and inviting neighbors to use specific rooms. You control *which* rooms they can enter, *when* they can enter, and *what* they can do inside each room—but once you open that door, anyone on your street can potentially find it (unless you hide the door number).

**Definition**: A [[Windows Share]] is any resource—file, folder, printer, or device—that you intentionally expose to the network, making it accessible to other computers with appropriate credentials.

**Key Details**:
- Shares are the foundation of network file access in Windows environments
- Resources become available to remote machines via [[SMB]] ([[Server Message Block]]) protocol
- Shares can be temporary (created during a session) or persistent (created permanently)

---

### Drive Mapping

**Analogy**: Imagine your computer has a filing cabinet with drawers labeled A through Z. Drives C and D are your own drawers, but you can open remote drawers from someone else's cabinet and assign them letters too—so drawer X suddenly points to your coworker's folder across the building.

**Definition**: [[Drive Mapping]] assigns a local drive letter (X:, Y:, Z:, etc.) to a remote network share, making that distant resource appear as a native local drive.

**Why It Matters**:
- Applications can access mapped drives as if they're physically connected
- Users experience seamless access to network resources
- Legacy software often requires mapped drives to function properly

**Mapping Methods**:

| Method | Interface | Best For |
|--------|-----------|----------|
| [[File Explorer]] GUI | Point-and-click "Map Network Drive" | End-user simplicity |
| [[net use]] command | Command line / scripts | Automation, batch operations |
| [[Group Policy]] | Domain-wide deployment | Enterprise environments |

**Command Syntax**:
```batch
net use X: \\computername\sharename /persistent:yes
net use X: /delete
net use
```

---

### Hidden Shares

**Analogy**: A hidden share is like a speakeasy during Prohibition—the door doesn't have a visible sign, but if you know the address and knock correctly, you can still get in.

**Definition**: A [[Hidden Share]] is a network resource that doesn't appear in browse lists but remains fully accessible if you know its exact name and path. You create hidden shares by appending a dollar sign (`$`) to the share name.

**How It Works**:
- `admin$` = a hidden share named "admin" on the remote computer
- The dollar sign tells Windows: "Hide this from network discovery"
- **Critical**: This is *obfuscation*, NOT security—it doesn't prevent access if someone knows the name

**Common Hidden Shares on Windows**:

| Share Name | Purpose | Visibility |
|------------|---------|-----------|
| `C$`, `D$`, etc. | Root drive access | Hidden (admin-only by default) |
| `admin$` | System root folder | Hidden |
| `ipc$` | Inter-process communication | Hidden (system use) |
| `print$` | Printer drivers | Hidden |

**Example**:
```
\\192.168.1.100\documents     ← visible in browse lists
\\192.168.1.100\documents$    ← hidden, but accessible if you type the path
```

---

### Share Management & Discovery

**Analogy**: Think of [[Computer Management]] as a master control panel where you can see every door you've opened to your neighbors and exactly what each neighbor has access to.

**Definition**: [[Computer Management]] → **Shared Folders** is the administrative interface where you view, create, modify, and delete all configured shares on a local machine.

**Location**: 
```
Right-click "This PC" or "My Computer" → Manage 
→ Shared Folders → Shares
```

**What You'll See**:
- Share name and local path
- Current active connections
- Connected users
- Session details

**Related Tool - File Explorer Discovery**:
- File Explorer displays all **visible** shares on remote devices
- When you browse `\\computername`, you see only non-hidden shares
- Hidden shares won't appear in dropdown menus but can be manually typed in the address bar

---

## Exam Tips

### Question Type 1: Share Accessibility & Visibility

- *"You've created a share called `backup$`. Why doesn't it appear in the network browse list?"* → The dollar sign makes it hidden from discovery, but it's still accessible if the user types the full path `\\servername\backup$`.

- *"An administrator wants to prevent users from seeing a shared printer in network discovery. What should they do?"* → Rename the share to end with `$` (e.g., `printer$`).

**Trick**: Students confuse "hidden" with "inaccessible." A hidden share is still fully functional—it's just invisible in menus. The exam often tests this distinction.

---

### Question Type 2: Drive Mapping Commands

- *"You need to map drive Z: to `\\fileserver\archive` and ensure it persists after restart. What command do you use?"* → `net use Z: \\fileserver\archive /persistent:yes`

- *"A user's mapped drive keeps disconnecting at logoff. What flag should be added to the `net use` command?"* → `/persistent:yes`

**Trick**: Forgetting `/persistent:yes` is a common mistake—the default behavior is `/persistent:no`, meaning the mapping disappears when the user logs off.

---

### Question Type 3: Share Management Interface

- *"Where would you go to see all shares configured on a Windows 10 machine?"* → Computer Management → Shared Folders → Shares (or `fsmgmt.msc` from Run dialog).

- *"A technician needs to disconnect all active user sessions on a shared folder. Where is this done?"* → Computer Management → Shared Folders → Open Files or Sessions.

**Trick**: Confusing "Shares" (the list of configured shares) with "Open Files" (currently accessed files) costs points.

---

## Common Mistakes

### Mistake 1: Thinking Hidden Shares Are Secure

**Wrong**: "I'll hide my sensitive data share with a dollar sign, so it's protected."

**Right**: Hidden shares are purely cosmetic—they hide from browse listings but not from intentional connection attempts. Anyone who knows or guesses the name can access it (subject to [[NTFS Permissions]]).

**Impact on Exam**: You may see questions asking why hidden shares don't prevent unauthorized access. The answer is always: "Hidden shares provide obscurity, not security. Use [[NTFS Permissions]] for actual protection."

---

### Mistake 2: Confusing Share Names with File Paths

**Wrong**: Creating a share called `C:\Users\John\Documents` 

**Right**: The share *name* is what you type in the address bar (e.g., `data`). The *local path* is where it points (e.g., `C:\Users\John\Documents`). Remote users see only the share name.

**Impact on Exam**: Questions often test whether you understand that `\\computer\data` is a share name, not a file system path. Mixing these up tanks your answers.

---

### Mistake 3: Forgetting `/persistent:yes` on Mapped Drives

**Wrong**: Mapping a drive with `net use X: \\server\share` and assuming it stays mapped after logoff.

**Right**: Always include `/persistent:yes` if permanence is required; otherwise the mapping is temporary (session-only).

**Impact on Exam**: A question asking "The user logs off, and the mapped drive disappears. Why?" has a straightforward answer: missing `/persistent:yes`.

---

### Mistake 4: Not Understanding Dollar Sign Behavior

**Wrong**: "A share ending in `$` cannot be accessed remotely."

**Right**: A share ending in `$` *can* be accessed remotely if you know its name and have permission—it simply won't appear in network discovery lists.

**Impact on Exam**: You may see a scenario where a user can't find a share in "browse network" but *can* access it when typing the path manually. Recognizing the hidden share indicator (`$`) is the key.

---

## Related Topics

- [[NTFS Permissions]] — Control what users can *do* once they access a share
- [[SMB Protocol]] — The underlying network protocol for Windows shares
- [[Active Directory]] — Centralizes share management in enterprise environments
- [[UNC Paths]] — Universal Naming Convention (`\\computername\sharename`)
- [[Net Command]] — Command-line tools for share management
- [[File Explorer]] — GUI for browsing and mapping shares
- [[Group Policy]] — Enterprise deployment of persistent mappings

---

*Source: CompTIA A+ Core 2 (220-1202) | Windows Networking Essentials | [[A+]]*