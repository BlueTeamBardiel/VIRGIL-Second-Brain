# Ephemeral Credentials

## What it is
Like a visitor badge that self-destructs at 5 PM, ephemeral credentials are short-lived authentication tokens or secrets that automatically expire after a brief, defined window. Unlike static passwords or long-lived API keys, they are generated on-demand, used once or briefly, and become worthless after expiration — limiting the damage window if intercepted.

## Why it matters
In 2019, attackers who breached Capital One exploited a misconfigured WAF to steal AWS IAM role credentials from the EC2 metadata service. Had those credentials been ephemeral with a 15-minute TTL (as AWS STS tokens can be configured), the stolen credentials would have expired before attackers could pivot to S3 buckets containing 100 million customer records. This is the core defense value: a stolen key that expires is an expired problem.

## Key facts
- AWS STS (Security Token Service) issues ephemeral tokens with configurable TTLs as short as 15 minutes, replacing static IAM access keys
- **Just-in-Time (JIT) access** is the broader privileged access management (PAM) strategy that uses ephemeral credentials — granting elevated rights only when needed, then revoking them
- Kerberos tickets (TGTs/TGSs) are a foundational example of ephemeral credentials — default ticket lifetime is 10 hours, limiting lateral movement windows
- OAuth 2.0 access tokens are typically short-lived (minutes to hours) while refresh tokens are longer-lived — compromise of the access token alone has limited blast radius
- NIST SP 800-207 (Zero Trust Architecture) explicitly recommends ephemeral credentials as a core mechanism for reducing implicit trust and lateral movement risk

## Related concepts
[[AWS IAM Roles]] [[Just-in-Time Access]] [[Kerberos Authentication]] [[Zero Trust Architecture]] [[OAuth 2.0]]