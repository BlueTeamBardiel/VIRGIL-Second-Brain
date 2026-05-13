# PHP — Hypertext Preprocessor

## What it is

In **Mortal Kombat**, when the announcer growls "FINISH HIM" and the loser is left swaying, the attacker punches in a specific sequence — Down, Forward, Back, Punch — and the engine quietly executes a hidden routine that turns the input into a spine rip. The fatality isn't in the move list. It's server-side code the engine runs when the right input arrives.

That's exactly what **PHP** does — a server takes a request from the browser, runs hidden code, and ships back HTML. The user never sees the code, only the result.

**PHP (Hypertext Preprocessor)** is a server-side scripting language that runs inside a web server (Apache, Nginx + PHP-FPM, IIS). Browser sends a request to `/login.php`, the PHP interpreter executes the script, the script touches a database or filesystem, the output is sent back as HTML. PHP files are interpreted, not compiled — meaning an attacker who can write a `.php` file into the web root and reach it via URL gets **arbitrary code execution as the web server user**. That's why this acronym lives in a CS0-003 IR domain: PHP webshells are one of the most common artifacts a SOC analyst pulls off a compromised host.

## Why it matters

WordPress, Joomla, Drupal, Magento, phpMyAdmin, MediaWiki, Laravel, Symfony — somewhere around 75% of the public web runs on PHP. Which means the public-facing intrusion you're chasing this quarter probably involved a PHP application with an unpatched plugin, a misconfigured upload form, or a webshell named `wp-config-backup.php` sitting in `/wp-content/uploads/`.

Exam relevance: **Objective 3.2** asks you to perform IR activities — detect, contain, acquire evidence, preserve chain of custody, remediate, validate. PHP webshells, malicious plugins, and tampered legitimate `.php` files are the textbook artifact set CompTIA uses to test your IR muscle on a web compromise scenario. Knowing how PHP gets weaponized lets you read the question and immediately spot the IoCs, the right containment move, and the trap answer.

## Key facts

### How PHP gets weaponized

| Vector | Mechanics | What it leaves behind |
|---|---|---|
| **Unrestricted file upload** | App accepts `.php` (or `.phtml`, `.php5`, `.phar`) in an upload form, file lands in web-readable directory | New `.php` file in `/uploads/`, `/tmp/`, theme/plugin dirs |
| **Remote File Inclusion (RFI)** | `include($_GET['page'])` pulls attacker-hosted PHP and executes it | Outbound HTTP to attacker server, no file on disk |
| **Local File Inclusion (LFI) + log poisoning** | Inject PHP into User-Agent, then `include` the access log | Web access log contains `<?php ... ?>` lines |
| **Vulnerable plugin/CMS** | CVE in WordPress plugin, Drupalgeddon, Magento, Log4Shell-adjacent | New admin user, modified theme files, scheduled tasks |
| **Deserialization** | `unserialize()` on attacker input triggers magic methods (`__wakeup`, `__destruct`) | No file artifact — process anomaly only |
| **`eval()` / `system()` injection** | App passes user input to `eval`, `system`, `exec`, `passthru`, `popen`, `shell_exec` | Web server child process spawning `/bin/sh`, `cmd.exe` |

### Webshell IoCs — what to grep for

PHP webshells are surprisingly easy to fingerprint because the language is small and the dangerous functions are named.

**File-content IoCs:**
- `eval(`, `assert(`, `system(`, `exec(`, `passthru(`, `shell_exec(`, `popen(`, `proc_open(`
- `base64_decode(` wrapped around an `eval` — classic obfuscation: `eval(base64_decode("..."))`
- `gzinflate(`, `str_rot13(`, `gzuncompress(` chained with `eval`
- `$_GET`, `$_POST`, `$_REQUEST`, `$_COOKIE` feeding directly into `eval` or `system`
- `preg_replace` with the `/e` modifier (deprecated but still seen in old shells)
- Long base64 blobs with no comments, no formatting, weird filenames

**Filesystem IoCs:**
- New `.php` files in `/uploads/`, `/images/`, `/cache/`, `/tmp/` — directories that should never contain executable code
- `.php` files with double extensions: `image.jpg.php`, `update.php.suspected`
- Modified timestamps on core CMS files (compare to known-good hash from the vendor)
- `.htaccess` changes enabling PHP execution in upload directories

**Process / network IoCs:**
- `www-data`, `apache`, `nginx`, `iisuser` spawning `/bin/sh`, `bash`, `cmd.exe`, `powershell.exe`
- Outbound connections from the web server to non-CDN, non-API IPs — especially over 4444, 8080, 443 to residential ASNs
- DNS lookups to dynamic DNS providers (duckdns, no-ip) from the web tier

### CompTIA exam traps

> **CompTIA exam trap:** "Block PHP entirely" is almost never the right answer for containment — the business depends on the web app. The right move is **isolation** of the compromised host (pull it from the load balancer, snapshot it, route traffic to a clean node) while preserving evidence. Killing PHP across the fleet is the **eradication** phase, not containment.

> **CompTIA exam trap:** Re-imaging the web server **before** evidence acquisition fails chain of custody and destroys the artifacts you need for root cause. Acquisition (disk image, memory capture, log export) comes first. Re-imaging is a recovery action, not a detection one.

