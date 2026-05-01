---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 26
source: rewritten
---

# Video Cables
**Your gateway to connecting computers and displays—understanding the cables that bring pixels to life.**

---

## Overview

Video cables are the physical pathways that transmit visual (and often audio) information from your computer's graphics hardware to a display device. For the A+ exam, you need to recognize common connector types, understand their capabilities, and know when to use adapters for compatibility between different standards.

---

## Key Concepts

### HDMI (High-Definition Multimedia Interface)

**Analogy**: Think of HDMI like a highway that carries both cars (video) and trucks (audio) in the same lanes simultaneously, but only up to a certain distance before traffic gets congested and pixelated.

**Definition**: A [[digital video standard]] that transmits compressed audio and video simultaneously through a single cable. The connector features 19 pins arranged in a distinctive trapezoidal shape with slightly inset bottom corners—a design that ensures only compatible connectors fit.

**Key Details**:
- Maximum effective range: ~20 meters
- Most common connector type found on consumer displays and televisions
- Standard variant is **Type-A** (full-size HDMI)
- Supports bandwidth for 4K and beyond on newer iterations

| Feature | HDMI |
|---------|------|
| Pin Count | 19 pins |
| Audio Support | Yes |
| Signal Type | [[Digital]] |
| Max Range | ~20 meters |
| Typical Use | TVs, Monitors, Consumer Electronics |

---

### DisplayPort

**Analogy**: Imagine DisplayPort as a networking cable that learned to carry video—it bundles information into organized packets, just like Ethernet, making it incredibly flexible and future-proof.

**Definition**: A modern [[video interface standard]] that transmits audio and video in packetized form (similar to [[network protocols]]), allowing for scalable bandwidth and backward compatibility through passive adapters.

**Key Details**:
- Uses packet-based transmission (like [[Ethernet]])
- Supports conversion to [[HDMI]] and [[DVI]] via passive adapters
- Available in two physical formats:
  - **Full-size DisplayPort**: Standard connector on desktop graphics cards
  - **Mini DisplayPort**: Compact variant found on laptops and some peripherals

| Feature | DisplayPort | HDMI |
|---------|-----------|------|
| Transmission | Packet-based | Stream-based |
| Audio Support | Yes | Yes |
| Adapter Compatibility | Can convert to HDMI/DVI | Limited |
| Physical Sizes | Full + Mini | Standard + Micro + Mini |
| Primary Environment | Desktop/Professional | Consumer Electronics |

---

### DVI (Digital Visual Interface)

**Analogy**: DVI is like an older, video-only cousin of HDMI—it does one job really well (carry video), but doesn't handle audio, and it's gradually being replaced by newer relatives.

**Definition**: A [[digital video connector]] that transmits video only (no audio) and was common on older monitors and graphics cards before HDMI became ubiquitous.

**Key Details**:
- Video-only transmission
- Can be converted to/from DisplayPort and HDMI with adapters
- Largely legacy on modern systems

---

## Exam Tips

### Question Type 1: Connector Identification
- *"A user wants to connect a laptop with DisplayPort to a TV with only HDMI input. Which adapter should they use?"* → Passive DisplayPort-to-HDMI adapter
- **Trick**: Don't assume active adapters are always needed—DisplayPort to HDMI/DVI conversion uses **passive adapters**

### Question Type 2: Cable Range & Signal Loss
- *"A 30-meter HDMI run is experiencing pixelation and dropout. What's the likely cause?"* → Exceeding the ~20-meter effective maximum range for HDMI
- **Trick**: The exam may present this as a troubleshooting scenario rather than a direct specification question

### Question Type 3: Audio Capability
- *"Which standard video cables support both audio and video in a single connection?"* → HDMI and DisplayPort (NOT DVI)
- **Trick**: Students often forget DVI is video-only; this is a high-frequency test item

---

## Common Mistakes

### Mistake 1: Confusing DisplayPort with DVI
**Wrong**: "DisplayPort is just a newer version of DVI."
**Right**: DisplayPort uses packet-based transmission (networking-style), while DVI uses stream-based transmission; DisplayPort has adapter flexibility that DVI lacks.
**Impact on Exam**: You may encounter scenarios asking why DisplayPort is "better" for future expansion—the answer involves its scalable, packet-based architecture.

### Mistake 2: Assuming All Adapters Are Active
**Wrong**: "You always need a powered adapter to convert between video standards."
**Right**: DisplayPort-to-HDMI and DisplayPort-to-DVI conversions use **passive adapters**; only certain conversions (like HDMI-to-DisplayPort in the reverse direction) require active power.
**Impact on Exam**: A troubleshooting question might hinge on knowing whether to recommend a powered solution.

### Mistake 3: Underestimating Cable Distance Limits
**Wrong**: "HDMI can run reliably at any distance if you use a good cable."
**Right**: HDMI has a practical maximum of ~20 meters before signal degradation becomes visible (blockiness, dropout).
**Impact on Exam**: Real-world scenario questions often involve office setups where distance is the culprit.

### Mistake 4: Forgetting Mini DisplayPort Exists
**Wrong**: "DisplayPort only comes in full-size; mini versions are just marketing."
**Right**: Mini DisplayPort is a legitimate, smaller physical variant found on many laptops and professional devices.
**Impact on Exam**: You may need to troubleshoot a compatibility issue where the connector type is the limiting factor.

---

## Related Topics
- [[Graphics Cards and Video Adapters]]
- [[Monitor Types and Specifications]]
- [[Digital vs. Analog Transmission]]
- [[Network Protocols and Packet Structure]]
- [[Connector Types and Physical Standards]]
- [[Troubleshooting Display Issues]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) Video Cables | [[A+]]* 