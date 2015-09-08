# http://boxstarter.org/package/url?https://raw.githubusercontent.com/cam1985/chocolatey/master/boxstarter_chocolatey_hhpc.ps1
 
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

# -- Enable Remote Desktop
Enable-RemoteDesktop


cinst chocolatey -y 
cinst chocolateygui -y 
cinst boxstarter -y 

# -- Add Windows Features
cinst TelnetClient -source windowsFeatures

cinst nuget.commandline -y 
cinst wget -y 

cinst silverlight -y 
cinst vcredist2010 -y 
cinst dotnet4.5 -y 

cinst powershell -pre -y 
cup powershell -pre -yf --acceptlicense

cinst javaruntime -y 

# -- Install Additional Browsers
cinst googlechrome -y 
#Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Google\Chrome\Application\chrome.exe"

cinst firefox -y 

# -- Install Adobe Products
cinst flashplayeractivex -y 
cinst flashplayerplugin -y 
cinst adobeair -y 
cinst adobereader -y 

cinst malwarebytes -y 

cinst 7zip.install -y 

cinst vlc -y 
cinst ccleaner -y

cinst pdfcreator -y 

cinst ultravnc -y 

# -- Optional Packages
cinst itunes -y 
cinst skype -y
cinst teamviewer -y


# -- Install Windows Updates
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

} catch {
  Write-ChocolateyFailure 'example' $($_.Exception.Message)
  throw
}