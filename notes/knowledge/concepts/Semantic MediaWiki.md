# Semantic MediaWiki

## What it is
Think of a regular wiki as a filing cabinet where humans read the labels, but Semantic MediaWiki (SMW) is a filing cabinet where *machines* can read, query, and reason about the labels too. SMW is an extension to MediaWiki that adds structured, machine-readable metadata to wiki pages using typed properties and relationships, effectively turning a wiki into a queryable knowledge base. It allows users to annotate content with semantic triples (subject-predicate-object) that can then be queried using inline queries.

## Why it matters
In enterprise security environments, SMW is sometimes used to build internal threat intelligence wikis or asset management knowledge bases — and like any public-facing or internally exposed MediaWiki installation, it inherits MediaWiki's vulnerability surface, including outdated extension exploits and information disclosure risks. An attacker who gains read access to an internal SMW instance could extract structured asset inventories, network topology data, or vulnerability tracking information that humans scattered across thousands of pages — the semantic structure makes automated data harvesting dramatically easier than scraping unstructured wikis.

## Key facts
- SMW stores properties and values in a relational database (MySQL/MariaDB by default), making SQL injection against the underlying MediaWiki installation a high-value attack path
- Improperly configured SMW instances may expose sensitive structured data via the public API endpoint (`api.php`) without authentication
- SMW's `#ask` query language can be abused for denial-of-service through computationally expensive recursive queries if not rate-limited
- MediaWiki (and by extension SMW) has had multiple CVEs related to cross-site scripting (XSS) via page titles and property values
- Access control in SMW is inherited from MediaWiki's namespace and user-right model — granular property-level ACLs are not native, creating oversharing risks

## Related concepts
[[MediaWiki Security]] [[Information Disclosure]] [[Knowledge Base Attack Surface]]