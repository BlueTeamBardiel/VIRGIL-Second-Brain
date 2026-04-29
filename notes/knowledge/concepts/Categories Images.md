# Categories Images

## What it is
Like sorting photographs into labeled albums — "family," "vacation," "work" — categorizing images means classifying container images, OS images, or disk images by type, trust level, and intended use. Precisely, image categorization is the process of organizing software or system images into defined groups based on attributes like source, content, integrity status, and security posture.

## Why it matters
In a supply chain attack scenario, a threat actor injects malicious code into a container image hosted on a public registry like Docker Hub. If an organization lacks a clear categorization scheme distinguishing "verified internal" images from "untrusted external" images, developers may pull and deploy the compromised image into production, leading to full environment compromise. Proper image categories enforce policy — only "golden" images pass through automated scanning before deployment.

## Key facts
- **Golden images** are hardened, pre-approved base images that serve as the only sanctioned starting point for builds — deviations trigger alerts.
- Image categories typically include: **trusted internal**, **vendor-supplied**, **community/public**, and **legacy/deprecated** — each with different scanning and usage policies.
- Container image scanning tools (Trivy, Clair, Prisma Cloud) apply category-specific policies — public images may require zero critical CVEs while internal images allow controlled exceptions.
- **NIST SP 800-190** (Application Container Security Guide) recommends maintaining a curated image registry with strict categorization to reduce attack surface.
- Image categorization supports **least privilege** and **zero trust** principles — an uncategorized image is treated as untrusted by default in a mature DevSecOps pipeline.

## Related concepts
[[Container Security]] [[Supply Chain Attacks]] [[Vulnerability Scanning]] [[Golden Image]] [[DevSecOps]]