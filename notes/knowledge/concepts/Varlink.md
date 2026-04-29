# Varlink

## What it is
Think of Varlink like a drive-through intercom system between a customer and kitchen — a standardized way for processes to shout orders and receive responses without needing to know each other's internal workings. Varlink is an inter-process communication (IPC) protocol used primarily in Linux systems (notably systemd) that defines a JSON-based interface for services to communicate over Unix sockets or TCP. It provides a vendor-neutral, self-describing API contract, meaning services advertise exactly what methods and types they expose.

## Why it matters
Varlink surfaces in security contexts because privileged system services — like `systemd-resolved` or `io.systemd.network` — expose Varlink interfaces that could be targeted if socket permissions are misconfigured. An attacker who gains access to a Varlink socket with overly permissive ACLs could invoke privileged methods (such as DNS configuration changes) without authentication, enabling DNS hijacking or network manipulation entirely from userspace. Defenders audit Varlink socket paths under `/run/` and validate that only authorized processes have read/write access.

## Key facts
- Varlink uses **JSON over Unix domain sockets** (or TCP), making traffic human-readable and trivially inspectable with tools like `socat` or `varlink-cli`
- Socket files are typically located in `/run/` and protected by **filesystem DAC permissions** — no built-in authentication layer exists within the protocol itself
- Services self-document via an **interface definition language (IDL)**, so an attacker can enumerate all available methods by querying the socket directly
- Misconfigurations allowing **world-readable/writable sockets** on Varlink interfaces have the same risk profile as exposed Unix sockets generally — privilege escalation or lateral movement
- Varlink is **not encrypted by default**; confidentiality depends entirely on the underlying socket's OS-level access controls

## Related concepts
[[Unix Domain Sockets]] [[Inter-Process Communication]] [[D-Bus Security]] [[systemd]] [[Privilege Escalation]]