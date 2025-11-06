@echo off
setlocal enabledelayedexpansion

title WordPress Multi-BruteForce Manager
color 0A

echo.
echo ═══════════════════════════════════════════════════════════
echo        WORDPRESS MULTI-BRUTEFORCE MANAGER
echo ═══════════════════════════════════════════════════════════
echo.

:: Configuration
set SCRIPT=bf.py
set INSTANCES=5
set SITES_DIR=sites

:: Check prerequisites
echo [~] Checking prerequisites...
if not exist "%SCRIPT%" (
    echo [ERROR] Script %SCRIPT% not found!
    goto error
)

:: Create sites directory if it doesn't exist
if not exist "%SITES_DIR%" (
    echo [~] Creating sites directory...
    mkdir "%SITES_DIR%"
)

:: List of available site files
set FILES[0]=%SITES_DIR%/domains.txt
set FILES[1]=%SITES_DIR%/siteW.txt
set FILES[2]=%SITES_DIR%/fr.txt
set FILES[3]=%SITES_DIR%/vn.txt
set FILES[4]=%SITES_DIR%/net.txt
set FILES[5]=%SITES_DIR%/us.txt
set FILES[6]=%SITES_DIR%/uk.txt
set FILES[7]=%SITES_DIR%/de.txt
set FILES[8]=%SITES_DIR%/gouv.txt
set FILES[9]=%SITES_DIR%/gobmx.txt
set FILES[10]=%SITES_DIR%/edu.txt
set FILES[11]=%SITES_DIR%/ac.txt
set FILES[12]=%SITES_DIR%/siteS.txt
set FILES[13]=%SITES_DIR%/frs.txt
set FILES[14]=%SITES_DIR%/goid.txt
set FILES[15]=%SITES_DIR%/gov.txt
set FILES[16]=%SITES_DIR%/8.txt

:: Check which files exist
echo [~] Checking site files...
set AVAILABLE_FILES=0
set FILE_LIST=
for /l %%i in (0,1,9) do (
    if exist "!FILES[%%i]!" (
        set /a AVAILABLE_FILES+=1
        set FILE_LIST=!FILE_LIST! "!FILES[%%i]!"
        echo [!] Found: !FILES[%%i]!
    ) else (
        set FILES[%%i]=
    )
)

if %AVAILABLE_FILES%==0 (
    echo [WARNING] No site files found!
    echo [INFO] Instances will be launched without specific files
)

:: Configuration menu
echo.
echo Current configuration:
echo - Script: %SCRIPT%
echo - Instances: %INSTANCES%
echo - Available site files: %AVAILABLE_FILES%
echo - Sites directory: %SITES_DIR%
echo.

set /p CHOICE="Do you want to modify settings? (Y/N): "
if /i "%CHOICE%"=="Y" (
    set /p INSTANCES="Number of instances [16]: "
    if "!INSTANCES!"=="" set INSTANCES=16
    
    set /p SITES_DIR="Sites directory [sites]: "
    if "!SITES_DIR!"=="" set SITES_DIR=sites
    
    echo.
    echo [~] Rescanning site files...
    set AVAILABLE_FILES=0
    for /l %%i in (0,1,9) do (
        set FILES[%%i]=!SITES_DIR!/!FILES[%%i]:~6!
        if exist "!FILES[%%i]!" (
            set /a AVAILABLE_FILES+=1
            echo [!] Found: !FILES[%%i]!
        ) else (
            set FILES[%%i]=
        )
    )
)

:: Launch type selection
echo.
echo Launch options:
echo 1 - Each instance with different site file
echo 2 - All instances with same file (round-robin)
echo 3 - Manual file selection for each instance
echo 4 - Launch without site files
echo.
set /p LAUNCH_TYPE="Select launch type [1]: "

if "%LAUNCH_TYPE%"=="" set LAUNCH_TYPE=1
if "%LAUNCH_TYPE%"=="4" goto launch_without_files

echo.
echo [~] Preparing to launch %INSTANCES% instances...
timeout /t 2 /nobreak >nul

