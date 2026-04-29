# air gap

## What it is
Like a surgeon's sterile field that must never be touched by an ungloved hand, an air gap is a physical isolation barrier where a computer or network has **zero electrical or logical connection** to any external network, including the internet. The machine is an island — data only moves via deliberate physical means like USB drives or optical media.

## Why it matters
In 2010, the Stuxnet worm devastated Iranian nuclear centrifuges at Natanz — a facility believed to be air-gapped. Attackers bridged the gap using infected USB drives carried by unsuspecting contractors, proving that air gaps are a *policy and human* problem, not just a technical one. This remains the canonical case study in air gap exploitation and physical security failure.

## Key facts
- Air gaps are used in industrial control systems (ICS/SCADA), military networks (like SIPRNet), and payment processing environments handling classified or critical data
- The primary attack vector against air-gapped systems is **removable media** (USB, CD/DVD), making media controls and endpoint policies critical compensating controls
- Researchers have demonstrated covert air gap exfiltration channels using **heat, acoustics, electromagnetic emissions, and even LED blinking patterns** (e.g., the "SPEAKE(a)R" and "AirHopper" research)
- Maintaining an air gap requires strict procedural controls: clean-room USB policies, hardware write blockers, and personnel background checks
- Air gaps do **not** eliminate all risk — they shift the primary threat from remote attackers to insider threats and supply chain compromise

## Related concepts
[[physical security]] [[removable media controls]] [[ICS/SCADA security]] [[insider threat]] [[supply chain attack]]