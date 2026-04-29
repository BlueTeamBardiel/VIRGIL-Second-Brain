# Push Notification

## What it is
Like a doorbell that anyone who knows your address can ring — push notifications are server-initiated messages delivered to a device without the user actively requesting them. Technically, they rely on a broker service (Apple APNs, Google FCM) that maintains a persistent connection to the device and forwards messages from registered app servers to the client.

## Why it matters
Attackers abuse push notifications in **MFA fatigue attacks** (also called push bombing): they repeatedly trigger MFA approval requests to a victim's phone until the exhausted user taps "Approve" just to make the alerts stop. This technique was used in the 2022 Uber breach, where an attacker bombarded an employee with push MFA requests, then convinced them via WhatsApp to accept one, bypassing multi-factor authentication entirely.

## Key facts
- Push notifications are delivered via **token-based addressing** — each app installation receives a unique device token that the notification broker uses for routing.
- **APNs (Apple Push Notification Service)** and **Google FCM (Firebase Cloud Messaging)** are the dominant broker services; both use TLS to encrypt the notification payload in transit.
- MFA push fatigue is mitigated by **number matching** (user must enter a code displayed on the login screen) and **context-aware MFA** (showing IP/location in the approval prompt).
- Malicious apps can register for push notifications to maintain **persistent C2 channels**, since push traffic often bypasses firewalls that block inbound connections.
- Security+ and CySA+ expect you to recognize push bombing as a **social engineering** technique targeting MFA, not a cryptographic or network-layer bypass.

## Related concepts
[[Multi-Factor Authentication]] [[MFA Fatigue Attack]] [[Social Engineering]] [[Mobile Device Management]] [[Command and Control]]