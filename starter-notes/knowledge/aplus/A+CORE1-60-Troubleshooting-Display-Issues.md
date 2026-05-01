---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 60
source: rewritten
---

# Troubleshooting Display Issues
**Master the systematic approach to diagnosing and resolving monitor and video output failures.**

---

## Overview

Display problems are among the most common tickets you'll encounter in IT support—and often the easiest to fix. For the A+ exam, you need to understand the logical troubleshooting chain: starting with physical connections, moving through [[Video Cable Standards]], checking [[Monitor Configuration]], and diagnosing [[Video Card]] or [[GPU]] failures. Getting this right separates the true technicians from the button-pushers.

---

## Key Concepts

### Physical Connection Verification

**Analogy**: Think of a [[Monitor]] like a telephone—no matter how powerful the phone system is, if the cable is unplugged or loose, you get dead silence.

**Definition**: The first troubleshooting step involves confirming that the [[Video Cable]] between the [[Computer]] and [[Display]] is fully inserted into both the [[Video Port]] on the graphics system and the corresponding port on the monitor, and that the [[Power Cable]] is properly connected to a working outlet.

| Connection Type | What to Check | Common Issue |
|---|---|---|
| Video Cable | Fully seated on both ends, no bent pins | Partially inserted = no signal |
| Power Cable | Plugged in, outlet powered, LED indicator on | Monitor appears dead |
| Cable Type Match | Correct port used (HDMI to HDMI, etc.) | Wrong port selected = no image |

**Pro Tip**: This embarrassingly simple fix resolves 40% of "broken monitor" calls—always check it first.

---

### Monitor Input Selection Configuration

**Analogy**: Your monitor is like a television with multiple input sources (HDMI, cable, antenna)—the signal might be coming in perfectly, but if the TV is set to the wrong input, you see nothing.

**Definition**: [[Monitors]] contain built-in configuration menus that allow selection of which physical port to actively receive video signal from. Not all monitors [[Auto-Detect]] input sources; many require manual selection.

| Port Type | Resolution | Modern Use | Legacy |
|---|---|---|---|
| [[HDMI]] | Up to 4K | Yes | No |
| [[DisplayPort]] | Up to 8K | Yes | No |
| [[DVI]] (Digital Visual Interface) | Up to 1080p | Sometimes | Common |
| [[VGA]] (Analog) | Up to 1080p | Rare | Very Common |

**Troubleshooting Flow**:
```
Monitor shows "No Signal" 
  → Check cable physically connected
  → Press monitor menu button
  → Navigate to Input/Source menu
  → Select matching port type
  → Confirm signal appears
```

---

### Brightness and Contrast Adjustment

**Analogy**: A dimly lit room with perfect furniture still looks terrible—brightness is the foundational setting that makes everything visible.

**Definition**: [[Monitor]] brightness controls the overall light output of the [[Display Panel]], while [[Contrast]] adjusts the difference between light and dark pixels. A [[Video Signal]] may be transmitting perfectly, but if these are set to minimum, the image appears black or washed out.

**Quick Check**:
```
Press Monitor Menu → Image Settings → Brightness (try 50%)
                                   → Contrast (try 75%)
```

---

## Exam Tips

### Question Type 1: "No Signal" Scenarios
- *"A user reports their monitor displays 'No Signal' but the PC powers on normally. What's the FIRST step?"* → Check physical [[Video Cable]] connections (both ends), then verify monitor input selection, THEN check [[Video Card]] drivers or hardware.
- **Trick**: The exam loves making you skip the obvious step. Always eliminate physical/cable issues before jumping to software or device drivers.

### Question Type 2: Display Quality Issues
- *"A monitor shows a picture but it's extremely dim and hard to read. What should you check first?"* → Monitor brightness and contrast controls, NOT the [[GPU]] or drivers.
- **Trick**: Don't overthink it—the simplest solution (adjust the knob) is usually right on the A+.

### Question Type 3: Input Port Confusion
- *"You connect a system via [[HDMI]] but the monitor remains blank. The cable is seated. What's likely wrong?"* → Monitor is set to receive input from [[VGA]] or [[DVI]] port instead of HDMI.
- **Trick**: The signal may be arriving perfectly; the monitor just isn't looking at the right port.

---

## Common Mistakes

### Mistake 1: Skipping Physical Verification
**Wrong**: Assume the monitor is broken and rush to replace hardware or reinstall drivers.
**Right**: Always verify cables are fully inserted and power is connected before any software troubleshooting.
**Impact on Exam**: This is a fundamental principle tested repeatedly—you'll lose points for jumping straight to driver updates or BIOS changes.

### Mistake 2: Forgetting About Auto-Detect Failures
**Wrong**: Connect a [[Cable]] and expect the monitor to automatically recognize it.
**Right**: Understand that older or budget monitors may NOT auto-detect inputs; manual selection via the monitor menu is required.
**Impact on Exam**: Questions often assume manual input selection is needed—don't assume auto-detect always works.

### Mistake 3: Confusing Hardware vs. Software Issues
**Wrong**: Dim display = [[Video Card Driver]] problem.
**Right**: Dim display = check brightness dial first, then check driver.
**Impact on Exam**: The A+ expects you to troubleshoot in layers—physical → settings → software → hardware.

### Mistake 4: Ignoring Cable Type Compatibility
**Wrong**: Using a [[VGA]] cable and expecting [[1080p]] quality.
**Right**: Understand [[Analog]] vs. [[Digital]] signals and bandwidth limits of each [[Video Cable Standards]] type.
**Impact on Exam**: You may see questions about why a specific cable won't support a given resolution.

---

## Related Topics
- [[Video Cable Standards]] ([[HDMI]], [[DisplayPort]], [[DVI]], [[VGA]])
- [[Video Card]] (GPU) basics and driver troubleshooting
- [[Monitor Configuration]] menus and settings
- [[Resolution]] and refresh rate settings in [[Windows]] and [[macOS]]
- [[Dual Monitor Setup]] troubleshooting
- [[No Post]] scenarios vs. display-only failures

---

*Source: CompTIA A+ Core 1 (220-1201) Display Troubleshooting Framework | [[A+]] Certification Study Materials*