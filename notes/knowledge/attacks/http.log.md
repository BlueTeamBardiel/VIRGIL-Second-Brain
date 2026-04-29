# http.log

## What it is
Like a detailed receipt from every web transaction at a busy café — who ordered, what they asked for, what was served, and how long it took — `http.log` is Zeek's (formerly Bro) structured log file that captures full HTTP session metadata traversing a monitored network. It records fields like URI, method, status code, user-agent, referrer, and response size for every HTTP connection Zeek observes.

## Why it matters
During incident response following a data exfiltration event, analysts query `http.log` to identify abnormally large POST requests — a common technique where attackers upload stolen data to attacker-controlled servers disguised as normal web traffic. A defender might grep for `POST` requests with response bodies over 1MB sent to unknown external IPs, pivoting from `http.log` into `conn.log` to correlate connection duration and destination port.

## Key facts
- Fields include: `ts`, `uid`, `id.orig_h`, `id.resp_h`, `method`, `host`, `uri`, `referrer`, `user_agent`, `status_code`, `resp_body_len`
- The `uid` field links `http.log` entries to corresponding records in `conn.log` and `ssl.log` for full session reconstruction
- Unusual or spoofed `user_agent` strings (e.g., mimicking `curl` or old IE versions) are a key IoC detectable in this log
- HTTP tunneling — where attackers smuggle C2 traffic inside HTTP GET/POST — is frequently caught by analyzing request frequency patterns and URI entropy in `http.log`
- Only captures **cleartext HTTP (port 80)**; HTTPS traffic requires `ssl.log` and `x509.log` for metadata (payload remains encrypted)

## Related concepts
[[Zeek Network Security Monitor]] [[conn.log]] [[ssl.log]] [[User-Agent Analysis]] [[HTTP Tunneling]]