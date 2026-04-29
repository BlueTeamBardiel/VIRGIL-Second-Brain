# IMSI Catcher

## What it is
Imagine a fake postal sorting office that tricks every mail carrier in the neighborhood into handing over their packages — then secretly reads them before passing them along. An IMSI Catcher (also called a Stingray) is a rogue cellular base station that impersonates a legitimate cell tower, forcing nearby mobile devices to connect to it. Once connected, it captures the device's IMSI (International Mobile Subscriber Identity) — a unique 15-digit identifier — and can intercept calls, texts, and data in real time.

## Why it matters
Law enforcement agencies have deployed Stingray devices to track suspects' physical locations without warrants by logging which cell towers a target's phone pings — a practice challenged extensively in U.S. courts. Attackers with commercial-grade IMSI catchers (available for under $1,000 using software-defined radios) can perform man-in-the-middle attacks on 2G connections by forcing a downgrade from LTE, stripping encryption entirely and capturing plaintext SMS messages including OTP authentication codes.

## Key facts
- The IMSI is burned into the SIM card and transmitted during network registration — capturing it enables persistent device tracking across locations
- 2G (GSM) is the primary vulnerability because it uses one-way authentication (phone authenticates to tower, but tower does NOT authenticate to phone)
- 4G/LTE and 5G implement mutual authentication, making passive IMSI capture significantly harder — but protocol downgrade attacks remain viable
- IMSI catchers are classified as "cell-site simulators" and their use by U.S. agencies is governed under the Electronic Communications Privacy Act
- Detection methods include apps like AIMSICD, monitoring for unexpected signal drops, or sudden 2G fallback without coverage justification

## Related concepts
[[Man-in-the-Middle Attack]] [[Downgrade Attack]] [[Rogue Access Point]] [[SIM Cloning]] [[Protocol Authentication]]