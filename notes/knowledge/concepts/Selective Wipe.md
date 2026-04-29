# Selective Wipe

## What it is
Like a bouncer who confiscates only your company-issued wristband while letting you keep your wallet and phone, a selective wipe removes only corporate data and applications from a device while leaving personal data untouched. It is an MDM (Mobile Device Management) capability that targets managed containers or profiles — deleting corporate email, apps, and credentials — without performing a full factory reset.

## Why it matters
When an employee leaves a company that uses a BYOD (Bring Your Own Device) policy, IT needs to revoke access to corporate resources like email and SharePoint without destroying the employee's personal photos, contacts, and banking apps. Without selective wipe, organizations face a dilemma: either leave corporate data exposed on the ex-employee's device or perform a full wipe and invite legal disputes over destroyed personal data.

## Key facts
- Selective wipe is enforced through MDM solutions (e.g., Microsoft Intune, Jamf) by removing the enrolled management profile and its associated data container.
- It contrasts with a **remote wipe**, which performs a full factory reset and erases all data — personal and corporate — from the device.
- On iOS and Android, modern MDM platforms use **work profiles** or **managed containers** to sandbox corporate data, making selective wipe precise and legally defensible.
- Selective wipe is a key control for **BYOD policies** under frameworks like NIST SP 800-124 (Mobile Device Security).
- After a selective wipe, the device is **unenrolled** from MDM, meaning IT loses visibility and management control — an important post-incident consideration.

## Related concepts
[[Remote Wipe]] [[Mobile Device Management (MDM)]] [[BYOD Policy]] [[Data Loss Prevention (DLP)]] [[Containerization]]