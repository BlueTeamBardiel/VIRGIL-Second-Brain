# Malvertising

## What it is
Like a poisoned flyer slipped into a legitimate newspaper's ad section, malvertising embeds malicious code inside online advertisements served through trusted ad networks. It's the injection of malware-laden or redirect-triggering ads into legitimate advertising ecosystems, allowing attackers to reach victims on reputable websites without compromising those sites directly. The victim never clicks anything suspicious — simply loading the page can trigger the attack.

## Why it matters
In 2016, major sites including The New York Times, BBC, and MSN unknowingly served malvertising through compromised ad networks, delivering Angler exploit kit payloads to visitors running unpatched Flash or Silverlight. Users visiting completely legitimate news sites received ransomware infections with zero interaction required — a drive-by download at massive scale. This demonstrated that perimeter defenses and website reputation filters provide little protection when the attack vector is the advertising supply chain itself.

## Key facts
- **Drive-by download** is the primary delivery mechanism — malicious JavaScript executes when the ad renders, requiring no user click
- Malvertising exploits the **ad network trust chain**: attackers purchase ad space through legitimate brokers, making source-level filtering extremely difficult
- Exploit kits (e.g., Angler, RIG, Magnitude) are commonly bundled with malvertising campaigns to probe for browser/plugin vulnerabilities automatically
- Unlike a compromised website, malvertising is **transient** — ads rotate, making forensic attribution and takedowns difficult
- Defenses include **ad blockers**, browser sandboxing, disabling legacy plugins (Flash, Java), and keeping browsers/OS fully patched; content security policy (CSP) headers can also limit script execution sources

## Related concepts
[[Drive-by Download]] [[Exploit Kit]] [[Watering Hole Attack]] [[Cross-Site Scripting]] [[Content Security Policy]]