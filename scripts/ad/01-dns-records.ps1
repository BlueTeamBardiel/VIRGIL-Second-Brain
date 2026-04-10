#Requires -Modules DnsServer
# 01-dns-records.ps1
# Create DNS A records for all YOUR_LAB fleet hosts in the yourdomain.local zone.
# Run on DC01 as Domain Admin.

$Zone = "yourdomain.local"

$Records = @(
    [pscustomobject]@{ Name = "YOUR-CONTROL-NODE";   IP = "YOUR_LAN_IP" }
    [pscustomobject]@{ Name = "YOUR-WORKSTATION";  IP = "YOUR_LAN_IP"  }
    [pscustomobject]@{ Name = "YOUR-LAPTOP";     IP = "YOUR_LAN_IP"  }
    [pscustomobject]@{ Name = "YOUR-LAB-NODE-1";    IP = "YOUR_TAILSCALE_IP"  }
    [pscustomobject]@{ Name = "YOUR-LAB-NODE-2";    IP = "YOUR_TAILSCALE_IP" }
    [pscustomobject]@{ Name = "YOUR-SIEM-HOST";    IP = "YOUR_TAILSCALE_IP" }
    [pscustomobject]@{ Name = "YOUR-DNS-SERVER";  IP = "YOUR_LAN_IP" }
    [pscustomobject]@{ Name = "YOUR-PI-SERVER";  IP = "YOUR_LAN_IP" }
    [pscustomobject]@{ Name = "YOUR-LAB-NODE-3";     IP = "YOUR_TAILSCALE_IP"    }
    [pscustomobject]@{ Name = "YOUR-KALI-VM";    IP = "YOUR_HOST_IP" }
    [pscustomobject]@{ Name = "YOUR-WINDOWS-HOST";   IP = "YOUR_LAN_IP"       }
    [pscustomobject]@{ Name = "YOUR-DC02";      IP = "YOUR_LAN_IP"  }
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
