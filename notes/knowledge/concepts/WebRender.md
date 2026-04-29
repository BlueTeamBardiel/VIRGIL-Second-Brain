# WebRender

## What it is
Like a painter who re-draws only the parts of a canvas that actually changed instead of repainting the whole wall, WebRender is Mozilla's GPU-based rendering engine that batches and composites web page elements directly on the graphics card rather than the CPU. It replaces the traditional per-layer CPU compositing pipeline in Firefox with a scene-graph approach that offloads visual computation to the GPU for smoother, more consistent frame rates.

## Why it matters
WebRender expands the browser's GPU attack surface — any vulnerability in how it parses CSS, SVG, or WebGL inputs could trigger GPU driver exploits or memory corruption bugs that escape the browser sandbox. In 2020–2021, researchers identified that GPU process isolation (introduced alongside WebRender) became a new trust boundary requiring its own sandbox hardening, because a compromised GPU process with access to shared memory could leak cross-origin pixel data, enabling side-channel attacks similar to Spectre.

## Key facts
- WebRender ships in Firefox and uses **WebGL/GLSL shaders** under the hood, meaning malformed display lists can trigger GPU driver code paths with historically poor security track records
- It introduces a **GPU process** as a separate privilege level — if not properly sandboxed, it represents a lateral movement opportunity post-browser-compromise
- **Cross-origin pixel stealing** is a realistic threat when GPU shared memory isn't isolated per origin, violating the Same-Origin Policy at the hardware layer
- WebRender's scene graph batches draw calls, but **maliciously crafted CSS animations** can exhaust GPU memory, causing denial-of-service within the browser tab
- GPU-accelerated rendering pipelines are **not covered by traditional DEP/NX protections** because shader execution happens outside the normal CPU memory model

## Related concepts
[[Browser Sandbox Escape]] [[Side-Channel Attacks]] [[Same-Origin Policy]] [[GPU Process Isolation]] [[Spectre Vulnerability]]