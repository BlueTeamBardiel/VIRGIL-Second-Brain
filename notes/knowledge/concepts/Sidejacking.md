# Sidejacking

## What it is
Imagine someone at a coffee shop snatching the name tag off your jacket after you've already shown your ID at the door — they skip authentication entirely and just *become* you. Sidejacking (also called session hijacking) is the theft of a valid session cookie transmitted over an unencrypted network, allowing an attacker to impersonate an authenticated user without ever knowing their password. The attacker captures the cookie via packet sniffing and replays it to the target web application.

## Why it matters
In 2010, the Firefox extension Firesheep made sidejacking trivially easy on open Wi-Fi networks — anyone could click a button and hijack Facebook or Twitter sessions of nearby users, because those sites authenticated over HTTPS but then dropped back to HTTP for session traffic. This single tool forced major platforms to implement HTTPS everywhere and demonstrated that partial encryption is effectively no encryption from a session-security standpoint.

## Key facts
- Sidejacking specifically targets **session cookies after login**, bypassing the need to steal credentials
- It requires the attacker to be on the **same network segment** (or use ARP poisoning/MITM to get there)
- **Wireshark** and similar sniffers can capture plaintext cookies on unencrypted HTTP traffic
- Mitigations include: **HTTPS everywhere**, `Secure` cookie flag (prevents cookie transmission over HTTP), and `HttpOnly` flag (prevents JavaScript access)
- The `Secure` flag is the **direct countermeasure** — it forces cookies to only transmit over TLS-encrypted connections
- Session tokens should be **invalidated server-side** upon logout to limit the attack window

## Related concepts
[[Session Hijacking]] [[Cookie Theft]] [[Man-in-the-Middle Attack]] [[Packet Sniffing]] [[HTTPS]]