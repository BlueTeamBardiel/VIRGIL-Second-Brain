# Ansible and Terraform: Infrastructure as Code for Network Automation

## What it is

Setting up a fresh Minecraft server by hand — installing Java, editing `server.properties`, port forwarding, adding plugins one by one — works fine for one server. Now do it for 200 servers, and make sure they all stay identical six months later when someone "just tweaks one thing real quick." That's the nightmare Infrastructure as Code (IaC) solves.

**Infrastructure as Code** is the practice of describing your infrastructure — switches, routers, firewalls, cloud VMs, VLANs — in machine-readable files instead of clicking through GUIs or typing commands into a terminal at 2 AM. The file is the source of truth. The infrastructure is just an output of running that file.

Two of the heaviest hitters here are **Ansible** and **Terraform**, and they solve overlapping but distinct problems.

- **Ansible** is the procedural one. It's a recipe: "do step 1, then step 2, then step 3." Like writing out a Helldivers 2 stratagem input — a specific sequence to get a specific outcome.
- **Terraform** is the declarative one. You describe the *end state* you want, and Terraform figures out how to get there. Like setting a build target in a base-builder game: "I want 4 turrets and 2 generators here," and the game computes what to construct, demolish, or leave alone.

## Why it matters

Networks rot. Not literally, but functionally — and the disease has a name: **configuration drift**.

Drift is what happens when Beatrice fixes an outage at 3 AM by SSH-ing into a switch and tweaking a QoS policy, doesn't document it, and three months later Dante can't figure out why the new site won't match the "standard" template. Multiply that across 50 engineers and 500 devices over five years. Eventually no two devices are alike, no one knows what's "correct," and the runbook is a museum piece.

Sources of drift, all painfully familiar:
- Different engineers interpreting the "standard" differently
- Emergency fixes nobody wrote down
- Typos that became permanent
- No monitoring to catch when a device wandered off-spec

IaC kills drift because the code IS the standard. If a device doesn't match the code, the code wins — re-run the playbook, and the device is dragged back into compliance. You also get free version control (git blame on your network), peer review via pull requests, disaster recovery (rebuild the network from a repo), and an audit trail compliance auditors will actually accept.

The core configuration elements you'd typically codify: DNS servers, NTP servers, routing protocols, QoS policies, AAA servers, security policies, syslog destinations. The boring, repetitive stuff that *must* be identical everywhere.

## Key facts

### Configuration management fundamentals

- **Configuration management** maintains, controls, and documents device configs to enforce consistency, security, and compliance — it's the save-file system for your network.
- **Configuration drift** = the gradual divergence between what your docs say a device should be and what it actually is. Like a Tarkov hideout where you swear you upgraded the generator but the game says otherwise.
- The standard workflow: **edit template → validate file → apply to devices → report compliance**. Same loop whether you're using Ansible, Terraform, or anything else.
- **Jinja2** is the templating language doing the heavy lifting — placeholders like `{{ hostname }}` and `{{ mgmt_ip }}` get filled in per device, the way Discord message templates with `{user}` get filled per recipient.

### Ansible

- **Agentless** — no software installed on the managed devices. Ansible just SSHes in, runs commands, and leaves. Network gear doesn't need to host anything extra.
- **Push model** — the control node initiates everything and pushes changes outward. Like a raid leader in an MMO calling out mechanics; the bosses (devices) don't phone home, the leader dictates.
- **Playbooks** — YAML files listing tasks in order. Top to bottom, do this, then this, then this. Procedural.
- **Inventory files** — the roster. Lists every managed device with its variables (IP, role, site, credentials reference). Think of it as the party screen showing every character and their stats.
- **Modules** — pre-built ability cards for specific jobs. `cisco.ios.config` pushes config lines, `cisco.ios.facts` gathers info, `cisco.ios.command` runs arbitrary commands.
- **Idempotent** — running the same playbook 10 times produces the same result as running it once. No double-applying, no breakage. Like pressing the "equip loadout" button — already equipped means nothing happens, not "equip it twice."
- **No state tracking** — Ansible doesn't remember what it did last time. Each run, it checks the current state, makes it match, then forgets.

### Terraform

- **Declarative** — you write what you want to exist, not the steps to get there. "I want this VPC, these 3 subnets, this firewall rule." Terraform computes the diff.
- **Desired-state model** — Terraform constantly compares "what's deployed" against "what the code says should exist" and corrects the difference.
- **State file** — Terraform's memory. A JSON file (`terraform.tfstate`) that maps your code to real-world resources. This is how it detects drift: if reality doesn't match state, something changed outside Terraform.
- **Providers** — plugins for specific platforms. AWS provider, Azure provider, Cisco provider, Cloudflare provider. Like installing the right controller driver for the platform you're targeting.
- **Resources** — the individual infrastructure objects (a subnet, an instance, a DNS record). Each resource block is one "thing" you're managing.
- **Modules** — reusable bundles of resources. Write a "branch office" module once, instantiate it 40 times with different variables. Same energy as prefab buildings in Tears of the Kingdom's Ultrahand.
- **`terraform plan`** — dry run. Shows you exactly what will be created, changed, or destroyed before you commit. Like the loadout preview before mission start in Helldivers 2 — last sanity check.
- **Immutable infrastructure** — Terraform tends to destroy and recreate resources rather than patch them. Don't repair the broken VM; nuke it, redeploy a fresh one. New character, not a respec.

### Ansible vs Terraform at a glance

| | Ansible | Terraform |
|---|---|---|
| Style | Procedural (steps) | Declarative (end state) |
| State | No tracking | Explicit state file |
| Best at | Configuring existing devices | Provisioning new infrastructure |
| Model | Push via SSH | Provider API calls |
| Mutation | Patches in place | Destroys and recreates |

In practice, teams often run both: **Terraform** stands up the infrastructure (build the cloud VPC, spin up the routers), then **Ansible** configures what's living on it (push the routing config, set up SNMP, deploy the AAA settings).

## Related concepts

[[Configuration drift]] · [[YAML]] · [[Jinja2 templating]] · [[Git and version control for network configs]] · [[NETCONF and RESTCONF]] · [[YANG data models]] · [[CI/CD pipelines for networking]] · [[Idempotency]] · [[Declarative vs imperative programming]] · [[Cisco DNA Center]] · [[Network automation with Python and Netmiko]] · [[SSH key-based authentication]] · [[Source of truth (NetBox)]]