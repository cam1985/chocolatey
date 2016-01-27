# Invoke using following syntax into IE:
# http://boxstarter.org/package/url?[raw link to this gist]
try {
# ------------------------
# -- Boxstarter Options --
# ------------------------

$Boxstarter.RebootOk=$true # Allow reboots? 
$Boxstarter.NoPassword=$false # Is this a machine with no login password? 
$Boxstarter.AutoLogin=$true # Save my password securely and auto-login after a reboot

# ---------------------------
# -- Windows Configuration --
# ---------------------------

# -- Disable UAC --
Disable-UAC
if (Test-PendingReboot) { Invoke-Reboot }

# -- Update PowerShell Execution Policy --
Update-ExecutionPolicy Unrestricted
# -- Install Latest PowerShell and Management Framework--
cinst -y powershell -pre
cup -y powershell -pre
if (Test-PendingReboot) { Invoke-Reboot }

# -- Windows Explorer Settings --
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar 

#  --- Configure shell to include Run as Administrator for .ps1 files ---
New-Item -Path "Registry::HKEY_CLASSES_ROOT\Microsoft.PowershellScript.1\Shell\runas\command" -Force -Name '' -Value "`"$pshome\powershell.exe`" `"%1`"" | Out-Null
if (Test-PendingReboot) { Invoke-Reboot }

# -- Start Screen Options -- 
Set-StartScreenOptions -EnableSearchEverywhereInAppsView 
##Set-StartScreenOptions -EnableBootToDesktop

# -- Taskbar Settings --
##Set-TaskbarOptions -Size Large -Lock -Dock Bottom

# -- Disable IE Server Advanced Security --
##Disable-InternetExplorerESC

# -- Remote Desktop --
Enable-RemoteDesktop
if (Test-PendingReboot) { Invoke-Reboot }

# -- Disable Windows Update Auto Restart -- 
cinst -y windowsupdate.disableautorestart 
if (Test-PendingReboot) { Invoke-Reboot }

# -- Pin Items to Taskbar --
##Install-ChocolateyPinnedTaskBarItem "$env:windir\system32\mstsc.exe"

## -- Add Windows Features -- 
cinst TelnetClient -source windowsFeatures
if (Test-PendingReboot) { Invoke-Reboot }

# -- Setting Time Zone --
Write-BoxstarterMessage "Setting time zone to GMT Standard Time"
& C:\Windows\system32\tzutil /s "GMT Standard Time"
if (Test-PendingReboot) { Invoke-Reboot }

# -- Power options --

# --- Standby ---
##Write-BoxstarterMessage "Setting Standby Timeout to Never"
##powercfg -change -standby-timeout-ac 0
##powercfg -change -standby-timeout-dc 0

# --- Monitor Timeout ---
##Write-BoxstarterMessage "Setting Monitor Timeout to 20 minutes"
##powercfg -change -monitor-timeout-ac 20
##powercfg -change -monitor-timeout-dc 20

# --- Disk Timeout ---
##Write-BoxstarterMessage "Setting Disk Timeout to Never"
##powercfg -change -disk-timeout-ac 0
##powercfg -change -disk-timeout-dc 0

# --- AC - Lid Close Action (do nothing) ---
##powercfg -setacvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0

# --- DC - Lid Close Action (sleep) ---
##powercfg -setdcvalueindex 381b4222-f694-41f0-9685-ff5bb260df2e 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 1

# --- Disable Hibernation --- 
##Write-BoxstarterMessage "Turning off Windows Hibernation"
##powercfg -h off
if (Test-PendingReboot) { Invoke-Reboot }

# ----------------------------
# -- Microsoft Dependencies --
# ----------------------------

# -- Install .NET -- 
cinst -y dotnet3.5
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y dotnet4.5
if (Test-PendingReboot) { Invoke-Reboot }

# -- VC Redists --
cinst -y vcredist2005
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y vcredist2008
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y vcredist2010
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y vcredist2012
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y vcredist2013
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y vcredist2015
if (Test-PendingReboot) { Invoke-Reboot }

# -- Install Apps --
# --- Java ---
cinst -y javaruntime 
# --- Install Browsers ---
cinst -y googlechrome
cinst -y adblockpluschrome
cinst -y firefox
cinst -y adblockplusfirefox
cinst -y silverlight
cinst -y tor-browser
if (Test-PendingReboot) { Invoke-Reboot }

# --- Install Adobe Products ---
cinst flashplayeractivex -y #--acceptlicense
cinst flashplayerplugin -y #--acceptlicense
cinst adobeair -y #--acceptlicense
cinst adobereader -y #--acceptlicense
if (Test-PendingReboot) { Invoke-Reboot }

# --- Install Editors ---
# ---- Sublime 3 ----
cinst -y sublimetext3
cinst -y sublimetext3.packagecontrol
cinst -y sublimetext3-contextmenu 	
# ----- File associations -----
Install-ChocolateyFileAssociation ".txt" "$env:programfiles\Sublime Text 3\sublime_text.exe"
Install-ChocolateyFileAssociation ".xml" "$env:programfiles\Sublime Text 3\sublime_text.exe"
Install-ChocolateyFileAssociation ".config" "$env:programfiles\Sublime Text 3\sublime_text.exe"
# ----- Pin To TaskBar -----
Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles}\Sublime Text 3\sublime_text.exe"
if (Test-PendingReboot) { Invoke-Reboot }
# ---- NotePadPlusPlus ----
cinst -y notepadplusplus.install

