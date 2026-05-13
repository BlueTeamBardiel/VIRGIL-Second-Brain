# Mobile Device Management

## What it is

Your work phone gets stolen at the airport. Within ten minutes, IT has wiped it clean from a console two thousand miles away — corporate email gone, Teams gone, the cached SharePoint files gone. Your personal photos and texts? Untouched. That's MDM doing its job.

Mobile Device Management is the centralized control plane that lets a company push policies, apps, and configurations to every phone and tablet in the org — and yank them back when needed. Think of it as the immune system for the mobile fleet: it decides what's allowed in, monitors for infection, and quarantines or kills compromised hosts on command.

Technically, MDM is a server-side platform (Microsoft Intune, Jamf, VMware Workspace ONE, Google Workspace) that talks to an agent or built-in management profile on each device using the OS vendor's enrollment APIs — Apple's APNs and DEP for iOS/iPadOS, Android Enterprise for Android, MDM CSPs for Windows. The device checks in, receives policy, reports compliance, and accepts remote commands.

## Why it matters

Every company that lets employees touch corporate data on a phone runs MDM or should. It's the difference between "we trust people" and "we have controls." Auditors ask about it. Cyber insurance asks about it. Breach lawsuits ask about it.

For the A+ exam, objective 220-1201 1.3 expects you to configure mobile network connectivity and support apps in an MDM-managed context. You won't be deploying Intune from scratch — you'll be the tech who enrolls a new hire's phone, troubleshoots why their corporate Outlook won't sync, and explains to a confused user why their personal Bluetooth headphones suddenly won't pair to the work phone. Most of your mobile tickets will involve MDM somewhere in the chain.

## At home, at work

