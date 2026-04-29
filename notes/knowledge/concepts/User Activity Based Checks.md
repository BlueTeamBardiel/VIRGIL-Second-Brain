# User Activity Based Checks

## What it is
Like a bank teller who gets suspicious when a quiet elderly customer suddenly tries to wire $50,000 to a foreign account at 2 AM, user activity based checks compare current behavior against an established baseline to detect anomalies. Precisely defined, these are security controls that monitor and analyze patterns of user behavior — login times, data access volumes, application usage — and flag or block actions that deviate significantly from that user's historical norm. They form the behavioral layer of identity and access management.

## Why it matters
In the 2020 SolarWinds breach, attackers used legitimate credentials to move laterally across networks for months undetected — traditional signature-based tools saw nothing wrong. User activity based checks (implemented via UEBA — User and Entity Behavior Analytics) would have flagged the unusual volume of internal reconnaissance, off-hours access, and abnormal data staging as high-risk behavioral deviations, potentially cutting the dwell time dramatically.

## Key facts
- **Baseline period matters**: Systems typically require 30–90 days of activity data before anomaly detection becomes reliable and low-noise.
- **Risk scoring**: Modern UEBA tools assign cumulative risk scores rather than binary allow/deny — a single odd login is low risk, but odd login + mass download + new external upload = high-risk alert.
- **Insider threat focus**: User activity checks are specifically designed to catch privileged insiders and compromised credentials, where perimeter defenses offer zero protection.
- **CySA+ relevance**: Expect scenarios where UEBA/user activity monitoring is the correct detective control for compromised account or insider threat questions.
- **Data sources**: These checks ingest logs from SIEM, DLP, Active Directory, endpoint agents, and cloud access brokers (CASBs) to build behavioral profiles.

## Related concepts
[[UEBA]] [[Insider Threat Detection]] [[Behavioral Analytics]] [[SIEM]] [[Least Privilege]]