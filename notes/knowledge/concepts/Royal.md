# Royal

## What it is
Like a locksmith gang that evolved from breaking into cars to cracking bank vaults, Royal is a sophisticated ransomware operation that emerged in 2022 after key members split from the Conti ransomware group. It operates as a private group (not RaaS) targeting critical infrastructure, healthcare, and manufacturing with custom-built encryptors and multi-extortion tactics.

## Why it matters
In late 2022 and 2023, Royal targeted U.S. healthcare organizations and critical infrastructure, prompting a joint CISA/FBI advisory. Defenders needed to recognize Royal's specific TTPs — particularly its use of callback phishing (vishing) for initial access and partial encryption techniques — to distinguish it from other ransomware families and respond appropriately.

## Key facts
- **Initial access vector**: Royal heavily uses callback phishing (telephone-oriented attack delivery, or TOAD), tricking victims into calling fake help desks that install remote access tools like AnyDesk or Cobalt Strike
- **Encryption approach**: Uses partial file encryption (encrypting only a percentage of file contents) to evade detection and speed up the encryption process — a technique also used by BlackCat/ALPHV
- **Lineage**: Believed to be composed largely of former Conti group members; shares code and operational similarities with Conti and its successor groups (BlackBasta)
- **No RaaS model**: Unlike most major ransomware families, Royal operates privately without affiliates, meaning all attacks are conducted by a core, skilled team
- **Double extortion**: Exfiltrates data before encrypting; threatens to publish on leak site "Royal" if ransom is unpaid — CISA noted ransom demands ranged from $1M to $11M USD
- **MITRE relevance**: Leverages living-off-the-land binaries (LOLBins), disables VSS (Volume Shadow Copy Service) to prevent recovery

## Related concepts
[[Ransomware]] [[Callback Phishing]] [[Double Extortion]] [[Conti]] [[Volume Shadow Copy Deletion]]