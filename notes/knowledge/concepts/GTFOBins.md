# GTFOBins

## What it is
Like a locksmith's manual that reveals how every ordinary household tool can pick a lock, GTFOBins is a curated list documenting how legitimate Unix/Linux binaries (like `find`, `vim`, `tar`, and `curl`) can be abused to bypass security restrictions, escalate privileges, or execute arbitrary commands. It's the attacker's cheat sheet for living-off-the-land techniques on Linux systems.

## Why it matters
During a penetration test, an attacker lands on a hardened Linux box with minimal tools but discovers the `sudo` policy allows running `/usr/bin/find` as root. By consulting GTFOBins, they immediately know that `sudo find . -exec /bin/sh \; -quit` drops them into a root shell — turning a routine binary into a full privilege escalation in seconds. Defenders use GTFOBins to audit `sudo` policies, AppArmor profiles, and SUID-bit assignments before attackers do.

## Key facts
- GTFOBins stands for **"Get The F*** Out Binaries"** — binaries that help attackers escape restricted shells or escalate privileges
- Techniques are categorized by abuse type: **Shell, Sudo, SUID, Capabilities, File Read/Write, Reverse Shell, Bind Shell**
- SUID abuse is particularly dangerous — if a binary like `bash` has the SUID bit set (`-rwsr-xr-x`), `./bash -p` grants an effective root shell
- GTFOBins is the Linux/Unix equivalent of **LOLBAS** (Living Off the Land Binaries and Scripts) for Windows
- Common high-risk binaries include: `python`, `perl`, `awk`, `less`, `man`, `vim`, `tar`, `wget`, and `nmap` (in interactive mode)
- Mitigations include: restricting `sudo` with `NOEXEC`, removing unnecessary SUID bits, using AppArmor/SELinux mandatory access controls, and implementing the principle of least privilege

## Related concepts
[[Living Off the Land (LotL)]] [[Privilege Escalation]] [[SUID and SGID Permissions]] [[sudo Misconfigurations]] [[LOLBAS]]