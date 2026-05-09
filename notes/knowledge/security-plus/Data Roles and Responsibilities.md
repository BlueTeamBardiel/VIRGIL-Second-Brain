# Data Roles and Responsibilities

## What it is

In Half-Life, the Black Mesa Research Facility runs because everyone has a designated job: the Administrator owns the place and answers to nobody (until aliens arrive), the scientists in lab coats handle the anomalous materials directly, the security guards process access at checkpoints, and Gordon Freeman is the contractor who pushes the cart into the test chamber because someone told him to. When the resonance cascade hits, blame attaches to specific roles — the Administrator authorized the experiment, the scientists chose the sample, Gordon executed the procedure. That's exactly what data roles do — they assign accountability for data so that when things break, you know whose neck is on the line.

**Data roles and responsibilities** are the formally assigned accountabilities for the collection, classification, protection, processing, and disposal of organizational data, ensuring legal, regulatory, and security obligations are met by named parties.

## Why it matters

Without assigned roles, no one owns the breach. Regulators under [[GDPR]], [[HIPAA]], and [[PCI DSS]] require named accountability — "the IT team handles it" is not a legal answer and will earn fines. On SY0-701 Objective 5.1, you must distinguish **owner vs. controller vs. processor vs. custodian vs. steward vs. subject**, and CompTIA's favorite trap is conflating *owner* (accountable, makes decisions) with *custodian* (technical caretaker, executes decisions). They will also test whether you can spot that a cloud provider is almost always a **processor**, not a controller.

## Key facts

### The six roles you must know cold

| Role | Function | Real-world example |
|---|---|---|
| **[[Data Owner]]** | Senior executive with ultimate accountability for a data set; sets classification and approves access policy | VP of HR owns employee records |
| **[[Data Controller]]** | Determines *why* and *how* personal data is processed; legally liable under GDPR | The company collecting customer data |
| **[[Data Processor]]** | Processes data on behalf of the controller; follows controller's instructions | AWS, Salesforce, payroll vendor |
| **[[Data Custodian]]** | Technical hands-on caretaker; implements controls, backups, encryption | Sysadmin, DBA |
| **[[Data Steward]]** | Day-to-day quality, labeling, and policy enforcement; the data's bureaucrat | Records manager, compliance analyst |
| **[[Data Subject]]** | The human the data is *about*; has rights under privacy law | Customer, employee, patient |

### Owner vs. Custodian — the classic exam trap

- **Owner** is *accountable* — usually a business executive, not technical. Decides "this is Confidential, only Finance sees it."
- **Custodian** is *responsible* — technical staff who configure the [[ACL]], run the backups, rotate the keys.
- The owner can delegate the *work* to the custodian but **cannot delegate the accountability**. If the data leaks, the owner answers for it.

### Controller vs. Processor — the GDPR distinction

- **Controller** decides purpose and means → bears primary legal liability.
- **Processor** acts only on documented instructions from the controller → liability is narrower but real.
- A **Data Processing Agreement (DPA)** is the contract binding processor to controller's instructions. Required by GDPR Article 28.
- A processor that decides *its own* purposes for the data becomes a controller — and inherits all the liability that comes with it.

### Steward vs. Custodian — the subtle one

- **Steward** = policy and meaning. "This field is PII. It must be retained 7 years. It is labeled Internal."
- **Custodian** = mechanism. "I configured the storage encryption and the retention job."
- Steward governs *what should happen*; custodian makes it *actually happen*.

### Supporting roles that show up

- **[[Data Protection Officer]] (DPO)** — mandatory under GDPR for public bodies and large-scale processors of sensitive data; independent role reporting to top management.
- **[[Privacy Officer]] / Chief Privacy Officer (CPO)** — internal accountability for privacy program.
- **[[Chief Information Security Officer]] (CISO)** — owns the security program enabling all of the above.

### Why CompTIA cares

- Maps to [[Separation of Duties]] — no single role classifies, accesses, and audits.
- Required for [[Data Classification]] to function — someone has to *make* the classification decision.
- Underpins [[Incident Response]] — you need to know who to call when their data set is on fire.

## Related concepts

[[Data Classification]] · [[Data Sovereignty]] · [[GDPR]] · [[Data Protection Officer]] · [[Separation of Duties]] · [[Privacy Impact Assessment]] · [[Data Lifecycle]] · [[PII]] · [[Data Retention]] · [[Acceptable Use Policy]]

---
*Source: VIRGIL knowledge base — 2026-05-08*