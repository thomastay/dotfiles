#Requires -RunAsAdministrator
function promptYesNo ($title, $question) {
  $choices = '&Yes', '&No'
  $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
  $decision -eq 0
}

function Convert-GithubVersion($githubVersionString) {
  [System.Version]$githubVersionString.Substring(1)
}

function Test-IsAdmin {
  try {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
    return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
  }
  catch {
    throw "Failed to determine if the current user has elevated privileges. The error was: '{0}'." -f $_
  }

  <#
    .SYNOPSIS
        Checks if the current Powershell instance is running with elevated privileges or not.
    .EXAMPLE
        PS C:\> Test-IsAdmin
    .OUTPUTS
        System.Boolean
            True if the current Powershell is elevated, false if not.
  #>
}

#### ------------------ Main Function -------------------------
# Constants, change if needed
$keepassRPCLocation = "C:/Program Files (x86)/KeePass Password Safe 2/Plugins/"
$downloadFolder = "~/Downloads/"
$filename = "KeePassRPC.plgx"
$versionFileName = "keepassRPC-version.txt"
$keepassRPCGithubURL = "https://api.github.com/repos/kee-org/keepassrpc/releases"
# Check running as admin
if (!(Test-IsAdmin)) {
  Write-Host "Oops! Please run this script as administrator."
  return
}
# Check for closure of KeePass
if (!(promptYesNo("Keepass Closure Confirmation", "Have you closed KeePass?"))) {
  Write-Host "Please close KeePass and try again."
  Read-Host -Prompt "Press Enter to exit..."
  return
}
# Access the Github API
$resp = Invoke-RestMethod -Uri $keepassRPCGithubURL
# Check for a version bump
$version = Convert-GithubVersion($resp[0].tag_name)
$oldVersion = [System.Version](Get-Content ($downloadFolder + $versionFileName))
if ($version -le $oldVersion) {
  Write-Host "Current version is $oldVersion, no need to update"
  Read-Host -Prompt "Press Enter to exit..."
  return
}
# Download the latest file to ~/Downloads
Write-Host "Updating $oldVersion --> $version"
Write-Host "--------- Release notes --------"
Write-Host $resp[0].body
Write-Host "--------------------------------"
$url = $resp[0].assets.browser_download_url
Invoke-WebRequest -Uri $url -OutFile ($downloadFolder + $filename)
# Backup the files
Move-Item -Path ($keepassRPCLocation + $filename) -Destination ($keepassRPCLocation + "KeePassRPC(1).plgx") -Force
Copy-Item -Path ($downloadFolder + $filename) -Destination ($keepassRPCLocation + $filename)
# Record the updated version to file
[string]$version | Out-File ($downloadFolder + $versionFileName)
Read-Host -Prompt "Press Enter to exit..."

<#
  .SYNOPSIS
      Updates KeePassRPC, a plugin for KeePass
  .EXAMPLE
      PS C:\> Update-KeePassRPC
#>