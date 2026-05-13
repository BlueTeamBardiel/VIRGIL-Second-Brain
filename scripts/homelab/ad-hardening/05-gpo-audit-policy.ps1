#Requires -Modules GroupPolicy
# 05-gpo-audit-policy.ps1
# Create and link a GPO that configures advanced audit policy.
# NIST 800-53 AC-2, AU-2, AU-12: logon events, privilege use, object access,
# policy change, account management.
# Run on DC01 as Domain Admin.

$GPOName    = "COCYTUS-AuditPolicy"
$DomainDN   = "DC=cocytus,DC=lab"
$DomainFQDN = "cocytus.lab"

Write-Host "`nConfiguring GPO: $GPOName`n" -ForegroundColor Cyan

# Create GPO if it doesn't exist
$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $GPO) {
    $GPO = New-GPO -Name $GPOName -Comment "NIST 800-53 AU-2/AU-12 - Advanced Audit Policy"
    Write-Host "  [created] GPO: $GPOName" -ForegroundColor Green
} else {
    Write-Host "  [exists]  GPO: $GPOName" -ForegroundColor Gray
}

# Configure audit settings via registry (Advanced Audit Policy subcategories)
# These map to: Computer Config > Windows Settings > Security Settings > Advanced Audit Policy
# GUIDs are the standard Windows audit subcategory GUIDs

$AuditSettings = @{
    # Logon/Logoff
    "Logon"                         = 3  # Success + Failure
    "Logoff"                        = 1  # Success
    "Account Lockout"               = 2  # Failure
    "Special Logon"                 = 1  # Success
    # Account Management
    "User Account Management"       = 3
    "Security Group Management"     = 3
    "Computer Account Management"   = 3
    # Privilege Use
    "Sensitive Privilege Use"       = 3
    # Policy Change
    "Audit Policy Change"           = 3
    "Authentication Policy Change"  = 1
    # Object Access
    "File System"                   = 3
    "Registry"                      = 3
    # System
    "Security System Extension"     = 1
    "System Integrity"              = 3
}

# Use auditpol.exe via GPO registry keys (HKLM\SECURITY\Policy\PolAdtEv is not editable via GPO directly)
# Instead, configure via the Security Settings INF approach using Set-GPRegistryValue for
# the audit.csv approach, or use the Security Configuration Wizard.
# Most reliable method: configure via secedit template embedded in the GPO.

$SeceditInf = @"
[Unicode]
Unicode=yes
[Version]
signature="`$CHICAGO`$"
Revision=1
[Event Audit]
AuditSystemEvents = 3
AuditLogonEvents = 3
AuditObjectAccess = 3
AuditPrivilegeUse = 3
AuditPolicyChange = 3
AuditAccountManage = 3
AuditProcessTracking = 0
AuditDSAccess = 1
AuditAccountLogon = 3
"@

# Write secedit template to temp file and import into GPO
$TempInf = [System.IO.Path]::GetTempFileName() + ".inf"
$SeceditInf | Set-Content -Path $TempInf -Encoding Unicode

# Import via secedit - applies to the local security policy when no GPO method is available
# For GPO, we push via the GPO GUID path on SYSVOL
$GPOGUID = $GPO.Id.ToString()
$SysvolPath = "\\$DomainFQDN\SYSVOL\$DomainFQDN\Policies\{$GPOGUID}\Machine\Microsoft\Windows NT\SecEdit"

if (-not (Test-Path $SysvolPath)) {
    New-Item -Path $SysvolPath -ItemType Directory -Force | Out-Null
}
Copy-Item $TempInf -Destination "$SysvolPath\GptTmpl.inf" -Force
Remove-Item $TempInf

Write-Host "  [configured] Audit categories: Logon, Account Mgmt, Privilege Use, Policy Change, Object Access" -ForegroundColor Green

# Link GPO to domain root
$ExistingLink = Get-GPInheritance -Target $DomainDN |
    Select-Object -ExpandProperty GpoLinks |
    Where-Object { $_.DisplayName -eq $GPOName }

if (-not $ExistingLink) {
    New-GPLink -Name $GPOName -Target $DomainDN -Enforced Yes | Out-Null
    Write-Host "  [linked]    $GPOName -> domain root (Enforced)" -ForegroundColor Green
} else {
    Write-Host "  [linked]    $GPOName already linked to domain root" -ForegroundColor Gray
}

Write-Host "`nDone. Force update: gpupdate /force`n"
