# tracking pixel

## What it is
Like a tiny spy hiding in plain sight inside a letter, a tracking pixel is a 1×1 transparent image embedded in an email or webpage that silently phones home when rendered. When the recipient's client fetches the image, it sends an HTTP request to the attacker's (or marketer's) server, leaking metadata including IP address, user-agent, timestamp, and email client.

## Why it matters
In phishing reconnaissance, an attacker sends a spoofed email containing a tracking pixel hosted on their server. When the target opens the email, the attacker harvests the victim's IP address, geographic location, email client version, and operating time — intelligence used to craft a more convincing follow-up spear-phishing attack or to confirm the email account is active before launching further exploitation.

## Key facts
- The HTTP GET request triggered by a tracking pixel can reveal: source IP, operating system, browser/mail client version, and precise open timestamp.
- Tracking pixels bypass traditional link-click analysis because no user interaction beyond *opening* the message is required.
- Disabling automatic image loading in email clients (a hardening best practice) is the primary defense against tracking pixel reconnaissance.
- Threat actors use tracking pixels as a beaconing mechanism — confirming a live target before expending resources on a full attack campaign.
- Privacy regulations (GDPR, CCPA) require consent for marketing tracking pixels, but malicious use has no such constraint — detection depends on inspecting raw email headers and HTML source for `<img>` tags pointing to external domains.

## Related concepts
[[spear phishing]] [[open redirect]] [[email header analysis]] [[beaconing]] [[OSINT]]