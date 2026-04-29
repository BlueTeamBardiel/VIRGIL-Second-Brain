# Scattered Spider

## What it is
Imagine a con artist who can talk their way past any bouncer just by sounding confident and knowing a few insider phrases — that's Scattered Spider. It is a financially motivated, English-speaking threat actor group (also tracked as UNC3944 and Octo Tempest) notorious for aggressive social engineering, SIM swapping, and identity-based attacks to breach large enterprises without ever touching a traditional exploit.

## Why it matters
In 2023, Scattered Spider breached MGM Resorts International by calling the IT help desk, impersonating an employee, and convincing staff to reset MFA credentials — causing an estimated $100 million in losses. This attack demonstrated that the weakest link is often the human operating the security system, not the system itself, making robust identity verification and help desk authentication protocols critical defensive controls.

## Key facts
- **Primary TTPs:** Vishing (voice phishing), SIM swapping, MFA fatigue/push bombing, and living-off-the-land techniques using legitimate tools like Azure AD and remote management software
- **Target profile:** Large enterprises with outsourced IT help desks, particularly in hospitality, gaming, and financial sectors
- **Identity pivot:** Once inside, the group escalates by harvesting credentials from identity providers like Okta and Azure Active Directory to achieve lateral movement
- **CISA advisory:** CISA and FBI issued a joint advisory (November 2023) specifically warning about Scattered Spider's tactics and recommending phishing-resistant MFA (FIDO2/hardware keys) as a countermeasure
- **Age demographic:** Members are predominantly young adults (late teens to mid-20s), many English-native, part of a loosely affiliated cybercriminal community called "The Com"

## Related concepts
[[Social Engineering]] [[SIM Swapping]] [[MFA Fatigue Attack]] [[Identity Provider Attacks]] [[Vishing]]