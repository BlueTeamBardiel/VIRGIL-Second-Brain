# Lychee

## What it is
Think of it as a polished photo album manager you can self-host — Lychee is an open-source, web-based photo management application that runs on your own server using PHP and a MySQL/MariaDB backend. It provides a clean UI for uploading, organizing, and sharing photos without relying on third-party cloud services.

## Why it matters
Self-hosted applications like Lychee expand your attack surface in ways cloud services handle for you. Security researchers have identified multiple vulnerabilities in older Lychee versions, including SQL injection flaws and Cross-Site Scripting (XSS) issues, that allowed unauthenticated attackers to extract database credentials or hijack admin sessions — a textbook example of why patch management for self-hosted software is non-negotiable.

## Key facts
- Lychee is a **self-hosted web application**, meaning the server owner is solely responsible for patching, hardening, and securing the instance
- Historically vulnerable to **SQL injection** (CVE-documented) due to improper input sanitization in its PHP codebase
- Runs on a **LAMP/LEMP stack** — misconfigured PHP settings or exposed `.env` files can leak database credentials directly
- Public-facing instances indexed by Shodan are common targets; attackers use Google dorks (`inurl:lychee`) to find unpatched deployments
- Illustrates the **shared responsibility shift**: unlike AWS S3, there is no vendor patching — updates are fully manual and often neglected

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[Attack Surface Management]] [[Patch Management]] [[Shodan]]