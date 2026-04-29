# Notifications

## What it is
Like a postal worker slipping a message under your door to alert you something happened while you were away, notifications are system- or application-generated alerts that inform users or administrators of events, status changes, or required actions. In security contexts, notifications encompass alerts from SIEM systems, IDS/IPS triggers, patch advisories, and breach disclosure messages sent to affected parties.

## Why it matters
In a ransomware incident, an organization's SIEM may generate hundreds of security notifications flagging abnormal SMB traffic and lateral movement — but if alert fatigue has caused analysts to suppress or ignore low-priority notifications, attackers move undetected for days. Conversely, well-tuned notifications with proper escalation paths allow SOC analysts to contain threats within the critical first hour. Breach notification laws (like GDPR's 72-hour rule) also create legal obligations tied directly to when an organization becomes "aware" — making notification timing a compliance liability.

## Key facts
- **GDPR Article 33** requires organizations to notify supervisory authorities of a personal data breach within **72 hours** of becoming aware of it.
- **US State breach notification laws** (all 50 states have them) typically require notifying affected individuals within 30–90 days of discovering a breach.
- Push notifications on mobile devices can be weaponized via **MFA fatigue (push bombing)** attacks — flooding a user with approval requests until they accidentally accept.
- SIEM notification tuning involves adjusting **thresholds and correlation rules** to reduce false positives without creating blind spots (false negatives).
- IDS/IPS systems generate two core notification types: **alerts** (logged events) and **blocks** (active responses) — understanding the difference is exam-relevant for CySA+.

## Related concepts
[[SIEM]] [[Alert Fatigue]] [[MFA Fatigue Attack]] [[Breach Disclosure Laws]] [[IDS vs IPS]]