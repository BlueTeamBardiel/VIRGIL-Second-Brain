# MITRE ATT&CK T1070.008

## What it is
Like a burglar wiping fingerprints off a doorknob before leaving, adversaries manipulate email rules or delete messages directly from mail servers to erase evidence of their intrusion. T1070.008 (Indicator Removal: Clear Mailbox Data) describes attackers deleting emails, folders, or entire mailbox contents to destroy forensic artifacts and conceal phishing campaigns, lateral movement, or data exfiltration activity.

## Why it matters
During the 2023 Microsoft Exchange Online breach by Storm-0558, attackers accessed cloud email accounts and investigators found that covering email-based activity was a key operational security concern for the threat actors. Defenders relying solely on mailbox content for investigation — rather than mail flow logs or SIEM telemetry — would lose critical evidence if attackers purged sent items and inbox messages after exfiltrating data.

## Key facts
- Attackers commonly target: Sent Items (to hide phishing sent from compromised accounts), Deleted Items, and administrator audit mailboxes
- Exchange and Microsoft 365 environments are primary targets; PowerShell cmdlets like `Remove-MailboxMessage` and `Search-Mailbox -DeleteContent` are abused for bulk deletion
- This technique falls under **Tactic: Defense Evasion** (TA0005), specifically the Indicator Removal parent technique (T1070)
- Detection relies on **mail audit logs** (e.g., Microsoft Purview/Unified Audit Log), NOT mailbox content itself — making log preservation critical
- Attackers may also manipulate auto-delete rules via `New-InboxRule` to automatically destroy incoming security alerts or IT notifications in real time

## Related concepts
[[T1070 Indicator Removal]] [[T1114 Email Collection]] [[T1098.002 Account Manipulation: Additional Email Delegate Permissions]] [[Microsoft 365 Audit Logging]] [[Defense Evasion]]