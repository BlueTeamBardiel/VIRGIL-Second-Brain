# Account Lockout

## What it is
Like a bank vault that seals itself after three wrong combinations, forcing a thief to stop guessing — account lockout is a security control that temporarily or permanently disables an account after a defined number of consecutive failed authentication attempts. It directly disrupts brute-force and password-spraying attacks by introducing a hard ceiling on guess attempts.

## Why it matters
In a credential-stuffing attack, adversaries automate thousands of username/password pairs harvested from data breaches. Without lockout policies, they can silently cycle through combinations indefinitely. With a lockout threshold of 5 attempts, each account becomes exponentially harder to compromise — and the noise of mass lockouts alerts defenders that an attack is in progress.

## Key facts
- **Lockout threshold**: Typically set to 3–5 invalid attempts before lockout triggers; too low causes DoS risk against legitimate users, too high reduces protection.
- **Observation window**: The counter resets after a defined time period (e.g., 30 minutes) — failed attempts must occur *within* this window to trigger lockout.
- **Lockout duration**: Can be time-based (e.g., 15–30 minutes) or require manual administrator unlock; indefinite lockout increases helpdesk burden.
- **DoS risk**: Attackers can intentionally trigger lockouts for all accounts in an organization, effectively denying access — this is a **lockout-as-DoS** attack.
- **Account lockout does NOT apply to local administrator accounts by default in Windows** — a separate policy (e.g., RID 500) must be explicitly configured.

## Related concepts
[[Brute Force Attack]] [[Password Spraying]] [[Multi-Factor Authentication]] [[Authentication]] [[Credential Stuffing]]