---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 030
source: rewritten
---

# Infrastructure as Code
**Define your entire network environment using declarative configuration files instead of manual point-and-click setup.**

---

## Overview
[[Infrastructure as Code]] (IaC) represents a paradigm shift where you express your entire [[network infrastructure]]—servers, [[firewalls]], [[switches]], [[routers]], and applications—as machine-readable [[configuration files]]. Rather than physically building and configuring each device individually, you write code that describes the desired state, then let automation tools deploy it instantly. For the Network+ exam, understanding IaC is essential because cloud platforms and modern DevOps environments rely on it for speed, consistency, and disaster recovery.

---

## Key Concepts

### Infrastructure as Code
**Analogy**: Instead of giving a contractor verbal instructions for every detail of building a house room-by-room, you hand them a complete blueprint that specifies every wall, pipe, and electrical outlet—then they build it all at once.

**Definition**: A [[declarative programming]] approach where you describe your entire infrastructure stack in [[configuration files]]. Rather than executing manual commands, you define the end state and let automation tools (like [[Terraform]], [[CloudFormation]], or [[Ansible]]) build it.

| Aspect | Manual Setup | Infrastructure as Code |
|--------|--------------|----------------------|
| **Deployment Speed** | Hours/days | Minutes |
| **Consistency** | Prone to human error | Identical every time |
| **Scalability** | Repetitive clicking | Copy, paste, deploy |
| **Version Control** | No tracking | Git-tracked changes |
| **Disaster Recovery** | Rebuild from scratch | Redeploy from code |

### Configuration Files
**Analogy**: Think of a recipe card—once written, anyone can follow it exactly the same way and produce identical results.

**Definition**: Plain-text or [[markup language]] files (JSON, YAML, HCL) that contain declarative statements defining every network and application component: [[IP addresses]], [[VLAN]] assignments, [[firewall rules]], [[load balancer]] configurations, and [[DNS]] records.

```yaml
# Example IaC configuration snippet
resource "aws_instance" "mail_server" {
  hostname = "mail.example.com"
  instance_type = "t3.medium"
  availability_zone = "us-east-1a"
}

resource "aws_instance" "web_server" {
  hostname = "web01.example.com"
  instance_type = "t3.small"
}

resource "aws_instance" "database_server" {
  hostname = "db01.example.com"
  instance_type = "r5.large"
}
```

### Idempotency
**Analogy**: Pressing the same button twice produces the same result—not a double result.

**Definition**: The ability to apply the same [[IaC]] configuration multiple times without creating duplicates or causing unintended changes. The system checks current state and only applies necessary modifications.

### Versioning & Repeatability
**Analogy**: Like saving versions of a document (v1.0, v1.1, v2.0), you track infrastructure changes and can roll back if needed.

**Definition**: Store [[configuration files]] in [[version control systems]] (Git, SVN) to track changes, enable collaboration, and maintain a complete audit trail of infrastructure evolution.

### Multi-Environment Deployment
**Analogy**: You have one recipe card, but you can bake the same cake in your home kitchen or a commercial bakery—same result, different location.

**Definition**: Copy your [[IaC]] code to another [[data center]], [[cloud region]], or [[availability zone]], run the deployment script, and instantly create an identical infrastructure replica in a new location.

---

## Exam Tips

### Question Type 1: IaC Benefits & Use Cases
- *"Your company wants to deploy an identical test environment that mirrors production. Which approach best achieves this?"* → **Infrastructure as Code—copy the configuration file and deploy to a new region**
- **Trick**: Don't confuse IaC with simple [[configuration management]]. IaC creates infrastructure; configuration management customizes already-existing systems.

### Question Type 2: IaC Tools & Terminology
- *"Which tool uses declarative configuration files to manage cloud infrastructure?"* → [[Terraform]], [[CloudFormation]] (AWS), [[Azure Resource Manager]]
- **Trick**: The exam may ask which is "procedural" vs "declarative"—IaC is declarative (you say *what*, not *how*).

### Question Type 3: Disaster Recovery Scenarios
- *"After a data center failure, your team needs to rebuild the entire network in 30 minutes. What enables this?"* → Pre-written [[Infrastructure as Code]] that can be deployed immediately
- **Trick**: They might emphasize "speed" or "consistency"—both are correct answers in the context of IaC.

### Question Type 4: Change Management
- *"A network engineer modifies the IaC configuration and commits it to Git. What happens next in a CI/CD pipeline?"* → The code is reviewed, tested, and deployed automatically
- **Trick**: Don't confuse manual code review with automated deployment—both occur.

---

## Common Mistakes

### Mistake 1: Treating IaC as Only for Large Enterprises
**Wrong**: "Infrastructure as Code is only useful for massive companies with thousands of servers."
**Right**: IaC provides value at any scale—even a 10-server network benefits from consistent, version-controlled deployments.
**Impact on Exam**: Net+ tests your understanding that IaC is a modern best practice for all organizations, not a luxury feature.

### Mistake 2: Confusing IaC with Configuration Management
**Wrong**: "IaC and [[Ansible]] do the same thing."
**Right**: IaC *creates* infrastructure (servers, networks, storage); [[configuration management]] *configures* already-existing systems (patches, software, settings).
**Impact on Exam**: You'll see questions asking which tool is appropriate for a specific task—know the distinction.

### Mistake 3: Assuming IaC is Cloud-Only
**Wrong**: "You can only use Infrastructure as Code with AWS/Azure/GCP."
**Right**: IaC works with on-premises data centers, hybrid clouds, and private clouds using tools like [[Terraform]], [[Ansible]], and [[OpenStack]].
**Impact on Exam**: Net+ tests real-world scenarios where organizations use IaC across multiple platforms.

### Mistake 4: Overlooking Idempotency
**Wrong**: "If I run the same IaC script twice, it will create duplicate resources."
**Right**: Proper IaC tools check existing state and only apply necessary changes (idempotent behavior).
**Impact on Exam**: Questions about infrastructure stability and preventing unintended changes rely on understanding idempotency.

### Mistake 5: Ignoring Version Control
**Wrong**: "IaC configuration files don't need to be tracked like code."
**Right**: IaC files *are* code and should live in [[Git]] or similar version control for audit trails and collaboration.
**Impact on Exam**: Net+ emphasizes governance, compliance, and change tracking—IaC + version control is the foundation.

---

## Related Topics
- [[Configuration Management]]
- [[Cloud Computing]]
- [[DevOps]]
- [[Automation]]
- [[Version Control Systems]]
- [[Disaster Recovery Planning]]
- [[CI/CD Pipeline]]
- [[Declarative vs Procedural Programming]]
- [[Terraform]]
- [[CloudFormation]]
- [[Ansible]]
- [[Network Orchestration]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*