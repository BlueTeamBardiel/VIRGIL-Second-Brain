# TFTP & FTP: File Transfer Protocols for Network Device Management

**Why this matters:** You cannot upgrade Cisco devices, back up configurations, or recover from disasters without mastering TFTP and FTP. These are foundational protocols for IOS image management and appear frequently on the CCNA exam.

---

## Overview: Two Protocols, Two Different Approaches

Think of TFTP like a postal worker who only carries letters—simple, fast, but limited. FTP is like a full logistics company—complex, but handles everything. Both solve the same problem (moving files), but make different trade-offs between simplicity and features.

| Feature | [[FTP]] | [[FTP]] |
|---------|------|-----|
| **Complexity** | Minimal | Full-featured |
| **Connection Model** | Connectionless (UDP) | Connection-oriented (TCP) |
| **Port Number** | 69 | 20-21 (data/control) |
| **Authentication** | None | Username/password |
| **Reliability** | Basic retransmission | Full TCP reliability |
| **Error Handling** | Simple timeout/retry | Extensive error reporting |
| **File Permissions** | No support | Directory/file-level control |
| **Use Case** | Quick boot transfers | Full file system access |

---

## ## TFTP: Trivial File Transfer Protocol

### What TFTP Is and Why It's "Trivial"

TFTP operates over [[UDP]] port 69, making it stateless and lightweight. The word "trivial" means it lacks the overhead of [[FTP]]—no authentication, no directory listing, no file permissions. A Cisco router needs only 4 KB of RAM to run a TFTP client, critical when devices boot from ROM code with minimal memory.

**Core concept:** Client sends a read or write request → server responds with file data in 512-byte blocks → client acknowledges each block → repeat until done.

### How TFTP Works: The Block Exchange

1. **RRQ (Read Request)** or **WRQ (Write Request)**: Client initiates transfer, specifying filename and mode (netascii or octet/binary)
2. **DATA blocks**: Server transmits file in sequential 512-byte chunks, each with a block number (1, 2, 3...)
3. **ACK (Acknowledgment)**: Client confirms receipt of each block by sending its block number
4. **Timeout & Retry**: If no ACK received within ~5 seconds, server retransmits that block
5. **Final block**: When a DATA block < 512 bytes arrives, transfer is complete

**Example sequence:**
- Client → Server: `RRQ filename.bin octet`
- Server → Client: `DATA block 1 [512 bytes]`
- Client → Server: `ACK block 1`
- Server → Client: `DATA block 2 [512 bytes]`
- Client → Server: `ACK block 2`
- ... (continues until final block < 512 bytes)

### TFTP File Transfer Process on Cisco IOS

The standard workflow for downloading an IOS image from a TFTP server:

```
Router# copy tftp: flash:
Address or name of remote host []? 192.168.1.100
Source filename []? c2900-universalk9-mz.16.12.04.SPA.bin
Destination filename [c2900-universalk9-mz.16.12.04.SPA.bin]? 
Accessing tftp://192.168.1.100/c2900-universalk9-mz.16.12.04.SPA.bin...
Loading c2900-universalk9-mz.16.12.04.SPA.bin from 192.168.1.100 (via GigabitEthernet0/0): !!!!!!!!!!
[OK - 536870912 bytes]
```

**Uploading configuration to TFTP server:**

```
Router# copy running-config tftp:
Address or name of remote host []? 192.168.1.100
Destination filename [router-confg]? router-backup.cfg
```

### Key TFTP Limitations

- **No authentication:** Anyone with network access can read/write any file
- **No directory listing:** You must know exact filename
- **512-byte block size:** Not optimized for modern networks; causes more overhead than necessary
- **Stateless:** Server doesn't maintain session state, making it less robust for large transfers
- **No file system access:** Cannot change directories or permissions

---

## ## FTP: File Transfer Protocol

### What FTP Is and Why It Exists

FTP uses [[TCP]] ports 20 (data) and 21 (control), establishing a full connection-oriented relationship. It supports user authentication, directory navigation, and file manipulation commands. FTP is ideal when you need granular control and security.

**Core concept:** Two TCP connections run simultaneously—one for commands (port 21), one for file data (port 20). The control channel stays open throughout the session, while the data channel opens/closes for each file transfer.

### FTP Connection Model: Control + Data Channels

```
CLIENT                           SERVER
  |                               |
  |-------- TCP 21 (Control) ----->|
  |<------- TCP 21 (Control) ------|
  | (USER, PASS, LIST, RETR, STOR) |
  |                               |
  |-------- TCP 20 (Data) -------->|  (when transferring)
  |<------- TCP 20 (Data) ---------|  (when transferring)
  |                               |
```

**Passive mode vs. Active mode:**
- **Active FTP:** Client sends PORT command → server initiates data connection back to client. Problematic with firewalls blocking inbound connections.
- **Passive FTP:** Client sends PASV command → server opens listening port → client initiates data connection. Modern default; works through NAT.

### FTP Commands and Operations

