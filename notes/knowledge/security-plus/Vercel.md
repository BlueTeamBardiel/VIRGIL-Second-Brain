# Vercel

## What it is
Think of Vercel like a vending machine for websites — you drop in your code, pull a lever, and a fully deployed, globally distributed web application comes out the other side. Precisely, Vercel is a cloud platform for frontend deployment and serverless functions, optimized for frameworks like Next.js, offering automatic CI/CD pipelines, edge network distribution, and preview deployments per Git branch.

## Why it matters
Attackers increasingly target CI/CD pipeline integrations on platforms like Vercel by stealing environment variables (API keys, database credentials) stored in project settings — a misconfigured Vercel project exposing `NEXT_PUBLIC_` prefixed variables can leak secrets directly into client-side JavaScript bundles visible to anyone who views page source. In 2022, multiple organizations suffered credential exposure because developers accidentally promoted server-side secrets into public environment variable slots, enabling attackers to pivot into backend databases or third-party services.

## Key facts
- Vercel serverless functions execute in isolated environments but share the same environment variable configuration — a compromised build process can exfiltrate all secrets at deploy time
- Preview deployments are publicly accessible by default unless protected, creating shadow attack surfaces that bypass production security controls
- Vercel integrates with GitHub/GitLab/Bitbucket via OAuth tokens; a stolen token grants full deployment control and secret access
- Environment variables marked `NEXT_PUBLIC_` are intentionally embedded in client-side bundles — any secret placed here is fully public regardless of intent
- Supply chain attacks targeting Vercel deployments often abuse the `vercel.json` configuration file to redirect rewrites/proxies to malicious origins

## Related concepts
[[CI/CD Pipeline Security]] [[Environment Variable Exposure]] [[Supply Chain Attack]] [[Serverless Security]] [[Secret Management]]