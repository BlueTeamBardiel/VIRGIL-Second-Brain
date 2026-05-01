---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 023
source: rewritten
---

# Impersonation
**Attackers fabricate false identities to manipulate trust and extract sensitive information from targets.**

---

## Overview
[[Impersonation]] is a [[social engineering]] attack where a threat actor assumes a fake identity to deceive victims into believing they are someone trustworthy. This technique matters for Security+ because it's one of the most effective [[human-based attack vectors]], bypassing technical controls entirely by exploiting our natural tendency to trust authority figures and familiar organizations. Understanding impersonation helps you recognize when someone is misrepresenting themselves and know when to verify identities independently.

---

## Key Concepts

### Identity Falsification
**Analogy**: Imagine someone wearing a fake police uniform to convince you they have authority—they look the part, but they're just a criminal in a costume.

**Definition**: The act of claiming to be someone (or something) you're not to gain credibility or access. The attacker creates a false persona and maintains it through the conversation.

Examples: Claiming to be from [[Microsoft]] support, the IRS, a bank, your company's [[IT Help Desk]], or a corporate executive.

---

### Authority Exploitation
**Analogy**: If a stranger in a suit and tie tells you to do something, you're more likely to comply than if a random person does—attackers weaponize this psychological bias.

**Definition**: Using impersonation to leverage the assumed authority of legitimate institutions or high-ranking positions to bypass critical thinking.

| Authority Figure | Trust Level Exploited | Typical Request |
|---|---|---|
| [[IT Support]]/Help Desk | Internal legitimacy | Credentials, remote access |
| Government Agency (IRS, Treasury) | Fear-based compliance | Payment, personal data |
| Banking Institution | Financial trust | Account verification, PII |
| Corporate Executive | Organizational hierarchy | Wire transfers, data access |

---

### Context Manipulation
**Analogy**: A scammer tells you a detailed story about a problem with your computer so convincing that you stop questioning whether they actually work for the manufacturer.

**Definition**: Building a fictional scenario with specific details to make the impersonation more believable and lower the target's defenses.

Related: [[Pretext]], [[Social Engineering]]

---

## Exam Tips

### Question Type 1: Identifying Impersonation Scenarios
- *"A caller claims to be from your company's finance department and asks you to verify your password for a system upgrade. What attack is occurring?"* → **Impersonation** combined with [[Phishing]]/[[Pretexting]]. The answer focuses on the false identity claim.
- *"You receive a voicemail from 'Microsoft Support' warning of critical security issues on your computer."* → This is impersonation because Microsoft doesn't initiate unsolicited support calls.
- **Trick**: The exam may describe impersonation alongside other attacks ([[Phishing]], [[Vishing]]). Remember: impersonation is *specifically about false identity*; [[Vishing]] is the voice channel used to deliver it.

### Question Type 2: Defensive Measures
- *"How should you respond to an unexpected call claiming to be from your IT department?"* → Verify independently using known contact information (not numbers provided by the caller), never provide credentials verbally, request a callback.
- **Trick**: Watch for answers that say "always trust employees"—the correct answer involves verification protocols.

---

## Common Mistakes

### Mistake 1: Confusing Impersonation with Phishing
**Wrong**: "Impersonation and phishing are the same thing."
**Right**: [[Impersonation]] is the *tactic* of assuming a false identity; [[Phishing]] is the *attack method* (usually email-based). Impersonation can occur via phone ([[Vishing]]), email, in-person, or text ([[Smishing]]). Phishing is email-specific.
**Impact on Exam**: A question asking "what's the broad category of attack where someone pretends to be a trusted entity?" wants [[Impersonation]] as the answer. A question about email attacks mimicking banks wants [[Phishing]].

### Mistake 2: Assuming Impersonation Only Comes from Strangers
**Wrong**: "I can trust callers who know internal company details or use our official phone number."
**Right**: Threat actors gather organizational intelligence before calling; they may even spoof caller ID using [[VOIP]] technology. Internal knowledge doesn't guarantee legitimacy.
**Impact on Exam**: Expect questions where the attacker demonstrates knowledge of company structure or uses spoofed numbers. The correct answer is still to verify independently.

### Mistake 3: Overlooking the Psychological Element
**Wrong**: "Impersonation works because people aren't paying attention."
**Right**: Impersonation works because it leverages [[authority bias]], [[urgency]], and [[reciprocity]]—psychological principles that affect even security-aware people. The best defense is policy (always verify), not just vigilance.
**Impact on Exam**: Security+ emphasizes that technical controls alone don't stop impersonation; you need awareness training and verification procedures.

---

## Related Topics
- [[Pretexting]] — Building a fabricated scenario (often the *method* through which impersonation occurs)
- [[Vishing]] — Voice-based impersonation attacks
- [[Phishing]] — Email-based social engineering (may include impersonation)
- [[Smishing]] — SMS-based impersonation
- [[Social Engineering]] — Broad category encompassing impersonation
- [[VOIP Spoofing]] — Falsifying caller ID to support impersonation
- [[Authority Bias]] — Psychological weakness impersonation exploits
- [[Verification Procedures]] — The defensive control against impersonation
- [[Security Awareness Training]] — Teaches recognition of impersonation tactics

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*