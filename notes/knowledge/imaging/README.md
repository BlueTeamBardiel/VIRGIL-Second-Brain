# OS Imaging & Deployment
> The help desk skill that proves you understand the machine, not just the ticket.

Imaging is how you go from a blank hard drive to a fully configured, domain-joined workstation in under an hour. Every help desk tech should be able to image a machine manually, understand enterprise deployment tools, and know what breaks after imaging and why.

---

## What Imaging Means in IT

**Manual imaging:** Clone one configured machine to another. Fast for small deployments, brittle at scale.

**Enterprise deployment:** A central server stores OS images and config. Technicians (or machines themselves, via PXE boot) pull and apply images over the network. 100 machines built identically, overnight, without anyone touching them.

**The build process:** Install OS → configure → install apps → join domain → test → **Sysprep** → capture image → deploy to other machines.

---

## Windows Imaging

### Manual: Rufus
The simplest tool for creating a bootable Windows USB.

1. Download Windows 11 ISO from Microsoft
2. Download [Rufus](https://rufus.ie)
3. Plug in USB (8GB+), select ISO in Rufus, click Start
4. Boot target machine from USB (F12/F11/Delete for boot menu)
5. Install Windows

**TPM bypass for older hardware (Windows 11):**
Rufus handles this. In Rufus, when prompted, check:
- "Remove requirement for TPM 2.0"
- "Remove requirement for Secure Boot"
- "Remove requirement for an Microsoft account"

Or manually: during Windows 11 install, press `Shift+F10` at the first screen → run `regedit` → navigate to `HKEY_LOCAL_MACHINE\SYSTEM\Setup` → create key `LabConfig` → add DWORD values `BypassTPMCheck=1`, `BypassSecureBootCheck=1`, `BypassRAMCheck=1`.

### WDS — Windows Deployment Services
Microsoft's built-in deployment server, included with Windows Server.

- Stores images on a server, deploys over the network via PXE
- Machines boot from PXE → find WDS server → select image → install
- Works for small/medium environments, no licensing cost beyond Windows Server
- Limitation: image management is clunky compared to MDT

### MDT — Microsoft Deployment Toolkit
Free tool from Microsoft that extends WDS with task sequences.

- **Task sequences:** ordered list of actions (partition disk, apply image, install drivers, join domain, install apps, configure settings)
- Handles driver injection better than bare WDS
- Can deploy via USB or PXE
- Integrates with WDS for network deployment

**Basic MDT workflow:**
1. Install MDT + Windows ADK
2. Create Deployment Share (folder where images and scripts live)
3. Import OS (from ISO or reference machine capture)
4. Add drivers to driver database
5. Create Task Sequence (defines build steps)
6. Generate Lite Touch ISO or PXE boot files
7. Boot target machine → runs task sequence automatically

### SCCM (Configuration Manager) / Intune
Enterprise-grade. SCCM is on-premises; Intune is cloud (Azure).

- Full hardware inventory, OS deployment, app deployment, patch management
- Overkill for small shops, standard at enterprise
- Intune is where everything is going — cloud-managed device enrollment via Autopilot
- If you're job hunting, Intune/Autopilot familiarity is increasingly valuable

**Windows Autopilot:** Pre-register device hardware IDs with Azure. Machine ships to end user, user logs in with company credentials, Intune enrolls the device and pushes all config automatically. Zero-touch deployment.

---

## Linux Imaging

### `dd` — disk clone
The Unix swiss army knife for disk operations. `dd` reads bytes in, writes bytes out.

```bash
# Clone entire disk to image file
dd if=/dev/sda of=/mnt/backup/disk.img bs=4M status=progress

# Restore image to disk
dd if=/mnt/backup/disk.img of=/dev/sdb bs=4M status=progress

# Clone disk-to-disk (source to target)
dd if=/dev/sda of=/dev/sdb bs=4M status=progress

# WARNING: dd is "disk destroyer" — wrong of= target destroys data with no confirmation
```

**Use `ddrescue` instead of `dd` for failing drives** — it retries bad sectors instead of aborting.

### Clonezilla
Free, bootable disk imaging tool. Better UI than raw dd, supports network deployment.

- Boot from Clonezilla USB
- Clone disk-to-disk, disk-to-image, or image-to-disk
- Supports network storage (NFS, SMB, SSH)
- Can multicast: send one image to 50 machines simultaneously via LAN

### netboot.xyz + PXE Boot
PXE (Preboot Execution Environment) lets machines boot from the network before any OS is installed.

**How it works:**
1. Machine powers on, no bootable media
2. NIC sends DHCP request
3. DHCP server responds with PXE options (TFTP server address, boot filename)
4. Machine downloads boot file via TFTP
5. Boot menu appears — pick your OS

**netboot.xyz** hosts a PXE menu with dozens of Linux distros, tools, and utilities. Point your DHCP option 66/67 to `boot.netboot.xyz` and every machine on your network gets a network boot option. Invaluable for lab environments.

### PXE Setup (simplified)
```bash
# On your DHCP server (or router), set:
# Option 66: next-server = IP of TFTP server
# Option 67: bootfile-name = pxelinux.0 (for syslinux) or bootx64.efi (UEFI)

# On TFTP server:
apt install tftpd-hpa
cp /path/to/pxelinux.0 /var/lib/tftpboot/
# Configure pxelinux.cfg/default with menu entries
```

---

## Cross-Platform: Balena Etcher
Simple, graphical tool for flashing ISOs to USB drives. Works on Windows, macOS, Linux.

Good for: Linux distros, Tails, Raspberry Pi images, any .img or .iso file.
Not good for: enterprise deployment, Windows imaging at scale (use Rufus for Windows).

---

## Step-by-Step: Image a Machine to Ubuntu 22.04

1. **Download Ubuntu 22.04 LTS ISO** from ubuntu.com
2. **Create USB** with Balena Etcher or `dd if=ubuntu.iso of=/dev/sdX bs=4M status=progress`
3. **Boot target machine** from USB (F12/Del for boot menu)
4. Select **"Try or Install Ubuntu"**
5. Choose **"Erase disk and install Ubuntu"** (or manual partition if needed)
6. Set username, password, hostname
7. Wait for install (~15-20 min)
8. Reboot, remove USB
9. **Post-install:**
   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install -y openssh-server curl git vim
   hostnamectl set-hostname NEWNAME
   # For AD join: sudo realm join corp.local -U domainadmin
   ```

---

## Step-by-Step: Image a Machine to Windows 11

1. Download **Windows 11 ISO** from Microsoft
2. Create USB with **Rufus** (enable TPM bypass if needed)
3. Boot from USB
4. At first screen: language/region → Install Now → accept license
5. **Custom install** → delete partitions → New → install
6. OOBE (out of box experience): region, keyboard, skip Microsoft account (create local account instead):
   - Press `Shift+F10` → type `OOBE\BYPASSNRO` → machine reboots → "I don't have internet"
7. Set local admin account
8. **Post-install:**
   - Install all Windows Updates
   - Install drivers (Device Manager → check for unknown devices)
   - Install [[Chocolatey]] or [[Winget]] for software deployment
   - Join domain: Settings → Accounts → Access work/school → Join domain → domain join

---

## Sysprep — Why You Generalize Before Cloning

If you clone a configured Windows machine without running Sysprep first, every cloned machine will have **the same SID (Security Identifier)**. In an Active Directory environment, duplicate SIDs cause authentication failures, group policy conflicts, and account confusion.

**Sysprep generalize** removes the machine-specific SID, resets Windows activation state, clears user profiles, and prepares the machine to receive a new identity on first boot.

```cmd
# Run on the reference machine before capturing the image
C:\Windows\System32\Sysprep\sysprep.exe /generalize /oobe /shutdown
```

- `/generalize` — strips SID and machine-specific info
- `/oobe` — sets machine to run Windows Welcome on next boot
- `/shutdown` — powers off after completion (image captures the shutdown state)

After Sysprep + image capture, every deployed copy gets a fresh SID on first boot.

---

## Driver Management — What Breaks After Imaging

**What breaks:** Display drivers (generic VGA), network adapters (no internet), audio, specialized hardware (fingerprint readers, smartcard readers).

**Why:** Images typically contain drivers for the reference hardware. If you deploy to different hardware, drivers may not match.

**Fixes:**
- **MDT driver database:** Inject hardware-specific drivers during task sequence, matched by PnP hardware ID
- **Windows Update:** First-boot Windows Update pulls most drivers automatically if internet is available
- **Device Manager:** Run `devmgmt.msc` after imaging — unknown devices (yellow !) need driver injection
- **Driver packages:** Download driver packs from Dell/HP/Lenovo and inject into MDT
- **DISM:** `dism /image:C:\Mount /add-driver /driver:C:\Drivers\ /recurse` — inject drivers into offline image

**Pro tip:** Stick to one hardware model per image where possible. Mixed hardware = driver hell.

---

## Tags
`[[Windows]]` `[[Linux]]` `[[Help Desk]]` `[[Active Directory]]` `[[Automation]]` `[[Sysprep]]` `[[PXE]]`