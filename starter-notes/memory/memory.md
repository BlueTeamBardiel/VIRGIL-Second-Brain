# memory.md — VIRGIL Second Brain

> Sample memory file — replace with your own entries as you use VIRGIL.
> The promote.sh hook distills your daily logs into entries like these automatically.

---

## Promoted — 2025-11-20

**Lesson Learned — Misconfiguration:**
Set up fail2ban fleet-wide and assumed it was working because the service showed `active (running)`. Three weeks later, realized it wasn't actually blocking anything — the backend was still set to `iptables` and the host was using `nftables`. Status green, protection zero.

Fix: always verify the backend matches the host's firewall stack. On modern Ubuntu/Debian, `backend = systemd` is the correct setting. Added a smoke test to the deployment checklist: after fail2ban runs, check `fail2ban-client status sshd` and confirm it shows recent bans or at least a filter hit count.

The lesson isn't "fail2ban is unreliable." The lesson is that *service running* and *service working* are different things.

---

## Promoted — 2025-12-04

**Study Insight — Incident Response Phases:**
The IR phase ordering question trips me up every time. I keep wanting to put Containment before Identification because it feels wrong to know something is happening and not stop it immediately. But the correct order is Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned.

The reason Identification comes before Containment: if you contain before you've fully identified the scope, you might isolate one machine while the attacker maintains access through three others. You need to know what you're containing before you contain it.

The exam trap is questions that describe a responder jumping straight to isolation. That's Containment — but the question will ask "which phase was SKIPPED?" and the answer is Identification.

---

## Promoted — 2026-01-12

**Career Decision:**
Decided to stop applying to every job I'm technically qualified for and start filtering by whether the role has a clear growth path. A helpdesk job that leads to sysadmin in 18 months is worth more than a "security analyst" contract role that's really just ticket-closing with a better title.

Narrowed the target list to three types: desktop support at a company with internal promotions, junior SOC at an MSSP (real alert volume, not just compliance paperwork), and IT technician at a healthcare or education org (stable, real infrastructure complexity).

This reduced my application rate. It also reduced the despair rate. Both are good outcomes.

---

## Promoted — 2026-02-08

**Tool Evaluation — Wazuh vs. Splunk for Home Lab:**
Ran Wazuh for 6 weeks. It's genuinely useful for a home lab. The agent deployment is clean, the dashboard shows real event volume, and the default rules catch things you'd otherwise miss (SSH brute force patterns, sudo abuse, file integrity changes).

Splunk Free has a 500MB/day ingest cap that you hit fast if you're running anything real. Wazuh has no ingest limit. For a lab where the goal is learning detection concepts, Wazuh wins on cost and on getting hands-on with a tool that's actually deployed in production environments.

Downside: the Wazuh web UI is slower than Splunk's, and the rule syntax takes time to learn. But the rule syntax is worth learning.

---

## Promoted — 2026-03-15

**Lab Observation — VLAN Segmentation Reality Check:**
Thought I had proper VLAN segmentation between the lab network and the management network. Ran a quick test: from a machine on the lab VLAN, tried to reach the management interface on the switch. Got there.

The inter-VLAN routing was enabled on the router, which I'd set up for convenience and then forgotten about. Convenience and segmentation are enemies. If you want isolation, you have to verify isolation — don't assume the config does what you think it does.

Added this to the lab checklist: after any network change, test the thing you're trying to prevent, not just the thing you're trying to allow.

---

*This file is auto-updated by promote.sh. Edit individual entries but do not reorder — the promote hook appends chronologically.*
