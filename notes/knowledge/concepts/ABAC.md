# ABAC

## What it is
Think of ABAC like a bouncer who checks *everything* about you—not just your ID, but what you're wearing, the time of day, and who you're with—before deciding if you get in. Attribute-Based Access Control (ABAC) makes authorization decisions by evaluating attributes (properties) of the user, resource, action, and environment against a set of policies, rather than just checking fixed roles.

## Why it matters
A hospital needs nurses to access patient records, but only during their shift, only for patients on their ward, and only to read (not delete) records. Role-based access (RBAC) would grant broad "nurse" permissions; ABAC lets you enforce fine-grained rules like `(user.department == "ICU") AND (current_time >= shift_start) AND (action == "read")`. This prevents lateral movement and privilege creep—when a nurse transfers departments, their access automatically adjusts based on new attributes.

## Key facts
- Uses **attributes** across four dimensions: user (department, clearance level), resource (classification, owner), action (read, write, delete), and environment (time, IP location, device type)
- More **flexible and dynamic** than RBAC—no need to manually update role definitions when circumstances change
- Requires a **policy engine** to evaluate complex logical expressions (usually written in XACML or similar languages)
- Scales well for **fine-grained control** in cloud and zero-trust architectures
- Operationally complex—managing attribute data and policies requires discipline

## Related concepts
[[RBAC]] [[Zero Trust]] [[Principle of Least Privilege]] [[XACML]] [[Entitlement Management]]