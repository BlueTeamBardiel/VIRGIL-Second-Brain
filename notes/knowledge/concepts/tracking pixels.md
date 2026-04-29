# tracking pixels

## What it is
Like a tiny invisible thread sewn into an envelope that tugs when someone opens it, a tracking pixel is a 1×1 transparent image embedded in an email or webpage that silently phones home to a remote server the moment it's rendered. Precisely: it's a miniature HTTP request trigger — when a client loads the image, the attacker's server logs the IP address, timestamp, browser/email client, and operating system of the recipient.

## Why it matters
Spear phishing campaigns routinely use tracking pixels to perform reconnaissance *before* launching the real attack — confirming which targets actually opened a lure email, their approximate geolocation via IP, and what mail client they use, allowing attackers to craft a second, precisely tailored payload. Defenders counter this by disabling automatic image loading in email clients and stripping remote images at the mail gateway, which is why modern security policies specifically address this configuration.

## Key facts
- A tracking pixel generates an HTTP GET request to an attacker-controlled server, leaking the victim's IP, User-Agent string, and exact open timestamp
- They are frequently used in **email open tracking**, both by legitimate marketers and malicious actors, making them a dual-use technique
- Blocking or proxying remote image loading (e.g., Google's image proxy in Gmail) neutralizes the IP-leakage risk but not the open-confirmation risk
- On the **CySA+ exam**, tracking pixels appear under passive reconnaissance and data exfiltration techniques — they can also be used to exfiltrate small data payloads via URL query parameters
- Detection strategies include inspecting email headers for remote image URLs pointing to unfamiliar domains and using email security gateways that sandbox or block 1×1 image tags

## Related concepts
[[spear phishing]] [[email header analysis]] [[passive reconnaissance]] [[data exfiltration]] [[user-agent fingerprinting]]