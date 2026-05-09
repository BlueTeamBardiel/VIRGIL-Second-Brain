# Other Social Engineering Attacks

## What it is

In Far Cry 3, Vaas doesn't shoot you in the opening cutscene — he ties your hands, monologues about insanity, and waits for you to trust the wrong person to escape. Citra plays the same game from the other side, weaponizing belief and ritual to recruit you. That's exactly what these social engineering attacks do — they bypass technology entirely by exploiting human trust, urgency, fear, and authority.

**Other Social Engineering Attacks** are the SY0-701 attack vectors beyond standard phishing that manipulate human behavior — including misinformation/disinformation, impersonation, business email compromise, pretexting, watering holes, brand impersonation, and typosquatting.

## Why it matters

Social engineering bypasses every firewall you bought. One persuaded accountant wires $2.3M to a "vendor" and your SOC 2 audit, your cyber insurance, and your CFO's career all combust simultaneously. The exam objective 2.2 lists these by name — **misinformation/disinformation**, **impersonation**, **business email compromise**, **pretexting**, **watering hole**, **brand impersonation**, **typosquatting** — and CompTIA's favorite trap is making you distinguish between near-identical scenarios (Is this *pretexting* or *impersonation*? Is this *BEC* or *spear phishing*?). Memorize the precise definitions, not the vibes.

## Key facts

### The attack catalog

| Attack | Mechanic | Tell |
|---|---|---|
| [[Misinformation]] | False information spread without intent to deceive | Honest mistake, viral repost |
| [[Disinformation]] | False information spread *with* intent to deceive | Deliberate influence campaign |
| [[Impersonation]] | Pretending to be a specific person or role | "This is IT, I need your password" |
| [[Pretexting]] | Fabricated **scenario** that justifies the request | "I'm auditing accounts and need access" |
| [[Business Email Compromise]] (**BEC**) | Compromised or spoofed executive email demanding wire/data | "Urgent — wire to new vendor, don't call" |
| [[Watering Hole Attack]] | Compromise a site the target group already trusts | Industry forum serving malware to its niche |
| [[Brand Impersonation]] | Mimic a trusted brand's look/voice | Fake Microsoft password reset |
| [[Typosquatting]] | Register lookalike domains | `microsft.com`, `paypa1.com` |

### Pretexting vs. Impersonation (the CompTIA trap)

- **Impersonation** = *who* you claim to be. (CEO, IT, vendor.)
- **Pretexting** = *why* you're asking. (The story.)
- They're frequently combined. If the question emphasizes the **fabricated story**, pick pretexting. If it emphasizes **assuming an identity**, pick impersonation.

### Business Email Compromise (BEC) variants

- **CEO fraud** — spoofed or compromised executive demands urgent wire transfer.
- **Vendor email compromise** — attacker hijacks real vendor thread, swaps banking details on next invoice.
- **Account compromise** — internal mailbox taken over via [[credential phishing]] and used for lateral fraud.
- BEC typically involves no malware — pure social engineering, which is why [[email security gateway]] tools miss it.

### Watering hole anatomy

1. Attacker profiles target organization's habits.
2. Identifies a third-party site the target frequents (industry forum, supplier portal).
3. Compromises *that* site with a [[drive-by download]] or exploit kit.
4. Waits. The target visits voluntarily.
- Defeats outbound filtering because the destination looks legitimate. Mitigations: [[browser isolation]], [[endpoint detection and response]] (EDR), patching, [[DNS filtering]].

### Typosquatting techniques

- **Character substitution** — `paypa1.com` (1 for l), `rnicrosoft.com` (rn for m).
- **TLD swap** — `company.co` instead of `company.com`.
- **Hyphenation** — `pay-pal.com`.
- **Subdomain trickery** — `paypal.com.attacker.ru`.
- Defenses: [[domain monitoring]], defensive registration, [[DMARC]]/[[SPF]]/[[DKIM]] for email, user training.

### Misinformation vs. Disinformation (intent is everything)

- **Misinformation** — wrong, but spread in good faith. (Grandma reposts a hoax.)
- **Disinformation** — wrong, weaponized. (State actor seeds election lies.)
- Both fall under **influence campaigns** in objective 2.2. Defense is largely organizational: [[media literacy]], verified communication channels, official spokespersons.

### Defenses (cross-cutting)

- [[Security awareness training]] with phishing simulations
- [[Multifactor authentication]] (kills credential-only BEC pivots)
- **Out-of-band verification** for any financial request — call a known number
- [[DMARC]] enforcement at `p=reject`
- [[Acceptable Use Policy]] and clear escalation paths
- [[Zero Trust]] — assume the email is hostile until proven otherwise

## Related concepts

[[Phishing]] · [[Spear Phishing]] · [[Whaling]] · [[Vishing]] · [[Smishing]] · [[Influence Campaigns]] · [[Social Engineering Principles]] · [[DMARC]] · [[Security Awareness Training]] · [[Zero Trust]]

---
*Source: VIRGIL knowledge base — 2026-05-08*