# OneSignal - Web Push Notifications

## What it is
Like a megaphone handed to a website that can shout at you even after you've left the room, OneSignal is a third-party push notification platform that lets websites deliver browser-based messages to users who've granted permission. It operates via the Web Push API, using service workers to receive notifications even when the originating site isn't actively open in the browser.

## Why it matters
Attackers abuse OneSignal-style push notification infrastructure as a social engineering vector — malicious sites trick users into clicking "Allow" on the browser permission prompt (often disguised as a CAPTCHA or age verification), then bombard them with phishing links, fake virus alerts, or malvertising. This is a real delivery mechanism for tech-support scams and credential harvesting pages, making browser permission management a legitimate hardening concern.

## Key facts
- OneSignal uses **service workers** registered in the browser to receive push messages even when the tab is closed — this persistence makes it more powerful and riskier than standard pop-ups
- Push notification **permissions are origin-scoped** — revoking them requires manually adjusting browser site settings or clearing service worker registrations
- Attackers use **subscription abuse**: once permission is granted, they can push unlimited notifications until the user explicitly blocks them
- The **Web Push protocol (RFC 8030)** underpins these notifications — messages route through browser vendor servers (Google FCM, Mozilla Autopush), creating a third-party dependency in the delivery chain
- From a blue-team perspective, **Content Security Policy (CSP)** does not block push notifications; mitigation requires browser-level controls or endpoint security tools that flag rogue service worker registrations

## Related concepts
[[Social Engineering]] [[Service Workers]] [[Malvertising]] [[Browser Security]] [[Content Security Policy]]