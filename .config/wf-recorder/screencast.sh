#!/bin/bash

config="$HOME/.config/wf-recorder/config"

if [ ! -f "$config" ]; then
    mkdir -p "$(dirname "$config")"
    cat > "$config" << EOF
dir="\$(xdg-user-dir VIDEOS)/Screencasts"

use_mic="true"
video_codec="libx264"
audio_codec="libopus"
EOF
fi

source "$config"

mkdir -p "$dir"

if pgrep -x wf-recorder > /dev/null; then
    pkill -INT wf-recorder
    latest="$(ls -t "$dir"/*.mp4 2>/dev/null | head -n1)"
    response=$(notify-send "Screencast" "Запись остановлена → $latest\n" --action 'default=Open Folder' -t 8000)
    if [ "$response" = "default" ]; then xdg-open "$dir"; fi
else
    filename="$dir/$(date '+%Y-%m-%d_%H-%M-%S').mp4"
    audio_output=""

    if [[ "$use_mic" == "true" ]] then
        audio_output=$(pactl get-default-source)
    else
        audio_output=$(pactl get-default-sink).monitor 
    fi 

    wf-recorder -f "$filename" -c "$video_codec" -C "$audio_codec" --audio="$audio_output" &
    
    sleep 0.5
    if pgrep -x wf-recorder > /dev/null; then
        notify-send "Screencast" "Запись начата\n" -t 3000
    else
        notify-send "Screencast" "Ошибка: не удалось начать запись\n"
        exit 1
    fi
fi
