# biometrics

## What it is
Like a bouncer who memorizes your face instead of checking your ID card, biometrics authenticates identity using physical or behavioral characteristics that are inherently *you* rather than something you carry or know. Precisely defined, biometrics is an authentication method that measures unique biological traits — fingerprints, iris patterns, voiceprints, or gait — to verify identity. Unlike passwords, these factors cannot be changed if compromised.

## Why it matters
In 2015, the U.S. Office of Personnel Management breach exposed fingerprint records of 5.6 million federal employees — a catastrophic consequence of storing biometric data centrally, since unlike passwords, you cannot issue someone new fingerprints. Attackers can also defeat fingerprint scanners using lifted latent prints cast in gelatin (a "gummy finger" attack), demonstrating that biometrics alone is not infallible and must be layered with liveness detection.

## Key facts
- **Three error rates matter**: False Acceptance Rate (FAR) — letting the wrong person in; False Rejection Rate (FRR) — locking out the right person; Crossover Error Rate (CER/EER) — where FAR equals FRR, used to compare system accuracy (lower CER = better system)
- **Type 3 authentication factor**: "something you are," distinct from Type 1 (something you know) and Type 2 (something you have)
- **Biometric data must be protected like credentials**: GDPR and CCPA classify biometric data as sensitive personal information requiring explicit consent
- **Liveness detection** (anti-spoofing) checks for pulse, eye movement, or 3D depth to defeat photos, replicas, or deepfake attacks
- **Behavioral biometrics** (keystroke dynamics, mouse movement) can authenticate continuously throughout a session, not just at login

## Related concepts
[[multifactor authentication]] [[authentication factors]] [[false acceptance rate]] [[identity and access management]] [[zero trust]]