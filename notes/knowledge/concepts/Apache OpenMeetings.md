# Apache OpenMeetings

## What it is
Think of it as a full video conferencing suite built into a web server — like Zoom, but self-hosted and open-source, running inside your organization's own infrastructure. Apache OpenMeetings is a web-based collaboration platform providing video conferencing, whiteboarding, file sharing, and session recording, built on the Apache Software Foundation stack using Java and Red5 media server.

## Why it matters
In 2018, security researchers discovered **CVE-2018-1325** and related vulnerabilities allowing unauthenticated remote code execution in OpenMeetings installations — attackers could exploit a flaw in the invitation hash mechanism to gain admin access without credentials. Organizations self-hosting OpenMeetings for internal meetings had exposed their entire server because the application ran with elevated privileges and patching cycles for self-hosted open-source apps are notoriously slow.

## Key facts
- **CVE-2018-1286** allowed SSRF (Server-Side Request Forgery), enabling attackers to probe internal network services from the OpenMeetings server itself
- Built on **Apache Wicket** (web framework) and **Red5** (RTMP media server) — both independently introduce attack surface
- Runs on port **5080** (HTTP) and **5443** (HTTPS) by default, often left exposed to the internet without firewall rules
- Vulnerabilities have included **XML injection, path traversal, and insecure deserialization** — a common pattern in Java-based enterprise web apps
- As a self-hosted solution, it bypasses cloud vendor security controls, making **patch management** the organization's sole responsibility

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[Insecure Deserialization]] [[Remote Code Execution]] [[CVE Vulnerability Management]] [[Open Source Software Risk]]