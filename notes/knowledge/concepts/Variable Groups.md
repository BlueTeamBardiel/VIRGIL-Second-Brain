# Variable Groups

## What it is
Like a labeled drawer in a filing cabinet that holds related items together, a variable group is a named collection of variables stored centrally so multiple pipelines, scripts, or configurations can reference them without hardcoding values. In CI/CD environments (like Azure DevOps), variable groups let teams manage secrets, API keys, and environment-specific settings in one place rather than scattering them across dozens of pipeline definitions.

## Why it matters
In 2023, attackers targeting CI/CD pipelines specifically hunted for misconfigured variable groups that exposed secrets like cloud credentials or signing keys to unauthorized pipeline runs. If a variable group containing AWS access keys is linked to a pipeline that any repository contributor can trigger, a malicious insider or compromised account can exfiltrate those credentials simply by running a build — no additional exploitation needed.

## Key facts
- Variable groups in Azure DevOps can be linked to **Azure Key Vault**, meaning secrets are pulled dynamically at runtime rather than stored statically in the pipeline config
- **Access control on variable groups** is a distinct permission layer — a user with pipeline edit rights does not automatically inherit access to linked variable groups
- Secrets stored in variable groups should be marked as **secret variables**, which masks them in logs but does not prevent them from being accessed by malicious pipeline code
- The **principle of least privilege** dictates that variable groups should be scoped to only the pipelines/projects that require them, limiting blast radius on compromise
- Attackers use `printenv` or echo commands injected into pipeline steps to **exfiltrate secret variable values** even when masked in UI logs

## Related concepts
[[CI/CD Pipeline Security]] [[Secrets Management]] [[Principle of Least Privilege]] [[Azure Key Vault]] [[Hardcoded Credentials]]