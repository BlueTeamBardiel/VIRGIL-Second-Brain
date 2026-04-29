# TryHackMe Cybersecurity 101

A foundational learning path on TryHackMe covering core cybersecurity concepts and practical hands‑on exercises. This path provides structured training for beginners entering the cybersecurity field.

## Overview

Cybersecurity 101 is designed as an introductory course that combines theoretical knowledge with practical, interactive labs. The path typically covers fundamental security principles, defensive techniques, and common attack vectors.

## Key Topics

- Core security concepts and terminology  
- Network security fundamentals  
- System hardening and defense  
- Common vulnerabilities and exploits  
- Practical hands‑on labs and challenges  

## Learning Format

TryHackMe uses interactive, browser‑based [[virtual machines]] and labs where learners can apply concepts in real‑world scenarios without requiring local setup.

## Related Resources

- [[CCNA]] – networking foundation  
- [[CVE]] databases – vulnerability research  

## Tags

#tryhackme #cybersecurity‑101 #learning‑path #beginner #hands‑on‑labs  

---

## What Is It? (Feynman Version)

Imagine a workshop where you learn to fix a car without ever having to leave the garage. TryHackMe Cybersecurity 101 is that workshop for cybersecurity: it teaches how to spot and patch digital threats through guided lessons and live experiments in isolated virtual environments.

## Why Does It Exist?

Before this platform, newcomers had to rummage through scattered tutorials, install messy tools, and risk breaking their own machines. TryHackMe offers a ready‑made, safe sandbox that lets learners focus on concepts instead of setup, reducing the barrier to entry and preventing accidental damage.

## How It Works (Under The Hood)

1. **Room creation** – The platform spins up a cloud‑based VM for each lab.  
2. **SSH into the box** – You connect with a browser‑based terminal or SSH client.  
3. **Challenge prompt** – A goal is presented (e.g., “capture the flag”).  
4. **Tool set** – The VM comes pre‑loaded with scanners, exploits, and a local web server.  
5. **Interaction** – You run commands, manipulate services, and observe the results in real time.  
6. **Progress tracking** – The platform records successful steps and awards points.  
7. **Feedback loop** – Upon completion, hints and explanations are revealed to reinforce learning.

## What Breaks When It Goes Wrong?

- **Network isolation fails** – An attacker could reach other students’ VMs or external services.  
- **VM corruption** – Bugs in the lab can lock a student out or cause loss of progress.  
- **Platform outage** – If the hosting service goes down, lessons stall and data is temporarily inaccessible.  
- **Misconfigured permissions** – Poorly set file rights can expose sensitive data or give unintended privileges.

The first to notice is usually the learner stuck in a lab, followed by the instructor or platform staff addressing the outage or security breach.

## Exam Angle

| Exam | Focus | Common Traps | Mnemonic |
|------|-------|--------------|----------|
| Security+ | Threat models, defensive controls, common attack vectors | Mixing up “hardening” (system changes) with “mitigation” (policy controls) | *C*onfidence *O*f *S*ecurity = *C*onceptual *O*versight *S*urvival |
| CySA+ | Vulnerability management, incident response, security architecture | Confusing “penetration testing” (active attack) with “vulnerability scanning” (passive detection) | *P*ractice *S*aves *C*haracters, *A*lways *C*heck |
| CCNA | Network fundamentals, OSI model, routing | Treating “ACL” as “allow” instead of “access control list” | *A*ccess *C*ontrol *L*ist = *A*llow or *C*lose *L*imits |

- **Key terms**:  
  - *Defense in depth* – layers of protection, not a single solution.  
  - *Zero‑day* – a vulnerability with no patch.  
  - *Patching* – updating software to fix known issues.

These distinctions often appear in exam questions, so clarify each before studying.