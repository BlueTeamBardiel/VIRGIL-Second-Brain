# tmate

## What it is
Like handing a stranger a spare key to your terminal through a tunnel dug under the firewall — tmate is a terminal multiplexer (based on tmux) that creates instant, shareable SSH sessions by routing connections through a relay server at tmate.io. A developer runs one command and receives a public URL that anyone with the link can use to observe or control that terminal session in real time.

## Why it matters
Attackers who gain code execution on a CI/CD pipeline or developer workstation frequently abuse tmate to establish persistent, firewall-bypassing reverse shells — because the outbound connection to tmate.io looks like legitimate developer tooling rather than a C2 callback. Security teams hunting for this technique look for processes spawning `tmate` alongside unexpected SSH relay connections to `*.tmate.io` on port 22 or 443.

## Key facts
- tmate sessions route through a third-party relay server (tmate.io), meaning **all session data transits an external host** — a confidentiality risk for sensitive environments
- Supports **read-only sharing links** (observer) and **read-write links** (full control) — attackers seek read-write access
- Bypasses inbound firewall rules because the victim machine **initiates the outbound connection** to the relay, similar to a reverse shell
- Commonly seen in **supply chain attacks** and malicious GitHub Actions workflows where `tmate` is injected to exfiltrate secrets or maintain access
- Detection signatures: unexpected `tmate` binary execution, outbound SSH to `nyc1.tmate.io` or `lon1.tmate.io`, or `.tmate.io` in DNS query logs

## Related concepts
[[Reverse Shell]] [[C2 (Command and Control)]] [[SSH Tunneling]] [[CI/CD Pipeline Security]] [[Living Off the Land Binaries]]