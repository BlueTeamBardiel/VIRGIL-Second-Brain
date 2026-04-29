# Embedded Systems

## What it is
Think of a Swiss Army knife permanently sealed in a specific configuration — it does exactly what it was built to do, and you can't swap out the blades. Embedded systems are purpose-built computing devices with fixed hardware and firmware, designed to perform dedicated functions within a larger system. Unlike general-purpose computers, they run a single application or tightly scoped set of tasks, often with no traditional OS or user interface.

## Why it matters
In 2015, security researchers Charlie Miller and Chris Valasek remotely compromised a Jeep Cherokee's embedded ECU (engine control unit) through its Uconnect system, executing code over a cellular connection to cut the transmission on a highway. This attack demonstrated how embedded systems in critical infrastructure and consumer products often lack basic security controls — no authentication, no encryption, firmware burned at the factory and never patched. Defenders must think about firmware signing, network segmentation, and supply chain integrity to protect these devices.

## Key facts
- Embedded systems often run **RTOS (Real-Time Operating Systems)** like FreeRTOS or VxWorks, which prioritize timing over security features
- Firmware can frequently be **extracted via JTAG or UART debug ports** — physical access bypasses software defenses entirely
- Most embedded devices are **EOL (End of Life) in the field** yet still operational, meaning known CVEs go unpatched for years
- **Default credentials** are endemic — hardcoded usernames/passwords in firmware are a top attack vector (e.g., Mirai botnet exploited this at scale)
- Embedded devices typically lack **ASLR, DEP, or stack canaries**, making memory corruption exploits far easier than on modern desktops

## Related concepts
[[Firmware Analysis]] [[IoT Security]] [[JTAG Debugging]] [[Supply Chain Attacks]] [[SCADA Systems]]