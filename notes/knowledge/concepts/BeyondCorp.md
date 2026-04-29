# BeyondCorp

## What it is
Imagine a hospital where doctors aren't trusted just because they're inside the building — every time they open a patient file, they must show their badge, confirm their role, and prove the device they're using is clean. BeyondCorp is Google's enterprise security model that eliminates the concept of a trusted internal network, treating every access request — regardless of whether it originates inside or outside the corporate perimeter — as untrusted by default. It is the foundational real-world implementation of Zero Trust Architecture (ZTA).

## Why it matters
In the 2011 Operation Aurora attacks, adversaries breached Google's perimeter and moved laterally through the internal network because internal traffic was implicitly trusted. BeyondCorp was Google's direct response: by 2017, Google employees could work from any network without a VPN because trust was bound to the *user and device identity*, not the network location — meaning a compromised network segment no longer automatically grants access to resources.

## Key facts
- Originated at Google around 2011 and published in a series of research papers starting in 2014; the model became the blueprint for NIST SP 800-207 (Zero Trust Architecture).
- Core components: a **Device Inventory Service**, an **Access Proxy**, and a **Trust Engine** that continuously evaluates context (device health, user identity, location) before granting access.
- Replaces VPN-centric models; access is granted per-resource, not per-network segment.
- Uses **mutual TLS (mTLS)** and certificate-based device authentication to verify endpoint identity at every request.
- Policies are dynamic — a device that fails a posture check mid-session can have access revoked immediately without terminating the user's account.

## Related concepts
[[Zero Trust Architecture]] [[Least Privilege]] [[Mutual TLS]] [[Network Access Control]] [[Identity and Access Management]]