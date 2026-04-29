# Redis

## What it is
Think of Redis like a waiter who memorizes your order instead of writing it down — blazingly fast because everything lives in RAM, not on a slow disk. Redis (Remote Dictionary Server) is an open-source, in-memory key-value data store used for caching, session management, and real-time data processing.

## Why it matters
Exposed Redis instances are a classic attack vector — Redis has no authentication enabled by default, so an internet-facing server is an open door. Attackers have weaponized this to write SSH public keys directly into the root user's `authorized_keys` file via Redis's `CONFIG SET dir` and `SLAVEOF` commands, achieving unauthenticated remote code execution at scale (notably in the 2018 "RedisWannaMine" cryptomining campaign).

## Key facts
- Redis listens on **TCP port 6379** by default with **no authentication** and **no encryption** unless explicitly configured
- The `CONFIG SET` command allows an attacker to change the working directory and write arbitrary files to disk — including cron jobs or SSH keys
- Redis supports **persistence modes** (RDB snapshots, AOF logs) that can be abused to write malicious payloads to predictable file paths
- Binding Redis to `0.0.0.0` instead of `127.0.0.1` is one of the most common misconfigurations found in cloud environments
- Hardening steps include: enabling `requirepass`, using `rename-command CONFIG ""`, and restricting access via firewall rules or VPC security groups

## Related concepts
[[Insecure Default Configurations]] [[Remote Code Execution]] [[Credential Exposure]] [[Network Segmentation]] [[Misconfigured Cloud Services]]