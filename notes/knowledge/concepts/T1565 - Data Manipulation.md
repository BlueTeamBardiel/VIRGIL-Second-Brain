# T1565 - Data Manipulation

## What it is
Like a crooked accountant who doesn't steal money but quietly changes account balances to hide fraud, Data Manipulation attacks modify stored or in-transit data to achieve a goal — without necessarily stealing it. Adversaries alter files, databases, or network traffic to deceive, cause operational failures, or cover their tracks while leaving systems apparently functional.

## Why it matters
During the 2016 Bangladesh Bank heist, attackers didn't just exfiltrate money — they manipulated SWIFT transaction records to erase evidence of $81 million in fraudulent transfers, delaying detection by days. This illustrates how data manipulation serves both as an attack objective and a cover mechanism, making it far more dangerous than simple data theft.

## Key facts
- **Three sub-techniques exist:** T1565.001 (Stored Data Manipulation), T1565.002 (Transmitted Data Manipulation via MitM), and T1565.003 (Runtime Data Manipulation — altering data in memory during execution)
- Classified under the **Impact** tactic in MITRE ATT&CK, since the primary effect is compromising data integrity rather than confidentiality
- Detecting manipulation requires **integrity monitoring tools** (e.g., Tripwire, file hash verification) because traditional AV won't catch altered data
- Attackers manipulate logs, financial records, medical data, or configuration files — targeting whatever data drives trust-based decisions
- **Defense focus:** Implement cryptographic checksums, write-once audit logs (WORM storage), and database activity monitoring (DAM) to establish baselines and detect deviations

## Related concepts
[[T1485 - Data Destruction]] [[T1557 - Adversary-in-the-Middle]] [[T1070 - Indicator Removal on Host]]