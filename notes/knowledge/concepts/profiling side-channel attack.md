# profiling side-channel attack

## What it is
Like a safecracker who first practices on an identical safe in their workshop to map every click and resistance before touching the real vault, a profiling side-channel attack uses a **training device** to build a statistical model of how a target leaks physical information — then deploys that model to crack an unknown key on a real device. It is a two-phase attack: an offline profiling phase on a cloned device with known secrets, followed by an online attack phase against the actual target using power traces, electromagnetic emissions, or timing data.

## Why it matters
Template attacks and deep learning-based profiling (e.g., using neural networks trained on power traces) have successfully extracted AES keys from smart cards and hardware security modules in controlled lab settings. This breaks the assumption that physical possession of a device is sufficient protection — an attacker with access to *any* identical device can do the heavy lifting offline, then attack yours quickly with minimal measurements.

## Key facts
- The two phases are **profiling** (characterize leakage on a known device) and **matching/attack** (classify traces from the target device)
- **Template attacks** are the classical profiling method; they model leakage as a multivariate Gaussian distribution per secret key hypothesis
- **Deep learning profiling attacks** (CNNs, MLPs) have broken countermeasures like masking and shuffling that defeated classical methods
- Requires **physical access** to both a training device and the target, making it a targeted, high-sophistication attack
- Primary countermeasures include **masking** (randomizing intermediate values), **hiding** (adding noise/jitter), and **device-specific entropy injection** to invalidate cross-device profiles

## Related concepts
[[power analysis attack]] [[electromagnetic side-channel attack]] [[differential power analysis]] [[hardware security module]] [[timing attack]]