# grep & Regular Expressions

## What it is

In **Destiny**, when you're hunting Lost Sectors for a specific exotic drop, you don't sweep the whole patrol zone — you go to the boss chest, you check the slot, you ignore the blues. The Ghost scans the room and only lights up what matters: the chest, the threat, the loot. Everything else is noise the engine renders but your brain filters out. That's exactly what `grep` does — it scans a wall of log text and only surfaces the lines that match a pattern you care about, ignoring the millions of lines that don't.

Plain English: `grep` is the find-text tool on Linux. You point it at a file (or a stream), give it a pattern, and it prints every line that matches. **Regular expressions** (regex) are the pattern language — a tiny syntax that lets you say "match anything that looks like an IP address" or "match `powershell.exe` followed by `-EncodedCommand`" without writing a script.

Technical: `grep` (Global Regular Expression Print) is a Unix utility that searches input line-by-line for lines matching a [[POSIX regular expression]] or fixed string, writing matches to stdout. It's the foundational text-search primitive that every SOC analyst running [[Linux Forensics]] or parsing exported [[SIEM]] data leans on before reaching for Python.

## Why it matters

CySA+ Objective 1.2 is the indicator-analysis objective: beaconing, unauthorized scheduled tasks, anomalous process behavior, registry changes, obfuscated links, data exfiltration, suspicious outbound traffic. Every one of those indicators lives in a log file somewhere. The job is finding it.

In the real SOC, you will not always have a Splunk license open in front of you. You will have:

- A 2 GB Apache access log a developer dumped in a ticket
- A raw `auth.log` pulled from a compromised Ubuntu box
- A directory of `evtx`-converted-to-text Windows events
- Sysmon output someone exported to CSV at 3am

You need to find the needle. Right now. Before the IR lead asks again. `grep` is how you do it without spinning up a tool that requires a ticket and a license seat.

CompTIA tests the *concept* — they want you to recognize that `grep "pattern" file.log` is how an analyst extracts indicators from raw data, and they want you to know basic flags and basic regex metacharacters. They will not ask you to write a backreferenced PCRE expression. They will ask which command finds case-insensitive matches of "failed password" in `auth.log`.

## Key facts

### Core grep syntax

```
grep [options] PATTERN [file...]
```

The pattern goes first, then the file. If no file is given, `grep` reads from stdin — which is how it chains with pipes.

### Flags worth memorizing

| Flag | What it does | When you reach for it |
|------|--------------|----------------------|
| `-i` | Case-insensitive match | Searching for "ERROR" vs "error" vs "Error" in mixed logs |
| `-n` | Prefix matches with line number | Reporting findings, building a timeline |
| `-v` | Invert — show lines that *don't* match | Filtering out known-good noise to see what's left |
| `-r` | Recursive — search every file under a directory | Searching `/var/log/` for one IoC across all logs |
| `-c` | Count matches instead of printing them | "How many failed logins from this IP?" |
| `-l` | List filenames containing matches (not the lines) | "Which logs even mention this user?" |
| `-A N` | Print N lines **after** each match | Seeing what happened next |
| `-B N` | Print N lines **before** each match | Seeing what led up to it |
| `-C N` | Context — N lines before and after | Reconstructing an event window |
| `-E` | Extended regex (ERE) — no backslashes on `+ ? ( ) { } \|` | When your pattern has groups or alternation |
| `-F` | Fixed string — no regex interpretation | When the pattern has `.` or `$` you want literal |
| `-o` | Print only the matched part, not the whole line | Extracting just IPs or hashes from log lines |
| `-w` | Match whole words only | Searching for `admin` without hitting `administrator` |

### Regex metacharacters (the ones CompTIA touches)

| Symbol | Meaning | Example |
|--------|---------|---------|
| `.` | Any single character | `c.t` matches `cat`, `cot`, `c7t` |
| `*` | Zero or more of the previous element | `ab*c` matches `ac`, `abc`, `abbbc` |
| `+` | One or more (ERE) | `ab+c` matches `abc`, `abbc`, not `ac` |
| `?` | Zero or one (ERE) | `colou?r` matches both spellings |
| `^` | Start of line | `^Failed` matches lines starting with "Failed" |
| `$` | End of line | `denied$` matches lines ending in "denied" |
| `[abc]` | Any one character in the set | `[0-9]` matches any digit |
| `[^abc]` | Any character NOT in the set | `[^0-9]` matches non-digits |
| `\|` | Alternation (ERE) | `error\|fail\|denied` matches any of the three |
| `()` | Grouping (ERE) | `(GET\|POST) /admin` |
| `{n,m}` | Between n and m repetitions | `[0-9]{1,3}` matches 1–3 digits |
| `\d \w \s` | Digit, word char, whitespace (PCRE — use `grep -P`) | Cleaner but less portable |

### Patterns every SOC analyst should recognize on sight

