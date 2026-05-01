---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 21
source: rewritten
---

# Display Attributes
**Master the technical specifications that separate a crisp 4K monitor from a blurry bargain bin disaster.**

---

## Overview

When shopping for any display device, you're faced with a bewildering array of technical specs that determine image quality, use-case suitability, and overall performance. Understanding [[display attributes]] is essential for the A+ exam because technicians must recommend appropriate monitors for specific business scenarios—whether that's a boardroom presentation system, a gaming rig, or a wall-mounted lobby display. These measurements give us concrete, measurable ways to evaluate which display truly fits the job.

---

## Key Concepts

### Pixel Density (PPI)

**Analogy**: Think of pixel density like thread count in cotton sheets—more threads per square inch make the fabric smoother and more luxurious, just as more pixels packed into the same physical space create sharper, crisper images.

**Definition**: [[Pixel density]], measured in **pixels per inch (PPI)** or pixels per centimeter, represents how many individual light points fit within a one-inch square of display area. Higher PPI = sharper image clarity.

| Pixel Density | Use Case | Visual Quality |
|---|---|---|
| < 100 PPI | Older CRT monitors, projectors | Visible pixelation |
| 100-150 PPI | Standard office monitors | Acceptable for documents |
| 150-220 PPI | Modern laptops, tablets | Sharp, comfortable viewing |
| 220+ PPI | High-end mobile, 4K displays | Exceptional clarity |

**Why it matters**: A monitor with 300 PPI will render the same size text far crisper than one with 100 PPI because the pixels are physically smaller and packed tighter together.

---

### Dots Per Inch (DPI) for Printing

**Analogy**: If pixels are the building blocks on a digital screen, dots are the equivalent ink particles a printer can place on paper—more dots in the same space means finer detail reproduction.

**Definition**: [[DPI (Dots Per Inch)]] measures the printer's output resolution—how many ink dots the printer can deposit per linear inch on paper. This is crucial when determining whether digital content can be faithfully reproduced in print.

**Screen vs. Print Reality**: A beautiful image on your 300 PPI monitor may look pixelated or blurry when printed on a 150 DPI printer, because the printer simply cannot reproduce that level of detail.

| DPI Rating | Output Quality | Best Use |
|---|---|---|
| 72-96 DPI | Draft quality | Internal memos, proofs |
| 150-200 DPI | Standard quality | Business documents, photos |
| 300+ DPI | Professional quality | Marketing materials, archives |

---

### Use-Case Matching

**Analogy**: Buying a monitor without knowing its purpose is like buying a vehicle without asking if you need a sedan, truck, or motorcycle—the same tool won't excel at every job.

**Definition**: [[Use-case matching]] means selecting display attributes based on the intended application—gaming vs. office work vs. kiosk displays require completely different specifications.

**Real-World Selection Process**:
1. Identify the use case (presentations? design work? data entry?)
2. Reference appropriate specs for that scenario
3. Cross-check against budget and connectivity options
4. Validate DPI/PPI requirements for output methods

---

## Exam Tips

### Question Type 1: PPI vs. DPI Identification
- *"A user complains that printed documents look blurry even though they look sharp on screen. Which specification should you examine?"* → **Printer DPI**, not screen PPI
- **Trick**: The exam loves mixing these up. Remember: PPI = screen sharpness, DPI = printer output capability

### Question Type 2: Use-Case Matching
- *"A company is installing displays in a high-traffic lobby that will show marketing videos 8 hours per day. Which is the MOST important attribute?"* → Brightness and color accuracy (not necessarily highest PPI)
- **Trick**: Not every scenario requires the most expensive, highest-spec monitor. Context matters.

### Question Type 3: Specification Interpretation
- *"Monitor A has 163 PPI; Monitor B has 110 PPI. Both are 24 inches. Which appears sharper to the eye?"* → **Monitor A** (higher density = crisper pixels)
- **Trick**: The physical size is a red herring. It's the density that determines perceived sharpness.

---

## Common Mistakes

### Mistake 1: Confusing PPI with Size

**Wrong**: "A 27-inch monitor automatically has better pixel density than a 24-inch monitor."

**Right**: Pixel density depends on the number of pixels divided by the diagonal screen size. A 24-inch 4K monitor (163 PPI) is sharper than a 27-inch 1080p monitor (82 PPI).

**Impact on Exam**: You'll face questions asking you to calculate or compare sharpness across different monitor sizes. Don't assume bigger = better PPI.

---

### Mistake 2: Ignoring Output Requirements

**Wrong**: "We bought a beautiful high-res 300 PPI monitor, so our printed materials will look perfect."

**Right**: Print quality depends on **printer DPI**, not screen PPI. A 150 DPI printer will never match a 600 DPI printer, regardless of source image quality.

**Impact on Exam**: Real-world scenario questions test whether you understand the entire pipeline (screen → digital → printer). Missing this connection costs points.

---

### Mistake 3: Over-Specifying for the Use Case

**Wrong**: "This data-entry workstation needs a 27-inch 4K 300 PPI gaming monitor."

**Right**: A standard office monitor with adequate brightness, reasonable PPI (100-150), and good ergonomic stand is sufficient for spreadsheets and email. Overkill specs = wasted budget.

**Impact on Exam**: The A+ exam rewards practical decision-making. Know when a $300 monitor beats a $1200 gaming display for business purposes.

---

## Related Topics
- [[Monitor Resolution]] (1080p, 1440p, 4K and their PPI implications)
- [[Color Accuracy and Gamut]] (important for design and photo work)
- [[Refresh Rate]] (Hz, separate from PPI—often confused)
- [[Display Connectors and Interfaces]] (HDMI, DisplayPort, etc.)
- [[Printer Types and Specifications]] (impact on DPI output)
- [[Video Output Technologies]] (how resolution gets to the screen)

---

*Source: Virgil A+ Study Notes | Based on CompTIA A+ Core 1 (220-1201) Display Technologies | [[A+]]*