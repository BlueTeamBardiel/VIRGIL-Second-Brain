# RBAC

## What it is
Think of a hospital: janitors have keys to utility closets, nurses access patient records, and surgeons enter operating theaters — nobody gets a universal master key just by working there. Role-Based Access Control (RBAC) assigns permissions to *roles* rather than to individual users, so access rights are inherited by whoever occupies that role. Users are granted the minimum access their job function requires.

## Why it matters
In the 2020 Twitter breach, attackers used social engineering to compromise internal admin tools — accounts with excessive privileges far beyond their job function. Proper RBAC implementation would have compartmentalized those tools so that only a narrow set of roles (with tight monitoring) could access them, limiting the blast radius when credentials were compromised.

## Key facts
- RBAC is formalized in **NIST RBAC model (NIST SP 800-207)** and is the dominant access control model in enterprise environments
- Three core components: **Users → Roles → Permissions** (users never receive permissions directly)
- Enforces **Least Privilege** and **Separation of Duties** naturally through role design
- Distinguished from **DAC** (owner sets permissions) and **MAC** (system enforces labels) — RBAC is policy-driven by job function
- **Role explosion** is a common failure: organizations create too many granular roles, making management unworkable and defeating the purpose
- On Security+/CySA+ exams, RBAC is contrasted with **ABAC** (Attribute-Based) which uses contextual attributes like time, location, or device type — more flexible but more complex

## Related concepts
[[Least Privilege]] [[Separation of Duties]] [[ABAC]] [[Mandatory Access Control]] [[Identity and Access Management]]