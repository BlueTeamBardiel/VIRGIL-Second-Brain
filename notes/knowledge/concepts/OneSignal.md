# OneSignal

## What it is
Think of it like a postal service that app developers rent instead of building their own mail room — OneSignal is a third-party push notification, email, and SMS delivery platform used by mobile and web apps to send messages to users at scale. Developers integrate it via SDK or API, and OneSignal's infrastructure handles the actual delivery through Apple APNs, Google FCM, and other channels.

## Why it matters
Attackers who compromise an app's OneSignal API key can send malicious push notifications to *every* subscriber of that application — millions of users could receive phishing links or social engineering messages appearing to come from a trusted app. In 2022, researchers found hardcoded OneSignal API keys exposed in public mobile app repositories, enabling full notification takeover. This illustrates the broader supply chain risk of third-party service credentials embedded in client-side code.

## Key facts
- OneSignal API keys embedded in mobile apps (especially Android APKs) can be extracted via reverse engineering tools like `apktool`, exposing the **REST API Key** used to send notifications
- The **REST API Key** (server-side) must be kept secret; the **App ID** (client-side) is public by design — confusing the two is a common developer mistake
- Unauthorized access to OneSignal enables mass phishing campaigns, fake security alerts, or credential harvesting at scale with no malware required
- Classified as a **third-party/supply chain risk** and an **API key exposure** vulnerability under OWASP Mobile Top 10 (M9: Insecure Data Storage)
- Mitigation includes secrets scanning in CI/CD pipelines, rotating exposed keys immediately, and using server-side proxies so keys never touch client code

## Related concepts
[[API Key Exposure]] [[Supply Chain Attack]] [[Push Notification Phishing]] [[Mobile App Reverse Engineering]] [[OWASP Mobile Top 10]]