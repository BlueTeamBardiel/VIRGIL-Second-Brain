# Babuk

## What it is
Like a master locksmith who publishes their entire toolkit online after retiring, Babuk's operators leaked their full ransomware source code in 2021 — and that single act spawned dozens of copycat variants. Babuk is a ransomware-as-a-service (RaaS) operation first observed in early 2021, notable for targeting large enterprises and critical infrastructure using a custom encryption scheme, and later for its source code leak that dramatically lowered the barrier to entry for threat actors worldwide.

## Why it matters
In April 2021, Babuk operators attacked the Washington D.C. Metropolitan Police Department, exfiltrating 250GB of sensitive data including officer personnel files and threatening to expose confidential informant information — a classic double extortion tactic. When their source code leaked to underground forums in June 2021, security teams suddenly faced a proliferation of new ransomware families (e.g., Babuk Tortilla, ESXiArgs) all sharing the same underlying DNA, making threat attribution significantly harder.

## Key facts
- Babuk was among the **first ransomware families to target VMware ESXi servers**, using a Linux/ELF variant to encrypt virtual machine files directly
- Employs **double extortion**: encrypts data AND threatens to publish stolen data on a leak site ("payload.bin" blog)
- Uses **Elliptic Curve Diffie-Hellman (ECDH)** key exchange combined with **ChaCha8** stream cipher for encryption — a deviation from the common RSA+AES pattern
- Source code leak in June 2021 on a Russian-language forum enabled at least **10+ new ransomware families** to emerge using the codebase
- Operators publicly stated they were **shutting down** after the D.C. police attack attracted too much law enforcement attention — a rare self-retirement announcement

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[VMware ESXi Vulnerabilities]] [[ChaCha Encryption]] [[Threat Attribution]]