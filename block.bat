@echo off
setlocal

net session >nul 2>&1
if %errorLevel% == 0 (
    goto :main
) else (
    echo Running script with elevated privileges...
    powershell -Command "Start-Process -FilePath \"%~dp0%~nx0\" -Verb RunAs"
    exit
)

:main
set "hostsFile=%windir%\System32\drivers\etc\hosts"
set "lineToAddOrRemove=127.0.0.1 outlookads.live.com"

echo.
echo Simple Outlook adblocker
echo.

findstr /c:"%lineToAddOrRemove%" "%hostsFile%" >nul
if %errorLevel% == 0 (
    echo.
    echo Note: Adblock is already installed.
    echo.
)

echo This script will add or remove the line:
echo.
echo %lineToAddOrRemove% 
echo.
echo from the hosts file to either block or unblock ads in Outlook.
echo Note: The ads will be gone, but the blank space will still be there.

echo.
echo Select operation:
echo 0. Exit
echo 1. Install adblock
echo 2. Remove adblock
echo.

set /p operation=choice: 

if "%operation%"=="1" (
    echo Adding the line to hosts file...
    echo.%lineToAddOrRemove%>>"%hostsFile%"
    echo Successfully installed adblock.
) else if "%operation%"=="2" (
    echo Removing the line from hosts file...
    findstr /v "%lineToAddOrRemove%" "%hostsFile%" > "%hostsFile%.new"
    move /y "%hostsFile%.new" "%hostsFile%" > nul
    echo Successfully removed adblock.
) else if "%operation%"=="0" (
    echo Exiting...
    exit
) else (
    echo Invalid choice. Please enter 0, 1 or 2.
)

endlocal
