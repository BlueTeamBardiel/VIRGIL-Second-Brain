# TOTP

## What it is
Imagine a lighthouse that flashes a unique pattern every 30 seconds — anyone who knows the timing algorithm and the secret seed can predict the next flash, but only *right now* matters. TOTP (Time-based One-Time Password) is an algorithm (RFC 6238) that generates a short-lived numeric code by combining a shared secret key with the current Unix timestamp, producing a password valid only within a narrow time window. It extends HMAC-based OTP (HOTP) by replacing an event counter with time as the moving factor.

## Why it matters
In 2022, Twilio suffered a phishing attack where attackers tricked employees into surrendering both passwords *and* live TOTP codes via a fake login page, then immediately replayed those codes before the 30-second window expired. This illustrates that TOTP defeats credential stuffing and offline brute-force, but remains vulnerable to real-time phishing — a critical nuance for defenders architecting MFA strategies.

## Key facts
- TOTP codes are generated using `HMAC-SHA1(secret, floor(time / 30))`, producing a 6–8 digit code valid for a ~30-second time step
- Shared secret is typically provisioned via a QR code encoding a `otpauth://` URI during setup — this provisioning moment is a high-value attack surface
- Authenticator apps (Google Authenticator, Authy) and the server both independently compute the same code — no network communication required at verification time
- Servers typically accept codes from one or two adjacent time steps to account for clock drift (skew tolerance)
- TOTP satisfies the "something you have" MFA factor; it does **not** protect against real-time adversary-in-the-middle (AiTM) attacks or SIM-swap if used via SMS fallback

## Related concepts
[[HOTP]] [[Multi-Factor Authentication]] [[Phishing-Resistant MFA]] [[HMAC]] [[Authenticator Apps]]