# obfuscation

## What it is
Like a magician hiding a coin by palming it in plain sight — the coin still exists, but your eye can't track it — obfuscation makes code or data deliberately difficult to analyze without altering its core functionality. Precisely: obfuscation is the practice of transforming readable content (source code, commands, payloads) into a form that is harder for humans or automated tools to understand, while preserving its original behavior.

## Why it matters
Malware authors routinely obfuscate PowerShell payloads to bypass signature-based antivirus detection — for example, encoding a `Invoke-Mimikatz` command in Base64 so the raw string never appears in memory or on disk in recognizable form. Security analysts performing malware triage must de-obfuscate scripts before they can determine what a sample actually does, making this a core skill for incident responders. Threat actors also obfuscate C2 traffic using custom encoding to evade network-based IDS signatures.

## Key facts
- **Not encryption**: Obfuscation does not require a key and is not designed for confidentiality — it targets analyst comprehension, not cryptographic secrecy.
- **Common techniques**: String encoding (Base64, hex), variable renaming, dead code insertion, packing, and control-flow flattening are standard obfuscation methods.
- **MITRE ATT&CK mapping**: Obfuscation appears under **T1027 (Obfuscated Files or Information)** — a frequently tested technique on CySA+.
- **Defense evasion primary goal**: On Security+, obfuscation is categorized under *defense evasion*, not data exfiltration or persistence.
- **Living-off-the-land synergy**: Attackers combine obfuscation with LOLBins (e.g., `certutil`, `mshta`) to execute encoded payloads using trusted Windows binaries, making detection harder.

## Related concepts
[[encoding]] [[polymorphic malware]] [[defense evasion]] [[steganography]] [[indicator of compromise]]