# COPE

## What it is
Like a company car you're allowed to drive for personal errands — the organization owns the vehicle but grants you personal use within defined limits. **Corporate-Owned, Personally Enabled (COPE)** is a mobile device management strategy where the organization purchases and owns the device but permits employees to use it for personal activities alongside work functions.

## Why it matters
A COPE deployment at a healthcare firm gave employees personal app access on company iPhones. An employee installed a malicious third-party app that exfiltrated cached VPN credentials, compromising the corporate network. Because the MDM solution had full device control (not just a containerized work profile), security could remotely wipe the entire device and audit all installed applications — something impossible under a BYOD model.

## Key facts
- The **organization retains full ownership and control**, enabling complete remote wipe, policy enforcement, and app allowlisting/blocklisting across the entire device
- Provides **stronger security posture than BYOD** because IT selects, provisions, and hardens the device from the start — no unknown pre-existing malware or configurations
- **Privacy tension exists**: employees accept reduced personal privacy since corporate MDM can monitor the full device, not just a work container
- On Security+/CySA+, COPE contrasts directly with **BYOD** (user-owned), **CYOD** (Choose Your Own Device — user picks from approved list), and **COBO** (Corporate-Owned, Business Only — zero personal use permitted)
- **Data loss risk remains higher than COBO** because personal apps can create data leakage pathways that stricter business-only policies eliminate

## Related concepts
[[BYOD]] [[Mobile Device Management]] [[CYOD]]