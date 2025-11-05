# #!/usr/bin/env bash
# set -euo pipefail
#
# KSD="/usr/bin/kscreen-doctor"
# OUTPUT="eDP-1"    # <-- change to your exact output (e.g. HDMI-A-1, DP-1, etc.)
#
# # Grab only the block for the chosen output, then extract the rotation word
# ROT="$("$KSD" -o | awk -v o="$OUTPUT" '
#   $1=="Output" && $2==o {inblk=1}
#   $1=="Output" && $2!=o {inblk=0}
#   inblk && /rotation/ {
#     for(i=1;i<=NF;i++) if(tolower($i)=="rotation") {print tolower($(i+1)); exit}
#   }'
# )"
#
# # Fallback if parsing fails
# ROT="${ROT:-normal}"
#
# # Some systems use "none" for 0°
# if [[ "$ROT" == "normal" || "$ROT" == "none" ]]; then
#   exec "$KSD" output."$OUTPUT".rotation.right
# else
#   exec "$KSD" output."$OUTPUT".rotation.normal
# fi
#
