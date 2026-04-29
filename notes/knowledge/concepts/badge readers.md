# badge readers

## What it is
Like a bouncer checking a wristband at a concert, a badge reader is a physical access control device that verifies a credential before granting entry. Precisely, it's an electronic system that reads data from a proximity card, smart card, or key fob — typically via RFID or NFC — and compares it against an access control list to permit or deny physical access. The reader itself is just the sensor; the decision logic lives in a backend access control panel.

## Why it matters
In the 2012 Wyndham Hotels breach, attackers who gained physical access to back-office systems could have been stopped cold by properly segmented badge-controlled server rooms. Badge reader logs are also a critical forensic artifact — they can prove or disprove an insider's alibi by showing exactly which doors they badged through and when, making them as valuable as SIEM logs during incident response.

## Key facts
- **RFID skimming** is the dominant attack: an attacker holds a concealed reader near a victim's badge and clones the credential without contact, often within inches
- Standard proximity cards (125 kHz HID) transmit their ID in plaintext with **no encryption or authentication**, making them trivially clonable
- **Tailgating/piggybacking** bypasses badge readers entirely by following an authorized user through a door — a social engineering attack no technology alone prevents
- Badge readers should be combined with **mantrap/airlock vestibules** and PIN entry (multi-factor physical access) to mitigate both cloning and tailgating
- Access logs from badge systems are **audit trail evidence** and fall under physical security controls in frameworks like NIST SP 800-53 (PE family) and ISO 27001 Annex A.11

## Related concepts
[[RFID]] [[physical access controls]] [[tailgating]] [[multi-factor authentication]] [[access control lists]]