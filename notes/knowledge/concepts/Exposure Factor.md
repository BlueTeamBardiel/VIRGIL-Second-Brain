# Exposure Factor

## What it is
Think of a house fire that burns down only the kitchen — the whole house isn't lost, just a portion of it. Exposure Factor (EF) is that portion: the percentage of an asset's value that would be destroyed if a specific threat were realized. It's expressed as a decimal between 0 and 1 (or 0–100%) and feeds directly into calculating Single Loss Expectancy (SLE).

## Why it matters
During a ransomware attack on a hospital, the security team must estimate the financial impact before deciding whether to pay the ransom or restore from backups. If the affected server is valued at $500,000 and the ransomware encrypts 60% of its critical data (EF = 0.6), the SLE becomes $300,000 — a concrete number that justifies the cost of maintaining offline backups versus paying a ransom demand.

## Key facts
- EF is always expressed as a percentage or decimal between 0 (no loss) and 1.0 (total loss)
- **Formula anchor:** SLE = Asset Value (AV) × Exposure Factor (EF)
- EF is inherently subjective — it requires expert judgment or historical data to estimate accurately
- A single asset can have *different* EFs for different threats (e.g., a server has EF 0.3 for flooding but EF 1.0 for physical theft)
- EF feeds into the full quantitative risk chain: **AV × EF = SLE → SLE × ARO = ALE**

## Related concepts
[[Single Loss Expectancy (SLE)]] [[Annualized Loss Expectancy (ALE)]] [[Quantitative Risk Analysis]] [[Asset Valuation]] [[Annual Rate of Occurrence (ARO)]]