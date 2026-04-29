# EIA

## What it is
Like a property inspector who examines a building *before* you buy it, an Electromagnetic Interference Analysis examines electronic systems by measuring the unintended radio signals they leak. EIA (also called emissions analysis or emanations analysis) is the process of capturing and interpreting electromagnetic signals unintentionally radiated by electronic hardware to extract sensitive data or fingerprint devices.

## Why it matters
A nation-state attacker parks a van outside a government building and uses a directional antenna to capture electromagnetic emissions from CRT monitors or keyboards — reconstructing keystrokes and screen content without ever touching the network. This is the real-world basis of **TEMPEST** surveillance, which drove the NSA to create shielding standards for classified systems handling sensitive information.

## Key facts
- EIA is a **passive, non-invasive** attack vector — no network connection or physical access required, making it nearly undetectable
- The government countermeasure is **TEMPEST** (NSA) / **EMSEC** (emissions security) — shielding facilities and devices to limit detectable radiation
- **Van Eck phreaking** is the classic EIA exploit: reconstructing a monitor's display from its electromagnetic emissions from hundreds of meters away
- Faraday cages, **RF shielding**, and distance-based controls are primary physical countermeasures
- EIA falls under the broader **side-channel attack** category alongside power analysis, timing attacks, and acoustic cryptanalysis — all exploit unintended physical information leakage rather than logical vulnerabilities

## Related concepts
[[TEMPEST]] [[Side-Channel Attack]] [[Van Eck Phreaking]] [[Faraday Cage]] [[Physical Security Controls]]