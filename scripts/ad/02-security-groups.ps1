#Requires -Modules ActiveDirectory
# 02-security-groups.ps1
# Create YOUR_LAB security groups and a Groups OU to house them.
# Run on DC01 as Domain Admin.

$Domain     = "DC=your-lab,DC=lab"
$GroupsOU   = "OU=LAB-Groups,$Domain"

# Create OU if it doesn't exist
if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$GroupsOU'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name "LAB-Groups" -Path $Domain
    Write-Host "[created OU] LAB-Groups" -ForegroundColor Cyan
} else {
    Write-Host "[exists OU]  LAB-Groups" -ForegroundColor Gray
}

$Groups = @(
    [pscustomobject]@{
        Name        = "LAB-Admins"
        Description = "Full administrative access to YOUR_LAB lab resources"
        Scope       = "Global"
    }
    [pscustomobject]@{
        Name        = "LAB-Users"
        Description = "Standard user access to YOUR_LAB domain resources"
        Scope       = "Global"
    }
    [pscustomobject]@{
        Name        = "LAB-ServiceAccounts"
        Description = "Service accounts for automation and monitoring"
        Scope       = "Global"
    }
    [pscustomobject]@{
        Name        = "LAB-ReadOnly"
        Description = "Read-only access to YOUR_LAB domain resources"
        Scope       = "Global"
    }
)

Write-Host "`nCreating security groups in OU: LAB-Groups`n"

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

# Add the domain admin account to the LAB-Admins security group
$AdminUser = "your-username"
if (Get-ADUser -Filter "SamAccountName -eq '$AdminUser'" -ErrorAction SilentlyContinue) {
    Add-ADGroupMember -Identity "LAB-Admins" -Members $AdminUser -ErrorAction SilentlyContinue
    Write-Host "`n  [member]   $AdminUser -> LAB-Admins" -ForegroundColor Green
}

Write-Host "`nDone. Verify with: Get-ADGroup -Filter * -SearchBase '$GroupsOU' | Select Name`n"
