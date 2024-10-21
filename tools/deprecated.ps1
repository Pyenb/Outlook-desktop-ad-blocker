# Author: Pyenb
# https://github.com/Pyenb/Outlook-desktop-ad-blocker

$batchFileUrl = "https://raw.githubusercontent.com/Pyenb/Outlook-desktop-ad-blocker/main/adblock.cmd"
$batchFilePath = "$env:TEMP\adblock.cmd"

# Remove batch file if it already exists
if (Test-Path $batchFilePath) {
    Remove-Item -Path $batchFilePath -Force
}

# Download and execute batch file
Write-Host "Downloading batch file..."
Invoke-RestMethod -Uri $batchFileUrl -OutFile $batchFilePath

Write-Host "Executing batch file..."
Start-Process -FilePath $batchFilePath -Wait
Remove-Item -Path $batchFilePath -Force
Write-Host "Removed batch file..."