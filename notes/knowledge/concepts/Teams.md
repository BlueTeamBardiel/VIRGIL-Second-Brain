# Teams

## What it is
Like a sports franchise with offensive and defensive squads, security teams are structured groups with distinct roles and adversarial or cooperative relationships during security exercises. In cybersecurity, **Red Teams** attack, **Blue Teams** defend, **Purple Teams** collaborate to share intelligence between both, and **White Teams** referee and set rules of engagement. Each team structure tests different aspects of an organization's security posture.

## Why it matters
During a Red Team engagement at a financial institution, attackers simulated an APT group using living-off-the-land techniques to exfiltrate customer data over 30 days. The Blue Team failed to detect the breach until the White Team revealed it during debrief — this gap prompted a Purple Team exercise where both sides shared TTPs in real time, reducing mean time to detect (MTTD) from weeks to hours in subsequent tests.

## Key facts
- **Red Team**: Offensive, simulates real-world adversaries using full attack chains (not just vulnerability scanning); operates covertly against the Blue Team
- **Blue Team**: Defensive, responsible for detection, response, and hardening; works within the SOC using SIEM, IDS, and log analysis
- **Purple Team**: Not a separate team but a *collaborative mode* where Red and Blue share findings continuously to accelerate defensive improvements
- **White Team**: Acts as referee — defines scope, rules of engagement (ROE), and halts exercises if real damage risk emerges
- **Yellow/Green Teams** (emerging): Yellow = builders/developers; Green = Blue Team members applying Red Team techniques to their own defenses — less standardized but appearing in advanced frameworks

## Related concepts
[[Red Team Operations]] [[Blue Team]] [[Purple Team]] [[Penetration Testing]] [[Rules of Engagement]]