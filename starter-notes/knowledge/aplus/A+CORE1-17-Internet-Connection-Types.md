---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 17
source: rewritten
---

# Internet Connection Types
**Understanding how data reaches you from orbital relay stations to ground-based networks.**

---

## Overview

The modern world offers countless ways to plug into the internet, each with unique strengths and weaknesses. For A+ techs, understanding these [[connection types]] matters because you'll need to troubleshoot connectivity issues, recommend appropriate solutions for different environments, and answer exam questions about bandwidth, latency, and reliability trade-offs.

---

## Key Concepts

### [[Satellite Internet]]

**Analogy**: Imagine throwing a ball to a friend standing on a rooftop across the street. The ball travels up to the roof, bounces down to your friend's hands—that's extra distance compared to just tossing it directly. Satellite internet works the same way: your signal travels UP to a satellite in space, then DOWN to ground stations. That round trip adds real delay.

**Definition**: A wireless [[internet connection]] where data packets travel from your ground station up to an orbiting satellite and back down again, enabling connectivity in remote locations where traditional infrastructure doesn't exist.

**Speed Profile**:
- Download speeds: ~100 Mbps
- Upload speeds: ~5 Mbps
- Asymmetrical (much faster downloads than uploads)

**Latency Challenge**: Traditional satellite connections suffer from approximately 250ms up-link delay + 250ms down-link delay = ~500ms total [[latency]]. This half-second round trip causes noticeable lag in interactive applications.

**Next-Generation Improvements**: [[Low Earth Orbit (LEO)]] satellites like Starlink orbit much closer to Earth, reducing latency to 25-60ms—still noticeable but dramatically better for gaming and video calls.

| Factor | Traditional Satellite | LEO Satellite (Starlink) |
|--------|----------------------|------------------------|
| Orbital Altitude | 22,000+ miles | 340 miles |
| Latency | ~500ms | 25-60ms |
| Cost | Higher | Still expensive |
| Coverage | Global | Expanding rapidly |
| Weather Impact | Severe | Still vulnerable |

**Key Limitations**:
- Requires direct [[line of sight]] to satellite (trees, buildings, weather block signal)
- Weather degradation (rain, storms cause signal loss)
- High cost relative to terrestrial options
- Best for remote/rural deployments where alternatives don't exist

---

## Exam Tips

### Question Type 1: Latency and Performance
- *"A customer in a remote mountain cabin needs internet. They're complaining about 500ms delays during video calls. What connection type are they likely using?"* → [[Satellite internet]]
- **Trick**: Don't confuse "slow speeds" with "high latency." Satellite can download at 100 Mbps (fast) but still feel sluggish due to delay. The exam loves testing this distinction.

### Question Type 2: Environmental Factors
- *"A satellite internet user's connection drops during thunderstorms. Why?"* → [[Atmospheric interference]] blocks [[line of sight]] transmission
- **Trick**: The exam might ask about "signal obstruction"—trees, buildings, mountains ALL block satellite. It's not just storms.

### Question Type 3: Technology Comparison
- *"Which internet type is BEST for a rural ranch 50 miles from the nearest town?"* → [[Satellite internet]] (only viable option when [[DSL]], [[cable]], and [[fiber]] unavailable)
- **Trick**: Don't pick "cellular/mobile" unless they mention 5G towers nearby. Satellite is the default for true remote areas.

---

## Common Mistakes

### Mistake 1: Confusing Speed with Responsiveness
**Wrong**: "Satellite internet has 100 Mbps speeds, so it should feel as responsive as my cable connection."
**Right**: Download speed (Mbps) ≠ responsiveness ([[latency]]). You can have fast speeds but slow response times. Satellite excels at bulk downloads but struggles with real-time interaction.
**Impact on Exam**: Question asks "Why does satellite feel slow for gaming?" Answer: latency, not bandwidth.

### Mistake 2: Thinking Weather Only Affects Download Speeds
**Wrong**: "Rain slows my satellite download to 50 Mbps instead of 100 Mbps."
**Right**: Severe weather can completely DROP the connection (signal loss), not just reduce speed. [[Atmospheric interference]] physically blocks transmission.
**Impact on Exam**: Expect questions about "connection unavailability during storms," not just "reduced speeds."

### Mistake 3: Forgetting about Line-of-Sight Requirements
**Wrong**: "I can get satellite internet anywhere on my property, even under trees."
**Right**: Satellite requires direct, unobstructed view of the sky. Dense foliage, building overhangs, and terrain all prevent connectivity.
**Impact on Exam**: A question might describe a customer with poor satellite performance—the answer involves checking for physical obstructions.

### Mistake 4: Mixing Up Old vs. New Satellite Technology
**Wrong**: "All satellite internet has 500ms latency."
**Right**: [[LEO satellites]] (Starlink) reduced this to 25-60ms. Traditional [[geostationary satellites]] still have higher latency. The exam is updating to reflect this.
**Impact on Exam**: Newer questions may reference "low-latency satellite options"—don't assume all satellite = terrible latency.

---

## Related Topics
- [[DSL and Cable Internet]]
- [[Fiber Optic Connections]]
- [[Cellular Mobile Networks]] (4G/5G)
- [[Latency and Bandwidth]] concepts
- [[Network Troubleshooting]]
- [[Line of Sight Wireless]]
- [[Atmospheric Interference]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) | [[CompTIA A+]] | [[Internet Connectivity]]*