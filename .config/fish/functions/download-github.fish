function download-github
set repoPart (url-parser --part=path $argv[1] | awk -F'/' '{print $2 "/" $3}')
set tmpFileName (mktemp)
curl -H "Accept: application/vnd.github.v3+json" -L -o tmpFileName "https://api.github.com/repos/$repoPart/tarball"
tar -xzvf tmpFileName
end
