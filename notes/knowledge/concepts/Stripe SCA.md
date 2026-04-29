# Stripe SCA

## What it is
Think of it like a bouncer who doesn't just check your ID, but also calls you on your phone to confirm you're really you — Strong Customer Authentication (SCA) is a regulatory requirement under Europe's PSD2 directive that forces payment processors like Stripe to verify online transactions using at least two independent factors. Stripe implements SCA by dynamically triggering 3D Secure 2 (3DS2) challenges when a cardholder attempts a payment that crosses risk thresholds defined by the issuing bank.

## Why it matters
Before SCA enforcement, attackers who harvested card numbers via e-skimming (Magecart attacks) could immediately monetize stolen credentials through card-not-present fraud, since no second factor was required. With SCA enforced, a stolen card number alone is insufficient — the attacker also needs access to the cardholder's phone or biometric, which dramatically collapses the window for fraud exploitation.

## Key facts
- SCA requires **two of three** factors: something you know (password/PIN), something you have (phone/token), something you are (biometric)
- Stripe uses **3DS2** to pass contextual risk signals (device fingerprint, transaction history) to the issuing bank, reducing unnecessary friction for low-risk transactions
- **Exemptions exist**: transactions under €30, merchant-initiated payments, and low-fraud-rate merchants can bypass SCA challenges
- Non-compliance with PSD2/SCA can result in **payment declines at the issuer level**, not just regulatory fines — broken checkout flows are the direct penalty
- SCA applies to **EEA (European Economic Area)** transactions; US merchants are unaffected by PSD2 but may voluntarily implement 3DS2 for fraud reduction

## Related concepts
[[Multi-Factor Authentication]] [[3D Secure (3DS2)]] [[PSD2 Compliance]] [[Card-Not-Present Fraud]] [[Magecart Attack]]