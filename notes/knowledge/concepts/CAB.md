# CAB

## What it is
Like a panel of judges who must approve before a contestant advances on a talent show, a Change Advisory Board is a group of stakeholders who review and authorize proposed changes to an IT environment before implementation. It exists to ensure that modifications to systems, infrastructure, or applications are evaluated for risk, necessity, and impact before anyone touches production.

## Why it matters
In 2017, a misconfigured change to an AWS S3 bucket at a major firm exposed sensitive customer data — the kind of incident a CAB process is designed to prevent by forcing a risk review before deployment. Conversely, security teams use CAB approval to ensure that emergency patches (like a zero-day fix) can be fast-tracked through an expedited process without bypassing oversight entirely. The CAB is the checkpoint between "someone thinks this is a good idea" and "this is now running in production."

## Key facts
- The CAB is a core component of **ITIL (Information Technology Infrastructure Library)** change management, widely referenced in Security+ and CySA+ contexts
- An **Emergency CAB (eCAB)** is a smaller, faster-convening subset authorized to approve urgent changes outside normal scheduling cycles
- CAB meetings typically review a **Request for Change (RFC)**, which documents the change's scope, rollback plan, risk assessment, and implementation timeline
- Unauthorized changes — bypassing the CAB — are a common cause of **configuration drift** and unintentional attack surface expansion
- CAB approval does **not** mean changes are tested; it means they are reviewed for business and security risk — testing (in a staging environment) should occur before RFC submission

## Related concepts
[[Change Management]] [[Configuration Management]] [[ITIL]] [[Risk Assessment]] [[Incident Response]]