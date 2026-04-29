# concurrent map access

## What it is
Imagine two cooks simultaneously grabbing the same recipe card, one reading while the other scribbles changes — the reader ends up with corrupted instructions. Concurrent map access occurs when multiple threads or goroutines read and write to a shared map data structure simultaneously without synchronization, causing race conditions, data corruption, or application crashes.

## Why it matters
In Go-based microservices (a common backend for cloud-native security tools), unprotected concurrent map writes cause panics that crash the entire process — a denial-of-service vector attackers can trigger by flooding endpoints that force simultaneous cache writes. Security monitoring daemons that store alert state in shared maps are particularly vulnerable; a crashed monitor creates a blind spot attackers can exploit.

## Key facts
- Go's runtime **deliberately detects and panics** on concurrent map writes (since Go 1.6), making this visible rather than silently corrupt — but only at runtime, not compile time
- The fix is explicit synchronization: `sync.Mutex`, `sync.RWMutex` (allows concurrent reads), or `sync.Map` (built for high-concurrency scenarios)
- Race conditions in shared state are classified under **CWE-362 (Concurrent Execution Using Shared Resource with Improper Synchronization)**
- **TOCTOU (Time-of-Check to Time-of-Use)** attacks exploit the window between checking a map value and acting on it — relevant in authentication caches and session stores
- In security-critical code, using an unprotected map as a **token blacklist or session store** under load can allow revoked tokens to appear valid if a write is lost

## Related concepts
[[race condition]] [[TOCTOU vulnerability]] [[denial of service]]