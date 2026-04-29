# forensic analysis

## What it is
Like an archaeologist brushing dust off artifacts to reconstruct a lost civilization, forensic analysis carefully uncovers and preserves digital remnants to reconstruct what happened during a security incident. It is the structured, legally defensible process of collecting, preserving, examining, and reporting on digital evidence without altering its integrity. The goal is to answer *who, what, when, where, and how* in a way that holds up in court or an internal investigation.

## Why it matters
In the 2014 Target breach, forensic analysts examined memory dumps and network logs to trace how attackers moved laterally from an HVAC vendor's credentials to point-of-sale systems stealing 40 million card numbers. Without forensic discipline — particularly maintaining chain of custody and acquiring bit-for-bit disk images — that evidence could have been inadmissible or unknowingly corrupted, shielding the attackers from prosecution and Target from understanding the full kill chain.

## Key facts
- **Order of volatility** dictates collection sequence: CPU registers/RAM → swap/temp files → disk → remote logs. Volatile data dies when power is cut.
- **Chain of custody** documents every person who touched evidence, with timestamps — a gap can make evidence legally worthless.
- **Write blockers** are hardware or software tools that prevent any writes to evidence drives, ensuring the original is never modified.
- **Hashing** (MD5, SHA-256) creates a cryptographic fingerprint of evidence at acquisition; any alteration changes the hash, proving tampering.
- The **WinPmem/FTK Imager** toolset is commonly used for memory and disk acquisition; forensic copies are called *forensic images*, not simple file copies.

## Related concepts
[[chain of custody]] [[incident response]] [[log analysis]]