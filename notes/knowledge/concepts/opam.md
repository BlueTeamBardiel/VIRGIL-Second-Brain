# opam

## What it is
Like pip for Python or npm for Node.js, but for the OCaml ecosystem — opam is the OCaml Package Manager, a command-line tool that installs, upgrades, and manages OCaml libraries and compiler versions in isolated "switches" (sandboxed environments). It resolves dependency graphs and maintains reproducible build environments for OCaml projects.

## Why it matters
Supply chain attacks targeting language package managers are a growing threat vector — a malicious or typosquatted opam package could execute arbitrary code during installation via opam's build hooks. Security tools like Tezos blockchain nodes, parts of MirageOS (a security-focused unikernel framework), and formal verification tools are built in OCaml, meaning a compromised opam package could undermine cryptographic infrastructure or trusted execution environments.

## Key facts
- opam packages can define **build scripts and install hooks** that execute arbitrary shell commands during `opam install`, making package integrity verification critical
- Uses **opam switches** to create isolated compiler/library environments, similar to Python virtualenvs, reducing dependency conflicts and blast radius from compromised packages
- The official package repository is **opam.ocaml.org**; organizations should pin to specific package versions and checksums to prevent substitution attacks
- opam supports **`opam-lock`** files and **reproducible builds**, which are key controls against supply chain tampering
- OCaml's strong type system and formal verification roots make it popular for **security-critical software** (Mirage firewall, cryptographic libraries), elevating the risk profile of its package manager

## Related concepts
[[Supply Chain Attack]] [[Package Manager Security]] [[Dependency Confusion]] [[Sandboxing]] [[Build Pipeline Security]]