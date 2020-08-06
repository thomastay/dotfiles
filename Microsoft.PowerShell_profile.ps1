function replaceHome($pathArray) {
    # Check whether the first three paths are equal to HOME
    # If it is, it substitutes it for ~
    # Change this accordingly, if your home path is more than three 
    # paths long.
    $splitChar = [System.IO.Path]::DirectorySeparatorChar
    if ( ($pathArray.Length -gt 2) -and
        (($pathArray[0..2] -join $splitChar) -eq $HOME)) {
        @("~") + $pathArray[3..$pathArray.Length]
    }
    else {
        $pathArray
    }
}
function fish_prompt {
    $splitChar = [System.IO.Path]::DirectorySeparatorChar
    $currLocation = (Get-Location)
    if ($currLocation.ToString() -eq $HOME) {
        # Special case the home directory
        "~>"
    }
    else {
        $current = Split-Path -Leaf -Path $currLocation
        $parent = Split-Path -Parent -Path $currLocation
        $folders = $parent.Split($splitChar, [System.StringSplitOptions]::RemoveEmptyEntries)
        if ($folders.Length -lt 2) {
            # If the path is 0 or 1, then ignore.
            $currLocation.ToString() + ">"
        }
        else {
            $folders = replaceHome($folders) # optional, to get the ~/Docs effect
            # Replace everything except the first name
            # Note: On line 34, (+) for array concat avoids issue of empty arr
            $firstNameFolders = ForEach ($f in $folders[1..$folders.Length]) { $f[0] }
            $folders = @($folders[0]) + $firstNameFolders + @($current)
            ($folders -join $splitChar) + ">"
        }
    }
}
function prompt {
    fish_prompt
}

# Set-PSReadlineOption -EditMode vi
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
Set-PSReadLineOption -Colors @{ Prediction = '#8b92fc' }

function mkgo ($folderName) {
    mkdir $foldername
    Set-Location $foldername
}

function fortune {
    $fortuneLocation = "C:\Users\z124t\source\repos\fortune\fortune.exe"
    $noofFortunes = 3515 # update this accordingly
    $randNum = (Get-Random -Max $noofFortunes)
    & $fortuneLocation $randNum
}

$scriptPath = "C:/Users/z124t/dotfiles/pwsh_scripts"

function Get-Youtube {
    & ("$scriptPath/Get-Youtube.ps1")
}

function Update-KeepassRPC {
    Start-Process pwsh -ArgumentList "-NoProfile -file $scriptPath/Update-KeePassRPC.ps1" -Verb RunAs
}

######## Aliases ###############
Set-Alias -Name v -Value nvim-qt
Set-Alias -Name ssa -Value ssh-agent

######## Aliases as Functions ###############
function nimc { nim c $args }
function nimrun { nim c -r $args }

# On Startup, do:
fortune
