@echo off

:: Check administrator privileges
net session >nul 2>&1
if not %errorlevel% == 0 (
    echo Please run this script with administrator privileges.
    echo Right-click on the command prompt icon and select "Run as administrator".
    pause
    goto :eof
)

echo Welcome to McFirewalls, written by ChatGPT at the request of Xaevien
echo This will not do port forwarding for you, just makes dealing with firewall rules easier

:: Loop back
:askAction
echo.

:: Prompt user for action
set /p "action=Do you want to add or remove Minecraft firewall rules? (Type 'add' or 'remove'): "

:: Validate user input
if /i not "%action%"=="add" if /i not "%action%"=="remove" (
    echo Invalid action. Please type 'add' or 'remove'.
    goto :askAction
)

:: Prompt user for custom RuleName and Port or use default values
echo.
if /i "%action%"=="add" (
    set /p "useCustomValues=Do you want to use a custom RuleName and Port? (Type 'no' or 'yes'): "
) else (
    set /p "useCustomValues=Are you deleting a server with a custom RuleName? (Type 'no' or 'yes'): "
)

if /i "%useCustomValues%"=="yes" (
    if /i "%action%"=="add" (
        echo.
        set /p "RuleName=Enter custom RuleName (default is 'Server'): "
        echo.
        set /p "Port=Enter custom Port (default is '25565'): "
    ) else (
        set /p "RuleName=What was the RuleName?: "
        set "Port=25565"
    )
) else (
    set "RuleName=Server"
    set "Port=25565"
)

:: Define variables based on user input
set "RuleNameTCP=%RuleName% TCP Inbound"

:: Perform action
echo.
if /i "%action%"=="add" (
    :: Check if firewall rule already exists
    set "existingRule="
    for /F "tokens=*" %%i in ('netsh advfirewall firewall show rule name^="%RuleNameTCP%" ^| find /i "%RuleNameTCP%"') do set existingRule=%%i >nul

    if not defined existingRule (
        :: Add firewall rules
        netsh advfirewall firewall add rule name="%RuleNameTCP%" dir=in action=allow protocol=TCP localport=%Port% >nul && (
            netsh advfirewall firewall add rule name="%RuleName% UDP Inbound" dir=in action=allow protocol=UDP localport=%Port% >nul 
            netsh advfirewall firewall add rule name="%RuleName% TCP Outbound" dir=out action=allow protocol=TCP localport=%Port% >nul 
            netsh advfirewall firewall add rule name="%RuleName% UDP Outbound" dir=out action=allow protocol=UDP localport=%Port% >nul 
            echo Firewall rules for Minecraft server added successfully:
            echo   - %RuleNameTCP%
            echo   - %RuleName% UDP Inbound
            echo   - %RuleName% TCP Outbound
            echo   - %RuleName% UDP Outbound
        ) || (
            echo Failed to add firewall rules for Minecraft server.
        )
    ) else (
        echo Firewall rules for Minecraft server already exist.
    )
) else if /i "%action%"=="remove" (
    :: Get firewall rules with the specified display name
    for /F "tokens=*" %%i in ('netsh advfirewall firewall show rule name^="%RuleNameTCP%" ^| find /i "%RuleNameTCP%"') do set "rulesToRemove=%%i" >nul

    if defined rulesToRemove (
        :: Remove firewall rules
        netsh advfirewall firewall delete rule name="%RuleNameTCP%" >nul
        netsh advfirewall firewall delete rule name="%RuleName% UDP Inbound" >nul
        netsh advfirewall firewall delete rule name="%RuleName% TCP Outbound" >nul
        netsh advfirewall firewall delete rule name="%RuleName% UDP Outbound" >nul
        echo Firewall rules for Minecraft server removed successfully.
    ) else (
        echo No firewall rules found for Minecraft server.
    )
) else (
    echo Invalid action. Please type 'add' or 'remove'.
)

:: Pause to keep the window open
echo.
pause
