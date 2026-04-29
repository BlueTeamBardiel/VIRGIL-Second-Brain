# Uptime Kuma

## What it is
Like a smoke detector for your servers — it watches silently in the background and screams the moment something stops breathing. Uptime Kuma is a self-hosted, open-source monitoring tool that continuously checks the availability of websites, services, and network endpoints, alerting operators via notifications when monitored targets go down or degrade.

## Why it matters
During an active intrusion, attackers often disrupt monitoring infrastructure first to blind defenders before moving laterally. A security team running Uptime Kuma can detect anomalous downtime patterns — for example, a suddenly unreachable internal DNS server or authentication portal — that serve as early indicators of compromise before a full incident is declared. Conversely, an attacker who gains access to an exposed Uptime Kuma dashboard gains a complete map of internal infrastructure targets and their health status.

## Key facts
- Uptime Kuma supports monitoring via HTTP/HTTPS, TCP, DNS, Ping, and Docker container status, making it relevant to both network and application-layer visibility
- The web dashboard is self-hosted (typically on port 3001) and requires authentication, but misconfigurations can expose it publicly — a significant reconnaissance risk
- It integrates with notification channels including Slack, PagerDuty, email, and Telegram, making it part of an organization's alerting and incident response chain
- Because it runs as a persistent service with network access to internal hosts, a compromised Uptime Kuma instance can be pivoted from to probe internal network topology
- Uptime Kuma generates historical uptime logs and response-time graphs, which can serve as forensic baselines during post-incident analysis to pinpoint when a service first became unavailable

## Related concepts
[[Network Monitoring]] [[Incident Response]] [[Attack Surface Management]] [[Security Information and Event Management (SIEM)]] [[Reconnaissance]]