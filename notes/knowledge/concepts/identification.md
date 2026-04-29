# identification

## What it is
Like a patron walking up to a library desk and saying "My name is Alice" before showing any ID card — identification is the act of claiming an identity, nothing more. Precisely, it is the first step in the AAA (Authentication, Authorization, Accounting) framework where a subject asserts *who they are* to a system, without yet proving it.

## Why it matters
In a credential-stuffing attack, adversaries submit stolen username/password pairs at scale. The username submission is the identification step — attackers are claiming to be legitimate users. Understanding that identification and authentication are *separate* steps explains why username enumeration vulnerabilities are dangerous: if a login page confirms "that username doesn't exist," attackers learn which identities are worth targeting before authentication even begins.

## Key facts
- Identification is **not** authentication — it is the *claim*, while authentication is the *proof* of that claim
- Common identification mechanisms include usernames, email addresses, account numbers, and smart card serial numbers
- Username enumeration attacks exploit weak identification feedback (e.g., HTTP 200 vs. 401 responses revealing valid usernames)
- In biometric systems, **identification** = 1-to-many match (who is this person?); **verification** = 1-to-1 match (are you who you claim to be?)
- NIST SP 800-63 defines identity proofing as the process of validating an identity claim before credentials are issued — distinct from runtime identification

## Related concepts
[[authentication]] [[authorization]] [[AAA framework]] [[username enumeration]] [[identity proofing]]