:: Launch instances based on selected type
if "%LAUNCH_TYPE%"=="1" goto launch_different_files
if "%LAUNCH_TYPE%"=="2" goto launch_round_robin
if "%LAUNCH_TYPE%"=="3" goto launch_manual_selection

:launch_different_files
echo.
echo [~] Launching instances with different site files...
set LAUNCHED=0
set USED_FILES=0

for /l %%i in (1,1,%INSTANCES%) do (
    set FILE_FOUND=0
    set FILE_TO_USE=
    
    :: Find next available file
    for /l %%j in (0,1,9) do (
        if !FILE_FOUND!==0 (
            if defined FILES[%%j] (
                set FILE_TO_USE=!FILES[%%j]!
                set FILES[%%j]=
                set FILE_FOUND=1
                set /a USED_FILES+=1
            )
        )
    )
    
    :: Launch instance with appropriate file
    if !FILE_FOUND!==1 (
        echo [!] Instance %%i: Launching with !FILE_TO_USE!
        start "WP-BF-%%i" python %SCRIPT% "!FILE_TO_USE!"
    ) else (
        echo [!] Instance %%i: Launching without site file
        start "WP-BF-%%i" python %SCRIPT%
    )
    
    set /a LAUNCHED+=1
    if %%i lss %INSTANCES% (
        timeout /t 1 /nobreak >nul
    )
)
goto launch_complete

:launch_round_robin
echo.
echo [~] Launching instances with round-robin file distribution...
set LAUNCHED=0

:: Create temporary array of available files
set TEMP_INDEX=0
for /l %%i in (0,1,9) do (
    if defined FILES[%%i] (
        set TEMP[!TEMP_INDEX!]=!FILES[%%i]!
        set /a TEMP_INDEX+=1
    )
)

for /l %%i in (1,1,%INSTANCES%) do (
    set /a FILE_INDEX=(%%i-1) %% TEMP_INDEX
    if !TEMP_INDEX! gtr 0 (
        echo [!] Instance %%i: Launching with !TEMP[%FILE_INDEX%]!
        start "WP-BF-%%i" python %SCRIPT% "!TEMP[%FILE_INDEX%]!"
    ) else (
        echo [!] Instance %%i: Launching without site file
        start "WP-BF-%%i" python %SCRIPT%
    )
    
    set /a LAUNCHED+=1
    if %%i lss %INSTANCES% (
        timeout /t 1 /nobreak >nul
    )
)
goto launch_complete

:launch_manual_selection
echo.
echo [~] Manual file selection mode...
set LAUNCHED=0

for /l %%i in (1,1,%INSTANCES%) do (
    echo.
    echo Available files for Instance %%i:
    set COUNT=0
    for /l %%j in (0,1,9) do (
        if exist "!FILES[%%j]!" (
            set /a COUNT+=1
            echo !COUNT! - !FILES[%%j]!
        )
    )
    echo 0 - Without site file
    echo.
    set /p FILE_CHOICE="Select file for Instance %%i [0]: "
    
    if "!FILE_CHOICE!"=="0" (
        echo [!] Instance %%i: Launching without site file
        start "WP-BF-%%i" python %SCRIPT%
    ) else (
        set FILE_COUNT=0
        for /l %%j in (0,1,9) do (
            if exist "!FILES[%%j]!" (
                set /a FILE_COUNT+=1
                if !FILE_COUNT!==!FILE_CHOICE! (
                    echo [!] Instance %%i: Launching with !FILES[%%j]!
                    start "WP-BF-%%i" python %SCRIPT% "!FILES[%%j]!"
                )
            )
        )
    )
    
    set /a LAUNCHED+=1
)
goto launch_complete

:launch_without_files
echo.
echo [~] Launching instances without site files...
for /l %%i in (1,1,%INSTANCES%) do (
    echo [!] Instance %%i: Launching without site file
    start "WP-BF-%%i" python %SCRIPT%
    if %%i lss %INSTANCES% (
        timeout /t 1 /nobreak >nul
    )
)
set LAUNCHED=%INSTANCES%