| Command | Purpose | Example |
|---------|---------|---------|
| `USER` | Authenticate with username | `USER admin` |
| `PASS` | Send password | `PASS cisco123` |
| `LIST` | List directory contents | `LIST /` |
| `RETR` | Download (retrieve) file | `RETR ios-image.bin` |
| `STOR` | Upload (store) file | `STOR backup-config.txt` |
| `CWD` | Change working directory | `CWD /backup` |
| `DELE` | Delete file | `DELE old-image.bin` |
| `RMD` | Remove directory | `RMD /temp` |
| `QUIT` | End session | `QUIT` |

### FTP File Transfer Process on Cisco IOS

**Downloading from FTP server:**

```
Router# copy ftp: flash:
Address or name of remote host []? 192.168.1.50
User ID []? admin
Password: ••••••••
Source filename []? c3850-universalk9.17.06.03.SPA.bin
Destination filename [c3850-universalk9.17.06.03.SPA.bin]? 
Accessing ftp://admin@192.168.1.50/c3850-universalk9.17.06.03.SPA.bin...
Loading c3850-universalk9.17.06.03.SPA.bin from 192.168.1.50 (via GigabitEthernet0/0): !!!!!!!!!
[OK - 587202560 bytes]
```

**Uploading configuration via FTP:**

```
Router# copy running-config ftp:
Address or name of remote host []? 192.168.1.50
User ID []? backup_user
Password: ••••••••
Destination filename [router-confg]? router-prod-backup.cfg
```

### FTP Advantages Over TFTP

- **Authentication:** Username and password protect access
- **Directory operations:** Navigate, create, delete directories
- **File management:** Rename, delete, view permissions
- **Reliability:** TCP guarantees ordered, complete delivery
- **Detailed responses:** Server sends status codes and messages
- **Better for humans:** Interactive session feels like command-line access

---

## ## Upgrading Cisco IOS Images

### The Complete IOS Upgrade Workflow

Upgrading an IOS image is the most common use case for TFTP/FTP knowledge on the CCNA exam. Here's the full process:

**Step 1: Verify current IOS and available flash space**

```
Router# show version | include System image file
System image file is "flash:c2900-universalk9-mz.16.09.01.SPA.bin"

Router# show flash:
Directory of flash:/

    1  -rw-   536870912   Jun 10 2021 12:45:52 +00:00  c2900-universalk9-mz.16.09.01.SPA.bin
    2  drw-        4096   Oct 15 2022 14:22:10 +00:00  .installer

24000000000 bytes total (23456000000 bytes free)
```

**Step 2: Download new IOS image via TFTP or FTP**

```
! Using TFTP (fastest, simplest)
Router# copy tftp: flash:
Address or name of remote host []? 10.1.1.1
Source filename []? c2900-universalk9-mz.16.12.04.SPA.bin
Destination filename [c2900-universalk9-mz.16.12.04.SPA.bin]? [press Enter]
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
[OK - 536870912 bytes]

! OR using FTP with authentication
Router# copy ftp: flash:
Address or name of remote host []? ftp.internal.com
User ID []? netadmin
Password: [hidden]
Source filename []? images/c2900-universalk9-mz.16.12.04.SPA.bin
Destination filename [c2900-universalk9-mz.16.12.04.SPA.bin]? [press Enter]
```

**Step 3: Verify image integrity (optional but recommended)**

```
Router# verify /md5 flash:c2900-universalk9-mz.16.12.04.SPA.bin
Verifying digest... OK
```

**Step 4: Configure boot image and reload**

```
Router# configure terminal
Router(config)# boot system flash:c2900-universalk9-mz.16.12.04.SPA.bin
Router(config)# exit
Router# copy running-config startup-config
Destination filename [startup-config]? [press Enter]

! Now reload the device
Router# reload
System configuration has been modified. Save? [yes/no]: yes
Proceed with reload? [confirm] yes
```

**Step 5: Verify new IOS version after reload**

```
Router# show version | include System image file
System image file is "flash:c2900-universalk9-mz.16.12.04.SPA.bin"
Cisco IOS XE Software, Version 16.12.04
```

### TFTP Server Setup (Practical Lab Consideration)

A typical lab TFTP server runs on a PC or Linux box:
- **Windows:** Tftpd32, 3CDaemon, or similar
- **Linux:** `sudo apt install tftpd-hpa` then configure `/etc/default/tftpd-hpa`
- **Default directory:** Server serves files from `/tftpboot/` or `C:\tftpboot\`

Ensure the router can reach the server IP and the firewall allows UDP port 69.

---

## ## Lab Relevance: Exact Cisco IOS Commands

### TFTP Operations

```
! Copy file from TFTP server to flash (interactive)
copy tftp: flash:

! Copy file from flash to TFTP server (interactive)
copy flash: tftp:

! One-liner TFTP download (non-interactive)
copy tftp://10.1.1.1/filename.bin flash:filename.bin

! Verify TFTP server reachability
ping 10.1.1.1
```

### FTP Operations

```
! Copy from FTP server (interactive, prompts for credentials)
copy ftp: flash:

! Copy to FTP server
copy flash: ftp:

! One-liner FTP download (embedded credentials - security risk)

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 8 | [[CCNA]]*
