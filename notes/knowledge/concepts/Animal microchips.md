# Animal microchips

## What it is
Like a library book's barcode sewn under the skin, an animal microchip is a passive RFID transponder (typically 125 kHz or 134.2 kHz) implanted subcutaneously that stores a unique identification number readable by a handheld scanner. It contains no battery — it harvests energy from the scanner's electromagnetic field to transmit its ID. Standards like ISO 11784/11785 govern the data format and communication protocol.

## Why it matters
Animal microchips are a textbook case study in RFID security weaknesses. Security researchers demonstrated that cheap, commercially available RFID readers can clone a pet's microchip ID in seconds, then write that cloned ID to a blank transponder — the same attack vector used against access control cards. More provocatively, researcher Mark Gasson had a chip implanted in his hand that carried a computer virus payload, demonstrating that trusted biological/physical boundaries don't automatically confer data trust.

## Key facts
- Operating frequencies: 125 kHz (older EM4100 chips) and 134.2 kHz (ISO-compliant modern chips); neither frequency is inherently encrypted
- Most animal microchips transmit their ID in **plaintext** with **no authentication**, making eavesdropping and cloning trivially easy with ~$20 hardware
- ISO 11784 defines the data structure; ISO 11785 defines the air interface — knowing the standard means knowing exactly what to intercept
- The same RFID cloning attack applies to HID proximity cards used in building access control — animal chips are a low-stakes lab for understanding a high-stakes attack
- Gasson's 2010 experiment (University of Reading) is the first documented case of a human-implanted device carrying malware, illustrating supply-chain trust issues in implantable hardware

## Related concepts
[[RFID Security]] [[NFC Attacks]] [[Physical Security Controls]]