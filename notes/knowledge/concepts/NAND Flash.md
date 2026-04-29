# NAND Flash

## What it is
Like a notebook where you must erase an entire page before rewriting any single word, NAND flash memory organizes data into fixed "blocks" that must be erased wholesale before new data can be written. It is a type of non-volatile storage that retains data without power, used in SSDs, USB drives, SD cards, and mobile devices, where data is stored in floating-gate transistor cells arranged in a grid of pages and blocks.

## Why it matters
During forensic investigations of SSDs and mobile devices, NAND flash's built-in **TRIM command** and **wear-leveling algorithms** actively remap and overwrite old data blocks to extend drive lifespan — silently destroying evidence that would persist on a traditional HDD. This means standard magnetic-disk wiping tools and file-carving techniques often fail on flash storage, and investigators must disable TRIM before acquisition or accept potential data loss. Attackers also exploit firmware vulnerabilities in flash controllers (e.g., BadUSB) to persist malicious code below the OS level.

## Key facts
- **Non-volatile**: Retains data without power; used in SSDs, USB drives, eMMC chips, and smartphones
- **Wear leveling** distributes writes evenly across blocks to prevent premature cell failure, but also relocates data unpredictably, complicating forensics
- **TRIM command** tells the OS to proactively mark deleted blocks for erasure, making deleted file recovery much harder than on HDDs
- **Write-in-pages, erase-in-blocks**: Typical page size is 4–16 KB; block size is 256 KB–4 MB — you can't overwrite a single page without erasing its whole block
- **Flash Translation Layer (FTL)** hides physical block management from the OS, creating a logical-to-physical mapping that forensic tools must account for

## Related concepts
[[SSD Forensics]] [[BadUSB]] [[Wear Leveling]] [[File Carving]] [[Non-Volatile Storage]]