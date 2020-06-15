function replaceHome($pathArray) {
    # Check whether the first three paths are equal to HOME
    # If it is, it substitutes it for ~
    # Change this accordingly, if your home path is more than three 
    # paths long.
    $splitChar = [System.IO.Path]::DirectorySeparatorChar
    if ( ($pathArray.Length -gt 2) -and
        ([System.String]::Join($splitChar, $pathArray[0..2]) -eq $HOME)) {
        @("~") + $pathArray[3..$pathArray.Length] # plus avoids issue of empty arr
    }
    else {
        $pathArray
    }
}
function fish_prompt {
    $splitChar = [System.IO.Path]::DirectorySeparatorChar
    if ((Get-Location).ToString() -eq $HOME) {
        # Special case the home directory
        "~>"
    }
    else {
        $current = Split-Path -Leaf -Path (Get-Location)
        $parent = Split-Path -Parent -Path (Get-Location)
        $folders = $parent.Split($splitChar, [System.StringSplitOptions]::RemoveEmptyEntries)
        if ($folders.Length -lt 2) {
            # If the path is 0 or 1, then ignore.
            (Get-Location).ToString() + ">"
        }
        else {
            $folders = replaceHome($folders) # optional, to get the ~/Docs effect
            # Replace everything except the first name
            $firstNameFolders = ForEach ($f in $folders[1..$folders.Length]) { $f[0] }
            $folders = @($folders[0]) + $firstNameFolders # plus avoids issue of empty arr
            [System.String]::Join($splitChar, $folders) + $splitChar + $current + ">"
        }
    }
}
function prompt {
    fish_prompt
}

# Set-PSReadlineOption -EditMode vi
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
Set-PSReadLineOption -Colors @{ Prediction = '#8b92fc' }

function phineasferb ($start) {
    mpv --playlist-start=$start 'https://www.youtube.com/playlist?list=PLt7zt2c5Rum0qukFJ73NWmFv-UdLDnYkJ'
}

function mkgo ($folderName) {
    mkdir $foldername
    Set-Location $foldername
}

######## Aliases ###############
Set-Alias -Name v -Value nvim-qt
Set-Alias -Name ssa -Value ssh-agent
