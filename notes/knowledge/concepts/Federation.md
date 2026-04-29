# Federation

## What it is
Like a border treaty between countries where each nation keeps its own passport system but agrees to honor the others — federation lets separate identity systems trust each other without merging. Precisely, federation is a system that allows users authenticated by one organization's identity provider (IdP) to access resources in another organization's domain without re-authenticating. It uses trust relationships and shared standards (SAML, OAuth, OIDC) to pass identity assertions across boundaries.

## Why it matters
In 2020, attackers compromised SolarWinds and used forged SAML tokens — a technique called "Golden SAML" — to impersonate any federated user and move laterally into Microsoft 365 environments without needing passwords. This attack worked precisely because federated trust meant the target organization's systems accepted signed assertions from the IdP without further challenge, demonstrating that whoever controls the federation signing keys controls identity itself.

## Key facts
- **SAML 2.0** is the dominant enterprise federation protocol; it passes XML-based assertions between an IdP and a Service Provider (SP)
- **Trust anchor = signing certificate**: if an attacker steals the IdP's private signing key, they can forge assertions for any user (Golden SAML attack)
- **SSO is federation's most visible use case** — one login at the IdP grants access to all federated SPs
- **OAuth 2.0 / OIDC** handle federated *authorization* and *authentication* respectively, dominant in consumer/cloud contexts vs. SAML in enterprise
- Federation differs from simple SSO: SSO is a user experience; federation is a cross-domain trust architecture that *enables* cross-org SSO

## Related concepts
[[SAML]] [[Single Sign-On (SSO)]] [[OAuth 2.0]] [[Identity Provider (IdP)]] [[Golden SAML Attack]]