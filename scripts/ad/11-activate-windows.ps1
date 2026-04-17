# 11-activate-windows.ps1
# Activate Windows Server 2022 using MAS (Microsoft Activation Scripts).
# Method: KMS38 - activates until 2038, no internet license check, no phone home.
# Run on DC01 and DC02 as local/domain Administrator.
#
# MAS source: https://massgrave.dev
# KMS38 works on: Windows Server 2019, 2022 (both Datacenter and Standard eval/retail)

Write-Host "`nActivating Windows Server 2022 via MAS (KMS38)...`n" -ForegroundColor Cyan

# Method A: Direct invocation (requires internet access from DC01)
Write-Host "  Running: irm https://get.activated.win | iex" -ForegroundColor Yellow
Write-Host "  When the menu appears: select option 2 (KMS38)`n"

try {
    # This is the standard MAS one-liner
    Invoke-Expression (Invoke-RestMethod "https://get.activated.win")
} catch {
    Write-Host "  [failed] Internet access may be blocked from DC01 (NAT)" -ForegroundColor Red
    Write-Host "  Use Method B below instead.`n" -ForegroundColor Yellow
}

Write-Host @"

---------------------------------------------------------
Method B - Manual (if DC01 has no internet access via NAT)
---------------------------------------------------------
Run this from BEHEMOTH or MORAX (which have internet), then
copy the MAS folder to DC01 via VMware shared folder or RDP clipboard:

  1. From a machine WITH internet:
       Invoke-WebRequest -Uri https://github.com/massgravel/Microsoft-Activation-Scripts/archive/refs/heads/master.zip -OutFile MAS.zip
       Expand-Archive MAS.zip -DestinationPath C:\MAS

  2. Copy C:\MAS to DC01 via:
       - VMware: VM > Settings > Options > Shared Folders > Add
       - Or: copy over RDP clipboard as zip

  3. On DC01, run:
       Set-ExecutionPolicy Bypass -Scope Process
       C:\MAS\Microsoft-Activation-Scripts-master\MAS\All-In-One-Version\MAS_AIO.cmd
       Select option 2: KMS38

---------------------------------------------------------
Verify activation status:
  slmgr /xpr              # expiry date (2038 if KMS38 applied)
  slmgr /dlv              # detailed license info
  Get-CimInstance SoftwareLicensingProduct | Where { `$_.Name -like '*Windows*' -and `$_.LicenseStatus -eq 1 }
---------------------------------------------------------

"@ -ForegroundColor Cyan
