# Man-in-the-Browser

## What it is
Imagine a corrupt court stenographer who transcribes your exact words to the judge but secretly rewrites the official record — that's Man-in-the-Browser (MitB). It's a Trojan-based attack where malware injects itself into a web browser, intercepting and manipulating transactions in real-time *after* the secure connection is established, making the user see one thing while the server receives something entirely different.

## Why it matters
In 2009–2010, the Zeus banking Trojan used MitB techniques to silently redirect wire transfers — a victim would initiate a $500 payment, see a confirmation for $500, but the bank received instructions to transfer $50,000 to a mule account. This attack bypasses SSL/TLS and even two-factor authentication because the malware operates *inside* the trusted browser session, after all security checks have passed.

## Key facts
- MitB operates at the **application layer inside the browser**, making network-layer defenses like TLS, VPNs, and firewalls completely ineffective against it
- Unlike Man-in-the-Middle (MitM), MitB **requires malware already installed on the victim's machine** — the attacker doesn't need to intercept network traffic
- Common infection vectors include **malicious browser extensions, BHOs (Browser Helper Objects)**, and drive-by downloads
- MitB can defeat **out-of-band OTP authentication** because the malware waits for the user to authenticate and then replays the session
- Detection relies on **behavioral analysis and transaction verification** (e.g., banks sending SMS confirmation of exact transfer details) rather than encryption

## Related concepts
[[Man-in-the-Middle Attack]] [[Trojan Horse]] [[Session Hijacking]] [[Credential Harvesting]] [[Drive-By Download]]