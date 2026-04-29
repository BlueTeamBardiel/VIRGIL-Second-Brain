# Writing data to T5577 cards

## What it is
Like burning a custom mixtape over an old cassette, writing to a T5577 card overwrites its memory with new RFID data so it mimics a different card entirely. The T5577 is a writable, multi-protocol 125 kHz RFID chip commonly used in penetration testing to clone low-frequency access cards by programming it with a captured card's ID and configuration blocks.

## Why it matters
In a physical penetration test, an attacker who skims an employee's HID Prox card in an elevator can write that card's facility code and card number onto a blank T5577 using a Proxmark3, then walk through badge-controlled doors within minutes. This attack requires no cryptographic breaking — 125 kHz cards like EM4100 and HID Prox transmit credentials in plaintext, making cloning trivially easy.

## Key facts
- T5577 cards use a **block-based memory structure** — Block 0 is the configuration block that sets the output modulation (FSK, ASK, PSK) and data rate to match the target card's protocol
- Writing is done via tools like **Proxmark3** (`lf t55xx write`) or the **Flipper Zero**, which abstract the low-level block writes into simple clone commands
- A misconfigured Block 0 (wrong modulation or bit rate) will cause the cloned card to be **unreadable** by the target reader even if data blocks are correct
- T5577 supports emulation of **EM4100, HID Prox, Indala, and several other** 125 kHz formats — one card, many identities
- **Password protection** can be enabled on T5577 to prevent unauthorized rewrites, but is rarely used in the wild

## Related concepts
[[RFID Cloning]] [[Proxmark3]] [[Physical Security Controls]]