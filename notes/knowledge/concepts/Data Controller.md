# Data Controller

## What it is
Think of a Data Controller like the executive chef of a restaurant — they decide *what* gets cooked, *why*, and *how*, even if the line cooks (processors) do the actual work. Precisely: a Data Controller is the entity (person, company, or organization) that determines the **purposes and means** of processing personal data. Under GDPR and similar frameworks, this legal designation carries direct accountability for how data is collected, used, and protected.

## Why it matters
When a healthcare SaaS company suffers a breach exposing patient records, regulators don't chase the cloud provider hosting the database — they go after the Data Controller (the healthcare company) because *they* decided what data to collect and why. This distinction matters defensively too: during a vendor risk assessment, identifying whether a third party acts as a Controller or merely a Processor determines who holds liability and who must sign a Data Processing Agreement (DPA).

## Key facts
- A Data Controller is legally accountable under GDPR (Article 4) and must implement appropriate technical and organizational measures
- One organization can be **both** Controller and Processor simultaneously (e.g., an HR firm managing its own employees' data while processing payroll data for clients)
- Controllers must ensure Processors comply via binding contracts — a DPA is mandatory, not optional
- If two organizations jointly determine processing purposes, they become **Joint Controllers** and must define their responsibilities in a transparent arrangement
- Fines under GDPR for Controller violations can reach **€20 million or 4% of global annual turnover**, whichever is higher

## Related concepts
[[Data Processor]] [[GDPR]] [[Data Processing Agreement]] [[Privacy Impact Assessment]] [[Data Subject Rights]]