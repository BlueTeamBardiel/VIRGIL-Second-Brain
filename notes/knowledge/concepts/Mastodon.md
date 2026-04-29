# Mastodon

## What it is
Like a constellation of independently owned coffee shops that all share the same menu and can serve each other's customers — Mastodon is a decentralized, open-source microblogging platform built on the ActivityPub protocol, where thousands of separately administered "instances" federate together into a broader social network. No single corporation owns or controls the entire system.

## Why it matters
From a security perspective, Mastodon's federated architecture creates an expanded and inconsistent attack surface: a threat actor who compromises a single instance administrator gains full access to that instance's user data, private messages, and federation trust relationships. In 2023, researchers demonstrated that malicious ActivityPub payloads could propagate cross-instance through boosted posts, enabling stored XSS attacks to spread virally across federated servers running unpatched Mastodon versions.

## Key facts
- **CVE-2022-24307** (and similar): Mastodon has had critical account takeover vulnerabilities via password reset token enumeration — patched in point releases, but dangerous on unpatched self-hosted instances
- **Data exposure risk**: Instance admins can read all user DMs in plaintext; there is no end-to-end encryption on private messages by design
- **ActivityPub trust model**: Federation creates implicit trust chains — a compromised or malicious instance can inject manipulated data into legitimate users' timelines
- **Self-hosting attack surface**: Organizations running their own instances inherit full responsibility for patching Rails/Sidekiq/PostgreSQL stack vulnerabilities
- **OSINT value**: Public Mastodon instances are fully crawlable via API without authentication, making them rich sources for open-source intelligence gathering on users and communities

## Related concepts
[[ActivityPub]] [[Federated Identity]] [[Cross-Site Scripting (XSS)]] [[Open Source Intelligence (OSINT)]] [[Patch Management]]