# HDD

## What it is
Like a vinyl record player where a physical needle reads grooves on a spinning platter, a Hard Disk Drive (HDD) uses magnetic read/write heads hovering nanometers above spinning magnetic platters to store and retrieve data. Unlike SSDs, data persists on HDDs through magnetic polarity — bits remain even after power is removed, and deleted files often leave recoverable magnetic remnants.

## Why it matters
In a forensic investigation, a suspect's "deleted" files can frequently be recovered from an HDD because the OS merely marks sectors as available without immediately overwriting the magnetic data. Investigators using tools like Autopsy or FTK can carve these remnant sectors to reconstruct evidence — making proper secure wiping (DoD 5220.22-M overwrite standards or physical degaussing) critical before disposal of sensitive drives.

## Key facts
- **Data remanence** is the phenomenon where deleted data persists magnetically on HDDs; SSDs handle this differently due to wear leveling, making HDD forensics more predictable
- **Secure erasure methods** for HDDs include multi-pass overwriting (e.g., 7-pass DoD standard), degaussing (magnetic field disruption), and physical shredding — simple deletion is never sufficient
- **RPM matters forensically**: 7200 RPM drives are common in enterprise environments; spindle speed affects how quickly data can be imaged during live forensics
- **Bad sectors** can hide data that standard wiping tools skip, requiring hardware-level tools to address
- **Chain of custody** for HDD evidence requires write blockers (hardware or software) to prevent accidental modification during forensic imaging

## Related concepts
[[Data Remanence]] [[Digital Forensics]] [[Secure Data Disposal]] [[Write Blocker]] [[File Carving]]