# --- Archive Manager ---
cinst -y 7zip.install
if (Test-PendingReboot) { Invoke-Reboot }
# --- Media ---
cinst -y vlc
##cinst -y itunes
cinst -y audacity
cinst -y foobar2000
##cinst -y kodi

# --- System Tools ---
# ---- CCleaner ----
cinst -y ccleaner
cinst -y ccenhancer
# ---- Fiddler 4 ----
cinst -y fiddler4
# ---- Cygwin -----
cinst -y cygwin
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y mingw
cinst -y xming
if (Test-PendingReboot) { Invoke-Reboot }
##cinst -y freesshd
cinst -y putty
cinst -y winscp
cinst -y rsync
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y sudo
cinst -y nano
##cinst -y processhacker 
cinst -y setacl
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y curl
cinst -y wget
if (Test-PendingReboot) { Invoke-Reboot }
# --- Communications ---
cinst -y skype

# --- Storage ---
cinst -y dropbox
if (Test-PendingReboot) { Invoke-Reboot }
# --- Virtualisation ---
cinst -y virtualbox
cinst -y virtualbox.extensionpack
cinst -y vagrant
if (Test-PendingReboot) { Invoke-Reboot }
# --- Networking / VPN --- 
cinst -y openvpn
##cinst -y winpcap
##cinst -y wireshark
cinst -y nmap
if (Test-PendingReboot) { Invoke-Reboot }
# --- Password Management ---
cinst -y lastpass

# --- Development ---
# ---- Git ----
##cinst -y git

# ---- Python ----
cinst -y python
cinst -y python2
cinst -y pip

# --- Productivity ---
cinst -y pdfcreator
cinst -y growl
##cinst -y cdburnerxp

# --- Security ---
##cinst -y malwarebytes
##if (Test-PendingReboot) { Invoke-Reboot }
# --- Email ---
cinst -y thunderbird
##
# --- Remote Management Tools ---
cinst -y rsat
cinst -y windowsazure
if (Test-PendingReboot) { Invoke-Reboot }
cinst -y teamviewer
cinst -y ultravnc

# --- Access Runtime 2010 - x86 ---
##cinst -y msaccess2010-redist-x86 
##if (Test-PendingReboot) { Invoke-Reboot }

# -- Install Windows Updates --
Install-WindowsUpdate -AcceptEula
if (Test-PendingReboot) { Invoke-Reboot }

# -- Restore UAC --
Enable-UAC
if (Test-PendingReboot) { Invoke-Reboot }

Write-BoxstarterMessage "Machine is complete!"
} catch {
  Write-ChocolateyFailure 'Boxstarter Error: ' $($_.Exception.Message)
  throw
}
