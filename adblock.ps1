Function Ensure-Admin {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Start-Process powershell "-File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
}
Ensure-Admin

$domains = @(
    "0.0.0.0 outlookads.live.com",
    "0.0.0.0 m.adnxs.com",
    "0.0.0.0 adnxs.com",
    "0.0.0.0 www.adnxs.com",
    "0.0.0.0 acdn.adnxs.com",
    "0.0.0.0 3lift.com",
    "0.0.0.0 www.3lift.com",
    "0.0.0.0 browser.events.data.microsoft.com/OneCollector/",
    "0.0.0.0 m.adnxs.com/ut/v3",
    "0.0.0.0 eb2.3lift.com"
)

$hostsFile = "$env:SystemRoot\System32\drivers\etc\hosts"

function Write-Color {
    param (
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Host (" " + $Text) -ForegroundColor $Color -NoNewline
}

function Show-Menu {
    Clear-Host
    Write-Color "`n`n`n`n`n       ______________________________________________________________`n" Yellow
    if (Check-Adblocker) {
        Write-Color "             Outlook Adblocker is already installed`n" Green
    } else {
        Write-Color "             Outlook Adblocker is not installed`n" Red
    }
    Write-Color "`n             [1] Install Outlook adblocker" White
    Write-Color "`n             [2] Uninstall Outlook adblocker" White
    Write-Color "`n             [0] Exit`n" White
    Write-Color "       ______________________________________________________________`n" Yellow
    Write-Color "             Enter a menu option [1,2,0]: " Green
}

function Check-Adblocker {
    $hostsContent = Get-Content -Path $hostsFile -ErrorAction SilentlyContinue
    foreach ($domain in $domains) {
        if (-not ($hostsContent -contains $domain)) {
            return $false
        }
    }
    return $true
}

function Install-Adblocker {
    Clear-Host
    Write-Color "`n`n`n`n`n       ______________________________________________________________`n" Yellow
    Write-Color "             Installing Outlook adblocker...`n" White
    foreach ($domain in $domains) {
        if (-not (Get-Content -Path $hostsFile | Select-String -SimpleMatch $domain)) {
            Add-Content -Path $hostsFile -Value $domain
        }
    }
    if (Check-Adblocker) {
        Write-Color "             Successfully installed Outlook adblocker.`n" Green
    } else {
        Write-Color "             Outlook adblocker installation failed.`n" Red
    }
    Write-Color "       ______________________________________________________________`n" Yellow
    Write-Color "             Press any key to go back..." Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Uninstall-Adblocker {
    Clear-Host
    Write-Color "`n`n`n`n`n       ______________________________________________________________`n" Yellow
    Write-Color "             Uninstalling Outlook adblocker...`n" White
    $hostsContent = Get-Content -Path $hostsFile
    $filteredContent = $hostsContent | Where-Object { $_ -notin $domains }
    Set-Content -Path $hostsFile -Value $filteredContent
    if (-not (Check-Adblocker)) {
        Write-Color "             Successfully uninstalled Outlook adblocker.`n" Green
    } else {
        Write-Color "             Uninstalling Outlook adblocker failed.`n" Red
    }
    Write-Color "       ______________________________________________________________`n" Yellow
    Write-Color "             Press any key to go back..." Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

do {
    Show-Menu
    $choice = Read-Host
    switch ($choice) {
        "1" { Install-Adblocker }
        "2" { Uninstall-Adblocker }
        "0" { exit }
        default { Write-Color "Invalid selection, please try again." Yellow; Start-Sleep 2 }
    }
} while ($true)
