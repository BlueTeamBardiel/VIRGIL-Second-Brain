# Waterfall

## What it is
Like building a skyscraper floor-by-floor where you can't pour the 3rd floor concrete until the 2nd is fully cured — Waterfall is a sequential software development methodology where each phase (requirements → design → implementation → testing → deployment) must be fully completed before the next begins. There is no going back to a previous phase once it's closed.

## Why it matters
In a Waterfall-developed system, security requirements must be captured in the very first phase — if a threat model misses an authentication vulnerability during requirements gathering, that flaw gets baked into design, coded into implementation, and potentially ships to production before testing catches it. This is why many legacy enterprise systems (banking, healthcare, government) carry deep-rooted vulnerabilities: security was an afterthought bolted on at the testing phase rather than designed in from the start.

## Key facts
- Waterfall follows strict sequential phases: Requirements → Design → Implementation → Testing → Deployment → Maintenance
- Security defects found late in Waterfall are exponentially more expensive to fix than those caught in requirements (IBM research estimates 100x cost increase)
- Waterfall contrasts with **Agile/DevSecOps**, where security testing is integrated continuously ("shift left")
- Waterfall's rigid structure makes it poorly suited for threat landscapes that evolve faster than the development cycle
- Common in government and defense contracts (e.g., DoD historically mandated Waterfall via MIL-STD-2167A) where documentation and phase sign-offs are legally required
- Security+ and CySA+ associate Waterfall with **SDLC** concepts and contrast it against iterative models for secure development

## Related concepts
[[SDLC]] [[Agile Development]] [[DevSecOps]] [[Threat Modeling]] [[Shift Left Security]]