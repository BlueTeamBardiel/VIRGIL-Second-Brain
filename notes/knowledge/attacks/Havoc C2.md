# Havoc C2

## What it is
Think of it like a puppet master's control board — Havoc is an open-source Command and Control (C2) framework that lets attackers issue commands to compromised systems, collect output, and manage entire networks of infected hosts from a single interface. Released publicly in 2022, it was specifically designed to evade modern EDR solutions that had learned to fingerprint older frameworks like Cobalt Strike.

## Why it matters
In 2023, threat actors were observed deploying Havoc's "Demon" implant against government and financial sector targets as a direct alternative to Cobalt Strike, leveraging its built-in sleep obfuscation and indirect syscalls to bypass CrowdStrike and Microsoft Defender. Defenders who only tuned detection rules for Cobalt Strike beacon traffic were completely blind to the activity, illustrating why signature-based detection alone fails against evolving tooling.

## Key facts
- **Demon implant**: Havoc's default agent, written in C, supports sleep masking, AMSI/ETW patching, and indirect syscalls to evade user-mode hooks
- **Teamserver model**: Uses a central teamserver with an operator UI, similar to Cobalt Strike's architecture — multiple red teamers can collaborate on a single campaign
- **Protocol flexibility**: Supports HTTP, HTTPS, and SMB listeners, making traffic blending into normal web activity straightforward
- **Shellcode injection**: Natively supports multiple process injection techniques including Process Hollowing and Thread Hijacking
- **EDR evasion focus**: Built-in Heaven's Gate technique enables switching from 32-bit to 64-bit execution to bypass user-mode API hooks — a key differentiator from older frameworks

## Related concepts
[[Command and Control (C2)]] [[Cobalt Strike]] [[EDR Evasion]] [[Process Injection]] [[AMSI Bypass]] [[Syscall Hooking]]