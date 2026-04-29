# ABAC - Attribute-Based Access Control

## What it is
Imagine a bouncer who doesn't just check "are you on the list?" but instead evaluates: "Are you over 21 AND wearing proper shoes AND it's before 2am AND you're not on the banned list?" ABAC works the same way—access decisions are based on attributes (properties of users, resources, environment, and actions) rather than fixed roles. Instead of "admins can edit files," ABAC enforces "users with department=IT AND clearance=secret AND time=business-hours can edit files in the finance folder."

## Why it matters
A hospital needs fine-grained access control: nurses can view patient records during their shift for assigned patients only, but doctors can view any record anytime. Role-based access (RBAC) would require dozens of overlapping roles. ABAC handles this elegantly with attributes like `role`, `department`, `patientAssignment`, `currentTime`, and `location`. When an insider threat or compromised account attempts access outside normal parameters, ABAC policies catch what RBAC would miss.

## Key facts
- Attributes come from four sources: user (identity, department), resource (classification, owner), environment (time, IP, location), action (read, write, delete)
- Policies use logic (AND, OR, NOT) to combine attributes—far more flexible than RBAC's static role hierarchy
- ABAC scales better in dynamic environments (cloud, IoT) where roles constantly change
- Requires a Policy Decision Point (PDP) to evaluate attributes at request time—slightly higher latency than RBAC
- Standards include XACML (eXtensible Access Control Markup Language) and AWS's IAM policy language

## Related concepts
[[RBAC]] [[Principle of Least Privilege]] [[Zero Trust]] [[Policy Decision Point]]