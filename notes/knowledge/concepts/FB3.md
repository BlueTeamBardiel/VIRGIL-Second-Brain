# FB3

## What it is
Like a master key that unlocks any door in a building by knowing only the building's blueprint, FB3 (Fast Block Cipher with 3 rounds) is a lightweight symmetric encryption algorithm designed for constrained environments using a reduced-round structure to achieve speed at the cost of some cryptographic depth. It is a stream-cipher-adjacent block cipher variant optimized for IoT and embedded systems where computational resources are severely limited.

## Why it matters
In a real-world attack scenario, a penetration tester auditing an industrial control system (ICS) network discovers that sensor nodes are encrypting telemetry data using FB3. Because of its reduced round count, differential cryptanalysis can recover the key with far fewer chosen plaintext pairs than AES would require, meaning an attacker who intercepts enough traffic can decrypt command-and-control messages and potentially manipulate physical processes in a power grid or water treatment facility.

## Key facts
- FB3 uses only **3 encryption rounds**, making it computationally cheap but significantly more vulnerable to differential and linear cryptanalysis compared to AES (10+ rounds)
- Designed for **resource-constrained devices** (8-bit microcontrollers, RFID tags, sensor nodes) where AES is too computationally expensive
- The reduced round count means the **avalanche effect is incomplete** — changes in plaintext do not fully diffuse through the ciphertext, creating exploitable statistical patterns
- FB3 is considered **cryptographically weak** by modern standards and is flagged in security audits as a finding under the category of "insecure cryptographic implementation"
- When found in IoT firmware, FB3 is often a compliance violation under **IEC 62443** (Industrial Cybersecurity Standard) and NIST SP 800-82 guidance

## Related concepts
[[Differential Cryptanalysis]] [[Lightweight Cryptography]] [[Block Cipher Modes of Operation]] [[AES]] [[IoT Security]]