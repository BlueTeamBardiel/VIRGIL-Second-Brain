---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 099
source: rewritten
---

# Password Security
**Strong passwords are your first line of defense against attackers attempting to gain unauthorized access to systems and accounts.**

---

## Overview
Password strength directly impacts your organization's vulnerability to [[Attack Vectors|common attack methods]] like [[Brute Force Attack|brute force attacks]] and [[Password Spraying|password spraying]]. Understanding password construction and lifecycle management is essential for the Security+ exam because weak credential policies can compromise even well-defended infrastructure. This foundation protects both individual accounts and enterprise security posture.

---

## Key Concepts

### Password Entropy
**Analogy**: Think of entropy like mixing paint colors—the more different colors you add and blend, the harder it becomes to guess the exact shade someone created. Similarly, the more unpredictable elements in your password, the harder it is to guess.

**Definition**: [[Entropy]] measures how random and unpredictable a [[Password|password]] is, making it resistant to being decoded or guessed through systematic attacks.

**Characteristics of High-Entropy Passwords**:
- Mix of uppercase and lowercase letters
- Inclusion of numbers
- Special characters (@, #, $, %, etc.)
- Sufficient length to prevent quick computation

---

### Password Composition Requirements
**Analogy**: Building a password is like constructing a fence—single materials are weak, but combining wood, metal, and concrete makes it much harder to breach.

**Definition**: [[Password Composition]] refers to the mandatory character types and structure rules enforced by systems to ensure passwords cannot be easily guessed or cracked.

| Composition Element | Purpose | Example |
|---|---|---|
| Uppercase Letters | Increases character set size | A-Z |
| Lowercase Letters | Adds variety within alphabet | a-z |
| Numbers | Expands possible combinations | 0-9 |
| Special Characters | Maximum entropy increase | !@#$%^&* |
| Minimum Length | Time cost for brute force | 8+ characters recommended |

**Why Avoid**:
- Dictionary words alone (vulnerable to [[Dictionary Attack|dictionary attacks]])
- Sequential patterns (12345, qwerty)
- Personal information (birthdates, names)
- Obvious substitutions (P@ssw0rd)

---

### Password Length Requirements
**Analogy**: A longer fence is harder to climb over than a short one—the same applies to passwords and computational time needed to crack them.

**Definition**: [[Password Length]] policies establish minimum character counts that make [[Brute Force Attack|brute force attacks]] computationally expensive or impractical.

**Modern Standards**:
- Legacy standard: 8 characters minimum
- Current best practice: 12-16 characters
- Trending upward: 16+ characters as processing power increases
- Passphrase approach: 4-6 random words (higher entropy, easier to remember)

**Why Length Matters**: Each additional character exponentially increases the time required to crack a password through brute force methods.

---

### Password Expiration and Age
**Analogy**: Like rotating security guards on shifts, regularly changing passwords reduces the window an attacker has to use a compromised credential.

**Definition**: [[Password Age|Password age]] and [[Password Expiration|expiration policies]] force users to create new credentials at regular intervals, limiting exposure from compromised passwords.

**Common Expiration Cycles**:
- 30-day rotation (aggressive, user-intensive)
- 60-day rotation (balanced approach)
- 90-day rotation (traditional standard)
- Event-based (after breach or suspected compromise)

**Expiration Enforcement**:
- System locks account access when password expires
- Warning notifications appear 7-14 days before deadline
- User must authenticate with new password to regain access

---

### Password History
**Analogy**: Keeping a record of previous locks prevents someone from simply re-installing an old, compromised lock.

**Definition**: [[Password History]] is a security mechanism that prevents users from reusing previous passwords when they're forced to change credentials.

**Implementation Details**:
- Typical enforcement: Cannot reuse last 5-24 passwords
- Duration-based: Cannot reuse passwords from past 12 months
- Technical storage: Hashed versions kept in directory

**Purpose**: Prevents attackers with old credential dumps from simply waiting for password resets and reusing compromised passwords.

---

## Exam Tips

### Question Type 1: Password Composition and Strength
- *"Your organization requires passwords with uppercase, lowercase, numbers, and special characters with a 12-character minimum. What security principle does this primarily address?"* → [[Entropy]] and defense against [[Dictionary Attack|dictionary attacks]] and [[Brute Force Attack|brute force attacks]]
- **Trick**: Don't confuse password strength requirements with authentication factors—complexity ≠ [[Multi-Factor Authentication|MFA]]

### Question Type 2: Password Expiration Scenarios
- *"A user's password expires in 30 days. What happens if they don't change it before the deadline?"* → Account lockout until new password is created
- **Trick**: Distinguish between password aging (time passed) and password expiration (enforcement action)—these are related but different concepts

### Question Type 3: Password History Policies
- *"Why would an organization prevent password reuse for the last 10 passwords?"* → Mitigates risk from compromised credential dumps where attackers attempt old passwords
- **Trick**: Password history doesn't prevent weak passwords—it prevents password repetition specifically

---

## Common Mistakes

### Mistake 1: Confusing Entropy with Length
**Wrong**: "A 20-character password of all lowercase letters is harder to crack than an 8-character password with mixed case, numbers, and symbols."
**Right**: An 8-character mixed-composition password has higher entropy than a 20-character lowercase-only password because character set diversity matters more than length alone.
**Impact on Exam**: You'll face questions requiring you to evaluate password strength—entropy comes from *variety*, not just *quantity*.

### Mistake 2: Misunderstanding Password Expiration Purpose
**Wrong**: "Password expiration prevents attackers from guessing your password in the first place."
**Right**: Password expiration limits the window of opportunity if a password has already been compromised, forcing attackers to re-compromise credentials.
**Impact on Exam**: Security+ distinguishes between *prevention* controls (complexity, composition) and *limitation* controls (expiration, history)—this is tested explicitly.

### Mistake 3: Treating Password History as a Complexity Requirement
**Wrong**: "Password history forces users to create increasingly complex passwords over time."
**Right**: Password history only prevents *repetition*—it doesn't require passwords to be more complex, just different from previous ones.
**Impact on Exam**: Scenario-based questions test whether you know which policy addresses which threat—this distinction is critical for the exam.

### Mistake 4: Overestimating Passphrase Entropy
**Wrong**: "A passphrase like 'correct-horse-battery-staple' is weaker than an 8-character complex password."
**Right**: Passphrases can have equal or greater entropy than shorter complex passwords while remaining memorable—they're a valid modern approach.
**Impact on Exam**: Security+ increasingly recognizes passphrases as legitimate high-entropy alternatives; don't assume short = stronger.

---

## Related Topics
- [[Brute Force Attack]]
- [[Dictionary Attack]]
- [[Password Spraying]]
- [[Multi-Factor Authentication]]
- [[Authentication Methods]]
- [[Account Lockout Policy]]
- [[Attack Vectors]]
- [[Credential Management]]
- [[Access Control]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*