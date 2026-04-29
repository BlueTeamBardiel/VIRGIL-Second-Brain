# Windows Sandbox

## What it is
Think of it as a snow globe on your desk — you can shake it, watch chaos unfold inside, and when you're done, simply reset it with no mess escaping into your room. Windows Sandbox is a lightweight, isolated desktop environment built into Windows 10/11 Pro and Enterprise that spins up a temporary virtual machine using the host's OS kernel, allowing users to run untrusted software safely. When the Sandbox window closes, every file, registry change, and process spawned inside it is permanently destroyed.

## Why it matters
A security analyst receives a suspicious email attachment flagged by users but not yet caught by AV signatures. Rather than detonating it on a production machine or spinning up a full VM, they open the file inside Windows Sandbox, observe its behavior (network callbacks, file drops, process injection attempts), and capture indicators of compromise — all while the host system remains completely untouched. This is rapid, zero-setup malware triage.

## Key facts
- **Ephemeral by design**: All sandbox state is wiped on closure — there is no persistence between sessions, making it safe for one-time analysis.
- **Kernel sharing**: Uses Microsoft's *hypervisor-based isolation* (Hyper-V under the hood), sharing the host OS kernel but with hardware-enforced memory separation.
- **Requires virtualization**: Hardware virtualization (VT-x/AMD-V) must be enabled in BIOS/UEFI; unavailable on Windows Home edition.
- **No snapshot/rollback feature**: Unlike full VMs (VMware, VirtualBox), you cannot save state — isolation is enforced by destruction, not restoration.
- **Configuration via `.wsb` files**: XML-based config files can pre-map shared folders, enable/disable networking, and auto-run scripts — relevant for controlled analysis environments.

## Related concepts
[[Application Sandboxing]] [[Hypervisor Security]] [[Malware Analysis Techniques]] [[Defense in Depth]] [[Least Privilege]]