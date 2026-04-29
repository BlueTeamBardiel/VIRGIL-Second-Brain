# next-generation antivirus

## What it is
Where traditional antivirus is like a bouncer checking a guest list of known troublemakers, NGAV is a behavioral profiler who watches *how* everyone acts on the dance floor — stopping unknown threats by their movements, not their names. Next-generation antivirus (NGAV) is an endpoint protection technology that replaces static signature-based detection with machine learning, behavioral analysis, exploit prevention, and threat intelligence integration to identify and block both known and unknown malware in real time.

## Why it matters
In 2017, the NotPetya attack devastated organizations running traditional AV because its wiper component had no prior signature to match. NGAV solutions with memory-protection and behavioral monitoring could flag the anomalous MBR overwrite behavior before data destruction completed — demonstrating that signature-free detection is now a survival requirement, not a luxury.

## Key facts
- NGAV operates using **machine learning models** trained on millions of file attributes, allowing it to classify never-before-seen malware without a signature database update
- It includes **exploit prevention** techniques that block memory-based attacks (e.g., buffer overflows, ROP chains) at runtime — catching fileless malware that never touches disk
- **Behavioral analysis** monitors process trees, network calls, and registry changes; a Word document spawning `cmd.exe` triggers an alert regardless of whether the payload is known
- NGAV is a core component of **EDR (Endpoint Detection and Response)** platforms — the two are often bundled but are distinct capabilities
- Unlike traditional AV, NGAV can operate **without daily signature updates**, making it effective in air-gapped or bandwidth-constrained environments

## Related concepts
[[endpoint detection and response]] [[fileless malware]] [[behavioral analysis]] [[machine learning in security]] [[threat intelligence]]