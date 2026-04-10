#Requires -Modules ActiveDirectory
# 04-password-lockout-policy.ps1
# Configure Default Domain Policy for password and lockout settings.
# NIST 800-63B aligned: long passwords, no complexity, no short rotation.
# Also creates a Fine-Grained Password Policy for service accounts (stricter).
# Run on DC01 as Domain Admin.

$Domain = "cocytus.lab"

Write-Host "`nConfiguring Default Domain Policy - NIST 800-63B alignment`n" -ForegroundColor Cyan

# -- Default Domain Policy ------------------------------------------------------
# NIST 800-63B:
#   - Min 8 chars required; min 15 recommended for admin accounts
#   - Do NOT require complexity (NIST explicitly discourages it)
#   - Check against common/breached passwords (not enforceable via GPO - use HaveIBeenPwned scripts separately)
#   - Max age 365 days (NIST prefers no expiration unless compromised, but 365 is a reasonable organisational policy)
#   - No min age (allow immediate change if compromised)

Set-ADDefaultDomainPasswordPolicy -Identity $Domain `
    -MinPasswordLength    15   `
    -MaxPasswordAge       (New-TimeSpan -Days 365) `
    -MinPasswordAge       (New-TimeSpan -Days 0)   `
    -PasswordHistoryCount 12   `
    -ComplexityEnabled    $false `
    -ReversibleEncryptionEnabled $false

Write-Host "  [set] Default Domain Password Policy:" -ForegroundColor Green
Write-Host "        Min length    : 15"
Write-Host "        Max age       : 365 days"
Write-Host "        History       : 12 passwords"
Write-Host "        Complexity    : Disabled (NIST 800-63B)"

# -- Account Lockout ------------------------------------------------------------
# NIST 800-63B: lockout after repeated failures; 30 min observation window
Set-ADDefaultDomainPasswordPolicy -Identity $Domain `
    -LockoutThreshold          5   `
    -LockoutDuration           (New-TimeSpan -Minutes 30) `
    -LockoutObservationWindow  (New-TimeSpan -Minutes 30)

Write-Host "`n  [set] Account Lockout Policy:" -ForegroundColor Green
Write-Host "        Threshold     : 5 attempts"
Write-Host "        Duration      : 30 minutes"
Write-Host "        Obs. window   : 30 minutes"

# -- Fine-Grained Password Policy for Service Accounts -------------------------
# Stricter: 24-char minimum, no expiry, stronger lockout
$FGPPName = "COCYTUS-ServiceAccounts-PSO"

if (Get-ADFineGrainedPasswordPolicy -Filter "Name -eq '$FGPPName'" -ErrorAction SilentlyContinue) {
    Write-Host "`n  [exists] Fine-grained PSO: $FGPPName (skipping creation)" -ForegroundColor Gray
} else {
    New-ADFineGrainedPasswordPolicy `
        -Name                        $FGPPName `
        -Precedence                  10 `
        -MinPasswordLength           24 `
        -MaxPasswordAge              (New-TimeSpan -Days 0) `
        -MinPasswordAge              (New-TimeSpan -Days 0) `
        -PasswordHistoryCount        24 `
        -ComplexityEnabled           $false `
        -ReversibleEncryptionEnabled $false `
        -LockoutThreshold            3 `
        -LockoutDuration             (New-TimeSpan -Hours 1) `
        -LockoutObservationWindow    (New-TimeSpan -Hours 1)

    # Apply to COCYTUS-ServiceAccounts group
    Add-ADFineGrainedPasswordPolicySubject -Identity $FGPPName -Subjects "COCYTUS-ServiceAccounts"

    Write-Host "`n  [created] Fine-grained PSO: $FGPPName" -ForegroundColor Green
    Write-Host "           Applied to: COCYTUS-ServiceAccounts"
    Write-Host "           Min length : 24 | No expiry | Lockout: 3 attempts / 1hr"
}

Write-Host "`nDone. Verify: Get-ADDefaultDomainPasswordPolicy`n"
