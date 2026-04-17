#Requires -Modules GroupPolicy
# 10-gpo-applocker.ps1
# Configure AppLocker in AUDIT mode first - whitelist: signed executables only.
# NIST 800-53 CM-7, SI-3.
#
# IMPORTANT: This deploys in AUDIT mode. Review the event log (Event ID 8003/8004)
# for one week before switching to Enforce. Enforcing immediately on a live domain
# will break things.
#
# Switch to Enforce: change RuleCollection Enforcement="AuditOnly" to "Enabled"
# in the XML below, re-import, and force gpupdate.
#
# Run on DC01 as Domain Admin.
# Requires: Application Identity service running on client machines.

$GPOName  = "COCYTUS-AppLocker"
$DomainDN = "DC=cocytus,DC=lab"

Write-Host "`nConfiguring GPO: $GPOName (AUDIT MODE)`n" -ForegroundColor Cyan
Write-Host "  *** Running in AUDIT mode - no applications will be blocked ***" -ForegroundColor Yellow
Write-Host "  *** Review Event Viewer > AppLocker before enforcing         ***`n" -ForegroundColor Yellow

$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $GPO) {
    $GPO = New-GPO -Name $GPOName -Comment "NIST 800-53 CM-7 - AppLocker whitelist (audit mode)"
    Write-Host "  [created] GPO: $GPOName" -ForegroundColor Green
} else {
    Write-Host "  [exists]  GPO: $GPOName" -ForegroundColor Gray
}

# AppLocker policy XML - audit mode, signed executables + built-in defaults
# Rules:
#   1. Allow Admins to run everything
#   2. Allow signed executables from any publisher (for standard users)
#   3. Allow %PROGRAMFILES% and %WINDIR% by path (belt-and-suspenders)
#   Change Enforcement to "Enabled" when ready to enforce.

$AppLockerXML = @'
<AppLockerPolicy Version="1">
  <RuleCollection Type="Exe" EnforcementMode="AuditOnly">
    <FilePublisherRule Id="a9e18c21-ff8f-43cf-b9fc-db40eed693ba"
        Name="Allow all signed executables"
        Description="Allow any executable signed by a trusted publisher"
        UserOrGroupSid="S-1-1-0" Action="Allow">
      <Conditions>
        <FilePublisherCondition PublisherName="*" ProductName="*" BinaryName="*">
          <BinaryVersionRange LowSection="*" HighSection="*"/>
        </FilePublisherCondition>
      </Conditions>
    </FilePublisherRule>
    <FilePathRule Id="921cc481-6e17-4653-8f75-050b80acca20"
        Name="Allow %WINDIR%"
        Description="Allow executables in Windows directory"
        UserOrGroupSid="S-1-1-0" Action="Allow">
      <Conditions>
        <FilePathCondition Path="%WINDIR%\*"/>
      </Conditions>
    </FilePathRule>
    <FilePathRule Id="a61c8b2c-a319-4cd0-9690-d2177cad7b51"
        Name="Allow %PROGRAMFILES%"
        Description="Allow executables in Program Files"
        UserOrGroupSid="S-1-1-0" Action="Allow">
      <Conditions>
        <FilePathCondition Path="%PROGRAMFILES%\*"/>
      </Conditions>
    </FilePathRule>
    <FilePathRule Id="fd686d83-a829-4351-8ff4-27c7de5755d2"
        Name="Allow Admins"
        Description="Administrators can run anything"
        UserOrGroupSid="S-1-5-32-544" Action="Allow">
      <Conditions>
        <FilePathCondition Path="*"/>
      </Conditions>
    </FilePathRule>
  </RuleCollection>
  <RuleCollection Type="Script" EnforcementMode="AuditOnly">
    <FilePathRule Id="ed97d0cb-15ff-430f-b82c-8d7832957725"
        Name="Allow all scripts for admins"
        UserOrGroupSid="S-1-5-32-544" Action="Allow">
      <Conditions>
        <FilePathCondition Path="*"/>
      </Conditions>
    </FilePathRule>
    <FilePathRule Id="fe64bc58-1286-41d5-9bb5-3e2b97e45d55"
        Name="Allow scripts in WINDIR and PROGRAMFILES"
        UserOrGroupSid="S-1-1-0" Action="Allow">
      <Conditions>
        <FilePathCondition Path="%WINDIR%\*"/>
      </Conditions>
    </FilePathRule>
  </RuleCollection>
  <RuleCollection Type="Msi" EnforcementMode="AuditOnly">
    <FilePublisherRule Id="b7af7102-efde-4369-8a89-7a6a392d1473"
        Name="Allow all signed MSI"
        UserOrGroupSid="S-1-1-0" Action="Allow">
      <Conditions>
        <FilePublisherCondition PublisherName="*" ProductName="*" BinaryName="*">
          <BinaryVersionRange LowSection="*" HighSection="*"/>
        </FilePublisherCondition>
      </Conditions>
    </FilePublisherRule>
    <FilePathRule Id="5b290184-345a-4453-b184-45305f6d9a54"
        Name="Allow Admins all MSI"
        UserOrGroupSid="S-1-5-32-544" Action="Allow">
      <Conditions>
        <FilePathCondition Path="*"/>
      </Conditions>
    </FilePathRule>
  </RuleCollection>
</AppLockerPolicy>
'@

# Write XML to temp file and import into GPO via LGPO / secedit approach
# AppLocker policies live in the GPO as XML under the Computer Config node
$TempXML = [System.IO.Path]::GetTempFileName() + ".xml"
$AppLockerXML | Set-Content -Path $TempXML -Encoding UTF8

# Import using Set-AppLockerPolicy against the GPO
# Note: Set-AppLockerPolicy -XMLPolicy applies to the local policy.
# To apply to a GPO we use the GPO GUID path on SYSVOL.
$GPOGUID    = $GPO.Id.ToString()
$SysvolBase = "\\cocytus.lab\SYSVOL\cocytus.lab\Policies\{$GPOGUID}\Machine\Microsoft\Windows NT\AppLocker"

if (-not (Test-Path $SysvolBase)) {
    New-Item -Path $SysvolBase -ItemType Directory -Force | Out-Null
}
Copy-Item $TempXML -Destination "$SysvolBase\AppLocker.xml" -Force
Remove-Item $TempXML

Write-Host "  [configured] AppLocker policy written to GPO SYSVOL" -ForegroundColor Green
Write-Host "  Rules: signed EXE + WINDIR/PROGRAMFILES paths + admin bypass" -ForegroundColor Green

# Enable Application Identity service via GPO (required for AppLocker)
Set-GPRegistryValue -Name $GPOName -Key "HKLM\SYSTEM\CurrentControlSet\Services\AppIDSvc" `
    -ValueName "Start" -Type DWord -Value 2   # 2 = Automatic

Write-Host "  [set] Application Identity service: Automatic start" -ForegroundColor Green

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

Next steps:
  1. Run: gpupdate /force (on each domain member)
  2. Start Application Identity service: Start-Service AppIDSvc
  3. Monitor: Event Viewer > Applications and Services > Microsoft > Windows > AppLocker
     Event 8003 = would-have-blocked | Event 8004 = blocked (only in Enforce mode)
  4. After 1 week of audit review, change EnforcementMode to "Enabled" and re-import

"@ -ForegroundColor Yellow