```bash
# IPv4 address (rough — doesn't validate octets)
grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" access.log

# MD5 hash (32 hex chars)
grep -E "[a-fA-F0-9]{32}" report.txt

# SHA-256 (64 hex chars)
grep -E "[a-fA-F0-9]{64}" iocs.txt

# Base64-looking blob (length 20+, often C2 or encoded payload)
grep -E "[A-Za-z0-9+/]{20,}={0,2}" suspicious.log

# Failed SSH logins
grep -i "failed password" /var/log/auth.log

# Successful sudo to root
grep -E "sudo:.*COMMAND=" /var/log/auth.log
```

### Pipes — where `grep` becomes a force multiplier

The pipe (`|`) sends the output of one command into the next. `grep` rarely runs alone:

```bash
# Top 10 IPs hitting your web server
cat access.log | awk '{print $1}' | sort | uniq -c | sort -rn | head -10

# Failed SSH attempts grouped by source IP
grep "Failed password" auth.log | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort | uniq -c | sort -rn

# Find any process named powershell with encoded command argument
ps auxww | grep -i "powershell" | grep -i "encodedcommand"

# Listening ports outside the expected range
netstat -tlnp | grep -vE ":(22|80|443|3306)\s"
```

That last one is the `-v` invert flag doing real work: *"show me listening ports that aren't the four I expect."* That single line surfaces a rogue listener on port 4444 faster than any dashboard.

### Indicators from Objective 1.2 — what to grep for

| Indicator | Sample grep |
|-----------|------------|
| **Beaconing** | `grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" proxy.log \| sort \| uniq -c \| sort -rn` — same dest IP appearing on fixed intervals |
| **Unexpected outbound ports** | `grep -vE ":(80\|443\|53)" connections.log` |
| **Unauthorized scheduled tasks** | `grep -i "schtasks\|at.exe\|cron" sysmon.txt` |
| **New accounts** | `grep -iE "useradd\|net user.*\/add\|new-localuser" audit.log` |
| **Obfuscated PowerShell** | `grep -iE "powershell.*(-enc\|-e \|frombase64string\|iex)" sysmon.txt` |
| **Data exfiltration** | `grep -iE "curl\|wget\|Invoke-WebRequest.*-Method Post" host.log` |
| **Failed-then-success login** | `grep -E "Failed password.*$USER" auth.log` then check what came next |
| **Rogue device** | `grep -E "DHCPACK" dhcp.log \| grep -v -F -f known_macs.txt` |

### CompTIA exam traps

> **CompTIA exam trap:** `grep -v` does NOT delete lines from the file. It only filters output to stdout. Candidates see "inverse match" and think "remove." The file on disk is untouched. `grep` is read-only.

> **CompTIA exam trap:** `.` in regex matches any character — it is NOT a literal dot. To match a literal period (in a filename, an IP, a domain), escape it: `\.` or use `grep -F`. CompTIA will give you a pattern like `192.168.1.1` and ask why it also matched `192X168Y1Z1` in some other context. The answer is unescaped dots.

> **CompTIA exam trap:** `*` in regex is NOT a wildcard like in a shell. It means "zero or more of the previous character." `ab*` matches `a`, `ab`, `abb`, `abbb` — not `ax`. The shell glob `*` and the regex `*` are different beasts. Easy confusion point.

> **CompTIA exam trap:** Basic regex (BRE) vs Extended regex (ERE) — in BRE (default `grep`), `+ ? ( ) { } |` are LITERAL characters unless escaped. In ERE (`grep -E`), they're metacharacters. If a test question shows `grep "error|fail"` and asks what matches, the answer is the literal string `error|fail`, not "error OR fail." Use `grep -E` for alternation.

## SOC reality

- The L1 analyst gets a ticket: *"weird traffic from 10.4.2.17, can you look?"* First move isn't opening Splunk — it's `ssh` to the box and `grep -E "10\.4\.2\.17" /var/log/syslog /var/log/auth.log` to scope it locally before pulling SIEM.
- The IR lead asks: *"how many times did this IoC hit, and from which hosts?"* You answer with `grep -rl "evilhash" /collected_logs/ | wc -l` in under a minute. That speed is the difference between a 30-minute MTTD and a 4-hour one.
- During eradication, you're proving a negative: *"no instance of the C2 domain remains in any log."* `grep -ri "evil.tld" /var/log/` returning empty is the closest thing to comfort you get.
- Never promise the IR lead "I've checked everywhere" after running one `grep`. Logs rotate. Logs gzip. `zgrep` exists for `.gz`. `bzgrep` for `.bz2`. Check the rotated archives or you will get burned. *Three weeks into a campaign I missed the first beacon because it was in `auth.log.4.gz` and I had only grepped `auth.log` and `auth.log.1`.*
- Handoff: L1 produces the raw grep output and the count. L2 produces the timeline with `-B` and `-A` context. IR produces the correlated narrative across hosts. Three different uses of the same tool.

## Related concepts

[[SIEM]] · [[Log Analysis]] · [[Linux Forensics]] · [[Sysmon]] · [[Indicators of Compromise]] · [[Beaconing]] · [[Command Line Forensics]] · [[awk and sed]] · [[Regular Expressions]] · [[PowerShell Logging]] · [[Threat Hunting]] · [[Data Exfiltration]] · [[Living Off the Land]]

*Source: VIRGIL knowledge base — 2026-05-11*