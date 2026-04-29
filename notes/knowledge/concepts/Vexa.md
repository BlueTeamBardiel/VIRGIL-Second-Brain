# Vexa

## What it is
Like a spy who slips into a crowded room wearing a staff uniform to eavesdrop on conversations, Vexa is an open-source intelligence (OSINT) and reconnaissance framework designed to extract real-time meeting data — participant names, email addresses, and organizational details — from platforms like Google Meet, Zoom, and Microsoft Teams by joining calls as a silent observer. It automates the harvesting of attendee metadata without requiring authentication as a known participant.

## Why it matters
A red team operator conducting a pre-engagement reconnaissance phase could deploy Vexa against a target organization's public or semi-public webinars to silently collect employee names, email formats, and job titles — building a precise spear-phishing target list without ever sending a single suspicious email. This passive collection phase is particularly dangerous because most organizations have no telemetry alerting them that an unknown participant joined and scraped attendee data.

## Key facts
- Vexa targets the **attendee metadata layer** of video conferencing platforms, not the audio/video stream itself — making it a data harvesting tool, not a wiretapping tool
- It is categorized under **passive OSINT** techniques because it observes without actively probing systems or triggering authentication logs
- Harvested data commonly feeds **spear-phishing** and **business email compromise (BEC)** campaigns by confirming real employee identities and naming conventions
- Defenders can mitigate exposure by **requiring registration with verified credentials** before joining meetings and enabling **waiting rooms with manual approval**
- Relevant to CySA+ under the **threat intelligence** and **attack surface management** domains, specifically external reconnaissance techniques

## Related concepts
[[OSINT]] [[Spear Phishing]] [[Business Email Compromise]] [[Reconnaissance]] [[Attack Surface Management]]