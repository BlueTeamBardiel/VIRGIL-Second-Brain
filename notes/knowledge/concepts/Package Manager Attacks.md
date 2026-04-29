# Package Manager Attacks

## What it is
Imagine a town where everyone trusts the same pharmacy to dispense medicine — if someone poisons the supply chain at that pharmacy, every customer gets tainted pills without suspecting a thing. Package manager attacks exploit this trust model by injecting malicious code into software repositories (npm, PyPI, RubyGems) that developers automatically pull into their builds.

## Why it matters
In 2021, the **dependency confusion** attack by Alex Birsan tricked package managers at Apple, Microsoft, and Tesla into downloading attacker-controlled packages by registering public packages with the same names as internal private packages — causing the public version to win due to version number priority. This single technique compromised over 35 major companies simultaneously, demonstrating how a CI/CD pipeline becomes an instant attack multiplier.

## Key facts
- **Typosquatting**: Attackers register packages with names nearly identical to popular ones (e.g., `lodash` vs. `1odash`) hoping developers mistype the dependency name
- **Dependency confusion**: Public registry packages override private ones when the public version has a higher version number — exploitable without compromising any existing package
- **Compromised maintainer accounts**: Attackers take over legitimate package maintainer credentials to inject malicious updates into already-trusted packages (e.g., event-stream npm incident, 2018)
- **Supply chain integrity controls**: Tools like `npm audit`, Sigstore, and Software Bill of Materials (SBOM) are primary defenses tracked in CySA+ exam objectives
- **Scope of impact**: A single malicious package can reach millions of downstream applications simultaneously — making this a force-multiplied supply chain risk

## Related concepts
[[Supply Chain Attacks]] [[Dependency Confusion]] [[Software Bill of Materials (SBOM)]] [[Typosquatting]] [[CI/CD Pipeline Security]]