# ComfyUI

## What it is
Like a visual plumbing schematic where you connect pipes and valves to route water, ComfyUI is a node-based graphical interface that lets users wire together AI image generation workflows by connecting discrete processing blocks. Precisely, it is an open-source, locally-deployable frontend for Stable Diffusion models that executes complex generative AI pipelines through a drag-and-drop node graph. Users chain together loaders, samplers, and encoders without writing code.

## Why it matters
Threat actors have weaponized ComfyUI's custom node ecosystem to distribute malicious Python packages disguised as legitimate workflow extensions — a supply chain attack vector. In documented incidents, malicious ComfyUI nodes executed reverse shells and exfiltrated API keys from compromised artist workstations. Because ComfyUI runs locally with broad filesystem access and no sandboxing, a single malicious node install can fully compromise the host machine.

## Key facts
- ComfyUI custom nodes are arbitrary Python code executed with the privileges of the running user — there is **no permission model or sandboxing** by default
- Attackers have used **typosquatting** on popular node repositories (e.g., ComfyUI-Manager) to deliver credential-stealing malware
- ComfyUI serializes workflows as **JSON files** — malicious actors embed payload-triggering logic that activates when victims import a shared workflow file
- The tool is frequently run on high-GPU workstations that may also hold **cloud credentials, SSH keys, and model weights** worth stealing
- Classified as an **insider threat and third-party software risk** vector in enterprise environments adopting local AI tooling

## Related concepts
[[Supply Chain Attack]] [[Malicious Python Packages]] [[Privilege Escalation]] [[Sandboxing]] [[Typosquatting]]