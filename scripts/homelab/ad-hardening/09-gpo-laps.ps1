#Requires -Modules ActiveDirectory, GroupPolicy
# 09-gpo-laps.ps1
# Configure Windows LAPS (built into Server 2022 with Apr 2023+ updates).
# LAPS randomises the local Administrator password per machine, stores it in AD,
# and rotates it on a schedule. NIST 800-53 AC-2, IA-5.
#
# NOTE: Windows LAPS requires KB5025230 (Apr 2023 update) or later on Server 2022.
# If your DC01 is not updated, install updates first: sconfig -> option 6.
#
# Run on DC01 as Domain Admin.

$GPOName  = "COCYTUS-LAPS"
$DomainDN = "DC=cocytus,DC=lab"

Write-Host "`nConfiguring Windows LAPS`n" -ForegroundColor Cyan

# Step 1 - Extend AD schema for Windows LAPS
Write-Host "  [step 1] Updating AD schema for Windows LAPS..." -ForegroundColor Cyan
try {
    Update-LapsADSchema -Confirm:$false
    Write-Host "  [done]   Schema updated" -ForegroundColor Green
} catch {
    Write-Host "  [warn]   Schema update failed or already applied: $_" -ForegroundColor Yellow
}

# Step 2 - Grant the domain permission to read/write LAPS attributes
Write-Host "`n  [step 2] Setting OU permissions for LAPS self-reporting..." -ForegroundColor Cyan
Set-LapsADComputerSelfPermission -Identity $DomainDN
Write-Host "  [done]   Computers can self-update LAPS attributes" -ForegroundColor Green

# Step 3 - Grant COCYTUS-Admins the right to read LAPS passwords
Write-Host "`n  [step 3] Granting COCYTUS-Admins read access to LAPS passwords..." -ForegroundColor Cyan
Set-LapsADReadPasswordPermission -Identity $DomainDN -AllowedPrincipals "COCYTUS-Admins"
Write-Host "  [done]   COCYTUS-Admins can retrieve LAPS passwords via AD" -ForegroundColor Green

# Step 4 - Create GPO
Write-Host "`n  [step 4] Creating GPO: $GPOName..." -ForegroundColor Cyan
$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $GPO) {
    $GPO = New-GPO -Name $GPOName -Comment "Windows LAPS - local admin password management"
    Write-Host "  [created] GPO: $GPOName" -ForegroundColor Green
} else {
    Write-Host "  [exists]  GPO: $GPOName" -ForegroundColor Gray
}

$LAPSRegBase = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\LAPS"

# Enable LAPS
Set-GPRegistryValue -Name $GPOName -Key $LAPSRegBase `
    -ValueName "BackupDirectory"           -Type DWord -Value 2     # 2 = Active Directory
Set-GPRegistryValue -Name $GPOName -Key $LAPSRegBase `
    -ValueName "PasswordAgeDays"           -Type DWord -Value 30    # rotate every 30 days
Set-GPRegistryValue -Name $GPOName -Key $LAPSRegBase `
    -ValueName "PasswordLength"            -Type DWord -Value 20    # 20-char password
Set-GPRegistryValue -Name $GPOName -Key $LAPSRegBase `
    -ValueName "PasswordComplexity"        -Type DWord -Value 4     # 4 = large/small/digits/specials
Set-GPRegistryValue -Name $GPOName -Key $LAPSRegBase `
    -ValueName "AdministratorAccountName"  -Type String -Value ""   # blank = built-in Administrator
Set-GPRegistryValue -Name $GPOName -Key $LAPSRegBase `
    -ValueName "PostAuthenticationResetDelay" -Type DWord -Value 24 # hours before reset after use

Write-Host "  [set] LAPS: 30-day rotation, 20-char passwords, stored in AD" -ForegroundColor Green

# Link GPO to domain root
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

Done. Retrieve a LAPS password with:
  Get-LapsADPassword -Identity <ComputerName> -AsPlainText

Or in AD Users and Computers: right-click computer -> Properties -> LAPS tab

"@ -ForegroundColor Cyan
