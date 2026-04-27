# Linux Commands for IT & Security
> If you can't navigate a Linux shell comfortably, half the security field is locked to you.

Linux runs the internet. Web servers, cloud infrastructure, Docker containers, firewalls, network appliances — mostly Linux. Every SOC analyst, pentester, and sysadmin needs a working command-line vocabulary. This note covers the ~30 commands that get you through 90% of real scenarios, including what they look like in attack contexts.

---

## File System Navigation

### `ls` — list directory contents
```bash
ls -la              # long format, show hidden files
ls -lh              # human-readable sizes
ls -lt              # sort by modification time (newest first)
ls -ltr             # sort by time, oldest first (good for log review)
```
**Security:** `ls -la /tmp` — attackers stage tools in /tmp. Look for executables or odd filenames.

### `cd` / `pwd`
```bash
cd /var/log         # absolute path
cd ~                # home directory
cd -                # previous directory
pwd                 # print current path
```

### `find` — recursive file search
```bash
find /var/log -name "*.log" -mtime -1    # logs modified in last 24h
find / -perm -4000 -type f 2>/dev/null   # SUID binaries (privilege escalation targets)
find /home -name "*.ssh" -type d         # SSH directories across all users
find / -user root -writable 2>/dev/null  # root-owned writable files
find /tmp /var/tmp -executable -type f   # executables in temp dirs (red flag)
```
**Security angle:** `find / -perm -4000` is one of the first commands a pentester runs after getting a shell. SUID files run as their owner regardless of who executes them — a misconfigured SUID binary = instant root. Know what's normal on your system.

---

## Text Search & Processing

### `grep` — search file contents
```bash
grep -r "password" /etc/          # recursive search
grep -i "failed" /var/log/auth.log  # case-insensitive
grep -n "error" app.log            # show line numbers
grep -v "DEBUG" app.log            # invert — exclude DEBUG lines
grep -E "192\.168\.[0-9]+\.[0-9]+" access.log  # regex: find IP addresses
grep -A 3 -B 3 "segfault" /var/log/syslog  # 3 lines context around match
```
**Security:** `grep -r "FAILED\|Invalid\|authentication" /var/log/auth.log` — fast manual brute-force check.

### `awk` — column extraction
```bash
awk '{print $1}' /var/log/apache2/access.log   # extract first column (IP)
awk -F: '{print $1}' /etc/passwd               # extract usernames (: delimiter)
awk '{sum += $NF} END {print sum}' file         # sum last column
# Count unique IPs hitting web server:
awk '{print $1}' /var/log/apache2/access.log | sort | uniq -c | sort -rn | head 20
```

### `sed` — stream editor (find/replace)
```bash
sed 's/old/new/g' file.txt           # replace all occurrences, print
sed -i 's/old/new/g' file.txt        # edit in place
sed -n '10,20p' file.txt             # print lines 10-20
sed '/^#/d' config.conf              # delete comment lines
```

---

## Process & System Monitoring

### `ps` — snapshot of running processes
```bash
ps aux                     # all processes, all users, extra info
ps aux | grep nginx        # find nginx processes
ps -eo pid,user,cmd,%cpu,%mem --sort=-%cpu | head 15  # top by CPU
```
**Security:** `ps aux` should be second nature. After compromise, attackers often run persistent processes. Look for: processes owned by www-data outside /var/www, python/perl/ruby one-liners, anything from /tmp.

### `top` / `htop`
Interactive process viewer. `k` to kill a process in top. `htop` is friendlier if installed.

### `netstat` / `ss` — network connections
```bash
ss -tulnp             # TCP/UDP listening, numeric, show process
ss -anp               # all connections with PIDs
netstat -tulnp        # older equivalent (deprecated but still common)
ss -anp | grep ESTABLISHED  # active connections
```
**Security:** After incident, `ss -tulnp` shows what's listening and what process opened it. Unexpected LISTEN on port 4444? Shell. Unknown process with ESTABLISHED connections to external IPs? Beacon. Also see: [[Nmap]] for external view.

---

## Network Tools

### `curl` / `wget`
```bash
curl -I https://example.com          # headers only
curl -L -o file.zip https://...      # follow redirects, save to file
curl -x http://proxy:8080 https://.. # through proxy
wget -q -O - https://example.com     # pipe to stdout
wget -r --level=1 https://site.com   # recursive download
```
**Security:** Attackers use `curl` and `wget` to download payloads. In SIEM logs, outbound curl/wget from a web server or database host is a red flag.

