# User-Agent

## What it is
Like a visitor handing a business card at the front desk — announcing who they are before the receptionist decides how to greet them — the User-Agent is an HTTP request header that identifies the client software making the request. It typically contains the browser name, version, operating system, and rendering engine, sent automatically with every web request.

## Why it matters
Attackers frequently manipulate the User-Agent string to evade detection or impersonate legitimate browsers — a technique called User-Agent spoofing. For example, a web scraper or malware C2 beacon may forge a Chrome User-Agent to blend into normal traffic, while security tools like WAFs and SIEMs can flag suspicious strings (e.g., `sqlmap/1.0`, `Nikto`, or empty User-Agents) as indicators of automated scanning or exploitation attempts.

## Key facts
- User-Agent strings are **entirely client-controlled** and trivially falsified — treat them as untrusted data, never as authentication
- Default tool signatures are detectable: `sqlmap`, `Nikto`, `Masscan`, and `curl` all send distinctive User-Agent strings unless explicitly spoofed
- **Empty or null User-Agent headers** are a common red flag for malicious bots, scripts, or misconfigured malware
- SOC analysts correlate unusual User-Agent patterns in proxy/web logs as part of threat hunting for C2 beacons (e.g., hardcoded strings in RATs like Cobalt Strike malleable profiles)
- Some web servers perform **User-Agent-based content negotiation**, making UA strings a target for fingerprinting or browser-specific exploit delivery

## Related concepts
[[HTTP Headers]] [[Web Application Firewall]] [[C2 Beaconing]] [[Log Analysis]] [[Fingerprinting]]