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

function Get-Youtube {
    [CmdletBinding(SupportsShouldProcess = $True)]
    Param (
        [Parameter(Mandatory = $true)]
        [string]$URL,
        [Switch]$audio,
        [Switch]$ignoreErrors
    )
    $command = $URL, '-o', '%(title)s.%(ext)s'
    if ($audio) {
        $command += "-x", "--postprocessor-args", "`"-threads 2`""
    }
    if ($ignoreErrors) {
        $command += "--ignore-errors"
    }
    Write-Information "Executing Command..."
    Write-Information ("youtube-dl " + ($command -join " "))
    Start-Process -NoNewWindow -Wait -FilePath "youtube-dl" -ArgumentList $command 

    <#
    .SYNOPSIS
    Downloads a file using youtube-dl.

    .DESCRIPTION
    Takes as input a URL, and a switch to download as MP3
    Uses youtube-dl (a Python extension) to download the files

    .PARAMETER URL
    Specifies the URL. Mandatory.

    .PARAMETER audio
    Switch, specifying if the video should be downloaded as an audio file
    Note that this does not necessarily download an mp3 file, it might
    download an .opus file

    .PARAMETER ignoreErrors
    Switch, specifying whether ytdl should Continue on download errors,
    for example to skip unavailable videos in a playlist

    .LINK
    https://github.com/ytdl-org/youtube-dl

    .EXAMPLE
    PS> Get-Youtube -URL https://www.youtube.com/watch?v=yDOtENyOxyA -audio

    .EXAMPLE
    PS> Get-Youtube https://www.youtube.com/playlist?list=PLD6GNPaln5zKG4XKdMCN5YrgkIivJnkYd -ignoreErrors

    .EXAMPLE
    PS> Get-Youtube https://www.youtube.com/watch?v=yDOtENyOxyA -WhatIf
    #>
}

function promptYesNo ($title, $question) {
    $choices = '&Yes', '&No'
    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
    $decision -eq 0
}

function Convert-GithubVersion($githubVersionString) {
    [System.Version]$githubVersionString.Substring(1)
}

function Update-Keepass {
    # Constants, change if needed
    $keepassRPCLocation = "C:/Program Files (x86)/KeePass Password Safe 2/Plugins/"
    $downloadFolder = "~/Downloads/"
    $filename = "KeePassRPC.plgx"
    $versionFileName = "keepassRPC-version.txt"
    $keepassRPCGithubURL = "https://api.github.com/repos/kee-org/keepassrpc/releases"
    # Access the Github API
    $resp = Invoke-RestMethod -Uri $keepassRPCGithubURL
    # Check for a version bump
    $version = Convert-GithubVersion($resp[0].tag_name)
    $oldVersion = Convert-GithubVersion (Get-Content ($downloadFolder + $versionFileName))
    if ($version -le $oldVersion) {
        Write-Host "Current version is $oldVersion, no need to update"
        return
    }
    # Download the latest file to ~/Downloads
    Write-Host "Updating $oldVersion --> $newVersion"
    $url = $resp[0].assets.browser_download_url
    Invoke-WebRequest -Uri $url -OutFile ($downloadFolder + $filename)
    # Backup the files
    if (promptYesNo("Keepass Closure Confirmation", "Have you closed KeePass?")) {
        Move-Item -Path ($keepassRPCLocation + $filename) -Destination ($keepassRPCLocation + "KeePassRPC(1).plgx") -Force
        Copy-Item -Path ($downloadFolder + $filename) -Destination $($keepassRPCLocation + $filename)
        # Record the updated version to file
        $version | Out-File ($downloadFolder + $versionFileName)
    }
}

######## Aliases ###############
Set-Alias -Name v -Value nvim-qt
Set-Alias -Name ssa -Value ssh-agent

######## Aliases as Functions ###############
function nimc { nim c $args }
function nimrun { nim c -r $args }

# On Startup, do:
fortune
