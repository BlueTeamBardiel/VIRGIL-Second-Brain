# thin_vec

## What it is
Like a collapsed accordion folder that stores its spine and papers in one continuous strip of memory rather than separate pouches, a `thin_vec` (thin vector) is a heap-allocated, dynamically-sized array that stores its length and capacity metadata *inline* with the data pointer — reducing the struct size to a single machine word (pointer) instead of the typical three (pointer + length + capacity). Common in Rust ecosystem crates like `thin-vec`, it trades a small indirection cost for a dramatically smaller struct footprint.

## Why it matters
Memory layout optimizations like thin_vec become attack surfaces when developers mishandle the inline metadata. A vulnerability in Firefox (which ships `thin-vec` in its Rust components) where the inline length field is corrupted — via a type confusion or out-of-bounds write — could allow an attacker to forge the vector's perceived size, enabling heap reads or writes beyond intended boundaries, directly feeding into browser exploitation chains like those seen in Pwn2Own competitions.

## Key facts
- A standard Rust `Vec<T>` is 24 bytes on 64-bit systems (pointer + usize length + usize capacity); `ThinVec<T>` is 8 bytes — one pointer to a heap block containing the header and data.
- The heap block layout is: `[capacity: u32][length: u32][data...]` — corrupting these 8 bytes is equivalent to forging the entire vector's bounds.
- Firefox and Gecko use `thin-vec` at the FFI boundary between C++ and Rust to ensure ABI compatibility and smaller struct sizes in hot paths.
- Out-of-bounds writes targeting the inline header are a form of **heap metadata corruption**, relevant to CWE-122 and exploitable via heap spray techniques.
- Mitigations include Rust's safe API (bounds-checked indexing), but `unsafe` blocks that touch raw pointers bypass these guarantees entirely.

## Related concepts
[[heap_overflow]] [[memory_safety]] [[type_confusion]]