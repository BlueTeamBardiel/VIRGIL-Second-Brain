# NIO

## What it is
Like a single switchboard operator handling hundreds of phone calls simultaneously without putting anyone on hold — instead of dedicating one thread per connection, Non-blocking I/O (NIO) lets one thread manage multiple network connections by checking which ones are ready to send or receive data. NIO is an I/O model where read/write operations return immediately rather than blocking execution, using mechanisms like `select()`, `epoll()`, or completion ports to notify when data is ready.

## Why it matters
High-performance attack tools like Masscan and async port scanners exploit NIO to scan millions of hosts in minutes — a task that would take days with traditional blocking I/O. Defenders must recognize that anomalous high-speed scanning traffic on their network is often a signature of NIO-based tooling, and rate-limiting or connection-throttling controls at the perimeter are the appropriate countermeasure.

## Key facts
- NIO uses **event loops** or **reactor patterns** — a single thread monitors multiple file descriptors via system calls like `epoll` (Linux) or `kqueue` (BSD)
- Enables **C10K problem** solutions: handling 10,000+ simultaneous connections on a single server (critical for understanding web server scalability and attack surface)
- Blocking I/O creates **one thread per connection** — under a SYN flood or slowloris attack, this exhausts thread pools rapidly; NIO-based servers are significantly more resilient
- Many **C2 frameworks** (e.g., Cobalt Strike's async beacon) use NIO principles to manage multiple implants over fewer outbound connections, reducing detection surface
- Java's `java.nio` package and Python's `asyncio` are common NIO implementations — misconfigurations in these frameworks have led to deserialization and race condition vulnerabilities

## Related concepts
[[Asynchronous Programming]] [[Event-Driven Architecture]] [[Denial of Service]] [[Network Scanning]] [[Thread Exhaustion]]