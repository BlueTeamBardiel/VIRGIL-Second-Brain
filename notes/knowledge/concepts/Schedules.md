# Schedules

## What it is
Like a hospital shift roster that determines who has access to the medication cabinet and when, a schedule in cybersecurity is a time-based access control mechanism that restricts *when* a user, system, or process is permitted to operate or authenticate. Schedules enforce temporal boundaries on permissions, ensuring that access rights are active only during predefined windows (e.g., Monday–Friday, 08:00–18:00).

## Why it matters
A terminated employee whose account is deleted immediately poses less risk than one whose access lingers overnight. By implementing login schedules, an organization can automatically block after-hours authentication attempts — meaning even if valid credentials are stolen, an attacker trying to log in at 3 AM from an overseas IP will be denied before any other control even triggers. This is a lightweight but powerful layer of defense-in-depth.

## Key facts
- Schedules are a form of **time-of-day restrictions**, a category of logical access control enforced by directory services like Active Directory or RADIUS.
- They help enforce **least privilege** across a time dimension, not just a permission dimension.
- On Security+/CySA+ exams, schedules often appear as a control under **account management policies** alongside account expiration and geofencing.
- Schedules can be applied to **service accounts** to prevent automated processes from running outside maintenance windows, reducing the attack surface for lateral movement.
- Non-compliance with scheduled access windows should generate **alerts** for SOC analysts — off-hours logins are a classic Indicator of Compromise (IoC).

## Related concepts
[[Time-of-Day Restrictions]] [[Least Privilege]] [[Account Management]] [[Geofencing]] [[Indicators of Compromise]]