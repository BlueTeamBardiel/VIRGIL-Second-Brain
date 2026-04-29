# DBAN

## What it is
Like grinding a vinyl record into dust so no needle can ever replay its music, DBAN (Darik's Boot and Nuke) is a free, open-source bootable utility that overwrites every sector of a hard drive with random data, making forensic recovery of the original contents computationally infeasible. It runs independently of the installed operating system, ensuring even OS-level data cannot survive.

## Why it matters
A healthcare organization decommissions 200 workstations and donates them to a local school. Without proper sanitization, a curious student with Autopsy or Recuva could recover years of patient records — a direct HIPAA violation. Running DBAN before disposal ensures the drives are sanitized to a standard that satisfies regulatory requirements for media decommissioning.

## Key facts
- DBAN implements multiple overwrite standards including DoD 5220.22-M (7-pass), Gutmann (35-pass), and PRNG stream methods — the more passes, the longer the process but the stronger the assurance
- It is designed for **magnetic HDDs**; it is **ineffective for SSDs and flash storage** because wear-leveling algorithms can hide data in blocks DBAN never overwrites
- DBAN does **not** provide a certificate of destruction — regulated industries (HIPAA, PCI-DSS) often require documented proof, which enterprise tools like Blancco supply
- The tool boots from USB or CD, operating entirely outside the host OS, which prevents active processes from locking files during the wipe
- NIST SP 800-88 classifies overwrite-based sanitization as "Clear" for lower-sensitivity data; physical destruction (shredding) is recommended for "Purge/Destroy" classification on high-sensitivity media

## Related concepts
[[Data Sanitization]] [[Media Destruction]] [[NIST SP 800-88]] [[Secure Disposal]] [[Data Remanence]]