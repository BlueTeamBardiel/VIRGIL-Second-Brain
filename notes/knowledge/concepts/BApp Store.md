# BApp Store

## What it is
Think of it like the App Store on your phone, but instead of games and productivity tools, every download is a specialized weapon or analysis tool for web application testing. The BApp Store is the official extension marketplace for Burp Suite, PortSwigger's web application security testing platform, allowing testers to install community-developed and PortSwigger-verified plugins that extend Burp's core functionality.

## Why it matters
During a web application penetration test, a tester discovers a target using a GraphQL API — a technology Burp Suite doesn't deeply analyze by default. By installing the **InQL** extension from the BApp Store in under a minute, the tester can automatically enumerate GraphQL schemas, identify hidden queries, and discover exposed sensitive data endpoints that manual testing would have missed entirely.

## Key facts
- Extensions are written in Java, Python (via Jython), or Ruby (via JRuby), and interact with Burp through the **Montoya API** (formerly the Burp Extender API)
- BApp Store extensions are rated by stability and assigned a trust level; **PortSwigger-authored** extensions carry the highest trust rating
- Popular extensions include **Autorize** (broken access control testing), **Logger++** (advanced request logging), **ActiveScan++** (expanded active scanning rules), and **Param Miner** (hidden parameter discovery)
- Extensions can hook into Burp's **proxy, scanner, intruder, and repeater** tools, making them relevant at every phase of a web assessment
- BApp Store access requires Burp Suite Community or Professional; some extensions require the **Professional license** to unlock full functionality

## Related concepts
[[Burp Suite]] [[Web Application Penetration Testing]] [[OWASP Top 10]] [[Proxy Interception]] [[Broken Access Control]]