# Mobile Device Deployment Models

## What it is
Think of it like a car lease vs. ownership vs. a rental fleet — who owns the vehicle determines who controls the rules. Mobile device deployment models define *who owns the device* and *what level of corporate control* is enforced over it, ranging from fully company-managed hardware to personal phones accessing work email.

## Why it matters
In 2020, attackers compromised a financial firm by targeting an employee's personal phone enrolled in a BYOD program — because personal devices lacked enforced disk encryption and MDM controls, sensitive email attachments were recoverable after the phone was sold. A stricter COPE or COBO model would have enforced encryption and remote wipe capabilities, preventing the breach entirely.

## Key facts
- **BYOD (Bring Your Own Device):** Employee owns the device; highest privacy, lowest corporate control; greatest attack surface risk
- **COPE (Corporate-Owned, Personally Enabled):** Company owns the device but allows personal use; balances control and usability; MDM can enforce full-disk encryption and app whitelisting
- **COBO (Corporate-Owned, Business Only):** Maximum lockdown; personal use prohibited; common in high-security environments (finance, defense)
- **CYOD (Choose Your Own Device):** Employee selects from an approved hardware list; company owns it; reduces compatibility issues while maintaining control
- **VDI (Virtual Desktop Infrastructure) on mobile:** App/data never lives on the device itself — it streams from a server, making device theft largely irrelevant to data confidentiality

## Related concepts
[[Mobile Device Management (MDM)]] [[Containerization]] [[Endpoint Security]]