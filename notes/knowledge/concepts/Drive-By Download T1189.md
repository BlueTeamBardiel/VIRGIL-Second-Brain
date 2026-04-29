# Drive-By Download T1189

## What it is
Like stepping on a nail hidden in a doormat — simply walking past is enough to get hurt. A drive-by download is an attack where visiting a compromised or malicious website silently delivers and executes malware on the victim's machine without any explicit user action beyond the page load, exploiting vulnerabilities in browsers, plugins (Flash, Java), or scripting engines.

## Why it matters
In the 2016 AdGholas malvertising campaign, attackers injected malicious ads into legitimate ad networks; users visiting mainstream news sites had their systems profiled and infected with Trickbot banking malware purely by loading the page. Defenders counter this with browser isolation, aggressive patching of browser engines, and Content Security Policy (CSP) headers that block unauthorized script execution.

## Key facts
- **No user click required** — the attack triggers on page render, distinguishing it from phishing which needs a deliberate action like opening an attachment
- Exploit kits (e.g., Angler, RIG, Magnitude) are the primary delivery mechanism — they fingerprint the browser, select the right exploit, and deliver a payload automatically
- **Watering hole attacks** (T1566.002-adjacent) commonly use drive-by downloads: adversaries compromise sites frequented by a specific target group rather than broadcasting widely
- MITRE ATT&CK maps this under **Initial Access (TA0001)**, making it a primary entry vector before lateral movement begins
- Defenses include disabling JavaScript for unknown sites (NoScript), sandboxing browsers, enabling click-to-play for plugins, and deploying web proxies with URL categorization

## Related concepts
[[Watering Hole Attack]] [[Exploit Kit]] [[Malvertising]] [[Browser Exploitation]] [[Content Security Policy]]