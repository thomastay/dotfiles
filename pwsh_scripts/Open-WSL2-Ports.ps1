#Requires -RunAsAdministrator
Param(
  [Switch]$Reset = $false
)
function Test-IsAdmin {
  try {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
    return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator)
  }
  catch {
    throw "Failed to determine if the current user has elevated privileges. The error was: '{0}'." -f $_
  }
}

$ipAddress = (wsl hostname -I).Trim()
$listenAddr = "0.0.0.0"
$ports = 19000, 19001, 9630 # TODO: CHANGE ME!
$ruleName = "WSL 2 Firewall Unlock"

Test-IsAdmin | Out-Null

if ($Reset) {
  netsh int portproxy reset all | Out-Null
  Remove-NetFirewallRule -DisplayName $ruleName | Out-Null
  return
}

New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -LocalPort $ports -Protocol TCP -Action Allow | Out-Null
New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -LocalPort $ports -Protocol TCP -Action Allow | Out-Null
foreach ($port in $ports) {
  Write-Output "Opening port $port"
  netsh interface portproxy add v4tov4 listenaddress=$listenAddr listenport=$port connectaddress=$ipAddress connectport=$port | Out-Null
}
netsh interface portproxy show v4tov4

<#
  .SYNOPSIS
      Opens WSL 2 Ports. Must be run as administrator.
      Optionally takes a Reset flag to reset port rules.
  .EXAMPLE
      PS C:\> Open-WSL2-Ports
#>