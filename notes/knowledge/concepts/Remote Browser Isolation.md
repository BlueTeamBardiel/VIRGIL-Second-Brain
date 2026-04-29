# Remote Browser Isolation

## What it is
Like watching a movie through a one-way mirror — you see everything happening on screen, but nothing from that room can touch you. Remote Browser Isolation (RBI) executes all web browsing activity in a sandboxed environment hosted on a remote server, streaming only a safe visual rendering (pixels or DOM data) to the end user's device so that malicious code never executes locally.

## Why it matters
In a spear-phishing campaign, an attacker embeds a zero-day exploit in a malicious webpage targeting a financial analyst. With RBI deployed, the analyst clicks the link, the page loads and executes entirely on the remote server, and any malware payload detonates harmlessly in an isolated container that is destroyed afterward — the endpoint never touches the raw content.

## Key facts
- RBI comes in three rendering modes: **pixel pushing** (streams screenshots), **DOM mirroring** (reconstructs safe HTML), and **network vector renderer** — each trades off fidelity, bandwidth, and security.
- Protects against **drive-by downloads**, **browser exploits**, **malvertising**, and **credential harvesting** pages without requiring the browser to process raw malicious content.
- Sessions are **ephemeral** — containers are spun up per session and destroyed afterward, eliminating persistence mechanisms for malware.
- Distinguished from a standard proxy: a proxy filters *requests*, RBI eliminates *local code execution* entirely — a fundamentally stronger isolation guarantee.
- Often deployed as part of a **Secure Access Service Edge (SASE)** or **Zero Trust** architecture, sitting alongside SWG and CASB controls.

## Related concepts
[[Sandboxing]] [[Secure Web Gateway]] [[Zero Trust Architecture]] [[Content Disarm and Reconstruction]]