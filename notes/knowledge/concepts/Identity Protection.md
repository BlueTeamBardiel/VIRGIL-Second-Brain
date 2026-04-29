# Identity Protection

## What it is
Think of your digital identity like a master key ring — if someone duplicates even one key, they can open doors you never intended. Identity protection is the set of controls, policies, and technologies designed to ensure that digital identities (user accounts, credentials, certificates) are authentic, confidential, and used only by their rightful owners.

## Why it matters
In 2020, the SolarWinds attack demonstrated how compromised service account credentials allowed attackers to move laterally across networks for months undetected. Had identity protection controls like privileged access management (PAM) and anomalous login detection been enforced, the blast radius would have been dramatically contained.

## Key facts
- **MFA (Multi-Factor Authentication)** is the single most effective control against credential-based attacks, blocking over 99% of automated account takeover attempts according to Microsoft telemetry.
- **Credential stuffing** attacks exploit password reuse — breached credentials from one site are systematically tested against others using automated tools.
- **Zero Trust** architecture treats every identity as untrusted by default, requiring continuous verification regardless of network location.
- **Privileged Identity Management (PIM)** enforces just-in-time access, meaning admin rights are granted only for the duration of a specific task — minimizing standing privilege exposure.
- **Identity and Access Management (IAM)** systems use attributes like role, location, device posture, and time-of-day to make dynamic access decisions — relevant to CySA+ behavioral analytics questions.

## Related concepts
[[Multi-Factor Authentication]] [[Zero Trust Architecture]] [[Privileged Access Management]] [[Credential Stuffing]] [[Identity and Access Management]]