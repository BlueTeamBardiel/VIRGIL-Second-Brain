# Risk-Based Authentication

## What it is
Think of it like a bouncer who waves in regulars with a nod, but pulls aside strangers in hoodies at 2 AM for extra scrutiny — the level of verification scales with how suspicious the situation looks. Risk-Based Authentication (RBA) is an adaptive security mechanism that dynamically adjusts authentication requirements based on contextual signals (location, device, time, behavior) rather than applying a uniform challenge to every login attempt.

## Why it matters
In 2020, attackers conducting credential-stuffing attacks against financial institutions were often stopped not by password strength, but by RBA systems flagging logins from unfamiliar countries or IPs associated with Tor exit nodes — triggering step-up MFA challenges that the stolen credentials alone couldn't satisfy. This illustrates how RBA creates friction precisely where the threat is highest without burdening legitimate users.

## Key facts
- RBA evaluates signals such as **geolocation, IP reputation, device fingerprint, login time, and user behavior baseline** to calculate a real-time risk score
- A **low-risk score** may allow login with just a password; a **high-risk score** triggers step-up authentication (SMS OTP, push notification, biometric)
- RBA is distinct from standard MFA — MFA is static (always required), RBA is **conditional and adaptive**
- RBA can be defeated by **session hijacking after authentication**, since risk is evaluated at login time, not continuously
- Continuous authentication extends RBA principles beyond login by monitoring behavior (typing cadence, mouse movement) throughout an active session — sometimes called **Continuous Adaptive Risk and Trust Assessment (CARTA)**

## Related concepts
[[Multi-Factor Authentication]] [[Behavioral Analytics]] [[Continuous Authentication]] [[Credential Stuffing]] [[Zero Trust Architecture]]