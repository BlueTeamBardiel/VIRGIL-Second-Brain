# Graphics

## What it is
Like a magician's sleight of hand that distracts the audience while something slips past, graphics rendering pipelines process visual data through GPU hardware that operates largely outside traditional OS security controls. Precisely, "graphics" in security refers to the attack surface created by GPU drivers, image-parsing libraries, and rendering engines that handle visual data — from raw pixel buffers to complex shader programs.

## Why it matters
In 2023, a critical vulnerability in the Windows GDI (Graphics Device Interface) component allowed attackers to embed malicious code within crafted image files — when the victim simply previewed the file, the parser executed attacker-controlled data with SYSTEM privileges. This class of attack (image-based malicous file execution) routinely appears in phishing campaigns because users instinctively trust visual content and preview functionality is often enabled by default.

## Key facts
- **GPU memory is not protected by DEP/ASLR** in the same way CPU memory is, making GPU-based malware persistence and cryptomining particularly difficult to detect
- **Steganography** hides malicious payloads within image pixel data (LSB substitution), bypassing content filters that scan for known file signatures
- **ImageMagick's "ImageTragick" (CVE-2016-3714)** demonstrated that image processing libraries can execute arbitrary shell commands through malformed image headers — a reminder that parsers are always an attack surface
- **SVG files** are XML-based vectors that can embed JavaScript, making them a common vehicle for stored XSS attacks when user-uploaded images aren't sanitized
- **Shader code** (GLSL/HLSL) runs directly on the GPU and can be weaponized for side-channel attacks that extract data from co-located virtual machines in cloud environments

## Related concepts
[[Steganography]] [[File Format Vulnerabilities]] [[Cross-Site Scripting]] [[Side-Channel Attacks]] [[Social Engineering]]