# FIN6

## What it is
Think of FIN6 like a professional burglary crew that only robs jewelry stores — they have a specific target profile, specialized tools, and sell everything through a single fence. FIN6 is a financially motivated threat actor group specializing in the theft of payment card data from point-of-sale (PoS) environments and e-commerce platforms. They operate with APT-level discipline despite being driven purely by profit rather than espionage.

## Why it matters
In 2019, FIN6 was observed compromising e-commerce sites by injecting JavaScript skimmers (a technique called "Magecart-style" attacks) to harvest card data at checkout — pivoting from their earlier PoS-focused campaigns. Defenders monitoring for unusual outbound JavaScript calls or unexpected third-party script domains on payment pages would be positioned to detect this lateral evolution in their tactics.

## Key facts
- FIN6 extensively uses legitimate tools like Metasploit, PowerShell Empire, and CobaltStrike to blend into normal network traffic — a classic **living-off-the-land** strategy
- They harvest credentials using **LockerGoga** and **Ryuk ransomware** partnerships in later campaigns, showing collaboration with ransomware operators
- Stolen card data is sold on underground marketplaces like **Joker's Stash**, with millions of records per breach
- Primary targets include **retail, hospitality, and healthcare** sectors — any environment with high-volume PoS transactions
- FIN6 is tracked by Mandiant/FireEye and is associated with the broader **ITG08** designation used by IBM X-Force

## Related concepts
[[Point-of-Sale Malware]] [[Magecart]] [[Living Off the Land (LotL)]] [[Threat Intelligence]] [[APT Groups]]