# VM snapshots

## What it is
Like pressing pause on a movie and saving your exact spot — including every frame in the buffer — a VM snapshot captures the complete state of a virtual machine at a precise moment in time: memory contents, disk state, CPU registers, and running processes. If anything goes wrong, you can rewind to that exact frame instantly.

## Why it matters
Malware analysts use snapshots as a safety net when executing suspicious samples in a sandbox: they detonate the malware, observe its behavior, then roll the VM back to a clean pre-infection state in seconds. Conversely, attackers who compromise a hypervisor can steal snapshot files (.vmdk, .vmsn) which may contain plaintext credentials, encryption keys, or session tokens that were resident in memory at snapshot time.

## Key facts
- Snapshots capture **volatile memory state**, meaning credentials, decrypted data, and active session keys can be extracted from snapshot files offline using tools like Volatility
- Snapshot files are typically stored as **.vmdk** (disk) and **.vmsn/.vmem** (memory state) and are not encrypted by default in VMware environments
- **Snapshot sprawl** — accumulating too many snapshots — degrades performance and increases attack surface by leaving sensitive state data on disk
- In incident response, snapshots serve as **forensic evidence preservation**, capturing a compromised system's exact memory state before remediation destroys volatile artifacts
- Hypervisor-level snapshot access **bypasses guest OS security controls** entirely — the host sees raw disk and memory with no authentication from the guest OS

## Related concepts
[[Hypervisor Security]] [[Memory Forensics]] [[Sandbox Analysis]] [[Virtual Machine Escape]] [[Data at Rest Encryption]]