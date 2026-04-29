# user namespaces

## What it is
Like a funhouse mirror that makes a carnival worker *look* like the building's owner without actually giving them the keys — user namespaces let a process believe it has root privileges inside a isolated container while remaining an unprivileged user on the host. Technically, user namespaces are a Linux kernel feature that maps a set of user and group IDs inside a namespace to a different set outside it, creating virtualized privilege boundaries. A process can have UID 0 (root) inside its namespace but map to UID 65534 (nobody) from the host's perspective.

## Why it matters
Unprivileged container runtimes like Podman rely on user namespaces to allow non-root users to run containers — a significant security improvement over Docker's traditional root-daemon model. However, user namespaces have historically been a *prime attack surface*: CVE-2022-0492 exploited namespace privilege escalation to escape container isolation and gain host root, demonstrating that the boundary is only as strong as the kernel's namespace enforcement logic.

## Key facts
- User namespaces can be created by unprivileged users by default on many Linux distros, which expands the kernel attack surface significantly
- The `/proc/sys/kernel/unprivileged_userns_clone` toggle (Debian/Ubuntu) or `user.max_user_namespaces` sysctl can disable unprivileged namespace creation as a hardening measure
- User namespaces are a prerequisite for other namespace types (mount, network, PID) when created by non-root users
- Container escapes frequently chain user namespace bugs with other kernel vulnerabilities (e.g., cgroups v1 release_agent abuse)
- Seccomp profiles and AppArmor/SELinux policies are the primary compensating controls when user namespaces cannot be disabled

## Related concepts
[[Linux namespaces]] [[container escape]] [[privilege escalation]] [[seccomp]] [[capabilities]]