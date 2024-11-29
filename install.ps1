$logo = @"
 _____ _           __            ____  _           
|  ___(_)_ __ ___ / _| _____  __|  _ \| |_   _ ___ 
| |_  | | '__/ _ \ |_ / _ \ \/ /| |_) | | | | / __|
|  _| | | | |  __/  _| (_) >  < |  __/| | |_| \__ \
|_|   |_|_|  \___|_|  \___/_/\_\|_|   |_|\__,_|___/

Enjoy your enhanced browsing experience!
https://github.com/amnweb/firefox-plus

"@
Clear-Host

Write-Host ("{0}`n" -f ($logo -join "`n")) -ForegroundColor Blue

$firefoxProfilesPath = Join-Path -Path "$env:APPDATA\Mozilla\Firefox\Profiles" -ChildPath "*.default-release"
$user_script = "user.js"
if (-not (Test-Path -Path $firefoxProfilesPath)) {
    Write-Host "We can't find the profile directory, try manual installation."
}

Get-ChildItem -Path $firefoxProfilesPath | ForEach-Object {
    Write-Host "Downloading latest release"
    Set-Location $firefoxProfilesPath
    Invoke-WebRequest -Uri "https://github.com/amnweb/firefox-plus/archive/refs/heads/main.zip" -OutFile "main.zip"
    Write-Host "Extracting Chrome folders"
    Expand-Archive -Path "main.zip" -DestinationPath . -Force
    Remove-Item -Path "main.zip"
    Set-Location "firefox-plus-main"
    Copy-Item -Path "chrome" -Destination .. -Recurse -Force
    Set-Location ..
    Remove-Item -Path "firefox-plus-main" -Recurse -Force
    Write-Host "Config user.js"
    $confirmAdd = {
        param($line)
        do {
            Write-Host "$($line.desc)? (y/n) " -NoNewline
            $keyPress = [System.Console]::ReadKey()
    
            if ($keyPress.Key -ne [System.ConsoleKey]::Y -and $keyPress.Key -ne [System.ConsoleKey]::N) {
                Write-Host " Invalid response, please answer yes or no (y/n)" -ForegroundColor Red
            }else{
                Write-Host ""
            }
        } 
        while ($keyPress.Key -ne [System.ConsoleKey]::Y -and $keyPress.Key -ne [System.ConsoleKey]::N)
        if ($keyPress.Key -eq [System.ConsoleKey]::Y) {
            return @($line, 'y')
        } elseif ($keyPress.Key -eq [System.ConsoleKey]::N) {
            return @($line, 'n')
        }else{
            return $null
        }
    }
    
    $confirmAddLines = @(
        [PSCustomObject]@{
            "line"  = "user_pref(`"fp.tweak.autohide-bookmarks`", true);"
            "desc"  = "Enable autohide bookmarks"
        },
        [PSCustomObject]@{
            "line"  = "user_pref(`"fp.tweak.macos-button`", true);"
            "desc"  = "Enable macos button"
        },
        [PSCustomObject]@{
            "line"  = "user_pref(`"fp.tweak.rounded-corners`", true);"
            "desc"  = "Enable rounded corners"
        },
        [PSCustomObject]@{
            "line"  = "user_pref(`"app.update.auto`", false);"
            "desc"  = "Enable Firefox autoupdate"
        },
        [PSCustomObject]@{
            "line"  = "user_pref(`"toolkit.telemetry.enabled`", false);"
            "desc"  = "Enable telemetry (disabled by default)"
        } 
    )
$fileContent = @"
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("svg.context-properties.content.enabled", true);
user_pref("layout.css.color-mix.enabled", true);
user_pref("layout.css.light-dark.enabled`", true);
user_pref("browser.tabs.tabMinWidth", 66);
user_pref("browser.tabs.tabClipWidth", 86);
user_pref("browser.in-content.dark-mode", true);
user_pref("ui.systemUsesDarkTheme", 1);`r`n
"@
    
    foreach ($lineObj in $confirmAddLines) {
        $result  = $confirmAdd.Invoke($lineObj)
        $line = $result[0]
        $answer = $result[1]
        if ($line -ne $null -and $answer -ne 'n') {
            $fileContent += $line.line + "`r`n"
        }
        if ($line -ne $null -and $answer -ne 'y') {
            $fileContent += $line.line.Replace('true','false') + "`r`n"
        }
    }
    
    [void](New-Item -Path $user_script -ItemType File -Force)
    Set-Content -Path $user_script -Value $fileContent
    Write-Host "`r`nDone, Restart Firefox`r`n"  -ForegroundColor Green
}