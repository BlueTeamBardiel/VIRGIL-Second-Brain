#Requires -Modules GroupPolicy
# 08-gpo-firewall.ps1
# Enforce Windows Firewall - domain profile on, block inbound by default.
# NIST 800-53 SC-7.
# Run on DC01 as Domain Admin.

$GPOName  = "LAB-Firewall"
$DomainDN = "DC=your-lab,DC=lab"

Write-Host "`nConfiguring GPO: $GPOName`n" -ForegroundColor Cyan

$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $GPO) {
    $GPO = New-GPO -Name $GPOName -Comment "NIST 800-53 SC-7 - Enforce Windows Firewall domain profile"
    Write-Host "  [created] GPO: $GPOName" -ForegroundColor Green
} else {
    Write-Host "  [exists]  GPO: $GPOName" -ForegroundColor Gray
}

$FWBase = "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall"

# Domain Profile
Set-GPRegistryValue -Name $GPOName -Key "$FWBase\DomainProfile" `
    -ValueName "EnableFirewall"          -Type DWord -Value 1
Set-GPRegistryValue -Name $GPOName -Key "$FWBase\DomainProfile" `
    -ValueName "DefaultInboundAction"    -Type DWord -Value 1  # 1 = Block
Set-GPRegistryValue -Name $GPOName -Key "$FWBase\DomainProfile" `
    -ValueName "DefaultOutboundAction"   -Type DWord -Value 0  # 0 = Allow
Set-GPRegistryValue -Name $GPOName -Key "$FWBase\DomainProfile" `
    -ValueName "DisableNotifications"    -Type DWord -Value 0

Write-Host "  [set] Domain profile: ON | Inbound: Block | Outbound: Allow" -ForegroundColor Green

# Private Profile
Set-GPRegistryValue -Name $GPOName -Key "$FWBase\PrivateProfile" `
    -ValueName "EnableFirewall"          -Type DWord -Value 1
Set-GPRegistryValue -Name $GPOName -Key "$FWBase\PrivateProfile" `
    -ValueName "DefaultInboundAction"    -Type DWord -Value 1
Set-GPRegistryValue -Name $GPOName -Key "$FWBase\PrivateProfile" `
    -ValueName "DefaultOutboundAction"   -Type DWord -Value 0

Write-Host "  [set] Private profile: ON | Inbound: Block | Outbound: Allow" -ForegroundColor Green

# Public Profile (strictest)
Set-GPRegistryValue -Name $GPOName -Key "$FWBase\PublicProfile" `
    -ValueName "EnableFirewall"          -Type DWord -Value 1
Set-GPRegistryValue -Name $GPOName -Key "$FWBase\PublicProfile" `
    -ValueName "DefaultInboundAction"    -Type DWord -Value 1
Set-GPRegistryValue -Name $GPOName -Key "$FWBase\PublicProfile" `
    -ValueName "DefaultOutboundAction"   -Type DWord -Value 0

Write-Host "  [set] Public profile: ON | Inbound: Block | Outbound: Allow" -ForegroundColor Green

# Note: This does NOT create inbound allow rules - Windows will keep its default
# Windows Service rules (RPC, WMI, etc.) unless you explicitly remove them.
# Add specific allow rules here if needed:
# Set-GPRegistryValue -Name $GPOName -Key "$FWBase\DomainProfile\AuthorizedApplications\List" ...

# Link to domain root
$ExistingLink = Get-GPInheritance -Target $DomainDN |
    Select-Object -ExpandProperty GpoLinks |
    Where-Object { $_.DisplayName -eq $GPOName }

if (-not $ExistingLink) {
    New-GPLink -Name $GPOName -Target $DomainDN -Enforced Yes | Out-Null
    Write-Host "  [linked]  $GPOName -> domain root (Enforced)" -ForegroundColor Green
} else {
    Write-Host "  [linked]  already linked" -ForegroundColor Gray
}

Write-Host "`nDone. Verify with: Get-NetFirewallProfile | Select Name,Enabled,DefaultInboundAction`n"
