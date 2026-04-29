# WSUS

## What it is
Think of WSUS as a trusted librarian inside your corporate network — instead of every employee fetching books (updates) directly from the publisher (Microsoft), they all borrow from this one pre-vetted internal collection. Windows Server Update Services (WSUS) is a Microsoft server role that allows organizations to centrally download, approve, and distribute Windows updates to endpoints on their network, rather than having each machine pull directly from Microsoft's servers.

## Why it matters
WSUS has been weaponized in a well-documented attack class called **WSUS hijacking**: if the WSUS server communicates over HTTP instead of HTTPS, an attacker with a man-in-the-middle position can intercept update responses and deliver malicious binaries disguised as legitimate patches — the endpoint trusts WSUS implicitly. This technique was notably exploited in the wild and demonstrated by researchers using tools like **WSUXploit** and **PyWSUS**, achieving SYSTEM-level code execution on domain-joined machines.

## Key facts
- WSUS operates on **port 8530 (HTTP)** or **8531 (HTTPS)**; unencrypted deployments are vulnerable to MitM patch-injection attacks
- Clients are directed to a WSUS server via **Group Policy** (`HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate`)
- WSUS does **not validate the integrity of update packages** beyond checking that they are signed by Microsoft — attackers abuse this by wrapping malicious payloads in legitimate signed installers
- Compromise of the WSUS server itself represents a **high-impact lateral movement vector** — an attacker can push malicious "updates" to every managed endpoint simultaneously
- Hardening includes enforcing **HTTPS**, restricting WSUS admin access, and monitoring for unexpected approved updates in the console

## Related concepts
[[Man-in-the-Middle Attack]] [[Group Policy]] [[Patch Management]] [[Privilege Escalation]] [[Supply Chain Attack]]