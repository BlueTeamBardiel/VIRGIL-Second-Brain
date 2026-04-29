# Identity Proofing

## What it is
Like a bouncer checking your ID, birth certificate, and calling your mom before letting you into an exclusive club — identity proofing is the process of verifying that a person is who they claim to be *before* issuing credentials. It establishes real-world identity linkage to a digital account, typically during enrollment rather than at each login.

## Why it matters
In 2020, attackers used synthetic identity fraud to steal over $1 billion in COVID-19 relief funds by creating plausible but fake identities that passed weak identity proofing checks. Organizations that required document verification *plus* a live video selfie match (liveness detection) were significantly more resistant to these fraudulent enrollments — demonstrating that the strength of proofing directly determines the integrity of your entire authentication chain.

## Key facts
- NIST SP 800-63A defines three Identity Assurance Levels (IAL1, IAL2, IAL3): IAL1 requires no real-world identity verification; IAL2 requires remote document verification; IAL3 requires in-person or supervised remote proofing
- Identity proofing is distinct from authentication — proofing happens *once* at enrollment; authentication happens *every* login
- Knowledge-Based Authentication (KBA) questions (e.g., "What was your first car?") count as weak identity proofing and are deprecated in NIST guidelines due to data broker exposure
- Liveness detection combats presentation attacks where someone holds up a printed photo or uses a deepfake video during remote proofing
- Biometric binding during proofing (tying a face scan to a government document) creates a strong IAL3-equivalent evidence chain

## Related concepts
[[Authentication Factors]] [[NIST 800-63]] [[Credential Issuance]] [[Synthetic Identity Fraud]] [[Liveness Detection]]