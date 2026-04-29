# shared block

## What it is
Like two tenants in adjacent hotel rooms sharing a thin wall — what one does can be heard by the other. A shared block is a unit of storage (in memory, cache, or disk) that is simultaneously accessible by multiple processes, users, or virtual machines, often as a performance optimization to avoid redundant data duplication.

## Why it matters
In cloud environments, hypervisors use shared memory blocks between VMs to reduce RAM usage (a technique called memory deduplication). Attackers can exploit this via the **Rowhammer** attack or **cross-VM side-channel attacks** — by observing timing differences in how fast a shared block responds, a malicious VM can infer what data a neighboring VM is accessing, potentially leaking cryptographic keys or sensitive data without ever directly reading the victim's memory.

## Key facts
- **Copy-on-Write (CoW)** is the standard mitigation: shared blocks remain shared until one party writes to them, at which point a private copy is made — preventing silent data corruption between processes.
- Memory deduplication (used by VMware, KVM) deliberately creates shared blocks to save RAM, but this is a known side-channel attack surface.
- **TOCTTOU (Time-of-Check to Time-of-Use)** vulnerabilities frequently arise in shared block scenarios, where an attacker races to modify a block between a security check and the actual use.
- Shared blocks in disk storage (think cloud object stores) can cause **data remnance** issues if deprovisioning doesn't properly zero or reallocate blocks.
- In containerized environments, shared kernel memory blocks between containers are a key reason why containers provide weaker isolation than full VMs.

## Related concepts
[[side-channel attack]] [[memory deduplication]] [[TOCTTOU]] [[hypervisor security]] [[Copy-on-Write]]