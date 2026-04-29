# kernel module auto-load

## What it is
Like a hotel that automatically unlocks a room the moment a guest *mentions* needing it — without verifying who's asking — the Linux kernel will automatically load a kernel module when a process requests functionality that isn't yet loaded. Specifically, the kernel invokes `modprobe` via the `request_module()` call when a syscall or socket operation references an unregistered protocol or device, loading the matching `.ko` file from disk without explicit administrator action.

## Why it matters
In the wild, attackers have exploited auto-load by calling `socket(AF_PACKET, ...)` or referencing obscure network protocols (e.g., `af_can`, `dccp`) to force the kernel to load modules that contain unpatched vulnerabilities — turning an unprivileged user process into a kernel-level exploit. The 2017 DCCP privilege escalation (CVE-2017-6074) was reachable precisely because the DCCP module loaded automatically on demand, despite most systems never intentionally using it.

## Key facts
- `modprobe` is invoked by the kernel itself (not the user) during `request_module()`; any local user can trigger this indirectly through syscalls
- The file `/etc/modprobe.d/blacklist.conf` can blacklist modules to prevent auto-loading; `install <module> /bin/false` is the stronger hardening technique
- `lsmod` shows currently loaded modules; `modinfo` reveals a module's signing status and dependencies
- Kernel module signing (`CONFIG_MODULE_SIG_FORCE`) ensures only cryptographically signed modules load — a critical defense against malicious `.ko` injection
- CIS Benchmarks explicitly recommend blacklisting unused filesystems (e.g., `cramfs`, `freevxfs`, `hfsplus`) and protocols to reduce auto-load attack surface

## Related concepts
[[kernel exploitation]] [[privilege escalation]] [[attack surface reduction]]