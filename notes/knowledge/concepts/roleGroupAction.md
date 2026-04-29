# roleGroupAction

## What it is
Like a master key that opens every door in a building because it belongs to the "management staff" group, a roleGroupAction is a permission mechanism where an action or capability is granted to an entire role-group rather than an individual user. Precisely, it is an access control construct that binds a specific privileged action to a defined group role, meaning any member of that group inherits the ability to perform that action automatically.

## Why it matters
In Active Directory environments, attackers who compromise a single account with Domain Admins group membership immediately inherit every roleGroupAction bound to that group — including password resets, GPO modifications, and replication rights. This is why lateral movement often targets group memberships rather than individual account privileges; owning the group means owning all associated actions.

## Key facts
- roleGroupAction is central to **Role-Based Access Control (RBAC)**, where permissions flow from role → group → action rather than user → action directly
- Violating the **principle of least privilege** occurs when roleGroupActions are overly broad — granting entire groups capabilities only one member actually needs
- In **privileged access reviews**, auditors specifically enumerate roleGroupActions to identify toxic combinations (e.g., a group that can both modify audit logs AND create users)
- **Separation of Duties (SoD)** controls aim to ensure no single roleGroupAction assignment gives one group end-to-end control over a sensitive process
- Misconfigured roleGroupActions are a common finding in **cloud IAM audits** (AWS IAM policies, Azure RBAC), where wildcard actions (`*`) applied to groups create massive attack surfaces

## Related concepts
[[Role-Based Access Control]] [[Principle of Least Privilege]] [[Separation of Duties]] [[Privileged Access Management]] [[Identity and Access Management]]