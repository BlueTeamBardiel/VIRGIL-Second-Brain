# STM32WB55

## What it is
Think of it as a tiny apartment building with two separate tenants who share a wall but have strict lease agreements about what they can access — one tenant handles your app, the other handles the radio. The STM32WB55 is a dual-core wireless microcontroller from STMicroelectronics featuring an ARM Cortex-M4 application core and a Cortex-M0+ dedicated to managing Bluetooth Low Energy (BLE) and IEEE 802.15.4 (Zigbee/Thread) radio protocols. The two cores communicate via a hardware mailbox with Inter-Processor Communication (IPC) channels, enforcing separation between user application logic and RF stack execution.

## Why it matters
In IoT penetration testing, the STM32WB55 is a high-value target because attackers who compromise the M4 application core may attempt to abuse the IPC mailbox to inject malicious commands into the BLE stack running on the M0+ — potentially enabling unauthorized BLE advertisement spoofing or pairing bypass. Researchers have also exploited improperly locked JTAG/SWD debug interfaces on STM32WB55 devices to extract firmware containing hardcoded BLE encryption keys, enabling full device impersonation.

## Key facts
- Contains a **hardware-enforced security boundary** between the application CPU (M4) and the wireless CPU (M0+), but misconfiguration of IPC channels can collapse this boundary
- Supports **Secure Boot** and **Root of Trust** via STM32 TrustZone and option bytes — if option bytes are left at default, readout protection (RDP) level remains 0 (fully open)
- **RDP Level 2** permanently disables JTAG/SWD debug access; downgrading triggers a full flash erase, making firmware extraction after-the-fact impossible
- Used widely in **BLE-based medical devices, smart locks, and industrial sensors** — high-consequence targets for firmware attacks
- The **RF stack (FUS - Firmware Update Service)** runs in privileged mode on M0+; vulnerabilities here affect the entire radio subsystem

## Related concepts
[[Bluetooth Low Energy Security]] [[JTAG Debug Interface Exploitation]] [[Secure Boot and Root of Trust]]