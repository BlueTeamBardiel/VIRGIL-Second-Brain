# wiki links

## What it is
Like a library card catalog that lets you jump between related books by simply writing a title in brackets, wiki links are internal hyperlinks created by enclosing a page name in double brackets (e.g., `[[PageName]]`) within a wiki system. They create navigable connections between knowledge articles without requiring full URLs, relying on the wiki engine to resolve the reference to the correct internal page.

## Why it matters
In threat intelligence platforms and internal security wikis (like those built on Confluence or MediaWiki), broken or manipulated wiki links can lead analysts to outdated runbooks during an incident response — costing critical time when minutes matter. Attackers who gain write access to an internal wiki can also redirect wiki links to malicious pages or poisoned procedures, a form of supply chain sabotage targeting human decision-making.

## Key facts
- Wiki links differ from external hyperlinks in that they reference **page titles by name**, making them brittle if pages are renamed without a redirect
- In **MediaWiki** (the engine behind Wikipedia), double-bracket syntax `[[Article]]` auto-generates a hyperlink; piped syntax `[[Article|Display Text]]` allows custom anchor text — a vector for **social engineering** if display text misrepresents the destination
- **Orphaned pages** — wiki pages with no incoming wiki links — are a security concern because they may contain sensitive information discoverable by crawlers but invisible to normal navigation
- Wiki link manipulation is categorized under **content injection** or **insider threat** scenarios in CySA+ domains
- Proper wiki hygiene (link audits, access controls, page versioning) is a **defense-in-depth** control for knowledge management systems

## Related concepts
[[Content Injection]] [[Insider Threat]] [[Knowledge Management Security]]