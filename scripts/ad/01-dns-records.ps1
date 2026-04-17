#Requires -Modules DnsServer
# 01-dns-records.ps1
# Create DNS A records for all COCYTUS fleet hosts in the cocytus.lab zone.
# Run on DC01 as Domain Admin.

$Zone = "cocytus.lab"

$Records = @(
    [pscustomobject]@{ Name = "ABADDON";   IP = "YOUR_LAN_IP" }
    [pscustomobject]@{ Name = "BEHEMOTH";  IP = "YOUR_LAN_IP"  }
    [pscustomobject]@{ Name = "MORAX";     IP = "YOUR_LAN_IP"  }
    [pscustomobject]@{ Name = "ELIGOR";    IP = "YOUR_TAILSCALE_IP"  }
    [pscustomobject]@{ Name = "XAPHAN";    IP = "YOUR_TAILSCALE_IP" }
    [pscustomobject]@{ Name = "MALPAS";    IP = "YOUR_TAILSCALE_IP" }
    [pscustomobject]@{ Name = "KOKABIEL";  IP = "YOUR_LAN_IP" }
    [pscustomobject]@{ Name = "BARBATOS";  IP = "YOUR_LAN_IP" }
    [pscustomobject]@{ Name = "PURAH";     IP = "YOUR_TAILSCALE_IP"    }
    [pscustomobject]@{ Name = "AZAZEL";    IP = "YOUR_HOST_IP" }
    [pscustomobject]@{ Name = "VALEFOR";   IP = "YOUR_LAN_IP"       }
    [pscustomobject]@{ Name = "DC02";      IP = "YOUR_LAN_IP"  }
)

Write-Host "`nCreating DNS A records in zone: $Zone`n" -ForegroundColor Cyan

foreach ($Record in $Records) {
    $Existing = Get-DnsServerResourceRecord -ZoneName $Zone -Name $Record.Name -RRType A -ErrorAction SilentlyContinue
    if ($Existing) {
        Remove-DnsServerResourceRecord -ZoneName $Zone -Name $Record.Name -RRType A -Force
        Write-Host "  [replaced] $($Record.Name)" -ForegroundColor Yellow
    }
    Add-DnsServerResourceRecordA -ZoneName $Zone -Name $Record.Name -IPv4Address $Record.IP
    Write-Host "  [created]  $($Record.Name) -> $($Record.IP)" -ForegroundColor Green
}

Write-Host "`nDone. Verify with: Get-DnsServerResourceRecord -ZoneName $Zone -RRType A`n"
