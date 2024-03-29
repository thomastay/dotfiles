# exports
# These are universal exports, shouldn't need to re-do
# set -xU BROWSER firefox
# set -xU SHELL /usr/bin/fish

set -g fish_key_bindings fish_vi_key_bindings


# Functions

## Fish-specific functions

function fish_greeting 
    set h (date "+%H")
    if test $h -lt 12;
        echo "Top o' the morning to ya, $USER!"
    else if test $h -lt 18;
        echo "Afternoon, $USER!"
    else;
        echo "Evening, gentlemen"
    end
    fortune -a | cowsay -f (ls /usr/share/cowsay/cows/ | shuf -n1)
end

## User functions - Aliases
## As below, functions are in ~/.config/fish/functions

# Abbreviations (for non defaults)
abbr v nvim
abbr g git
abbr pip "pip3"
abbr sv "sudoedit"
abbr vim-all 'vim (find . -maxdepth 1 -type f)'
abbr find-here 'find . -maxdepth 1 -name'
abbr find-all 'find . -name'
abbr ssa "ssh-add"
abbr size "du -hd 1 --exclude './.*' | sort -hr"
abbr fosl 'fossil'
abbr lua "lua5.3"
abbr nimc "nim c"
abbr nimrun "nim c -r"
abbr mpv-ytdl-bth "mpv --audio-device='pulse/alsa_output.usb-0b0e_Jabra_Link_370_745C4BA6557C011200-00.analog-stereo' --ytdl-raw-options=write-sub=,write-auto-sub=,sub-lang=en"
abbr mpv-ytdl "mpv --audio-device='pulse/alsa_output.usb-0b0e_Jabra_Link_370_745C4BA6557C011200-00.analog-stereo' --ytdl-raw-options=write-sub=,write-auto-sub=,sub-lang=en"

### setup emdsk
abbr emsdksetup "python3 ~/external/emsdk/emsdk.py configure_env &> /dev/null"
