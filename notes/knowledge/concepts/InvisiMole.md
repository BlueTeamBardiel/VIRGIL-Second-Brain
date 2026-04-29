# InvisiMole

## What it is
Like a ghost that picks up a skeleton key from a passing stranger, InvisiMole is a sophisticated APT malware framework that hitches rides inside legitimate tools to avoid detection. Precisely, it is a modular espionage toolkit attributed to the Gamaredon-aligned threat actor group, composed of two primary backdoor components (RC2FM and RC2CL) designed for long-term covert surveillance of high-value targets.

## Why it matters
In documented attacks against Ukrainian and Eastern European military and diplomatic organizations, InvisiMole was delivered by piggybacking inside legitimate software like Total Commander and ffmpeg — a technique called DLL hijacking — allowing it to bypass application whitelisting controls entirely. Defenders who learned from this campaign now prioritize DLL search order hardening and monitoring for unexpected child processes spawned by trusted applications.

## Key facts
- Composed of two backdoor modules: **RC2FM** (lighter, basic recon) and **RC2CL** (full-featured surveillance including screen capture, camera/microphone activation, and geolocation)
- Uses **DLL side-loading and hijacking** to execute malicious code under the identity of legitimate, signed processes
- Attributed to a threat actor tracked as **InvisiMole Group**, with overlapping infrastructure ties to **Gamaredon APT**
- Employs **blended delivery**: Gamaredon provides initial access, then InvisiMole is deployed only on high-priority targets — a classic tiered intrusion model
- First publicly documented by **ESET researchers in 2018**, with updated campaigns observed through 2022, showing active development and evasion refinement

## Related concepts
[[DLL Hijacking]] [[Advanced Persistent Threat]] [[Backdoor]] [[Living off the Land]] [[Lateral Movement]]