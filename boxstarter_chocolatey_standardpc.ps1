# http://boxstarter.org/package/url?http://boxstarter.org/package/url?https://raw.githubusercontent.com/cam1985/chocolatey/master/boxstarter_chocolatey_standardpc.ps1
 
#####################
# BEGIN CONFIGURATION
#####################
# -- Set Powershell Execution Policy
try {
    Update-ExecutionPolicy Unrestricted
    try{
        # -- Optional - Move Library Directories
        # ---- Run in powershell 'Get-LibraryNames' for full list

            # -- e.g. Move Documents to Skydrive Directory
            #Move-LibraryDirectory "Personal" "$env:UserProfile\skydrive\documents"
    } catch{}

# -- Set Windows Settings --
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-StartScreenOptions -EnableSearchEverywhereInAppsView
Set-TaskbarOptions -Size Large -Lock -Dock Bottom
Install-ChocolateyPinnedTaskBarItem "$env:windir\system32\mstsc.exe"

# -- Enable Remote Desktop
Enable-RemoteDesktop


cinst chocolatey -y --acceptlicense
cinst chocolateygui -y --acceptlicense
cinst boxstarter -y --acceptlicense

# -- Add Windows Features
cinst TelnetClient -source windowsFeatures

cinst nuget.commandline -y --acceptlicense
cinst wget -y --acceptlicense

cinst powershell -pre -y --acceptlicense
cup powershell -pre -yf --acceptlicense
cinst sysinternals -y --acceptlicense
cinst bginfo -y --acceptlicense

cinst silverlight -y --acceptlicense
cinst vcredist2010 -y --acceptlicense
cinst dotnet4.5 -y --acceptlicense

# --  WINRM Setup --
winrm quickconfig -q
winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"}
winrm set winrm/config @{MaxTimeoutms="1800000"}
winrm set winrm/config/service @{AllowUnencrypted="true"}
winrm set winrm/config/service/auth @{Basic="true"}
sc config WinRM start= auto

cinst javaruntime -y --acceptlicense

# -- Install Additional Browsers
cinst googlechrome -y --acceptlicense
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Google\Chrome\Application\chrome.exe"

cinst firefox -y --acceptlicense

# -- Install Adobe Products
cinst flashplayeractivex -y --acceptlicense
cinst flashplayerplugin -y --acceptlicense
cinst adobeair -y --acceptlicense
cinst adobereader -y --acceptlicense


cinst malwarebytes -y --acceptlicense

cinst 7zip.install -y --acceptlicense

cinst vlc -y --acceptlicense
cinst ccleaner -y --acceptlicense

cinst notepadplusplus.install -y --acceptlicense
cinst pdfcreator -y --acceptlicense

cinst ultravnc -y --acceptlicense

# -- Optional Packages
#cinst itunes -y --acceptlicense
cinst dropbox -y --acceptlicense
cinst console-devel -y --acceptlicense
Install-ChocolateyPinnedTaskBarItem "$env:programfiles\console\console.exe"

# -- Install Windows Updates
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

} catch {
  Write-ChocolateyFailure 'example' $($_.Exception.Message)
  throw
}
