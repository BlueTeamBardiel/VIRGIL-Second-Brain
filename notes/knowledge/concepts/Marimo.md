# Marimo

## What it is
Like a chameleon that changes its appearance every time a predator looks at it, Marimo is a type of computer worm that actively mutates its code to evade detection. Specifically, it is a self-replicating malware variant that employs polymorphic techniques to continuously alter its binary signature while preserving its core malicious payload and functionality.

## Why it matters
In a real-world scenario, a security analyst relying solely on signature-based antivirus detection would completely miss a Marimo infection because each copy of the worm presents a different hash and byte pattern. This highlights why behavioral detection engines and heuristic analysis are critical complements to traditional signature scanning — organizations depending on legacy AV tools remain exposed to polymorphic worm families like Marimo long after initial compromise.

## Key facts
- Marimo is classified as a **polymorphic worm**, meaning it changes its observable code signature with each replication cycle while its functional logic remains intact
- First identified targeting networked systems, it spreads autonomously without requiring user interaction, distinguishing worms from trojans
- Its polymorphic engine encrypts the payload and mutates the decryption stub, which is the primary technique used to defeat static signature matching
- Detection requires **heuristic or behavioral analysis** — monitoring for unusual file replication activity, abnormal network propagation, or suspicious process spawning
- Relevant to Security+ objective domain covering **malware types** (worms, polymorphic malware) and **threat intelligence** concepts in CySA+

## Related concepts
[[Polymorphic Malware]] [[Metamorphic Malware]] [[Signature-Based Detection]] [[Heuristic Analysis]] [[Worm]]