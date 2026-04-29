# FIN13

## What it is
Like a burglar who breaks into a bank vault not to rob it overnight, but to quietly photocopy the ledgers and return every morning undetected for years, FIN13 is a financially motivated threat actor known for long-term, stealthy intrusions. Specifically, FIN13 is a Mexico-focused advanced persistent threat (APT) group that targets financial institutions, retail, and hospitality sectors primarily in Latin America, emphasizing sustained access over rapid smash-and-grab operations.

## Why it matters
FIN13 compromised multiple Mexican financial institutions by deploying custom backdoors and living-off-the-land techniques to maintain persistent access for months or years, exfiltrating financial transaction data and enabling fraudulent transfers through ATM networks. Defenders analyzing this group learned that long dwell times (averaging over a year) make behavioral anomaly detection and thorough log retention critical countermeasures — signature-based tools alone would miss them entirely.

## Key facts
- FIN13 is tracked by Mandiant and operates with a strong regional focus on **Mexico and Latin America**, distinguishing it from most financially motivated APTs targeting North America or Europe
- The group uses **custom malware tooling** including unique backdoors (e.g., CONFLICTCANDLE, FATPIPE) rather than commodity crimeware, indicating significant development resources
- FIN13 achieves **exceptionally long dwell times**, often exceeding 12 months before detection — far above typical breach timelines
- The group specifically targets **ATM transaction systems and financial messaging infrastructure** to enable fraudulent cash-out operations
- FIN13 heavily employs **living-off-the-land (LotL) techniques** — using legitimate tools like WMI and PowerShell — to blend into normal network activity and evade detection

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Living off the Land (LotL)]] [[Dwell Time]] [[Financial Threat Actors]] [[ATM Jackpotting]]