---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 046
source: rewritten
---

# Network Documentation
**Visual blueprints and diagrams that translate your infrastructure into actionable intelligence.**

---

## Overview
Network documentation serves as the institutional memory of your IT infrastructure—the reference guide that everyone from technicians to architects consults to understand how systems connect and operate. For the Network+ exam, mastering documentation types is essential because exam scenarios frequently ask you to interpret diagrams, troubleshoot based on documented layouts, and recommend appropriate documentation methods for given situations.

---

## Key Concepts

### Physical Network Map
**Analogy**: Think of it like the blueprint your electrician uses when wiring a house—it shows exactly where every wire goes, what it plugs into, and the physical path it takes through the walls.

**Definition**: A [[Physical Network Map]] is a visual representation that depicts the actual, tangible layout of networking hardware, cabling infrastructure, and device placement within a physical space. It functions as a real-world "you are here" guide.

**Characteristics**:
- Shows [[Cable]] runs and their physical paths
- Identifies exact device locations and [[IP Address]] assignments
- Tracks [[Port]] connections between specific devices
- Documents [[Patch Panel]] connections and wall outlets

**Use Cases**:
- Troubleshooting [[Cable]] problems by physically locating equipment
- Planning infrastructure upgrades or expansions
- Training new technicians on equipment locations
- Documenting [[Cabling Standards]] compliance

### Logical Network Map
**Analogy**: Imagine describing your friend group by how they communicate rather than where they sit—you're focused on who talks to whom, not their physical locations.

**Definition**: A [[Logical Network Map]] abstracts away physical minutiae and instead visualizes how data flows between network zones, systems, and services. It emphasizes connectivity relationships rather than cable runs.

**Characteristics**:
- Groups devices by function (e.g., "Data Center," "Branch Office")
- Shows [[Subnet]] organization and [[VLAN]] relationships
- Displays high-level connectivity flows
- Often represents [[Cloud]] resources as unified symbols
- Simplifies complexity for strategic planning

**Use Cases**:
- Planning [[WAN]] expansion or multi-site deployments
- Presenting network architecture to non-technical stakeholders
- Designing new subnets or [[VLAN]] structures
- Understanding data flow paths for security analysis

### Network Mapping Tools
**Common Documentation Software**:

| Tool | Best For | Strength |
|------|----------|----------|
| Visio | Enterprise documentation | Extensive stencil library, integration |
| OmniGraffle | Mac-centric teams | Native macOS support, template quality |
| Gliffy | Cloud collaboration | Browser-based, real-time updates |
| Lucidchart | Remote-first organizations | Web-native, version control |

**Benefits of Automated Tools**:
- Maintain consistent visual standards
- Enable quick iteration during redesigns
- Support version control and audit trails
- Allow dynamic updates as infrastructure changes

---

## Exam Tips

### Question Type 1: Diagram Interpretation
- *"A technician needs to locate a specific [[Patch Cable]] in Building B. Which documentation type would be most useful?"* → Physical network map (shows actual location and routing)
- **Trick**: Don't confuse logical maps with physical maps—logical maps won't tell you where to physically go to find equipment

### Question Type 2: Documentation Selection
- *"A company is planning to open three new branch offices. What should they review first?"* → Logical network map (shows existing WAN structure and optimal connection points)
- **Trick**: Physical maps are too detailed for this strategic planning phase

### Question Type 3: Change Management
- *"After installing new equipment, what documentation must be updated?"* → Both types—physical map reflects new cabling, logical map reflects new connectivity
- **Trick**: Updating only one type creates dangerous inconsistencies

---

## Common Mistakes

### Mistake 1: Treating Maps as Interchangeable
**Wrong**: Using a logical map to troubleshoot why a specific cable isn't working
**Right**: Using a physical map to locate the actual cable path, then referencing the logical map to understand what that cable should carry
**Impact on Exam**: Questions often test whether you understand the *purpose* of each map type, not just that they exist

### Mistake 2: Assuming One Map Covers Everything
**Wrong**: Maintaining only a logical map because "it shows all the connectivity we need"
**Right**: Maintaining both maps with synchronized updates, as they serve different audiences and purposes
**Impact on Exam**: Scenario questions may ask which documentation gap is creating problems, expecting you to recognize missing physical details

### Mistake 3: Neglecting Documentation Updates
**Wrong**: Creating maps once during deployment and never updating them as devices are added/removed
**Right**: Establishing a change management process where documentation is updated simultaneously with infrastructure changes
**Impact on Exam**: You may see questions about documentation governance, and "outdated docs create troubleshooting nightmares" is a core Network+ concept

---

## Related Topics
- [[Cabling Standards]]
- [[Network Topology]]
- [[VLAN]]
- [[Subnetting]]
- [[Change Management]]
- [[Patch Panel]]
- [[WAN]]
- [[Cloud Infrastructure]]
- [[IP Addressing]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*