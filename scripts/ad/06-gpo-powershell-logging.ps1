#Requires -Modules GroupPolicy
# 06-gpo-powershell-logging.ps1
# Create and link a GPO enabling PowerShell script block logging, module logging,
# and transcription. NIST 800-53 AU-2, SI-3.
# Run on DC01 as Domain Admin.

$GPOName    = "LAB-PowerShellLogging"
$DomainDN   = "DC=your-lab,DC=lab"
$DomainFQDN = "yourdomain.local"

Write-Host "`nConfiguring GPO: $GPOName`n" -ForegroundColor Cyan

$GPO = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
if (-not $GPO) {
    $GPO = New-GPO -Name $GPOName -Comment "NIST 800-53 AU-2 - PowerShell Script Block + Module + Transcription Logging"
    Write-Host "  [created] GPO: $GPOName" -ForegroundColor Green
} else {
    Write-Host "  [exists]  GPO: $GPOName" -ForegroundColor Gray
}

$PSRegBase = "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell"

# Script Block Logging
Set-GPRegistryValue -Name $GPOName -Key "$PSRegBase\ScriptBlockLogging" `
    -ValueName "EnableScriptBlockLogging"        -Type DWord -Value 1
Set-GPRegistryValue -Name $GPOName -Key "$PSRegBase\ScriptBlockLogging" `
    -ValueName "EnableScriptBlockInvocationLogging" -Type DWord -Value 1

Write-Host "  [set] Script Block Logging: Enabled (incl. invocation logging)" -ForegroundColor Green

# Module Logging
Set-GPRegistryValue -Name $GPOName -Key "$PSRegBase\ModuleLogging" `
    -ValueName "EnableModuleLogging" -Type DWord -Value 1
# Log all modules (wildcard)
Set-GPRegistryValue -Name $GPOName -Key "$PSRegBase\ModuleLogging\ModuleNames" `
    -ValueName "*" -Type String -Value "*"

Write-Host "  [set] Module Logging: Enabled (all modules)" -ForegroundColor Green

# Transcription Logging
# Transcripts go to a central share - adjust path if you set one up
$TranscriptPath = "C:\PSTranscripts"
Set-GPRegistryValue -Name $GPOName -Key "$PSRegBase\Transcription" `
    -ValueName "EnableTranscripting"          -Type DWord  -Value 1
Set-GPRegistryValue -Name $GPOName -Key "$PSRegBase\Transcription" `
    -ValueName "EnableInvocationHeader"       -Type DWord  -Value 1
Set-GPRegistryValue -Name $GPOName -Key "$PSRegBase\Transcription" `
    -ValueName "OutputDirectory"              -Type String -Value $TranscriptPath

Write-Host "  [set] Transcription: Enabled -> $TranscriptPath" -ForegroundColor Green
Write-Host "        Note: Create $TranscriptPath on each host or redirect to a share" -ForegroundColor Yellow

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

Write-Host "`nDone. Script block logs appear in Event Log: Applications and Services > Microsoft > Windows > PowerShell > Operational`n"
