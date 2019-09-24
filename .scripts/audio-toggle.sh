#!/bin/bash

# Setup the speakers and mics
AUDIO_BIN=pactl
noof_sinks=$(pactl list sinks short | grep -ci running)
if [[ $noof_sinks -eq 0 ]]; then
    internal_speakers=@DEFAULT_SINK@
elif [[ $noof_sinks -eq 1 ]]; then
    internal_speakers=$(pactl list sinks short | grep -i running | cut -f 1)
else
    echo "Too many sinks"
fi

# Process the cli input
if [[ "$1" == "toggleVol" ]]; then
    $AUDIO_BIN set-sink-mute $internal_speakers toggle;
elif [[ "$1" == "lowerVol" ]]; then
    $AUDIO_BIN set-sink-mute $internal_speakers false;
    $AUDIO_BIN set-sink-volume $internal_speakers -5%
elif [[ "$1" == "raiseVol" ]]; then
    $AUDIO_BIN set-sink-mute $internal_speakers false;
    $AUDIO_BIN set-sink-volume $internal_speakers +5%
elif [[ "$1" == "toggleMic" ]]; then
    pactl list sources short | grep -v monitor | cut -f 1 |
        while read internal_mic; do
            $AUDIO_BIN set-source-mute $internal_mic toggle
        done
else
    echo "option not recognized"
fi
