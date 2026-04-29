# drive-by download

## What it is
Like a flu virus drifting through a ventilation system — you catch it simply by *being in the building*, no handshake required. A drive-by download is malware that installs itself on a victim's machine just by visiting a compromised or malicious webpage, requiring zero clicks or user consent beyond opening the browser tab.

## Why it matters
In the 2016 AdGholas malvertising campaign, attackers purchased legitimate ad slots on major news sites and embedded exploit kit code that fingerprinted visitors' browsers; anyone running an unpatched version of Internet Explorer or Flash was silently infected with banking trojans without ever clicking an ad. This illustrates why patch management and script-blocking browser extensions are frontline defenses — the attack surface is simply *existing on the web*.

## Key facts
- **Exploit kits** (e.g., Angler, RIG, Magnitude) are the primary delivery mechanism — they probe the browser for vulnerable plugins (Flash, Java, PDF readers) and serve the matching exploit automatically.
- The attack typically chains: malicious redirect → exploit kit landing page → shellcode execution → payload drop, often completing in under two seconds.
- **Malvertising** is the most common infection vector, because attackers bypass site security entirely by injecting code through third-party ad networks.
- Drive-by downloads exploit **client-side vulnerabilities** — specifically unpatched browsers and browser plugins — distinguishing them from server-side attacks.
- Mitigations include: browser sandboxing, disabling legacy plugins (Flash is now deprecated), Content Security Policy (CSP) headers, and network-level URL filtering.

## Related concepts
[[exploit kit]] [[malvertising]] [[cross-site scripting]] [[browser sandbox]] [[watering hole attack]]