# RMP

## What it is
Like a velvet rope policy at a club that decides which guests can enter which rooms — Read-Map-Protect (RMP) refers to **Reference Monitor Policy**, the foundational access control concept defining how a system mediates every subject-to-object access request. It is the abstract machine that enforces security policy by sitting between all subjects (users, processes) and objects (files, memory, devices), ensuring no access occurs without explicit authorization.

## Why it matters
In a real-world scenario, a compromised web server process attempts to read `/etc/shadow` to harvest password hashes. The Reference Monitor Policy — implemented through Linux's DAC permissions and MAC labels (SELinux) — intercepts this request, checks the process's security context against the policy rules, and denies access even if the process runs as a service account. Without RMP enforcement, privilege escalation attacks would trivially succeed the moment any process is compromised.

## Key facts
- **Three properties** a Reference Monitor must satisfy: it must be **tamperproof**, **always invoked** (non-bypassable), and **small enough to be verifiable** (this is the "reference monitor concept" from the Anderson Report, 1972)
- The **Security Kernel** is the hardware/software implementation of the reference monitor; the **Trusted Computing Base (TCB)** includes the security kernel plus all protection-critical components
- RMP enforcement underpins both **DAC** (owner-defined rules) and **MAC** (system-enforced labels like Bell-LaPadula)
- Failure to enforce "always invoked" creates **TOCTTOU (Time-of-Check to Time-of-Use)** vulnerabilities — a classic bypass technique
- The **Common Criteria** evaluation framework tests whether a system's security target correctly implements reference monitor properties

## Related concepts
[[Trusted Computing Base]] [[Bell-LaPadula Model]] [[Mandatory Access Control]] [[TOCTTOU]] [[Security Kernel]]