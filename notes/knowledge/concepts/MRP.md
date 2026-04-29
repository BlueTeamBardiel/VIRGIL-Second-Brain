# MRP

## What it is
Like a thief who swaps the price tag on a $5 item to match a $500 item — the register rings up whatever label it sees. **Machine Readable Passports (MRP)** are standardized travel documents containing an optical Machine Readable Zone (MRZ) and, in modern versions, an RFID chip storing biometric and identity data, conforming to ICAO Document 9303 specifications.

## Why it matters
In 2008, researchers demonstrated that MRP RFID chips could be cloned by skimming the wireless signal in crowded areas, allowing fabrication of functional counterfeit passports. This matters defensively because border control systems rely on cryptographic validation (Basic Access Control / Active Authentication) to detect forgeries — illustrating how physical identity documents are attack surfaces, not just logical systems.

## Key facts
- MRPs use a **Machine Readable Zone (MRZ)**: two lines of OCR-B text encoding name, nationality, document number, DOB, and checksum digits
- The embedded RFID chip (ePassport, "biometric passport") stores a facial image and optionally fingerprints, protected by **Basic Access Control (BAC)** or the stronger **Password Authenticated Connection Establishment (PACE)**
- **Skimming attacks** exploit the fact that passive RFID chips broadcast when energized — BAC requires optical MRZ data as a key to unlock chip communication, mitigating unauthorized reads
- **Active Authentication (AA)** uses asymmetric cryptography (challenge-response) to prove a chip is genuine and prevent exact cloning
- ICAO Doc 9303 defines MRP standards globally; non-compliant documents raise red flags in automated border control (ABC) systems

## Related concepts
[[RFID Security]] [[Biometric Authentication]] [[Physical Security Controls]]