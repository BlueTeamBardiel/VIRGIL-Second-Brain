# memory

## What it is
Think of memory like a chef's prep counter — it holds everything actively being worked on right now, but gets wiped clean when the kitchen closes. Technically, memory (RAM) is volatile storage where the CPU reads and writes data during active execution, holding running processes, encryption keys, passwords, and OS structures that disappear when power is lost.

## Why it matters
In a cold boot attack, an adversary physically chills RAM chips with compressed air to slow the decay of volatile data, then transplants the chips to a controlled machine and dumps the contents — recovering full-disk encryption keys like BitLocker's VMK even from a "locked" laptop. This is why some high-security environments require memory encryption (Intel TME) or mandatory power-off policies rather than sleep/hibernate modes.

## Key facts
- RAM is **volatile** — data persists only seconds to minutes after power loss under normal conditions, but cold temperatures can extend this to minutes or longer
- **Buffer overflow attacks** exploit memory by writing past an allocated buffer's boundary, overwriting adjacent memory regions like return addresses to hijack execution flow
- **Heap vs. stack**: stack memory stores function call frames and local variables (LIFO); heap stores dynamically allocated objects — both are common attack surfaces
- Memory forensics tools (Volatility, Rekall) can extract running processes, network connections, registry hives, and plaintext credentials from RAM dumps
- **ASLR (Address Space Layout Randomization)** is a key defense that randomizes where code, stack, and heap are loaded in memory, making exploitation significantly harder

## Related concepts
[[buffer overflow]] [[ASLR]] [[cold boot attack]] [[memory forensics]] [[heap spraying]]