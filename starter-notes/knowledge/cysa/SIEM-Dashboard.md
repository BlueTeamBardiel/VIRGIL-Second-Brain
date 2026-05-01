---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# SIEM Dashboard
**Your command center for triaging security events and moving alerts through the investigation pipeline.**

---

## Overview

The [[SIEM]] dashboard is the operational nerve center where security analysts view, filter, and claim alerts for investigation. A SOC analyst lives on this dashboard—it's where raw security events transform into actionable incidents. Understanding how to navigate alert channels, filter by threat type, and transition cases through the lifecycle is critical for efficient incident response.

---

## Key Concepts

### Alert Channels

**Analogy**: Think of your email inbox with different folders—**Main Channel** is your inbox (all new mail), **Investigation Channel** is your "working on this" folder, and **Closed Alerts** is your archive.

**Definition**: The [[SIEM]] dashboard organizes alerts into three separate channels that represent the alert lifecycle. The [[Main Channel]] displays unclaimed alerts awaiting analyst attention. The [[Investigation Channel]] contains alerts an analyst has taken ownership of. The [[Closed Alerts]] channel stores completed investigations with documented outcomes.

Each channel acts as a workflow gate to prevent alert duplication and track case progression.

---

### Alert Metadata & Enrichment

**Analogy**: Like a crime scene report card—severity is urgency, alert type is the crime category, and contextual fields (source IP, destination, timestamps) are the forensic details.

**Definition**: [[Alert metadata]] includes severity levels ([[Low]], [[Medium]], [[High]], [[Critical]]), event timestamps, triggered rule names, event IDs, alert classifications ([[C2]], [[Malware]], [[Unauthorized Access]], [[Data Leakage]], etc.), and network/email context (source/destination addresses, SMTP details, device actions).

| Field | Purpose |
|-------|---------|
| Severity | Prioritizes analyst attention |
| Alert Type | Categorizes threat behavior pattern |
| EventID | Unique identifier for log correlation |
| Source/Destination | Identifies affected systems |
| Device Action | Shows if threat was blocked or allowed |

---

### Filtering & Prioritization

**Analogy**: Like using a metal detector at a beach—you set parameters (search for gold, ignore bottle caps) to surface what matters most from noise.

**Definition**: [[Alert filtering]] lets analysts narrow the alert queue by [[Severity]], [[Alert Type]], or assigned [[Incident Responder]] role. Filtering reduces false positive fatigue by surfacing genuinely suspicious events matching threat profiles.

---

### Case Management & Playbooks

**Analogy**: A playbook is like a restaurant's recipe card—it guides you through exact steps (gather ingredients, prepare sauce, plate) to produce consistent results every time.

**Definition**: When an alert escalates to investigation, the analyst [[Create Case]] to formally document the incident. The [[SIEM]] then launches a context-aware [[Playbook]]—a guided investigation script tailored to the threat type (phishing playbook asks for sender/recipient/attachment info; malware playbook asks for file hash/execution path, etc.). Following the playbook ensures no investigative steps are skipped.

---

### True Positive vs. False Positive Determination

**Analogy**: Like a smoke detector—a true positive is actual fire (malicious activity), a false positive is burnt toast (legitimate activity triggering the rule incorrectly).

**Definition**: [[True Positive]] means the alert correctly identified malicious or policy-violating activity requiring containment. [[False Positive]] means benign user/system behavior incorrectly triggered the detection rule. The analyst's final determination closes the case and feeds back into rule tuning.

---

## Analyst Relevance

**Real scenario**: It's 9 AM and you clock into your SOC shift. The [[Main Channel]] shows 47 new alerts. You immediately filter by **Critical + Malware** to surface the five most urgent cases. You claim the first alert (ransomware detected on a file server) by clicking "Take Ownership"—this locks it to you and moves it to your [[Investigation Channel]]. Now you create a formal case, launch the malware playbook, and start gathering indicators: file hash, lateral movement paths, affected systems. By 11 AM, you've determined it's a **True Positive**, documented the IOCs, and notified the incident response team. The case moves to [[Closed Alerts]], and you've prevented data exfiltration. This is the daily rhythm of SOC work.

---

## Exam Tips

### Question Type 1: Alert Lifecycle & Ownership
- *"An analyst reviews an alert in the Main Channel but must leave before completing analysis. What action prevents duplicate work by another analyst?"* → Taking ownership moves it to the Investigation Channel and locks it to that analyst.
- **Trick**: Candidates confuse "clicking an alert" with "taking ownership"—viewing ≠ claiming. Ownership is intentional.

### Question Type 2: Filtering Strategy
- *"A SOC receives 200 daily alerts. Which filtering approach best focuses analyst effort on high-risk threats?"* → Filter by **Severity (Critical/High) + Alert Type (C2, Ransomware, Data Leakage)** to surface business-critical threats first.
- **Trick**: Filtering by **only severity** is incomplete—low-severity alerts can still indicate breach tactics (e.g., low-severity C2 beacon is still critical threat intel).

### Question Type 3: Case Closure & Documentation
- *"After investigating an alert determined to be benign, the analyst should..."* → Close the alert as **False Positive** with summary notes explaining why the rule triggered on legitimate activity.
- **Trick**: Closing without classification wastes the alert—you lose improvement data for tuning the detection rule.

---

## Common Mistakes

### Mistake 1: Confusing Channel Navigation with Case Resolution

**Wrong**: "I reviewed an alert in the Main Channel, so my work is done."

**Right**: Reviewing ≠ investigating. You must claim ownership (moving to Investigation Channel), create a formal case, execute the playbook, and close with a True/False Positive determination to complete the lifecycle.

**Impact on Exam**: CySA+ tests the full workflow. A question asking "which step comes after taking ownership?" expects "create case" not "close alert." Skipping steps signals incomplete analyst methodology.

---

### Mistake 2: Under-Using Filters in High-Volume Environments

**Wrong**: "I'll just review alerts in order as they appear in the Main Channel."

**Right**: Filtering by severity and threat type ensures critical incidents get attention first. A **Critical ransomware alert** buried behind 30 low-priority brute-force attempts can mean the difference between early containment and full network encryption.

**Impact on Exam**: Scenario-based questions test prioritization judgment. Expect: *"Your SOC receives 300 alerts daily. Which filtering approach prevents alert fatigue while catching active threats?"* The answer rewards targeted filtering, not sequential processing.

---

### Mistake 3: Closing Cases Without Proper Classification

**Wrong**: "I finished the investigation, I'll just click Close Alert without selecting True/False Positive."

**Right**: Always document your determination. Closing as **True Positive** triggers alerting workflows; closing as **False Positive** flags the rule for tuning. Unmarked closures create blind spots.

**Impact on Exam**: The playbook framework expects formal determination. Missing this step suggests you don't understand how SOC findings feed back into detection rule improvement—a core SOC competency.

---

## Related Topics
- [[SIEM]]
- [[Alert Triage]]
- [[Incident Response Playbooks]]
- [[True Positive vs. False Positive]]
- [[Case Management]]
- [[Detection Rule Tuning]]
- [[SOC Workflow]]

---

*Source: CySA+ CS0-003 Study Notes | [[CySA+]] | Rewritten for Mastery*