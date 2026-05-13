# Cloud, VM, and Container Forensics

## What it is

In **Mass Effect**, when Shepard boards a derelict ship — the MSV Ontario, the Cerberus stations, the husk-infested freighters — the first thing the squad does is jack into the ship's onboard VI and pull the logs. The crew is gone. The bodies are gone. The Reaper indoctrination signal is gone. What's left is a console, a black box, and whatever the ship's automated systems decided to record before everything went sideways. You don't get a corpse to autopsy. You get a log file and a snapshot, and you reconstruct the attack from telemetry. That's exactly what cloud, VM, and container forensics is — the host is gone, the workload was killed by an autoscaler, the container was destroyed when the pod restarted, and you're left querying CloudTrail like Shepard scrubbing Cerberus terminal logs to figure out who came aboard and what they took.

**Plain English:** when the system you need to image is virtual, ephemeral, or running on someone else's hardware, traditional disk forensics breaks. You can't pull the drive. You can't write-block the SAN. You work from snapshots, provider APIs, and logs — and you trust the cloud provider's chain of custody whether you like it or not.

**Technical (CS0-003):** forensic acquisition and analysis in environments where the artifact is virtualized (VM disk images, memory snapshots), ephemeral (containers, serverless functions, autoscaled instances), or hosted on shared infrastructure under a shared-responsibility model. Evidence sources shift from physical media to cloud provider logs (CloudTrail, Azure Activity Log, GCP Audit Log), hypervisor snapshots, container runtime logs, and orchestration platform telemetry (Kubernetes audit logs).

## Why it matters

Workloads moved. The Fortune 500 isn't running on bare metal in a closet anymore — it's running on EC2, AKS, GKE, Lambda, ECS Fargate. When an attacker pops a container, that container might live for forty seconds before the pod restarts and the evidence is gone. When an attacker pops an EC2 instance, the autoscaling group might terminate it before your IR team finishes the bridge call. **You either know how to capture evidence in this environment or you don't get to do forensics at all.**

CompTIA tests this under Objective 3.2 (incident response activities) because the agency recognized that "image the disk, hash it, write-block it" doesn't survive contact with AWS. Expect questions on evidence acquisition in cloud contexts, snapshot-based imaging, and the limits imposed by shared responsibility.

Real stakes: a 2023 cryptojacking incident in a Kubernetes cluster where the IR team didn't enable audit logging before the attack — the pods rotated, the malicious images were pulled fresh each time, and the only forensic artifact left was a billing alert. Cost the company six figures before anyone could even prove what happened. *If you didn't turn on logging before the incident, the incident didn't happen as far as forensics is concerned.*

## Key facts

### The three environments and what breaks in each

| Environment | What breaks | Primary evidence source |
|---|---|---|
| **Cloud (IaaS/PaaS/SaaS)** | No physical access, shared tenancy, provider owns the hypervisor | Provider audit logs (CloudTrail, Activity Log), VPC flow logs, snapshot APIs |
| **Virtual machines** | Disk is a file on someone else's storage; memory is volatile and lives in hypervisor RAM | Hypervisor snapshots (VMDK, VHDX, qcow2), memory dumps via hypervisor introspection |
| **Containers** | Ephemeral by design — killed on restart, immutable images, shared kernel | Container runtime logs (Docker/containerd), orchestrator audit logs (K8s), image registry history |

### Evidence acquisition — the cloud playbook

**Snapshots over imaging.** You don't `dd` an EBS volume. You call the snapshot API, get a point-in-time copy, then mount it to a forensic analysis instance in a quarantined VPC. The snapshot is your image. AWS, Azure, and GCP all provide this — and the snapshot timestamp is your acquisition timestamp for [[chain of custody]].

**Memory is harder.** Cloud providers don't always expose hypervisor-level memory. Options:
- AWS: enable EC2 instance memory dump via SSM before terminating
- Azure: serial console or VM snapshot with memory option
- On-prem hypervisor (VMware, Hyper-V): suspend the VM and grab the `.vmem` or `.bin` file — this is the gold standard

**Logs are the new disk.** When the host is ephemeral, the only persistent record is what got shipped off-host before the workload died. This means [[SIEM]] ingestion, centralized logging (CloudWatch, Log Analytics, Stackdriver), and audit log retention are forensic prerequisites, not nice-to-haves.

### Container forensics — the hardest case

Containers are designed to be cattle, not pets. When something looks wrong, the orchestrator's instinct is to kill the pod and spin up a fresh one. That's a containment win and a forensics loss in the same action.

**Before killing the container:**
1. Cordon the node and prevent rescheduling
2. `kubectl exec` to grab `/proc/[pid]/` artifacts, environment variables, mounted volumes
3. `docker commit` or `nerdctl commit` the running container into a forensic image
4. Capture the container's writable layer (overlay2 upper directory) from the node
5. Pull the original image hash from the registry — compare against what's actually running

*The first time you do container [[Forensics — Acquisition and Analysis|forensic acquisition]] under pressure, you will forget step 3 and the pod will restart. Write the runbook now, not at 3am.*

### Validating data integrity in cloud forensics

