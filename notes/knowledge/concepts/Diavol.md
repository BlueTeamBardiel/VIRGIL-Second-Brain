# Diavol

## What it is
Like a locksmith who breaks into your house, steals your valuables, *and* leaves a ransom note — but turns out to be working for the same crew as the guy who cased the joint earlier. Diavol is a ransomware strain that emerged in 2021, attributed to the TrickBot/Wizard Spider threat group, designed to encrypt victim files and extort payment under threat of data publication.

## Why it matters
In mid-2021, Diavol was observed being deployed alongside Cobalt Strike beacons in enterprise intrusions, often dropped *after* TrickBot had already established persistence and performed lateral movement. This illustrates the "ransomware-as-the-final-stage" attack model — defenders who detect TrickBot early can prevent the ransomware detonation entirely, making early-stage detection critically valuable.

## Key facts
- Diavol uses **asynchronous I/O operations** for file encryption, making it faster than many competing ransomware families by processing multiple files simultaneously
- It registers the victim machine with a C2 server using a **unique bot ID** derived from device information before beginning encryption, allowing attackers to track victims
- Diavol's ransom note and branding were initially **confused with Conti ransomware**, revealing operational overlap between criminal groups sharing tooling and infrastructure
- It specifically **avoids encrypting files in certain language locales** (e.g., Russian, CIS countries) — a common indicator of Eastern European threat actor origin
- Attributed to **Wizard Spider**, the same group behind TrickBot, Ryuk, and Conti, making it part of a well-resourced, multi-tool criminal ecosystem

## Related concepts
[[TrickBot]] [[Conti Ransomware]] [[Wizard Spider]] [[Ransomware-as-a-Service]] [[Cobalt Strike]]