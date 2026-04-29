# AppleJeus

## What it is
Like a poisoned candy bar handed out at a legitimate-looking confectionery booth, AppleJeus is malware disguised as a fake cryptocurrency trading application. Precisely, it is a North Korean (Lazarus Group) supply chain and trojanized-software campaign that delivers a backdoor payload to victims who believe they're installing legitimate trading software.

## Why it matters
In 2018, a cryptocurrency exchange employee downloaded what appeared to be a trading tool called "Celas Trade Pro" — the installer contained a legitimate-looking updater that silently fetched and executed a remote backdoor (JRAT/Fallchill). This attack demonstrated how threat actors can weaponize the software installation process itself, bypassing traditional perimeter defenses because the victim *voluntarily* runs the malicious executable.

## Key facts
- **Attribution:** Lazarus Group (North Korean APT, also known as Hidden Cobra), primarily motivated by financial gain to fund state programs
- **Multi-platform:** AppleJeus variants target both Windows and macOS, making it notable as one of the first North Korean malware families to specifically target macOS users
- **Delivery mechanism:** Trojanized legitimate-looking cryptocurrency apps distributed via fake company websites, spearphishing, and social engineering on forums
- **Backdoor payload:** Uses a two-stage infection — a benign-looking updater establishes persistence, then pulls down the actual malicious payload (Fallchill RAT) from C2 infrastructure
- **CISA Advisory:** Formally documented in CISA Alert AA21-048A, making it exam-relevant as a named nation-state threat campaign

## Related concepts
[[Lazarus Group]] [[Supply Chain Attack]] [[Remote Access Trojan]] [[Spearphishing]] [[CISA Advisories]]