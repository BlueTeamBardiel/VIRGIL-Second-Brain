# mutexes

## What it is
Like a bathroom with a single key hanging on a hook outside the door — only one person can have the key and use the room at a time; everyone else waits. A mutex (mutual exclusion object) is a kernel-level synchronization primitive that prevents multiple threads or processes from accessing a shared resource simultaneously. Malware commonly uses mutexes to ensure only one instance of itself runs on a system at a time.

## Why it matters
Malware analysts and incident responders hunt for mutex names as reliable indicators of compromise (IOCs). When a RAT or ransomware strain creates a named mutex like `{A1B2-C3D4-MALWARE}` on startup, defenders can detect re-infection attempts or pivot across environments by searching for that exact string — it's effectively a malware fingerprint left in memory. Conversely, defenders who discover a mutex can create it themselves to "vaccinate" a machine, tricking the malware into thinking it's already running.

## Key facts
- Mutexes exist in **kernel space** and are visible via tools like Process Explorer, WinObj, or Volatility's `handles` plugin during memory forensics
- Named mutexes persist **system-wide** and can be created/queried cross-process, making them ideal for both synchronization and malware C2 coordination signals
- The **mutex vaccination technique** (creating the mutex manually) is a legitimate defensive trick against single-instance malware, though sophisticated malware randomizes mutex names to defeat this
- On Windows, mutexes are accessed via `CreateMutex()` / `OpenMutex()` Win32 API calls — both are flagged by behavioral sandboxes
- Mutex name analysis is a **Tier 1 IOC** used in threat intelligence sharing (STIX/TAXII format supports mutex objects natively)

## Related concepts
[[indicators of compromise]] [[malware analysis]] [[memory forensics]] [[Windows API]] [[sandbox analysis]]