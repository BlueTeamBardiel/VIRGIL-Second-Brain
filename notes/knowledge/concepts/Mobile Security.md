# Mobile Security

## What it is
Think of a smartphone as a Swiss Army knife you carry everywhere — incredibly useful, but every blade is a potential entry point if left unguarded. Mobile security is the discipline of protecting portable devices (smartphones, tablets, wearables) from threats targeting their hardware, operating systems, apps, and wireless communications.

## Why it matters
In 2023, attackers distributed a malicious Android app disguised as a legitimate 2FA authenticator through third-party app stores; once installed, it exfiltrated SMS messages and banking credentials via a banking trojan. MDM (Mobile Device Management) solutions with app allowlisting would have prevented unapproved apps from running, illustrating why enterprise mobile policy is critical infrastructure, not optional hygiene.

## Key facts
- **MDM vs. MAM**: Mobile Device Management controls the entire device; Mobile Application Management controls only specific apps — MAM is preferred for BYOD because it avoids managing employees' personal data.
- **Sideloading** — installing apps outside official stores — is the primary delivery vector for mobile malware on Android; iOS restricts this except on jailbroken devices.
- **Jailbreaking (iOS) / Rooting (Android)** removes OS-level sandboxing, invalidating the security model and exposing the kernel to privilege escalation attacks.
- **Smishing** (SMS phishing) exploits the higher trust users place in text messages versus email — click-through rates on malicious SMS links are significantly higher than malicious email links.
- The **OWASP Mobile Top 10** highlights insecure data storage as the #1 mobile risk — apps storing credentials in plaintext in SharedPreferences or SQLite databases are routinely harvested after physical device access.

## Related concepts
[[Endpoint Security]] [[Mobile Device Management]] [[BYOD Policy]] [[Application Sandboxing]] [[OWASP Top 10]]