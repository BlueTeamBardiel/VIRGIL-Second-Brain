# Workarounds

## What it is
Like a river that flows around a dam rather than through it, a workaround bypasses a security control without actually breaking it. Precisely, a workaround is a method that circumvents an intended security mechanism or technical limitation to achieve an objective — used by both attackers exploiting gaps and defenders maintaining operations when a patch isn't yet available.

## Why it matters
When a critical vulnerability is discovered but a vendor patch won't be available for weeks, administrators deploy workarounds — such as disabling a vulnerable service, blocking specific ports, or restricting access via ACLs — to reduce exposure in the interim. This is exactly what Microsoft recommended during the PrintNightmare (CVE-2021-34527) crisis: disable the Print Spooler service as a workaround before an official patch shipped, accepting reduced functionality to prevent remote code execution.

## Key facts
- Workarounds are **not remediations** — they reduce risk without eliminating the root vulnerability, meaning the underlying flaw remains present
- In patch management, workarounds are classified as **interim compensating controls** and should be tracked until a permanent fix replaces them
- Attackers use workarounds to **bypass EDR/AV tools**, such as using living-off-the-land binaries (LOLBins) like `certutil.exe` to download malware instead of triggering file-write detections
- Workarounds can introduce **new attack surface** — disabling a service for safety may break authentication or logging pipelines unexpectedly
- On Security+/CySA+ exams, workarounds appear in the context of **vulnerability response workflows**: the correct order is Identify → Evaluate → Apply Workaround (if patch unavailable) → Patch → Verify

## Related concepts
[[Compensating Controls]] [[Patch Management]] [[Vulnerability Remediation]] [[Living-Off-the-Land Attacks]]