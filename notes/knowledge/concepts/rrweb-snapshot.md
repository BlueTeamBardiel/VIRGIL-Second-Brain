# rrweb-snapshot

## What it is
Like a court stenographer who freezes the entire courtroom mid-session and transcribes every chair, face, and document before recording what happens next — rrweb-snapshot serializes a complete DOM state into a structured JSON snapshot, capturing every element, attribute, and text node at a single moment in time. It is the initialization phase of the rrweb session replay library, producing a "full snapshot" that anchors all subsequent incremental DOM mutations for accurate playback.

## Why it matters
Attackers who compromise a SaaS platform can inject rrweb-snapshot into a target site to silently exfiltrate full session replays — including form inputs, credit card fields, and authentication tokens — to an attacker-controlled server. This technique was observed in supply chain attacks against e-commerce platforms where the library was trojanized inside third-party analytics scripts, enabling large-scale credential harvesting without modifying the application's own code.

## Key facts
- rrweb-snapshot serializes the **live DOM tree** including shadow DOM, iframes, and canvas elements into a portable JSON structure called a `fullSnapshot` event
- The snapshot captures `input` field values at capture time, meaning **plaintext passwords and PII** can be embedded in the serialized output if recorded before masking is applied
- Legitimate uses include **UX session replay tools** (LogRocket, FullStory use similar techniques), but the same mechanism is weaponizable for form-jacking
- The library assigns every DOM node a unique numeric ID, enabling precise **delta patching** — attackers can reconstruct an exact replica of a victim's browser state
- CSP (Content Security Policy) headers restricting `script-src` and `connect-src` are the primary defensive controls against unauthorized rrweb-snapshot injection and data exfiltration

## Related concepts
[[Supply Chain Attack]] [[DOM-based XSS]] [[Content Security Policy]] [[Form-jacking]] [[Session Hijacking]]