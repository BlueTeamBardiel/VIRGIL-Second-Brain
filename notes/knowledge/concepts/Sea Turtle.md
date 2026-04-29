# Sea Turtle

## What it is
Imagine a thief who doesn't rob your house directly — instead, they bribe the post office to redirect all your mail to their address first, read it, then forward it along so you never notice. Sea Turtle is a state-sponsored DNS hijacking campaign (attributed to actors likely operating out of Turkey) discovered in 2019, in which attackers compromised DNS registrars and registry infrastructure to redirect legitimate domain traffic through attacker-controlled resolvers.

## Why it matters
In documented attacks, Sea Turtle actors targeted organizations in the Middle East and North Africa by hijacking DNS records for government agencies, telecom providers, and ISPs. Victims' credentials were intercepted via man-in-the-middle SSL termination — the attacker presented valid-looking certificates for the spoofed domains, meaning users saw the padlock icon and had no obvious indication anything was wrong.

## Key facts
- Sea Turtle is classified as a **supply chain / DNS infrastructure attack** — attackers targeted upstream registrars rather than victim organizations directly
- Actors obtained valid **TLS certificates** for hijacked domains, defeating basic certificate trust warnings
- Attributed by Cisco Talos in April 2019; linked to **nation-state espionage** objectives, not financial crime
- Attack technique relies on **DNS record manipulation at the registrar level**, making traditional endpoint defenses ineffective
- **ICANN** issued warnings recommending **multi-factor authentication on registrar accounts** and **DNSSEC** as primary mitigations
- Targets included ccTLD (country-code top-level domain) operators, amplifying the blast radius to all domains under that TLD

## Related concepts
[[DNS Hijacking]] [[Man-in-the-Middle Attack]] [[DNSSEC]] [[Supply Chain Attack]] [[BGP Hijacking]]