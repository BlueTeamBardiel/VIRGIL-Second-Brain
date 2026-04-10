#Requires -Modules GroupPolicy
# 07-gpo-smb-signing.ps1
# Require SMB signing on all connections (client and server).
# Mitigates relay attacks (NTLM relay, pass-the-hash via SMB).
# NIST 800-53 SC-8, IA-3.
# Run on DC01 as Domain Admin.

$GPOName  = "LAB-SMBSigning"
$DomainDN = "DC=your-lab,DC=lab"

Write-Host "`nConfiguring GPO: $GPOName`n" -ForegroundColor Cyan

$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $GPO) {
    $GPO = New-GPO -Name $GPOName -Comment "NIST 800-53 SC-8 - Require SMB signing, client and server"
    Write-Host "  [created] GPO: $GPOName" -ForegroundColor Green
} else {
    Write-Host "  [exists]  GPO: $GPOName" -ForegroundColor Gray
}

$LanmanServer = "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"
$LanmanWorkstation = "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"

# Server-side: require clients to sign
Set-GPRegistryValue -Name $GPOName -Key $LanmanServer `
    -ValueName "RequireSecuritySignature" -Type DWord -Value 1
Set-GPRegistryValue -Name $GPOName -Key $LanmanServer `
    -ValueName "EnableSecuritySignature"  -Type DWord -Value 1

Write-Host "  [set] LanmanServer: RequireSecuritySignature = 1" -ForegroundColor Green
Write-Host "  [set] LanmanServer: EnableSecuritySignature  = 1" -ForegroundColor Green

# Client-side: require servers to sign
Set-GPRegistryValue -Name $GPOName -Key $LanmanWorkstation `
    -ValueName "RequireSecuritySignature" -Type DWord -Value 1
Set-GPRegistryValue -Name $GPOName -Key $LanmanWorkstation `
    -ValueName "EnableSecuritySignature"  -Type DWord -Value 1

Write-Host "  [set] LanmanWorkstation: RequireSecuritySignature = 1" -ForegroundColor Green
Write-Host "  [set] LanmanWorkstation: EnableSecuritySignature  = 1" -ForegroundColor Green

# Disable NTLMv1 while we're here (pairs well with SMB signing)
$LSA = "HKLM\SYSTEM\CurrentControlSet\Control\Lsa"
Set-GPRegistryValue -Name $GPOName -Key $LSA `
    -ValueName "LmCompatibilityLevel" -Type DWord -Value 5
# 5 = Send NTLMv2 only, refuse LM & NTLM

Write-Host "  [set] LmCompatibilityLevel = 5 (NTLMv2 only, refuse LM/NTLMv1)" -ForegroundColor Green

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

Write-Host @"

Warning: SMB signing required on the client side will break connections to
non-signing SMB targets (old NAS devices, some Linux Samba configs).
Verify Samba hosts on YOUR-LAB-NODE-2/YOUR-LAB-NODE-3 have 'server signing = mandatory' in smb.conf.

Done. Force update: gpupdate /force

"@ -ForegroundColor Yellow
