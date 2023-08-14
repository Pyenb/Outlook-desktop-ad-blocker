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
echo Cool outlook blocker thing
echo.

findstr /c:"%lineToAddOrRemove%" "%hostsFile%" >nul
if %errorLevel% == 0 (
    echo.
    echo Note: The line is already present in the hosts file.
    echo.
)

echo This script will add or remove the line:
echo.
echo %lineToAddOrRemove% 
echo.
echo from the hosts file to either block or unblock ads in Outlook.
echo Note: The ads will be gone, but the space will still be there.

echo.
echo Select operation:
echo 1. Add the line
echo 2. Remove the line
echo.

set /p operation=Enter the number of your choice: 

if "%operation%"=="1" (
    echo Adding the line to hosts file...
    echo.%lineToAddOrRemove%>>"%hostsFile%"
    echo Line added successfully.
) else if "%operation%"=="2" (
    echo Removing the line from hosts file...
    findstr /v "%lineToAddOrRemove%" "%hostsFile%" > "%hostsFile%.new"
    move /y "%hostsFile%.new" "%hostsFile%" > nul
    echo Line removed successfully.
) else (
    echo Invalid choice. Please enter 1 or 2.
)

endlocal
