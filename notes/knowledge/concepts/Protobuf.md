# Protobuf

## What it is
Think of Protobuf like a compressed shipping label: instead of writing out "Name: Alice, Age: 30" in plain English, you stamp a tiny binary code that only people with the matching decoder ring can read. Protocol Buffers (Protobuf) is Google's language-neutral binary serialization format that encodes structured data into compact binary streams using predefined `.proto` schema files.

## Why it matters
Because Protobuf data is binary and not human-readable without the schema, attackers intercepting gRPC API traffic (which uses Protobuf by default) may struggle to analyze payloads — but defenders face the same problem during incident response. In 2021, several cloud-native applications were found vulnerable to Protobuf deserialization attacks where malformed binary payloads caused crashes or unexpected code paths, similar to classic XML/JSON injection but harder to detect with standard WAF rules tuned for text-based formats.

## Key facts
- Protobuf encodes fields by **field number + wire type**, not field name — the schema (`.proto` file) is required to decode meaningful data, making schema theft a real intelligence risk
- Binary format makes it **invisible to most WAFs and IDS signatures** tuned for text-based payloads like JSON or XML
- **Deserialization vulnerabilities** apply to Protobuf just like Java serialization — malformed messages can trigger parser bugs, buffer overflows, or denial of service
- Protobuf is the default encoding for **gRPC**, making it ubiquitous in microservice architectures and Kubernetes environments
- Missing field validation in `.proto` definitions can lead to **type confusion attacks** where unexpected field values alter application logic

## Related concepts
[[Deserialization Attacks]] [[gRPC Security]] [[API Security]] [[Data Serialization]] [[Man-in-the-Middle Attack]]