[[Hashing]] still rules. Every snapshot, every log export, every memory dump gets a SHA-256 the moment it lands in the forensic workspace. The hash goes in the [[chain of custody]] record alongside:
- Who pulled it (analyst identity, IAM role used)
- When (UTC, provider timestamp + analyst-side timestamp)
- From where (account ID, region, resource ARN)
- Via what (API call, console action, CLI command)

Cloud providers also offer their own integrity signals — CloudTrail log file integrity validation (signed digests every hour), Azure Storage immutable blob policies, GCP bucket retention policies. Turn these on before the incident, not after.

### Scope, impact, and the shared responsibility wall

**[[Scope]]** in cloud forensics is harder because of blast radius. One compromised IAM role can touch every service, every region, every account in the org. The scoping questions:
- Which accounts/subscriptions/projects are in scope?
- Which IAM principals had the compromised credential?
- What did those credentials touch (CloudTrail event history, last 90 days default)?
- Are there cross-account roles that extend the blast radius?

**[[Impact]]** assessment in cloud means looking at data egress (VPC flow logs, S3 access logs), API call volume anomalies, and resource creation in unusual regions (attackers love spinning up crypto miners in regions you don't normally use).

**The shared responsibility wall:** you cannot forensicate what the provider owns. The hypervisor, the physical network, the storage backend, the host OS of managed services — that's the provider's evidence, and you get what they give you via subpoena or contractual log access. *Your IR plan must assume the provider's logs are the upper limit of what you'll ever see.*

### Containment and compensating controls in cloud

[[Containment]] options that don't destroy evidence:
- **Network isolation:** modify security group to deny all ingress/egress, but leave the instance running so memory and disk are preserved
- **IAM revocation:** detach the compromised role's policies, force credential rotation, but don't delete the principal (you need it for log correlation)
- **Quarantine VPC:** snapshot the instance, restore it into an isolated VPC with no internet route, analyze there
- **Pod isolation:** Kubernetes NetworkPolicy to deny all traffic to the suspect pod, cordon the node

[[Compensating controls]] when you can't fully remediate immediately: WAF rules in front of the affected service, additional MFA on the IAM principal, increased logging verbosity, temporary geo-fencing.

### Re-imaging and recovery

[[Re-imaging]] is trivially easy in cloud — that's the upside. Terraform/CloudFormation/ARM templates spin up clean infrastructure in minutes. The discipline:
1. Confirm the malicious artifact isn't in your golden image or container base image
2. Rotate every secret the compromised workload had access to
3. Rebuild from infrastructure-as-code, not from the running (compromised) state
4. Validate the new instance's IoCs are clean before flipping DNS/load balancer

### CompTIA exam traps

> **CompTIA exam trap:** "Cloud forensics uses the same procedures as traditional forensics." Wrong. The shared responsibility model means you literally cannot acquire some evidence (hypervisor, physical layer). The right answer emphasizes provider APIs, snapshots, and log-centric analysis.

> **CompTIA exam trap:** "Terminate the compromised instance immediately to contain the threat." Wrong for forensics. Terminate destroys the volatile evidence (memory, running processes, open network connections). The correct sequence is **isolate first (security group lockdown), snapshot second, then terminate.** Containment that destroys evidence is a forensic failure even if it's a containment win.

> **CompTIA exam trap:** [[Legal hold]] in cloud means you must prevent the provider's lifecycle policies from deleting logs, snapshots, and storage objects. Default S3 lifecycle rules will happily delete your evidence on day 30. Legal hold requires explicit object-lock or retention-policy configuration.

> **CompTIA exam trap:** Container forensics ≠ VM forensics. Containers share the host kernel; you can sometimes get kernel-level evidence from the host that you'd never see inside the container. Know the boundary.

## SOC reality

- The 3am alert isn't "container compromised." It's a GuardDuty finding for unusual API calls from an EC2 instance role, or a CloudWatch alarm for crypto-mining-style CPU on a node, or a billing anomaly. The forensic question — *what happened on that host* — comes after the triage.
- L1 acknowledges, checks if the resource still exists (half the time it's already gone — autoscaled away), and escalates to L2 with the resource ARN, the IAM principal, and the CloudTrail event ID.
- The IR lead asks three questions: "Did we snapshot before anything got terminated? What's the blast radius on that IAM role? Are the logs preserved or are we inside the default retention window?"
- Never promise leadership "we have the full picture." In cloud, you have *the provider's picture* of what happened. The hypervisor, the underlying storage, the network fabric — those are the provider's evidence, and you don't get them without a subpoena.
- Handoff: L1 (alert triage) → L2 (snapshot + scope) → IR team (analysis + containment) → cloud platform team (re-imaging via IaC) → legal (if [[Legal hold]] required or breach notification triggers — GDPR 72h, state laws vary).

## Related concepts

[[Forensics — Acquisition and Analysis]] · [[Chain of Custody]] · [[Legal Hold]] · [[Hashing]] · [[SIEM]] · [[Containment]] · [[Compensating Controls]] · [[Re-imaging]] · [[Scope]] · [[Impact]] · [[Cloud Shared Responsibility Model]] · [[Kubernetes Security]] · [[VPC Flow Logs]] · [[CloudTrail]]

*Source: VIRGIL knowledge base — 2026-05-11*