# Obsidian

## What it is
Think of Obsidian like a corkboard covered in index cards connected by string — except the entire board lives locally on your hard drive and nothing phones home. Obsidian is a free, offline-first knowledge management application that stores all notes as plain Markdown (.md) files in a local "vault" folder. It creates bidirectional links between notes, enabling analysts and researchers to map relationships across concepts, threat actors, and incidents.

## Why it matters
In a SOC or threat intelligence context, analysts use Obsidian to build personal knowledge bases that link TTPs, CVEs, threat actor profiles, and incident timelines — all without uploading sensitive data to a cloud service. During a red team engagement, an operator might use Obsidian to document recon findings, chain attack paths visually, and maintain OPSEC by keeping notes entirely air-gapped from corporate or cloud infrastructure.

## Key facts
- All data is stored as plain `.md` files — fully portable, human-readable, and version-controllable with Git; no proprietary lock-in
- Obsidian operates **offline by default**; the optional Sync service (paid) uses end-to-end encryption if cloud sync is enabled
- Plugins extend functionality — security-relevant plugins include Dataview (query notes like a database) and Templater (automate structured note creation for incident reports)
- Bidirectional linking and graph view allow analysts to visualize connections between concepts, mimicking how ATT&CK Navigator maps adversary behavior
- Because notes are local files, the vault itself becomes a sensitive asset — full-disk encryption (BitLocker, FileVault) is recommended to protect operational notes

## Related concepts
[[Threat Intelligence]] [[MITRE ATT&CK]] [[OPSEC]] [[Markdown]] [[Personal Security Operations]]