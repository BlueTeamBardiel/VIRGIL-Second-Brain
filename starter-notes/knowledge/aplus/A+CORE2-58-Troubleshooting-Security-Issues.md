---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 58
source: rewritten
---

# Troubleshooting Security Issues
**Identifying and eliminating malware-related connectivity problems and deceptive browser threats.**

---

## Overview

Security threats don't just steal data—they actively sabotage your system's ability to function. When your computer mysteriously loses network access or your browser floods you with fake warnings, malware is often pulling the strings. For the A+ exam, you need to recognize these symptoms, understand *why* they happen, and know the remediation steps that actually work.

---

## Key Concepts

### Malware-Induced Network Disconnection

**Analogy**: Think of malware as a security guard who locks the front door to prevent you from calling for help. It doesn't want you installing antivirus software, so it sabotages your internet connection—either deliberately or as a side effect of its code running wild.

**Definition**: [[Malware]] that causes [[network connectivity]] failures by either intentionally blocking access to specific sites (particularly security vendors) or consuming system resources so badly that the network stack collapses.

| **Malware Behavior** | **Intentional** | **Unintentional** |
|---|---|---|
| Blocks antivirus downloads | Yes | No |
| Hijacks DNS settings | Yes | Rare |
| Crashes network drivers | Rare | Yes |
| Consumes all bandwidth | Both | Possible |

**Key Point**: [[Vulnerability|Unpatched vulnerabilities]] in your [[operating system]] are the entry point. Malware exploits these cracks to get in. A single [[patch]] closes that door forever.

---

### Browser Hijacking and Pop-Up Manipulation

**Analogy**: Imagine someone broke into your house and now they're putting fake eviction notices on your walls, asking you to call a number. Pop-up notifications are just digital versions of that scam—they *look* official but they're fake.

**Definition**: [[Malware]] or compromised websites that inject fake [[browser notifications]] and pop-ups designed to trick users into downloading more malicious software or revealing credentials.

**Common Fake Scenarios**:
- "Your antivirus subscription expired—click here to renew"
- "System Critical Alert: Your device is infected"
- "Update Adobe Flash NOW" (Flash hasn't existed since 2020)

**Defense Mechanism**: Modern browsers let you configure notification permissions:

```
Settings → Privacy & Security → Notifications → Block or Allow specific domains
```

| **Notification Type** | **Legitimate Source** | **Red Flag** |
|---|---|---|
| OS updates | microsoft.com, apple.com | Random pop-up window |
| Antivirus alerts | Installed software | Browser tab message |
| Bank warnings | Your actual bank's domain | Generic "urgent" language |

---

## Remediation Hierarchy

### Step 1: Disconnect and Isolate
Remove the infected machine from the network immediately. Don't let it infect others.

### Step 2: Malware Removal Attempt
Run [[malware scanner|malware scanners]] in Safe Mode. This works for many infections.

### Step 3: Nuclear Option (Clean Wipe)
If malware persists:
1. Backup critical files to external media (scan them first!)
2. [[wipe|Wipe]] the hard drive completely
3. Reinstall [[operating system|OS]] from trusted media
4. Restore from a [[backup|known-good backup]]

This is the gold standard because malware can hide in system files where traditional removal tools can't reach.

---

## Exam Tips

### Question Type 1: Symptom Recognition
- *"A user cannot access security vendor websites, but other sites work fine. What's the most likely cause?"* → [[Malware]] deliberately blocking access to prevent removal software downloads.
- **Trick**: Don't confuse this with normal [[firewall]] rules. Malware is *selective*—it blocks antivirus sites specifically.

### Question Type 2: Remediation Choice
- *"A computer is infected with persistent malware that survived two malware scans. What's the best next step?"* → Complete [[wipe and restore]] from backup.
- **Trick**: The exam loves to include "run another scan" as a trap. Know when to give up and rebuild.

### Question Type 3: Browser Threat Response
- *"Users report seeing pop-ups claiming their subscription expired. How do you prevent this?"* → Configure [[browser notification]] settings to block untrusted domains.
- **Trick**: Students often answer "block JavaScript" when the real answer is granular notification control.

---

## Common Mistakes

### Mistake 1: Assuming Network Failure = Hardware Problem
**Wrong**: "Network card is broken, replace it."
**Right**: Test connectivity on a different user account or different device first. If *that* works, it's a software/malware issue on the original system.
**Impact on Exam**: You'll waste time troubleshooting hardware when you should be running malware scans.

### Mistake 2: Trusting the Pop-Up Message
**Wrong**: "The notification says my antivirus expired, so I'll click the link."
**Right**: Ignore pop-up notifications entirely. Check your actual antivirus software's status from the system tray or Settings.
**Impact on Exam**: You need to recognize that *any* message not launched by the user is suspicious.

### Mistake 3: Scanning Instead of Wiping
**Wrong**: "Run Malwarebytes, then run Windows Defender, then try a third scanner."
**Right**: If scans don't work the first time, move to wipe and restore. Malware is persistent by design.
**Impact on Exam**: The test rewards efficiency. Know when remediation has failed and escalate to rebuild.

### Mistake 4: Patching AFTER Cleanup
**Wrong**: Clean the malware, then update Windows.
**Right**: Update Windows *immediately* after rebuild to close the vulnerability that let malware in originally.
**Impact on Exam**: You'll see questions where the answer includes both "restore from backup" AND "apply latest patches."

---

## Related Topics
- [[Malware Types]] (viruses, worms, trojans)
- [[Windows Update and Patch Management]]
- [[Antivirus and Anti-Malware Software]]
- [[Browser Security Settings]]
- [[Backup and Disaster Recovery]]
- [[Safe Mode and System Utilities]]
- [[Network Troubleshooting Fundamentals]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]] | [[CompTIA]]* 

**Study Note**: This is the intersection of security *and* troubleshooting. You need both the "why" (malware exploits vulnerabilities) and the "how" (scan vs. wipe). Expect 2-3 questions on this topic on test day.