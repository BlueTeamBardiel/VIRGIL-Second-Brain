#Requires -Modules ActiveDirectory
# 02-security-groups.ps1
# Create COCYTUS security groups and a Groups OU to house them.
# Run on DC01 as Domain Admin.

$Domain     = "DC=cocytus,DC=lab"
$GroupsOU   = "OU=COCYTUS-Groups,$Domain"

# Create OU if it doesn't exist
if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$GroupsOU'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "COCYTUS-Groups" -Path $Domain
    Write-Host "[created OU] COCYTUS-Groups" -ForegroundColor Cyan
} else {
    Write-Host "[exists OU]  COCYTUS-Groups" -ForegroundColor Gray
}

$Groups = @(
    [pscustomobject]@{
        Name        = "COCYTUS-Admins"
        Description = "Full administrative access to COCYTUS lab resources"
        Scope       = "Global"
    }
    [pscustomobject]@{
        Name        = "COCYTUS-Users"
        Description = "Standard user access to COCYTUS domain resources"
        Scope       = "Global"
    }
    [pscustomobject]@{
        Name        = "COCYTUS-ServiceAccounts"
        Description = "Service accounts for automation and monitoring"
        Scope       = "Global"
    }
    [pscustomobject]@{
        Name        = "COCYTUS-ReadOnly"
        Description = "Read-only access to COCYTUS domain resources"
        Scope       = "Global"
    }
)

Write-Host "`nCreating security groups in OU: COCYTUS-Groups`n"

foreach ($Group in $Groups) {
    if (Get-ADGroup -Filter "Name -eq '$($Group.Name)'" -ErrorAction SilentlyContinue) {
        Write-Host "  [exists]   $($Group.Name)" -ForegroundColor Gray
    } else {
        New-ADGroup `
            -Name           $Group.Name `
            -SamAccountName $Group.Name `
            -GroupScope     $Group.Scope `
            -GroupCategory  Security `
            -Description    $Group.Description `
            -Path           $GroupsOU
        Write-Host "  [created]  $($Group.Name)" -ForegroundColor Green
    }
}

# Add your domain admin account to COCYTUS-Admins — update $AdminUser below
$AdminUser = "your-username"
if (Get-ADUser -Filter "SamAccountName -eq '$AdminUser'" -ErrorAction SilentlyContinue) {
    Add-ADGroupMember -Identity "COCYTUS-Admins" -Members $AdminUser -ErrorAction SilentlyContinue
    Write-Host "`n  [member]   $AdminUser -> COCYTUS-Admins" -ForegroundColor Green
}

Write-Host "`nDone. Verify with: Get-ADGroup -Filter * -SearchBase '$GroupsOU' | Select Name`n"
