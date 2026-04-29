# HermeticWiper

## What it is
Like a janitor who doesn't just mop the floor but smashes the tiles, removes the subfloor, and salts the concrete underneath — HermeticWiper is a destructive malware that doesn't merely delete files but corrupts the Master Boot Record (MBR), partition tables, and individual file data, making the system completely unbootable and unrecoverable. It was deployed against Ukrainian organizations in February 2022, hours before Russia's full-scale invasion.

## Why it matters
In the February 2022 Ukraine cyberattacks, HermeticWiper was deployed against hundreds of Ukrainian government and financial systems simultaneously, acting as a digital first strike timed with kinetic military operations. Defenders who had offline, immutable backups were the only ones able to recover — illustrating why backup integrity matters more than backup existence.

## Key facts
- Named after the code-signing certificate stolen from a Cypriot company called "Hermetica Digital Ltd," which was used to make the malware appear legitimate and bypass security controls
- Uses legitimate Windows driver `EaseUS Partition Master` components (embedded within itself) to perform low-level disk corruption — a living-off-the-land adjacent technique
- Targets the MBR and Volume Boot Records (VBR), ensuring destruction survives even if individual files are restored
- Deployed alongside **HermeticWizard** (worm component for lateral movement) and **HermeticRansom** (decoy ransomware to distract incident responders)
- Classified as a **wiper**, not ransomware — no recovery is intended; the goal is pure destruction, not financial gain

## Related concepts
[[MBR (Master Boot Record)]] [[Destructive Malware]] [[Living-Off-The-Land Attacks]] [[NotPetya]] [[Supply Chain Attacks]]