> **CompTIA exam trap:** A webshell file on disk is an **Indicator of Compromise (IoC)** — forensic, after the fact. A web server process spawning `/bin/sh` in real time is an **Indicator of Attack (IoA)** — behavioral, happening now. CompTIA will write a question where both terms appear and the right answer depends on which artifact type is described.

### Detection and analysis

**Log sources you pull first** when the alert says "possible PHP webshell on web-01":

1. **Web server access logs** (`/var/log/apache2/access.log`, IIS logs) — look for the first `GET` or `POST` to the suspect `.php` file. That request's timestamp + source IP is your **patient zero**.
2. **Web server error logs** — attackers often trigger PHP errors during exploit dev; error log shows the failed attempts before the successful one.
3. **PHP-FPM / mod_php logs** — fatal errors, segfaults, OOM kills around the compromise window.
4. **EDR process telemetry** — `www-data` → `sh` → `curl` → `wget` chain is the smoking gun.
5. **NetFlow / firewall logs** — egress from the web server's internal IP to anywhere weird.

### Evidence acquisition and preservation

Order of volatility — capture **most volatile first**:

1. **Memory** — `LiME` on Linux, `WinPMEM` on Windows. Captures running webshell process, decoded payloads, in-memory artifacts that never hit disk (file-less PHP via RFI).
2. **Running processes, network connections, open files** — `ps auxf`, `ss -tnp`, `lsof`, `netstat -anob`.
3. **Disk image** — `dd`, `dcfldd`, FTK Imager. Bit-for-bit, write-blocker on physical, snapshot on virtual.
4. **Logs** — copy out before the attacker (or log rotation) destroys them. Hash each file (`sha256sum`) and record in the case log.

**Validating data integrity:** every artifact gets a SHA-256 hash at acquisition. Same hash at the lab proves no tampering. *If the hash changes between custody handoffs, the evidence is junk.*

**Chain of custody:** every transfer logged — who took it, who handed it off, timestamp, storage location. Missing one row breaks admissibility. **Legal hold** preservation order kicks in the moment counsel says so — no log rotation, no auto-deletion, no "we cleaned up the test box."

### Containment, eradication, recovery

| Phase | Action | Don't confuse with |
|---|---|---|
| **Containment** | Pull host from load balancer, segment via VLAN/firewall, **isolate** but keep running for evidence | Eradication — don't kill the box yet |
| **Eradication** | Remove webshells, patch the CVE, rotate every credential the host touched, kill backdoor accounts | Recovery — patching ≠ back in service |
| **Recovery** | **Re-image** from gold, redeploy app from clean repo, restore data from pre-compromise backup, validate, return to LB | Containment — recovery comes last |
| **Compensating controls** | If the patch isn't ready: WAF rule blocking the exploit pattern, disable file uploads, read-only filesystem on `/uploads`, `disable_functions = exec,system,...` in `php.ini` | "Fixed" — compensating means risk is *reduced*, not gone |

**Scope** — don't assume one webshell means one host. The attacker probably used the shell to pivot. Check: any other host that the web server can reach, any shared NFS mount, any database that returned data, any credential cached in `wp-config.php` or `.env`.

**Impact** — what data was accessible from the compromised app? PII, PHI, PCI, IP? This drives regulatory notification clocks (GDPR 72h, HIPAA, state breach laws).

### Hardening — what should already be in place

- `disable_functions = exec,passthru,shell_exec,system,proc_open,popen` in `php.ini`
- `open_basedir` restricts which directories PHP can read/write
- Upload directories: no execute, enforced via `.htaccess` `php_flag engine off` or Nginx `location` block
- WAF in front (ModSecurity, AWS WAF, Cloudflare) with OWASP CRS
- File integrity monitoring (FIM) on web root — alert on any new `.php` file
- CMS auto-updates, plugin inventory reviewed quarterly
- Least privilege: web server user can't write to its own code directory

## SOC reality

- The 3am alert reads "EDR: `www-data` spawned `/bin/sh` on web-prod-04." You acknowledge, pull `ps` and `netstat` snapshots via the EDR live-response shell **before** anything else, then page the IR lead.
- L1's first move is **isolation, not investigation** — yank the host from the load balancer so the bleed stops, then start looking. You do not log into the box and start `rm`-ing files. That's evidence destruction.
- The IR lead's first three questions are always the same: **scope** (what else can this host reach?), **impact** (what data was on it?), **evidence preserved** (do we have memory and disk before anyone touches it?). Have answers ready.
- Never tell the CISO "we've contained it" until you've confirmed no second-stage persistence — cron jobs, systemd units, modified `.bashrc`, scheduled tasks, new SSH keys in `~/.ssh/authorized_keys`, new admin in the CMS database. *A webshell is rarely the only thing they left.*
- Handoff: L1 isolates and acquires → L2/IR does forensic timeline and root cause → AppSec patches the CVE and reviews code → Legal handles legal hold and notification → the post-incident review feeds new SIEM rules and a FIM baseline so the next one fires in minutes, not hours.

## Related concepts

[[Webshells]] · [[Web Application Firewall]] · [[OWASP Top 10]] · [[File Inclusion (LFI/RFI)]] · [[SQL Injection]] · [[Indicators of Compromise]] · [[Indicators of Attack]] · [[Chain of Custody]] · [[Order of Volatility]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[Containment Eradication Recovery]] · [[Compensating Controls]] · [[File Integrity Monitoring]] · [[EDR]] · [[SIEM]] · [[NIST SP 800-61]]

*Source: VIRGIL knowledge base — 2026-05-11*