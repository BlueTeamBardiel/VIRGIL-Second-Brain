# AWS Shield

## What it is
Think of AWS Shield as a bouncer stationed permanently at the door of your cloud infrastructure — one specifically trained to spot and physically eject DDoS attackers before they ever reach your application. It is a managed Distributed Denial of Service (DDoS) protection service from AWS that automatically detects and mitigates volumetric, protocol, and application-layer attacks against resources like EC2, CloudFront, and Route 53.

## Why it matters
In 2020, AWS publicly disclosed mitigating a 2.3 Tbps DDoS attack — the largest ever recorded at the time — using infrastructure that Shield Advanced contributed to defending. Without this layer of protection, a sustained volumetric flood at that scale would exhaust network capacity and render entire application stacks unreachable, translating directly into revenue loss and SLA violations for the targeted organization.

## Key facts
- **Shield Standard** is free and automatically enabled for all AWS customers, protecting against common Layer 3/4 attacks (SYN floods, UDP reflection).
- **Shield Advanced** is a paid tier (~$3,000/month) that adds Layer 7 protection, near-real-time attack visibility, cost protection (credits for scaling charges during attacks), and 24/7 access to the AWS DDoS Response Team (DRT).
- Shield Advanced integrates with **AWS WAF** at no additional WAF cost, enabling fine-grained HTTP/HTTPS filtering alongside volumetric defense.
- Shield Advanced provides **attack diagnostics and forensics** through CloudWatch metrics and detailed attack reports — critical for post-incident analysis.
- Shield does **not** protect against application logic flaws or credential stuffing — it is purpose-built for availability attacks, not confidentiality or integrity threats.

## Related concepts
[[DDoS Mitigation]] [[AWS WAF]] [[Rate Limiting]] [[Cloud Security Posture Management]] [[Network ACLs]]