:launch_complete
echo.
echo ═══════════════════════════════════════════════════════════
echo [SUCCESS] %LAUNCHED% instances launched successfully!
echo.
echo Useful commands:
echo - taskkill /fi "WindowTitle eq WP-BF-*" /f
echo - To stop all instances
echo ═══════════════════════════════════════════════════════════
echo.

:: Advanced management menu
:management
echo.
echo Management Options:
echo 1 - Stop all instances
echo 2 - Launch additional instance
echo 3 - Launch instance with specific file
echo 4 - Restart all instances
echo 5 - Show running instances
echo 6 - Monitor instances
echo 7 - Change configuration
echo 8 - Exit
echo.
set /p MGMT_CHOICE="Choice [8]: "

if "%MGMT_CHOICE%"=="1" (
    echo [~] Stopping all instances...
    taskkill /fi "WindowTitle eq WP-BF-*" /f >nul 2>&1
    echo [OK] All instances stopped
    goto management
)

if "%MGMT_CHOICE%"=="2" (
    set /a INSTANCES+=1
    echo [~] Launching instance %INSTANCES%...
    start "WP-BF-%INSTANCES%" python %SCRIPT%
    echo [OK] Instance %INSTANCES% launched
    goto management
)

if "%MGMT_CHOICE%"=="3" (
    echo.
    echo Available files:
    set COUNT=0
    for /l %%i in (0,1,9) do (
        if exist "!FILES[%%i]!" (
            set /a COUNT+=1
            echo !COUNT! - !FILES[%%i]!
        )
    )
    echo 0 - Without site file
    echo.
    set /p FILE_CHOICE="Select file [0]: "
    
    set /a INSTANCES+=1
    if "!FILE_CHOICE!"=="0" (
        echo [~] Launching instance %INSTANCES% without site file...
        start "WP-BF-%INSTANCES%" python %SCRIPT%
    ) else (
        set FILE_COUNT=0
        for /l %%i in (0,1,9) do (
            if exist "!FILES[%%i]!" (
                set /a FILE_COUNT+=1
                if !FILE_COUNT!==!FILE_CHOICE! (
                    echo [~] Launching instance %INSTANCES% with !FILES[%%i]!
                    start "WP-BF-%INSTANCES%" python %SCRIPT% "!FILES[%%i]!"
                )
            )
        )
    )
    echo [OK] Instance %INSTANCES% launched
    goto management
)

if "%MGMT_CHOICE%"=="4" (
    echo [~] Restarting all instances...
    taskkill /fi "WindowTitle eq WP-BF-*" /f >nul 2>&1
    timeout /t 3 /nobreak >nul
    echo [~] Relaunching instances...
    goto :eof
)

if "%MGMT_CHOICE%"=="5" (
    echo.
    echo [~] Currently running instances:
    tasklist /fi "WindowTitle eq WP-BF-*" /fo table
    goto management
)

if "%MGMT_CHOICE%"=="6" (
    echo.
    echo [~] Instance Monitor - Refreshing every 10 seconds
    echo Press Ctrl+C to stop monitoring
    :monitor_loop
    cls
    echo ═══════════════════════════════════════════════════════════
    echo        INSTANCE MONITOR - %time%
    echo ═══════════════════════════════════════════════════════════
    echo.
    tasklist /fi "WindowTitle eq WP-BF-*" /fo table
    echo.
    echo Press Ctrl+C to stop monitoring
    timeout /t 10 /nobreak >nul
    goto monitor_loop
)

if "%MGMT_CHOICE%"=="7" (
    echo.
    set /p NEW_SCRIPT="Script name [%SCRIPT%]: "
    if not "!NEW_SCRIPT!"=="" set SCRIPT=!NEW_SCRIPT!
    
    set /p NEW_SITES_DIR="Sites directory [%SITES_DIR%]: "
    if not "!NEW_SITES_DIR!"=="" set SITES_DIR=!NEW_SITES_DIR!
    
    echo [~] Configuration updated
    goto management
)

exit /b 0

:error
echo.
echo ═══════════════════════════════════════════════════════════
echo [ERROR] Cannot continue
echo Verify that wpbrutgui.py is in the same directory
echo ═══════════════════════════════════════════════════════════
pause
exit /b 1