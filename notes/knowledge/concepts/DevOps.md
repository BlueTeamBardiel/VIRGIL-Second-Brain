# DevOps

## What it is
Like a restaurant where the chefs who cook the food also design the kitchen layout and own the recipes — DevOps tears down the wall between the people who write software (Dev) and the people who deploy and maintain it (Ops). Precisely: DevOps is a cultural and technical methodology that integrates software development and IT operations through automation, continuous integration/continuous delivery (CI/CD) pipelines, and shared responsibility for the full application lifecycle.

## Why it matters
In 2020, the SolarWinds attack exploited the CI/CD pipeline itself — attackers injected malicious code into the build process, so every legitimate software update shipped a backdoor to ~18,000 organizations. This is the nightmare of DevOps security (DevSecOps): if your pipeline is compromised, your security controls downstream mean almost nothing, because the threat is baked into the trusted artifact itself.

## Key facts
- **CI/CD pipelines** (e.g., Jenkins, GitHub Actions) are high-value attack targets because they have broad access to source code, secrets, and production environments
- **DevSecOps** = "shift left" security — integrating SAST (Static Application Security Testing) and DAST (Dynamic Application Security Testing) into the pipeline rather than testing post-deployment
- **Infrastructure as Code (IaC)** tools like Terraform and Ansible create new attack surfaces; misconfigured IaC templates can expose entire cloud environments
- **Secrets management** is a critical DevOps failure point — hardcoded API keys and credentials in source repositories are consistently exploited (GitGuardian reports millions of exposed secrets annually)
- **Immutable infrastructure** is a DevOps security best practice: deploy fresh containers/instances rather than patching running systems, reducing configuration drift and persistent compromise

## Related concepts
[[CI/CD Pipeline Security]] [[Supply Chain Attack]] [[DevSecOps]] [[Infrastructure as Code]] [[Secrets Management]]