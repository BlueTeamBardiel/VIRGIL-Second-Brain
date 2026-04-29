# Write

## What it is
Like a librarian who can add books to the shelf but not necessarily read them, **Write** is a permission that grants a subject the ability to modify, create, or append data to a resource — without necessarily granting Read access. In access control models, Write is a discrete privilege that must be explicitly granted and is separate from Read, Execute, or Full Control permissions.

## Why it matters
In a 2017-style misconfigured S3 bucket attack, an attacker with public Write access could upload malicious files — replacing legitimate web assets with malware-laced versions — even without being able to read the existing contents. Defenders audit Write permissions carefully because unauthorized Write access enables data tampering, ransomware staging, and supply chain attacks far more than Read access alone.

## Key facts
- In the **Bell-LaPadula model**, the *-property (star property) restricts Write: a subject cannot write *down* to a lower classification level to prevent data leakage
- In **DAC (Discretionary Access Control)**, the resource owner controls who holds Write permission; in **MAC**, policy enforces it regardless of owner preference
- Write access combined with Execute can enable **code injection** — writing a malicious script then triggering execution is a classic privilege escalation chain
- On Linux/Unix, Write permission (`w`) on a **directory** allows deletion and renaming of files within it — not just file content modification
- **Least privilege** principle mandates Write be granted only when operationally necessary; many breaches trace back to excessive Write permissions on service accounts

## Related concepts
[[Read Permission]] [[Execute Permission]] [[Least Privilege]] [[Bell-LaPadula Model]] [[Discretionary Access Control]]