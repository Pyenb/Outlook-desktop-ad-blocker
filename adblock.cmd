@echo off
setlocal

set "hostsFile=%windir%\System32\drivers\etc\hosts"
set "OutlookAdDomain=0.0.0.0 m.adnxs.com"

net session >nul 2>&1
if %errorLevel% == 0 (
    goto :OutlookAdblockInit
) else (
    echo Running script with elevated privileges...
    powershell -Command "Start-Process -FilePath \"%~dp0%~nx0\" -Verb RunAs"
    exit
)

:color
echo | set /p dummyName=" " & powershell -Command "Write-Host -ForegroundColor %~1 '%~2'"
goto :eof

:checkAdblocker
findstr /c:"%OutlookAdDomain%" "%hostsFile%" >nul
goto :eof

:OutlookAdblockInit

cls
title Manage Outlook adblocker
mode 76, 25

if not exist "%hostsFile%" (
echo.
echo.
echo.
echo.
echo.
echo.       ______________________________________________________________
echo.
call :color Red "             Hosts file was not found, aborting..."
echo.       ______________________________________________________________
echo.
call :color Yellow "             Press any key to exit..."
pause >nul
exit
)

:OutlookAdblockMenu

cls
title Manage Outlook adblocker

echo.
echo.
echo.
echo.
echo.
echo.       ______________________________________________________________
echo.
call :checkAdblocker
if %errorLevel% == 0 (call :color Green "             Outlook Adblocker is already installed")
if %errorLevel% == 1 (call :color Red "             Outlook Adblocker is not installed")
echo.
echo.             [1] Install Outlook adblocker
echo.
echo.             [2] Uninstall Outlook adblocker
echo.             __________________________________________________      
echo.                                                                     
echo.             [0] Exit
echo.       ______________________________________________________________
echo.
call :color Green "             Enter a menu option in the Keyboard [1,2,0]: "
choice /C:120 /N
set _erl=%errorlevel%

if %_erl%==3 exit
if %_erl%==2 goto :OutlookAdblockUninstall
if %_erl%==1 goto :OutlookAdblockInstall
goto :OutlookAdblockMenu

:OutlookAdblockInstall

cls
title Install Outlook adblocker

echo.
echo.
echo.
echo.
echo.
echo.       ______________________________________________________________
echo.
echo.             Installing Outlook adblocker...
echo.>>"%hostsFile%"
echo %OutlookAdDomain%>>"%hostsFile%"
echo.
call :checkAdblocker
if %errorLevel% == 0 (call :color Green "             Successfully installed Outlook adblocker.")
if %errorLevel% == 1 (call :color Red "             Outlook adblocker installation failed.")
echo.       ______________________________________________________________
echo.
call :color Yellow "             Press any key to go back..."
pause >nul
goto OutlookAdblockMenu


:OutlookAdblockUninstall

cls
title Uninstall Outlook adblocker

echo.
echo.
echo.
echo.
echo.
echo.       ______________________________________________________________
echo.
echo.             Uninstalling Outlook adblocker...
for /f "delims=" %%A in ('type "%hostsFile%" ^| findstr /v /b /c:"%OutlookAdDomain%"') do echo %%A >> "%hostsFile%.new"
move /y "%hostsFile%.new" "%hostsFile%" > nul
echo.
call :checkAdblocker
if %errorLevel% == 0 (call :color Red "             Uninstalling Outlook adblocker failed.")
if %errorLevel% == 1 (call :color Green "             Successfully uninstalled Outlook adblocker.")
echo.       ______________________________________________________________
echo.
call :color Yellow "             Press any key to go back..."
pause >nul
goto OutlookAdblockMenu

endlocal