#Requires -Modules ActiveDirectory
# 03-service-accounts.ps1
# Create COCYTUS service accounts in a dedicated OU.
# Passwords are set to a random 32-char value and printed once - save them immediately.
# Run on DC01 as Domain Admin.

$Domain  = "DC=cocytus,DC=lab"
$SvcOU   = "OU=COCYTUS-ServiceAccounts,$Domain"

# Create OU if it doesn't exist
if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$SvcOU'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "COCYTUS-ServiceAccounts" -Path $Domain
    Write-Host "[created OU] COCYTUS-ServiceAccounts" -ForegroundColor Cyan
}

function New-RandomPassword {
    $chars = 'abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789!@#$%^&*'
    -join (1..32 | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })
}

$ServiceAccounts = @(
    [pscustomobject]@{
        Name        = "svc-ansible"
        DisplayName = "Ansible Automation Service Account"
        Description = "Used by Ansible for domain-authenticated playbook execution"
        Group       = "COCYTUS-ServiceAccounts"
    }
    [pscustomobject]@{
        Name        = "svc-backup"
        DisplayName = "Backup Service Account"
        Description = "Used for configuration backup automation across fleet"
        Group       = "COCYTUS-ServiceAccounts"
    }
    [pscustomobject]@{
        Name        = "svc-monitor"
        DisplayName = "Monitoring Service Account"
        Description = "Used by Prometheus/Wazuh for read-only metrics collection"
        Group       = "COCYTUS-ReadOnly"
    }
)

Write-Host "`nCreating service accounts in OU: COCYTUS-ServiceAccounts`n"
Write-Host "SAVE THESE PASSWORDS - they are shown only once:`n" -ForegroundColor Yellow
Write-Host ("-" * 60)

foreach ($Svc in $ServiceAccounts) {
    if (Get-ADUser -Filter "SamAccountName -eq '$($Svc.Name)'" -ErrorAction SilentlyContinue) {
        Write-Host "  [exists]   $($Svc.Name) (skipped - reset password manually if needed)" -ForegroundColor Gray
        continue
    }

    $Password = New-RandomPassword
    $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

    New-ADUser `
        -Name                  $Svc.Name `
        -SamAccountName        $Svc.Name `
        -UserPrincipalName     "$($Svc.Name)@cocytus.lab" `
        -DisplayName           $Svc.DisplayName `
        -Description           $Svc.Description `
        -Path                  $SvcOU `
        -AccountPassword       $SecurePassword `
        -Enabled               $true `
        -PasswordNeverExpires  $true `
        -CannotChangePassword  $true

    Add-ADGroupMember -Identity $Svc.Group -Members $Svc.Name

    Write-Host "`n  [created]  $($Svc.Name)" -ForegroundColor Green
    Write-Host "  Password:  $Password" -ForegroundColor Yellow
    Write-Host "  UPN:       $($Svc.Name)@cocytus.lab"
    Write-Host "  Group:     $($Svc.Group)"
}

Write-Host ("-" * 60)
Write-Host "`nDone. Store these credentials in Vaultwarden once deployed.`n"
