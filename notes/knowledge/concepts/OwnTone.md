# OwnTone

## What it is
Think of OwnTone like running your own private Spotify server in your basement — you control the music, the access, and the data. OwnTone (formerly forked-daapd) is an open-source media server that implements Apple's DAAP (Digital Audio Access Protocol) and AirPlay protocols, allowing users to self-host a music streaming service accessible to iTunes clients and AirPlay devices on a local network.

## Why it matters
A security team conducting an internal network audit might discover an unpatched OwnTone instance exposing its default web interface (port 3689) to the broader network without authentication, allowing any user on the LAN to enumerate the media library, modify playlists, or — in vulnerable versions — exploit parsing flaws in metadata handling. This represents a classic case of shadow IT: an employee runs a personal service on corporate infrastructure, creating an unmonitored attack surface that bypasses standard endpoint controls.

## Key facts
- OwnTone defaults to listening on **TCP port 3689** (DAAP) and **port 3688** for its built-in HTTP control interface; both may be inadvertently exposed
- Historically vulnerable to **path traversal and metadata parsing issues** when handling malformed MP3/FLAC tags using libraries like libavcodec
- Runs as a **daemon on Linux/macOS** — easy to install silently, making it a common shadow IT / unauthorized service finding during network scans
- The web UI may ship with **no authentication enabled by default**, meaning discovery via Nmap or Shodan can immediately yield unauthenticated control
- Falls under the **unauthorized software / rogue services** category in CySA+ asset management and continuous monitoring domains

## Related concepts
[[Shadow IT]] [[DAAP Protocol]] [[Unauthenticated Services]] [[Network Service Enumeration]] [[Rogue Devices]]