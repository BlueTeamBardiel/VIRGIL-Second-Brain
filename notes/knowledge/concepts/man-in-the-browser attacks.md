# man-in-the-browser attacks

## What it is
Imagine a corrupt bank teller who lets you sign a legitimate withdrawal slip, then secretly rewrites the amount and account number before sending it to the vault — that's a man-in-the-browser attack. A malicious browser extension or Trojan injects itself into the browser process, intercepting and manipulating web transactions *after* the user authenticates but *before* the data leaves the browser. The user sees a legitimate confirmation screen while the attacker has already altered the actual request.

## Why it matters
The Zeus banking Trojan used this technique extensively to silently modify online banking transfers — victims would see their intended payment of $500 to their landlord while Zeus redirected thousands of dollars to mule accounts in real time. Even multi-factor authentication couldn't stop it because the malware operated *inside* the authenticated session, making the transaction look legitimate to the bank's servers.

## Key facts
- Operates at the **application layer inside the browser**, making network-level SSL/TLS inspection useless — the attack happens before encryption
- Differs from man-in-the-middle: **MitB requires malware on the endpoint**; no network interception position is needed
- Commonly delivered via **Trojanized browser extensions, BHOs (Browser Helper Objects), or drive-by downloads**
- Defeats standard 2FA because the **session is already authenticated** when manipulation occurs — the bank validates a legitimately signed, wrongly-altered request
- Mitigated by **out-of-band transaction verification** (e.g., SMS confirmation showing actual destination account) and **endpoint detection tools** that inspect browser process memory

## Related concepts
[[man-in-the-middle attacks]] [[session hijacking]] [[banking trojans]] [[browser helper objects]] [[credential theft]]