$batchFileUrl = "https://raw.githubusercontent.com/Pyenb/Outlook-desktop-ad-blocker/main/block.bat"
$batchFilePath = "$env:TEMP\block.bat"

Write-Host "Downloading batch file..."
Invoke-WebRequest -Uri $batchFileUrl -OutFile $batchFilePath

Write-Host "Executing batch file..."
Start-Process -FilePath $batchFilePath -Wait
Remove-Item -Path $batchFilePath -Force
Write-Host "Removed batch file..."