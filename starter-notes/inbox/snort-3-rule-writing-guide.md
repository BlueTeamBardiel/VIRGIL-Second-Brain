# Snort 3 Rule Writing Guide

Comprehensive documentation for writing detection rules in [[Snort]] 3, covering rule syntax, options, and protocol-specific detection methods. Published by the Cisco Talos Detection Response Team.

## Core Sections

### Getting Started
- [[Snort]] installation and basic usage
- Command line fundamentals
- Reading traffic and configuration
- Alert logging and trace modules

### Rule Fundamentals

#### Rule Headers
- Rule Actions (alert, drop, reject, etc.)
- Protocol specification (TCP, UDP, ICMP, etc.)
- IP address and CIDR ranges
- Port numbers and port ranges
- Direction operators (→, ←, ↔)

#### New Rule Types
- Service Rules
- File Rules
- File Identification Rules

### Rule Options

#### General Options
- `msg` — alert message
- `reference` — external references
- `gid`/`sid`/`rev` — group ID, signature ID, revision
- `classtype` — attack classification
- `priority` — alert priority level
- `metadata` — custom metadata
- `service` — service binding
- `rem` — comments
- `file_meta` — file metadata

#### Payload Detection
- **Content matching**: `content`, `fast_pattern`, `nocase`, `offset`, `depth`, `distance`, `within`
- **HTTP-specific**: `http_uri`, `http_header`, `http_cookie`, `http_client_body`, `http_method`, `http_stat_code`, `http_trailer`, etc.
- **Data buffers**: `bufferlen`, `isdataat`, `dsize`, `file_data`, `js_data`, `vba_data`
- **Pattern matching**: `pcre`, `regex`, `sd_pattern`
- **Encoding**: `base64_decode`, `base64_data`
- **Byte operations**: `byte_extract`, `byte_test`, `byte_math`, `byte_jump`
- **Protocol-specific**: [[SSL]]/[[TLS]], [[DCE]], [[SIP]], [[GTP]], [[DNP3]], [[CIP]], [[IEC 104]], [[MMS]], [[Modbus]], S7CommPlus
- **File analysis**: `md5`, `sha256`, `sha512`, `cvs`

#### Non-Payload Detection
- IP-layer: `fragoffset`, `ttl`, `tos`, `id`, `ipopts`, `fragbits`, `ip_proto`
- TCP-layer: `flags`, `seq`, `ack`, `window`
- ICMP-layer: `itype`, `icode`, `icmp_id`, `icmp_seq`
- Flow: `flow`, `flowbits`, `stream_reassemble`, `stream_size`
- RPC: `rpc`
- File: `file_type`

#### Post-Detection
- `detection_filter` — suppress alerts
- `replace` — inline content replacement
- `tag` — session/host tagging

### Advanced Topics
- Wizard and Binder configuration
- Shared Object Rules
- Tweaks and Scripts
- SnortML language support
- hexdump.lua utilities

## Tags
#snort #ids #rule-writing #detection #network-security #cisco-talos

---
_Ingested: [[2026-04-15]] 22:04 | Source: https://docs.snort.org/_
