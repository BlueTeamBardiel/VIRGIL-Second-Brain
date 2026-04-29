# Intel Management Engine

## What it is
Think of it as a night security guard who has a master key to every room in the building and keeps working even after everyone else goes home — including the CEO. The Intel Management Engine (ME) is a separate, autonomous microcontroller embedded in Intel chipsets that runs its own operating system (MINIX 3) independently of the main CPU, operating even when the host system is powered off (as long as AC power is present).

## Why it matters
In 2017, researchers discovered **CVE-2017-5689**, a critical authentication bypass vulnerability in Intel's Active Management Technology (AMT) — a feature built on top of ME — that allowed attackers to gain full remote administrative control of corporate machines by sending a blank authentication string. This affected millions of enterprise systems globally, and because ME operates below the OS layer, traditional antivirus and EDR tools were completely blind to the compromise.

## Key facts
- ME operates at **Ring -3**, below the hypervisor (Ring -1), OS kernel (Ring 0), and all user applications — making it the most privileged execution environment on the system
- It has **independent network access** via the NIC, allowing remote management even if the host OS is crashed, off, or wiped
- Runs on a **dedicated ARC processor** with its own RAM, ROM, and flash storage — completely isolated from the host CPU
- ME firmware is stored in the **SPI flash chip** shared with the BIOS/UEFI, but is cryptographically signed by Intel and cannot be easily modified
- Disabling ME entirely is non-trivial; tools like **me_cleaner** can neuter it, but full removal is practically impossible on modern hardware

## Related concepts
[[UEFI Firmware Attacks]] [[Privileged Access Management]] [[Hardware-Based Rootkits]] [[AMT Vulnerability]] [[Ring Architecture]]