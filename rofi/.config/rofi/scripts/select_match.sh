#!/bin/bash
dir="$HOME/.config/rofi/"
sdir="$HOME/.local/state/soccer"
match_file="${sdir}/match"
data_file="/tmp/espn_fetch_ger2"

mkdir -p ${sdir}
[ ! -f "$match_file" ] && touch $match_file

if [ ! -f "$data_file" ] || [ ! -s "$data_file" ]; then
	wget -qO- http://site.api.espn.com/apis/site/v2/sports/soccer/ger.2/scoreboard > $data_file
fi

match_names=""
declare -A match_ids
while read -r row; do
    name=$(echo "$row" | jq -r '.name')
    id=$(echo "$row" | jq -r '.id')
	match_names+="\n"${name}
	match_ids["${name}"]=${id}
done < <(cat $data_file | jq -c '.events[]')

match_names="${match_names#'\n'}"

sel="$(echo -e $match_names | rofi -dmenu -theme "$dir/styles/audio_out_dialog.rasi")"

echo ${match_ids["${sel}"]} > $match_file
