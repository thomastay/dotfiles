# Defined in /tmp/fish.9jK7Fs/download-github.fish @ line 2
function download-github --description 'Downloads a repo from github'
    set repoPart (url-parser --part=path $argv[1] | awk -F'/' '{print $2 "/" $3}')
    set tmpFileName (mktemp)
    curl -H "Accept: application/vnd.github.v3+json" -L -o $tmpFileName "https://api.github.com/repos/$repoPart/tarball"
    tar -xzvf $tmpFileName
end