**Beat 1 — Technical depth.** MDM works through enrollment. The device joins the platform either through user-initiated enrollment (user installs a profile, signs in with corporate creds) or zero-touch (device ships from the vendor already tied to the company's tenant — Apple Business Manager, Android Zero-touch, Windows Autopilot). Once enrolled, the device pulls down a configuration profile: Wi-Fi networks with pre-shared certificates, VPN settings, email accounts, app catalog, restrictions, passcode complexity, encryption requirements. Compliance policies decide what counts as a healthy device — jailbreak detection, OS version minimums, encryption status — and conditional access ties that compliance signal to whether the device gets to touch corporate resources at all.

**Beat 2 — Daily phone friction.** You've already lived the consumer side without calling it MDM:

**Find My iPhone.** You leave your phone in an Uber, log into iCloud from a laptop, mark it as lost, and it locks itself with a message on the screen. *Remote management command from a cloud console — same pattern as enterprise MDM, just for one user.*

**Family Sharing screen time.** A parent sets app limits on a kid's iPad, blocks the App Store, forces bedtime mode. The kid can't override it without the parent's passcode. *Policy enforcement from a remote authority — the kid's iPad is "managed."*

**The kicker.** Now picture that, but the parent is your IT department, the kid is every employee, and the consequence of misconfiguration is a regulatory fine. *MDM is consumer device management with a compliance team and a budget.*

**Beat 3 — Bridge to the enterprise.** A new hire arrives. You hand them a phone — or they bring their own under BYOD. Either way, the enrollment flow is the same shape: open the company portal app, sign in with corporate credentials, accept the management profile, wait for policies to land. Five minutes later, work email, Teams, the company VPN, and the corporate Wi-Fi profile are all configured automatically. They never typed a server address. The MDM did it.

**Beat 4 — The point.** Same fundamental question — "who controls this device, and what are they allowed to do to it?" — different answers depending on context. Personal phone: you do, fully. BYOD work profile: you control your half, IT controls the corporate container. Corporate-owned phone: IT controls everything. Get this question into your bones — every mobile ticket starts with figuring out which of those three you're standing in.

## Key facts

### Enrollment models

| Model | Who owns the device | Who controls it | Typical use |
|---|---|---|---|
| **COBO** (Corporate-Owned, Business-Only) | Company | Company, fully | Field techs, secure facilities, retail |
| **COPE** (Corporate-Owned, Personally Enabled) | Company | Company primary, user secondary | Standard exec/employee phone |
| **BYOD** (Bring Your Own Device) | Employee | Work profile only | Cost-saving orgs, contractors |
| **CYOD** (Choose Your Own Device) | Company | Company, user picked from list | Hybrid — company control, user preference |

### What MDM controls

- **Device:** passcode policy, encryption, OS version minimums, jailbreak detection
- **Network:** Wi-Fi profiles with certificates, VPN auto-connect, cellular APN, hotspot enable/disable
- **Apps:** silent install, blocklist/allowlist, app config (pre-fill server URLs), per-app VPN
- **Restrictions:** camera, screenshots, USB data transfer, AirDrop, iCloud backup, app store access
- **Bluetooth:** enable/disable, restrict pairing to approved peripherals, block file transfer
- **Location services:** force-enable for asset tracking, force-disable in classified areas
- **Sync:** which mailboxes, calendars, and contacts sync; cellular data caps; Wi-Fi-only enforcement

### Location services — what's actually using what

Location on a modern phone is a fusion of inputs:

- **GPS** — satellite, accurate to meters, works outdoors, drains battery
- **Cellular tower triangulation** — rough (hundreds of meters), works indoors, low battery cost
- **Wi-Fi positioning** — phone sees nearby SSIDs, cross-references Apple/Google databases, surprisingly accurate in cities
- **Bluetooth beacons** — retail and large venues for indoor positioning

MDM can force location services on for managed apps while leaving the user's personal toggle alone — on iOS, "Always Allow" can be enforced via configuration profile.

### Bluetooth pairing — the steps CompTIA wants you to know

1. **Enable Bluetooth** on both devices
2. **Set the peripheral to discoverable / pairing mode** (button hold, usually)
3. **On the phone, scan / find a device for pairing** — wait for the device name to appear
4. **Select the device** to initiate pairing
5. **Enter the appropriate PIN** (often 0000 or 1234 for legacy gear) or **confirm the matching code** on both screens
6. **Verify connection** — test that audio routes or file transfers work

In a managed environment, MDM may block pairing entirely, restrict it to a vendor allowlist, or require pairing be done in a specific app context.

### Mobile device synchronization

- **What syncs:** mail, contacts, calendar, photos, files (OneDrive/Google Drive/iCloud), notes, browser tabs, passwords
- **Where:** corporate cloud (Microsoft 365, Google Workspace), personal cloud, or on-prem (Exchange, ActiveSync)
- **How:** ActiveSync (Exchange), CalDAV/CardDAV (open standards), proprietary APIs (iCloud, Google)
- **Connection types:** Wi-Fi (preferred), cellular (watch the data cap), USB (rare now)
- **Data caps:** large initial sync over cellular will burn through a plan in hours. Default on most platforms is "Wi-Fi only for large transfers." MDM can enforce this.
- **Test connectivity first:** before troubleshooting sync, confirm the device has working internet. If a browser can't load a known site, the sync problem isn't a sync problem.

### CompTIA exam traps

> **CompTIA exam trap:** MDM vs MAM. MDM manages the *device*. MAM (Mobile Application Management) manages the *app and its data* without controlling the whole device — used in BYOD where IT can't legally wipe a personal phone but can wipe the corporate Outlook container.

> **CompTIA exam trap:** Remote wipe scope. Full wipe = factory reset, everything gone. Selective wipe (corporate wipe) = only the managed apps and data. BYOD policies almost always specify selective wipe — wiping personal data without consent is a lawsuit.

> **CompTIA exam trap:** Location services and privacy. Disabling location on the phone breaks Find My Device, fitness tracking, geotagged photos, weather, and any app that needs geofencing. It's not just maps.

## Helpdesk reality

- **"My work email won't sync."** First check: is the device enrolled and compliant? Open the company portal — if non-compliant, conditional access is blocking sync. Often the fix is updating the OS to meet policy minimum.
- **"My Bluetooth headphones won't pair to my work phone."** Check MDM policy. Many corporate configs block Bluetooth file transfer or restrict pairing to an approved peripheral list. Audio-only headsets usually work; data-capable devices often don't.
- **"My personal apps disappeared."** They didn't enroll a personal device into a COBO profile by accident, did they? Full management wipes personal apps. This is why BYOD enrollment flows show a clear consent screen.
- **"My phone is using too much cellular data."** Check sync settings. Photo backup over cellular is the usual culprit. Set OneDrive/iCloud/Google Photos to Wi-Fi only. MDM can enforce this org-wide.
- **Never promise** that a remote wipe will recover the device or its data. Wipe is destructive and final. If the user hasn't backed up, what's gone is gone. Set that expectation before you click the button.

## Related concepts

[[Mobile Device Synchronization]] · [[Bluetooth Pairing]] · [[BYOD Policies]] · [[Conditional Access]] · [[Cellular Data and Hotspot]] · [[Location Services and GPS]] · [[Microsoft Intune]] · [[Mobile Device Security]]

*Source: VIRGIL knowledge base — 2026-05-10*