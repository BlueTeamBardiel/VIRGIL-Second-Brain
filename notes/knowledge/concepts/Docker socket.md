# Docker socket

## What it is
Think of it as the master key hanging on a hook inside a hotel's front desk — anyone who grabs it can open every room. The Docker socket (`/var/run/docker.sock`) is a Unix domain socket file that acts as the API endpoint the Docker daemon listens on, allowing clients to send commands that create, start, stop, or delete containers. It is the local control plane for the entire Docker engine.

## Why it matters
Mounting the Docker socket into a container is a textbook container escape vector. An attacker who compromises a container with `/var/run/docker.sock` bind-mounted can issue Docker API calls to spawn a *new* privileged container with the host's root filesystem mounted, effectively achieving full host compromise — this technique appears in real-world breaches and CTF challenges alike. Defenders audit `docker inspect` output and runtime security policies (e.g., Falco rules) to detect unauthorized socket mounts.

## Key facts
- `/var/run/docker.sock` is owned by `root` and the `docker` group; membership in the `docker` group is functionally equivalent to passwordless `sudo`.
- A container with the socket mounted can escape isolation by running: `docker run -v /:/host --privileged alpine chroot /host`.
- Remote Docker API exposure (TCP port `2375` unencrypted, `2376` TLS) without authentication has led to cryptomining mass-exploitation campaigns.
- Docker socket access bypasses Linux namespace and cgroup isolation entirely — no kernel exploit needed.
- Hardening controls include: socket proxies (e.g., `docker-socket-proxy`), read-only mounts, and restricting access via `authorization-plugin`.

## Related concepts
[[Privilege Escalation]] [[Container Security]] [[Unix File Permissions]] [[Attack Surface Reduction]] [[Least Privilege]]