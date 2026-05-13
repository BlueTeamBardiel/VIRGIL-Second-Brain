# Patching Systems and Applications

## What it is

In **Marvel Rivals**, when Hela's ult is melting your backline through a wall you didn't know was destructible, you don't push the payload — you fall back, rebuild the choke, swap to Doctor Strange for the shield, and *then* re-engage. You patch the gap before you contest the point again. Push too early and the same ult clips you through the same wall and you wipe a second time. That's exactly what recovery-phase patching does — close the hole the attacker came through *before* you put the asset back in play.

**Plain English:** after an incident, you don't just clean the malware off the box and shove it back online. You patch the vulnerability that let the malware in. Otherwise the same actor — or the next one scanning for the same CVE — walks right back through.

**Technical:** patching during the **Containment, Eradication, and Recovery** phase of the NIST SP 800-61 lifecycle is the application of vendor-supplied fixes (OS, application, firmware, hypervisor, container base image) to remediate the exploited vulnerability and any related exposures discovered during root cause analysis. Patching is a remediation activity, not a containment one — and the order in which you patch is dictated by incident scope, not by your normal monthly cadence.

## Why it matters

Recovery without patching is theater. You re-image the box, restore from backup, declare victory at the morning standup — and the attacker re-exploits the same unpatched Confluence server, the same Log4Shell-vulnerable app, the same Exchange CVE you already knew about. The post-mortem then reads: *"reinfection occurred via the original vector."* That's a career-defining sentence in the wrong direction.

CySA+ tests this under **Objective 3.2** — incident response activities, specifically containment, eradication, recovery, and remediation. CompTIA wants you to know that **remediation includes patching**, that **patching prioritization follows incident scope**, and that **compensating controls** exist for the case where you *can't* patch immediately (legacy app, vendor won't certify, change board sitting on it).

In ops, this is also where the change-management war starts. Production owners don't want you patching at 2pm. You don't want to wait until Saturday's maintenance window while the threat actor still has a foothold. That negotiation is the job.

## Key facts

### Where patching lives in the IR lifecycle

| Phase | Patching role |
|---|---|
| Preparation | Patch management program, baseline images, vuln scanner tuned, change windows pre-approved for emergency patches |
| Detection & Analysis | Identify the **CVE / exploited vulnerability** from [[IoC]] analysis, log review, malware reverse engineering |
| Containment | **Compensating controls** while you build the patch plan — WAF rule, network segmentation, host isolation, disabled service |
| Eradication | Remove malware, kill persistence, rotate credentials |
| **Recovery** | **Patch OS, applications, firmware**. Validate. Re-image where needed. Return to production. |
| Post-incident | Lessons learned feed back into patch SLAs and the vulnerability management program |

Patching is *primarily* a recovery activity, but compensating controls in containment buy you the time to do recovery right.

### Patching prioritization during recovery

Order matters. Don't patch alphabetically. Patch by **incident scope**:

1. **Systems directly involved in the compromise** — the patient zero, the lateral-movement hops, anything the attacker touched. These get patched *and* re-imaged.
2. **Systems indirectly related** — same OS, same vulnerable app version, same subnet, same trust boundary. The attacker didn't reach them this time but the next scan will.
3. **Other enterprise systems with the same exposure** — every other Windows box with the same unpatched CVE, every other web server running the vulnerable library. This is where your [[Vulnerability Management]] program takes the baton from IR.

This is **scope-driven patching**, not severity-driven. A CVSS 7.5 that's actively being exploited in your environment beats a CVSS 9.8 that nobody's touched.

### What you actually patch

- **Operating system** — kernel, system libraries, security updates
- **Applications** — the exploited app first (Exchange, Confluence, MOVEit, whatever), then adjacent apps sharing libraries
- **Firmware** — routers, switches, iLO/iDRAC, BIOS/UEFI, IoT, OT devices. Often forgotten. Often the persistence layer.
- **Hypervisor / container runtime** — VMware ESXi, Hyper-V, Docker, containerd
- **Container base images** — rebuild and redeploy, don't try to `apt update` inside a running container
- **Third-party libraries** — the Log4j moment. Patch the dependency, not just the app.

### Compensating controls — when you can't patch yet

Patch unavailable, change board says no, legacy system won't certify, vendor end-of-life. You still have to reduce risk. **Compensating controls** are the temporary fix:

- **Network segmentation / isolation** — VLAN the asset off, ACL it down to known-good talkers
- **WAF rule / IPS signature** — virtual patching at the perimeter
- **Disable the vulnerable service or feature** — turn off SMBv1, disable the plugin, kill the listener
- **Enhanced monitoring** — EDR in block mode, SIEM rule tuned for exploit attempts, [[Honeypot]] adjacent
- **Application allow-listing** — only signed binaries run
- **MFA + just-in-time access** — make the credential less valuable if stolen

