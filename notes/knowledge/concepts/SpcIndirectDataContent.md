# SpcIndirectDataContent

## What it is
Like a wax seal on a medieval letter that proves the king signed it *before* it was sent, SpcIndirectDataContent is the data structure inside Microsoft Authenticode signatures that binds a cryptographic hash of an executable to its digital signature. It is defined in the Authenticode PE specification and embedded in the `SignedData` PKCS#7 structure of a signed Windows PE file, allowing Windows to verify the file hasn't been tampered with since signing.

## Why it matters
Attackers abusing the "signed binary proxy execution" technique (MITRE T1218) have exploited weaknesses in how Authenticode validation handles SpcIndirectDataContent — specifically, crafting malicious PE files that retain a valid signature by keeping the signed hash region intact while appending malicious code to unsigned regions. The Windows loader historically trusted files with valid Authenticode signatures without fully verifying the entire file, meaning malware could ride along on a legitimate signature.

## Key facts
- Contains two fields: `data` (the `SpcAttributeTypeAndOptionalValue` describing the file type) and `messageDigest` (the `DigestInfo` holding the hash algorithm OID and the actual hash value)
- The hash stored here covers *specific sections* of the PE file, not the entire binary — the PE header checksum field, certificate table pointer, and the certificate section itself are explicitly excluded from hashing
- OID for SpcIndirectDataContent is `1.3.6.1.4.1.311.2.1.4`
- Tools like `signtool`, `osslsigncode`, and `sigcheck` (Sysinternals) can extract and verify this structure
- Dual-signing (SHA-1 + SHA-256) means two separate SpcIndirectDataContent structures can exist in one signature, a technique Microsoft uses for backwards compatibility

## Related concepts
[[Authenticode]] [[PE File Format]] [[Code Signing]] [[PKCS#7]] [[Signed Binary Proxy Execution]]