# Snowflake Cortex

## What it is
Think of it like hiring a brilliant analyst who lives inside your locked filing room — they can answer questions about your classified documents without ever carrying those documents outside. Snowflake Cortex is a fully managed AI/ML service embedded directly within the Snowflake Data Cloud platform, allowing organizations to run large language models (LLMs) and machine learning functions on sensitive data without that data leaving Snowflake's governed environment. It provides SQL-callable AI functions (sentiment analysis, summarization, classification, etc.) that operate under Snowflake's existing access controls and data governance policies.

## Why it matters
In 2024, a wave of Snowflake customer breaches (linked to infostealer-harvested credentials) exposed how dangerous it is when sensitive cloud data stores lack MFA enforcement. Cortex raises the stakes further — if an attacker compromises a Snowflake account with Cortex privileges, they don't just exfiltrate raw data; they can programmatically query, summarize, and extract intelligence from petabytes of records at machine speed, dramatically accelerating data exfiltration and insider threat scenarios.

## Key facts
- Cortex functions execute entirely within Snowflake's security boundary, meaning data never leaves to an external API endpoint — a key differentiator from calling OpenAI/Gemini externally
- Access is controlled through Snowflake's **Role-Based Access Control (RBAC)** — Cortex privileges must be explicitly granted, making privilege creep a real threat vector
- Cortex supports **COMPLETE** (text generation), **SENTIMENT**, **SUMMARIZE**, and **EXTRACT_ANSWER** as native SQL functions
- Because queries are SQL-native, standard **query auditing** via Snowflake's `QUERY_HISTORY` view applies — useful for detecting anomalous AI-assisted data harvesting
- Organizations using Cortex should enforce **MFA**, **network policies**, and **session parameter restrictions** to match the elevated sensitivity of AI-enabled data access

## Related concepts
[[Cloud Access Security Broker (CASB)]] [[Role-Based Access Control]] [[Data Loss Prevention]]