Document every compensating control with an expiration date. *Compensating controls are loans, not gifts — interest compounds.*

### Validating the patch actually worked

Patching without validation is worse than not patching because it gives leadership false confidence:

1. **Verify version / KB / build number** post-patch — don't trust "Installed Updates"; query the actual file version or registry key the vendor specifies
2. **Re-scan the asset** with a credentialed [[Vulnerability Scanning|vulnerability scanner]] — the CVE should drop off
3. **Test the exploit path** if you have it — internal red team, validated PoC in a controlled detonation
4. **Validate data integrity** post-patch — hash-check critical files, confirm services restart clean, confirm app functionality
5. **Confirm no [[Configuration Drift]]** — patches sometimes reset settings to vendor defaults, re-opening doors you closed

### Re-imaging vs patching

For directly compromised hosts, **patching alone is not enough**. The attacker had code execution. You don't know what they left behind. The rule:

- **Re-image** anything that had attacker code execution. Gold image, fully patched, restored data from a known-clean point.
- **Patch in place** only for assets that were exposed but not confirmed compromised.

Re-imaging IS patching in the sense that you're deploying a current, patched baseline — but the trigger is "evidence of compromise," not "vulnerability present."

### Preserving evidence before you patch

This is where IR analysts get burned. You cannot patch a system you haven't finished collecting evidence from. Sequence:

1. **Forensic acquisition** — memory dump, disk image, log export. Hashes recorded.
2. **Chain of custody** documented — every transfer logged.
3. **Legal hold** confirmed if litigation or regulatory action is possible — patching can destroy evidence (overwriting binaries, clearing event logs, wiping temp files).
4. *Then* patch or re-image.

If the legal team has flagged the incident, you do not touch the box without their sign-off. *Patching a system on legal hold is a discovery-violation problem, not a security problem — and it's a much more expensive problem.*

### CompTIA exam traps

> **CompTIA exam trap:** patching is **recovery**, not **containment**. Containment is the WAF rule, the network isolation, the disabled service. Patching the vulnerability is eradication of the *exposure* and part of recovery. If the question describes "stopped the bleeding immediately," that's containment. If it describes "applied vendor security update," that's recovery.

> **CompTIA exam trap:** **compensating controls** are temporary risk reduction when the primary control (the patch) cannot be applied. They are NOT a substitute for patching long-term. Expect a question where the legacy ICS/SCADA system cannot be patched and the right answer is a compensating control (segmentation, monitoring), not "patch anyway."

> **CompTIA exam trap:** patching order during recovery is **directly involved → indirectly related → other enterprise systems**. CompTIA will offer "patch the highest CVSS first" as a distractor. Wrong. During active IR, scope dictates order. CVSS dictates order during normal vuln management.

> **CompTIA exam trap:** **re-imaging** is preferred over in-place patching for hosts with confirmed compromise. If the stem mentions "rootkit," "persistence mechanism," "unknown attacker dwell time," or "kernel-level malware," pick re-image.

## SOC reality

- **The 3am page:** EDR fires on a known CVE exploit attempt against an unpatched Confluence instance. Your first move is not to patch — it's to confirm scope, isolate the box, and preserve evidence. The patch comes after the forensic image.
- **The CISO question is always the same three:** *"Is it contained? What's the scope? When can we patch the rest of the fleet?"* Have the answer to all three before the standup. "We don't know yet" is acceptable once. Twice is a problem.
- **The change board fight:** production owner says "we can't patch during business hours." IR lead says "the attacker is still in the environment." This is escalated to the CISO or the incident commander, not negotiated by the L1. Document the decision either way — if the box gets re-popped because the patch waited, that document is your protection.
- **Never tell leadership "we've patched it" until you've validated it.** Installed ≠ effective. Reboot pending ≠ patched. Vendor says "fixed in v4.5.2" and you're running v4.5.1 — not patched. Verify the version, re-scan the host, then report.
- **The handoff:** L1 detects and isolates. L2/IR scopes and preserves evidence. IR + vuln management own the patch plan. System owners execute the patches in their change windows. Post-incident, the lessons feed into shorter patch SLAs and updated baselines. If patching took 90 days during a live incident, your patch program is the post-mortem finding, not the malware.

## Related concepts

[[Incident Response Lifecycle]] · [[Containment Eradication and Recovery]] · [[Vulnerability Management]] · [[Vulnerability Scanning]] · [[CVSS]] · [[Compensating Controls]] · [[Configuration Drift]] · [[Security Baselines]] · [[Re-imaging]] · [[Chain of Custody]] · [[Legal Hold]] · [[Evidence Acquisition]] · [[Change Management]] · [[Patch Management]] · [[IoC]] · [[Root Cause Analysis]] · [[Lessons Learned]]

*Source: VIRGIL knowledge base — 2026-05-11*