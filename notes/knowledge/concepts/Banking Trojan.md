# Banking Trojan

## What it is
Like a con artist who slips behind the bank teller's counter and skims your transaction *while the real teller is still processing it*, a Banking Trojan silently intercepts financial activity between you and your bank. It is a category of malware specifically designed to steal financial credentials and manipulate online banking sessions, typically through techniques like keylogging, form grabbing, or Man-in-the-Browser (MitB) attacks.

## Why it matters
The Zeus (Zbot) Trojan, first identified in 2007, infected over 3.6 million machines in the US alone and stole hundreds of millions of dollars by capturing banking credentials via form grabbing before data was encrypted and sent to the server. Defenders counter this by deploying behavioral analytics to flag anomalous transaction patterns, since stolen credentials alone don't reveal the malware's presence.

## Key facts
- **Form grabbing** is the primary technique: data is captured from browser memory *before* HTTPS encryption, bypassing SSL/TLS protections entirely
- **Man-in-the-Browser (MitB)** allows real-time transaction manipulation — the victim sees a legitimate transfer while the Trojan silently redirects funds to a mule account
- Zeus source code was leaked in 2011, spawning variants including **Citadel**, **GameOver Zeus**, and **Dridex**
- Banking Trojans commonly achieve persistence via **Registry run keys** and inject malicious DLLs into legitimate browser processes (e.g., `explorer.exe`)
- Distribution vectors include **spear phishing emails**, **drive-by downloads**, and **malvertising** — rarely requires admin privileges to deploy

## Related concepts
[[Keylogger]] [[Man-in-the-Browser Attack]] [[Credential Harvesting]] [[Spear Phishing]] [[Rootkit]]