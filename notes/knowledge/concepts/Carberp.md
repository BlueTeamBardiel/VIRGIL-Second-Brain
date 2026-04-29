# Carberp

## What it is
Like a master locksmith who not only breaks into your house but also hands out copies of his lockpicks to anyone willing to pay, Carberp was a sophisticated banking trojan whose leaked source code became a criminal franchise. Technically, it was a modular, rootkit-capable malware family targeting Windows systems to steal online banking credentials through form-grabbing and webinjection attacks.

## Why it matters
In 2013, Carberp's full source code leaked publicly on underground forums — the equivalent of a nation-state weapons cache being sold at a flea market. This enabled dozens of criminal groups to spin up customized variants almost overnight, dramatically lowering the barrier to entry for sophisticated banking fraud campaigns targeting Eastern European and Western financial institutions.

## Key facts
- **Origin:** Emerged around 2010, primarily targeting Russian and Eastern European banking customers; its operators were arrested in Ukraine in 2012
- **Modular architecture:** Used downloadable plugins for specific functions (e.g., VNC access, password theft, bootkit installation), making it highly adaptable
- **Rootkit capability:** Could install a bootkit (Rovnix) to survive OS reinstalls by infecting the Master Boot Record (MBR)
- **Source code leak (2013):** The ~40MB leaked code package spawned numerous derivatives and influenced later trojans including mobile variants targeting Android banking apps
- **Webinjection attacks:** Intercepted browser traffic in real time to inject fake form fields, harvesting credentials *before* encryption, bypassing HTTPS protections entirely

## Related concepts
[[Zeus Trojan]] [[Banking Malware]] [[Form Grabbing]] [[Rootkit]] [[Drive-by Download]]