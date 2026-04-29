# Segregation of Duties

## What it is
Like a bank vault that requires two different employees to each turn their own separate key simultaneously, Segregation of Duties (SoD) ensures no single person can complete a sensitive transaction or action alone. It is an access control principle that divides critical tasks across multiple individuals so that completing fraud or error requires collusion rather than a single bad actor.

## Why it matters
In 2011, a rogue UBS trader named Kweku Adoboli lost $2.3 billion partly because he had access to both the trading desk *and* the back-office settlement systems — a textbook SoD failure. In a properly controlled environment, the person who initiates a wire transfer should never be the same person who approves or reconciles it, forcing any fraudulent transaction to require at least two conspirators.

## Key facts
- SoD directly addresses **insider threat** by requiring collusion, which dramatically raises the cost and risk of fraud
- The three functions that must be separated are: **authorization**, **custody** (handling assets), and **record-keeping**
- In IT, a developer should not also have production deployment rights — they code it, someone else pushes it
- **Compensating controls** (like audit logs and dual approval workflows) are used when full SoD is impractical due to small staff size
- SoD is a required control under **SOX (Sarbanes-Oxley)** for financial systems and is assessed in **CISA** and **ISO 27001** audits

## Related concepts
[[Least Privilege]] [[Dual Control]] [[Need to Know]] [[Mandatory Access Control]] [[Job Rotation]]