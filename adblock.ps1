$hostsFile = "$env:SystemRoot\System32\drivers\etc\hosts"
$domainsToBlock = @(
    "outlookads.live.com",
    "m.adnxs.com"
)

function Check-Admin {
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        Write-Host "`nThis script needs to be run as Administrator. Relaunching with elevated privileges..." -ForegroundColor Yellow
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        Exit
    }
}

function Set-ConsoleColors {
    [console]::BackgroundColor = 'Black'
    [console]::ForegroundColor = 'White'
    cls
}

function Check-HostsFileExists {
    if (-not (Test-Path $hostsFile)) {
        Write-Host "`nHosts file not found, aborting..." -ForegroundColor Red
        Pause
        Exit
    }
}

function Is-AdblockerInstalled {
    foreach ($domain in $domainsToBlock) {
        if (-not (Select-String -Pattern $domain -Path $hostsFile)) {
            return $false
        }
    }
    return $true
}

function Install-Adblocker {
    Write-Host "`nInstalling Outlook adblocker..." -ForegroundColor Yellow
    foreach ($domain in $domainsToBlock) {
        if (-not (Select-String -Pattern $domain -Path $hostsFile)) {
            Add-Content -Path $hostsFile -Value "`n0.0.0.0 $domain"
        }
    }
    if (Is-AdblockerInstalled) {
        Write-Host "`nSuccessfully installed Outlook adblocker." -ForegroundColor Green
    } else {
        Write-Host "`nFailed to install Outlook adblocker." -ForegroundColor Red
    }
}

function Uninstall-Adblocker {
    Write-Host "`nUninstalling Outlook adblocker..." -ForegroundColor Yellow
    $content = Get-Content $hostsFile | Where-Object { 
        $notInList = $true
        foreach ($domain in $domainsToBlock) {
            if ($_ -match "0.0.0.0 $domain") {
                $notInList = $false
                break
            }
        }
        return $notInList
    }
    Set-Content $hostsFile -Value $content
    if (-not (Is-AdblockerInstalled)) {
        Write-Host "`nSuccessfully uninstalled Outlook adblocker." -ForegroundColor Green
    } else {
        Write-Host "`nFailed to uninstall Outlook adblocker." -ForegroundColor Red
    }
}

function Show-Menu {
    cls
    Write-Host "`nManage Outlook Adblocker" -ForegroundColor Cyan
    if (Is-AdblockerInstalled) {
        Write-Host "`nOutlook Adblocker is already installed." -ForegroundColor Green
    } else {
        Write-Host "`nOutlook Adblocker is not installed." -ForegroundColor Red
    }

    Write-Host "`n[1] Install Outlook adblocker"
    Write-Host "[2] Uninstall Outlook adblocker"
    Write-Host "[0] Exit"

    $choice = Read-Host "`nEnter a menu option [1, 2, 0]"
    return $choice
}

Check-Admin
Set-ConsoleColors
Check-HostsFileExists

do {
    $choice = Show-Menu

    switch ($choice) {
        "1" { Install-Adblocker }
        "2" { Uninstall-Adblocker }
        "0" { Exit }
        default { Write-Host "`nInvalid option. Please choose 1, 2, or 0." -ForegroundColor Red }
    }

    Pause
} while ($choice -ne "0")
