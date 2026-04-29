# Varint

## What it is
Like a parking garage that charges by the hour but only uses as many ticket stubs as the time actually requires — a 30-minute stay uses one stub, a 300-hour stay uses two — a varint (variable-length integer) is an encoding scheme where small numbers take fewer bytes than large numbers. Specifically, each byte uses 7 bits for data and 1 bit to signal whether another byte follows, allowing integers to be encoded in 1–10 bytes depending on their magnitude.

## Why it matters
Protocol Buffer (protobuf) parsing vulnerabilities have leveraged malformed varints to trigger integer overflows or infinite loops in parsers — an attacker sends a crafted protobuf message with a varint whose continuation bits never terminate, causing a server to spin indefinitely or allocate excessive memory. This class of bug appeared in real gRPC implementations and requires careful bounds checking to defend against.

## Key facts
- A varint uses the **most significant bit (MSB)** of each byte as a continuation flag: `1` means "more bytes follow," `0` means "this is the last byte."
- Maximum varint size in Protocol Buffers is **10 bytes** (for 64-bit integers), providing a natural parsing boundary.
- Malformed varints (e.g., 11 continuation bytes) are a denial-of-service vector if parsers lack length validation.
- Varints appear in **Protocol Buffers, QUIC, LEB128 (DWARF debug format), and Bitcoin's serialization format** — all common in network and binary protocol analysis.
- During forensic or malware analysis, recognizing varint encoding is essential when reversing custom binary protocols or C2 communication formats that embed protobuf.

## Related concepts
[[Protocol Buffers]] [[Integer Overflow]] [[Binary Protocol Analysis]]