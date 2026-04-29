# OID

## What it is
Like a universal library catalog number that works across every library on Earth, an Object Identifier (OID) is a globally unique, hierarchically structured numeric string used to unambiguously identify objects in information systems. Defined under ITU-T and ISO standards, OIDs appear as dotted-decimal sequences (e.g., `2.5.4.3`) that traverse a tree from broad root nodes down to specific objects like cryptographic algorithms, certificate attributes, or SNMP MIB variables.

## Why it matters
During certificate-based authentication, attackers have exploited OID confusion in certificate parsing libraries — notably in null-prefix attacks — where a rogue OID value in a Subject Alternative Name field tricks some parsers into accepting fraudulent certificates as legitimate. Defenders analyzing X.509 certificates use OIDs to precisely identify which signing algorithm was used (e.g., `1.2.840.113549.1.1.11` = SHA-256 with RSA), flagging weak algorithms like MD5 (`1.2.840.113549.1.1.4`) during certificate audits.

## Key facts
- OIDs are registered globally; the `2.5` arc belongs to X.500 directory services, making `2.5.4.x` OIDs extremely common in X.509 certificates (e.g., `2.5.4.3` = Common Name)
- SNMP uses OIDs in MIB (Management Information Base) trees to identify network device attributes — attackers enumerate these via SNMP sweeps for reconnaissance
- The `1.3.6.1.4.1` arc is reserved for private enterprise OIDs, meaning vendors register unique sub-arcs for proprietary objects
- Certificate policy OIDs (under `2.5.29.32`) specify how strictly a CA validated identity — EV certificates carry specific policy OIDs browsers check explicitly
- Cryptographic algorithm OIDs are critical for compliance: using deprecated OIDs (MD5, SHA-1) in certificates is a direct finding in PKI audits

## Related concepts
[[X.509 Certificates]] [[PKI]] [[SNMP]] [[ASN.1]] [[Certificate Authority]]