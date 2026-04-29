# wikilinks

## What it is
Like sticky notes that automatically connect to other sticky notes by name, wikilinks are double-bracket syntax (`[[PageName]]`) that create bidirectional hyperlinks between documents in a knowledge base or wiki system. They enable non-linear navigation and relationship mapping across interconnected notes or articles without requiring full URLs.

## Why it matters
In threat intelligence workflows, analysts use wiki-style knowledge bases (like Obsidian or MediaWiki) to map attacker TTPs, where wikilinks visually connect malware families to threat actors to CVEs — breaking the analysis silos that let attackers hide in complexity. A misconfigured internal wiki with overly permissive wikilink traversal could also expose sensitive internal documentation to unauthorized users if access controls aren't applied at the page level, not just the directory level.

## Key facts
- Wikilinks create **bidirectional links** — both the source and target pages know about the connection, enabling graph-based knowledge visualization
- Used heavily in **threat intelligence platforms** (TIPs) and SOC runbooks to cross-reference indicators of compromise (IOCs), playbooks, and asset inventories
- MediaWiki (powering Wikipedia) pioneered the `[[link]]` syntax; tools like **Obsidian, Confluence, and Roam Research** adopted it for security knowledge management
- **Access control misconfiguration risk**: wiki platforms must enforce authorization checks on every linked page — a wikilink doesn't inherit the permissions of its parent page
- Wikilinks support the **MITRE ATT&CK** documentation style, where techniques, sub-techniques, and mitigations are cross-linked for analyst navigation

## Related concepts
[[knowledge management]] [[threat intelligence]] [[MITRE ATT&CK]] [[access control]] [[documentation security]]