### `ssh` / `scp` / `rsync`
```bash
ssh user@192.168.1.10                     # connect
ssh -i ~/.ssh/id_rsa user@host            # specify key
ssh -L 8080:internal-host:80 jump-host   # local port forward (tunneling)
scp file.txt user@host:/remote/path/      # secure copy
rsync -avz /local/ user@host:/remote/    # sync directories
```
**Security:** SSH tunneling is a legitimate admin tool and an attacker persistence mechanism. Unexpected SSH connections in auth.log, or `-L`/`-R` flags in process list, warrant investigation. See [[SSH]].

### `nmap`
```bash
nmap -sV -O 192.168.1.0/24           # service/OS detection on subnet
nmap -p 22,80,443,3389 host          # specific ports
nmap --script vuln 192.168.1.10      # run vuln detection scripts
```
See the dedicated [[Nmap]] note.

---

## File & Permission Management

### `chmod` — change file permissions

**Permission model:** Every file has owner/group/others permissions.

```
rwxrwxrwx  →  owner rwx  |  group rwx  |  others rwx
r = 4, w = 2, x = 1

chmod 755 script.sh   # rwxr-xr-x  — owner full, others read+execute
chmod 644 file.txt    # rw-r--r--  — owner rw, others read-only
chmod 600 private.key # rw-------  — owner only (SSH keys MUST be 600)
chmod +x script.sh    # add execute for owner
chmod -R 750 /dir/    # recursive
```

**Setuid (SUID):** `chmod 4755` — file runs as owner, not executor. SUID on shell = root escape.
**Setgid (SGID):** `chmod 2755` — file runs with group permissions.
**Sticky bit:** `chmod 1777` — used on /tmp — users can only delete their own files.

```bash
# Dangerous: world-writable file owned by root
find / -perm -0002 -type f -not -path "/proc/*" 2>/dev/null

# Find all SUID binaries
find / -perm -4000 -type f 2>/dev/null | sort
```

### `chown` — change ownership
```bash
chown user:group file.txt        # set owner and group
chown -R www-data:www-data /var/www/html  # recursive (web server dirs)
```

### `sudo`
```bash
sudo command              # run as root
sudo -u username command  # run as another user
sudo -l                   # list your allowed sudo commands
sudo -i                   # interactive root shell
```

---

## Service Management

### `systemctl`
```bash
systemctl status nginx          # check status
systemctl start|stop|restart nginx
systemctl enable nginx          # start on boot
systemctl disable nginx
systemctl list-units --type=service --state=running  # all running services
systemctl list-timers           # scheduled tasks (analogous to cron)
```

---

## Log Analysis

### `journalctl` — systemd journal
```bash
journalctl -u nginx              # logs for nginx service
journalctl -f                    # follow (like tail -f)
journalctl --since "1 hour ago"
journalctl -p err                # only errors
journalctl -u ssh --since today  # SSH logs today
```

### `tail` / `cat` / `less`
```bash
tail -f /var/log/auth.log        # live follow
tail -n 100 /var/log/syslog      # last 100 lines
cat /etc/passwd | less           # paginate
grep "Failed" /var/log/auth.log | tail -50
```

---

## Key Log Locations

| Log | What's in it |
|-----|--------------|
| `/var/log/auth.log` | SSH logins, sudo, su, PAM — **primary security log** |
| `/var/log/syslog` | General system messages |
| `/var/log/kern.log` | Kernel messages |
| `/var/log/apache2/access.log` | Web requests (IP, URI, status code) |
| `/var/log/apache2/error.log` | Web server errors |
| `/var/log/nginx/access.log` | Nginx access log |
| `/var/log/dpkg.log` | Package installations |
| `/var/log/faillog` | Failed login attempts |
| `journalctl` | All systemd-managed service logs |

**Incident first look:**
```bash
# Who logged in and when?
last | head -20
lastb | head -20           # failed logins (lastb)
cat /var/log/auth.log | grep "Accepted\|Failed" | tail -50

# What was installed recently?
grep "install" /var/log/dpkg.log | tail -20

# Crontab for all users (backdoor persistence)
for user in $(cut -f1 -d: /etc/passwd); do crontab -u $user -l 2>/dev/null; done
```

---

## Other Critical Commands

### `tar` — archive/compress
```bash
tar -czf archive.tar.gz /directory/   # create gzipped archive
tar -xzf archive.tar.gz               # extract
tar -tzf archive.tar.gz               # list contents without extracting
```

### `crontab`
```bash
crontab -e            # edit your crontab
crontab -l            # list your crontab
crontab -u user -l    # list another user's crontab (root only)
```
See [[Automation]] for cron syntax.

---

## Tags
`[[Linux]]` `[[SSH]]` `[[Nmap]]` `[[CySA+]]` `[[Incident Response]]` `[[Help Desk]]` `[[Privilege Escalation]]` `[[Log Analysis]]`
