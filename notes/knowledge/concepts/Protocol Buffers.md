# Protocol Buffers

## What it is
Think of Protocol Buffers like a tightly compressed shipping manifest written in binary shorthand — instead of verbose XML tags spelling out every label, it encodes structured data into the smallest possible package using pre-agreed field numbers. Protocol Buffers (protobuf) is Google's language-neutral, platform-independent binary serialization format that encodes structured data using a schema (.proto file) compiled into language-specific code. Unlike JSON or XML, the data itself carries no field names — just numeric identifiers mapped to types.

## Why it matters
Because protobuf messages contain no human-readable field names, traditional WAFs and DLP tools that inspect HTTP traffic often fail to detect malicious payloads embedded in protobuf-encoded gRPC calls — attackers can exfiltrate data or deliver command-and-control instructions through binary blobs that signature-based detection completely misses. Security analysts performing traffic analysis must decode protobuf streams against their .proto schemas to understand what's actually being transmitted, making insider threat investigations and API abuse detection significantly more complex.

## Key facts
- Protobuf uses field numbers (not names) in wire format — field 1 might be "username" only if you have the .proto schema; without it, reverse engineering is required
- Wire types encode data as varint, 64-bit, length-delimited, or 32-bit — attackers can craft malformed length-delimited fields to cause buffer overflows or parser crashes
- gRPC (Google's RPC framework) uses protobuf by default over HTTP/2, meaning protobuf traffic analysis requires HTTP/2 awareness
- Deserialization vulnerabilities in protobuf parsers (e.g., CVE-2021-22570) can trigger denial-of-service via carefully crafted messages with null hypotheses in oneof fields
- Schema files (.proto) constitute sensitive intellectual property — leaked schemas enable attackers to craft precise, valid malicious API requests

## Related concepts
[[Serialization and Deserialization Vulnerabilities]] [[API Security]] [[gRPC]] [[Deep Packet Inspection]] [[Data Loss Prevention]]