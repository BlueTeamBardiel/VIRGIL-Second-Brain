# SLE

## What it is
Like estimating the repair bill after a single car accident — not whether it will happen, but how much it costs when it does. Single Loss Expectancy (SLE) is the monetary value of the loss expected from one occurrence of a specific risk, calculated as Asset Value (AV) multiplied by Exposure Factor (EF).

## Why it matters
A hospital calculates SLE for a ransomware attack that encrypts its patient records system. If the system is valued at $2,000,000 and ransomware typically destroys or locks 40% of its functional value (EF = 0.40), the SLE is $800,000 — a concrete number that justifies spending on backups and endpoint detection before the incident occurs.

## Key facts
- **Formula:** SLE = Asset Value (AV) × Exposure Factor (EF)
- **Exposure Factor** is expressed as a percentage (0.0–1.0) representing the portion of the asset destroyed or compromised in a single event
- SLE feeds directly into **ALE (Annualized Loss Expectancy):** ALE = SLE × ARO (Annual Rate of Occurrence)
- SLE represents a **single event**, not annual impact — a common exam trap is confusing SLE with ALE
- If EF = 1.0 (total loss), SLE equals the full asset value — relevant for scenarios like complete data destruction or theft of a physical server

## Related concepts
[[ALE]] [[ARO]] [[Quantitative Risk Analysis]]