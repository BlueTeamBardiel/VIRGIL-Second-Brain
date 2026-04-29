# NotPetya

## What it is
Like a wrecking ball disguised as a renovation crew, NotPetya appeared to be ransomware but was actually a pure wiper — collecting a ransom key it never intended to use. Technically, it was a destructive cyberweapon deployed in 2017 that spread via the EternalBlue exploit and a compromised Ukrainian accounting software update (M.E.Doc), permanently destroying MBRs and encrypting files with no recovery path.

## Why it matters
In June 2017, NotPetya devastated Maersk, the global shipping giant, destroying approximately 45,000 PCs and 1,000 servers across 130 countries — costing roughly $300 million and requiring a complete network rebuild in 10 days. This attack illustrates why supply chain compromise is catastrophic: a trusted software update became a global weapon, and no ransom payment could ever restore the data.

## Key facts
- **Attribution**: Widely attributed to Sandworm, a Russian GRU-linked APT group, targeting Ukraine but causing massive global collateral damage
- **Propagation**: Combined EternalBlue (SMB exploit, stolen from NSA) with Mimikatz credential harvesting and PsExec to move laterally without user interaction
- **Destructive mechanism**: Overwrote the Master Boot Record (MBR), making systems unbootable — the "ransom" demand was theater, not function
- **Not true ransomware**: Classified as a wiper/pseudo-ransomware; decryption was structurally impossible because victim IDs were randomly generated, not stored
- **Total estimated damage**: ~$10 billion globally, making it the most costly cyberattack in history at the time

## Related concepts
[[EternalBlue]] [[Supply Chain Attack]] [[Wiper Malware]] [[Mimikatz]] [[Sandworm APT]]