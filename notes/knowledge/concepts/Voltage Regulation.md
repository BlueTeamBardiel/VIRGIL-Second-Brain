# Voltage Regulation

## What it is
Think of voltage regulation like a bouncer at a club — it enforces strict limits on who (what electrical levels) gets in, turning away anyone too high or too low. Precisely defined: voltage regulation is the process of maintaining a stable, consistent electrical voltage output to systems regardless of fluctuations in the input power or load demand. It protects hardware from receiving damaging over-voltage or under-voltage conditions.

## Why it matters
In physical security and operational resilience, attackers can deliberately introduce power anomalies — voltage spikes or sags — to crash systems, corrupt data, or induce hardware failures without touching a single keyboard. A well-documented technique called a "voltage glitching attack" manipulates power supply levels to bypass secure boot processes or extract cryptographic keys from microcontrollers. Proper voltage regulation hardware (UPS units, surge protectors, line conditioners) forms the first physical layer of defense against both intentional and environmental power attacks.

## Key facts
- **UPS (Uninterruptible Power Supply)** provides both voltage regulation and battery backup — a critical control for availability in the CIA triad.
- **Surge protectors** only guard against over-voltage spikes; they do NOT protect against brownouts (under-voltage) or complete power loss.
- **Line conditioners** actively filter and stabilize voltage, making them superior to basic surge protectors for sensitive equipment.
- **Voltage glitching** is a real-world hardware attack used to defeat TPM chips and bypass firmware protections — relevant to supply chain and physical security threats.
- NIST SP 800-53 control **PE-11 (Emergency Power)** and **PE-12 (Emergency Lighting)** address power stability as physical security requirements.

## Related concepts
[[Uninterruptible Power Supply]] [[Fault Injection Attacks]] [[Physical Security Controls]]