# reference counting

## What it is
Like a library book with a sign-out sheet — the book only gets shelved (freed) when the last borrower returns it. Reference counting is a memory management technique where each object tracks how many pointers currently point to it; when that count drops to zero, the memory is automatically released.

## Why it matters
Use-after-free vulnerabilities frequently arise from flawed reference counting — if an attacker can manipulate the count to reach zero prematurely, the memory gets freed while a pointer still exists. Exploiting this, attackers can reclaim that freed memory with attacker-controlled data and redirect execution flow. CVE-2021-30551 (Chrome V8 engine) was a real-world use-after-free caused by exactly this class of reference counting error, enabling remote code execution.

## Key facts
- A **use-after-free** bug occurs when reference count hits zero and memory is freed, but a dangling pointer to that memory is still used
- **Integer overflow** in the reference counter itself is exploitable — wrapping a counter from max value back to zero causes premature deallocation
- **Double-free** errors can occur when reference counting logic is implemented incorrectly, freeing the same object twice and corrupting the heap
- Modern mitigations like **AddressSanitizer (ASan)** and **memory-safe languages** (Rust uses ownership + reference counting via `Rc<T>`/`Arc<T>` with compile-time checks) directly address these weaknesses
- Browser engines (V8, SpiderMonkey) and OS kernels are high-value targets because they use reference counting extensively for complex object graphs

## Related concepts
[[use-after-free]] [[heap exploitation]] [[memory safety]] [[dangling pointers]] [[integer overflow]]