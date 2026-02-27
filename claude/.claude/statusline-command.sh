#!/usr/bin/env bash
# Claude Code status line - mirrors starship prompt style

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten home directory to ~
home="$HOME"
short_cwd="${cwd/#$home/\~}"

# Build cwd segment
cwd_segment=$(printf '\033[34m%s\033[0m' "$short_cwd")

# Build git branch segment (only shown inside a git repo)
git_segment=""
git_branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
if [ -n "$git_branch" ]; then
    git_segment=$(printf '\033[33m \ue0a0 %s\033[0m' "$git_branch")
fi

# Build kube context segment (only shown when kubectl is available and returns a context)
kube_segment=""
if command -v kubectl >/dev/null 2>&1; then
    kube_ctx=$(kubectl config current-context 2>/dev/null)
    if [ -n "$kube_ctx" ]; then
        kube_ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
        [ -z "$kube_ns" ] && kube_ns="default"
        kube_segment=$(printf '\033[35m(%s:%s)\033[0m' "$kube_ctx" "$kube_ns")
    fi
fi

# Build model segment
model_segment=$(printf '\033[36m[%s]\033[0m' "$model")

# Build context usage segment (only shown if data is available)
context_segment=""
if [ -n "$used_pct" ]; then
    # Color the context bar: green < 70%, yellow < 85%, red >= 85%
    used_int=${used_pct%.*}
    if [ "$used_int" -ge 85 ] 2>/dev/null; then
        ctx_color='\033[31m'
    elif [ "$used_int" -ge 70 ] 2>/dev/null; then
        ctx_color='\033[33m'
    else
        ctx_color='\033[32m'
    fi
    # Build a 10-char Unicode block progress bar
    bar_width=10
    filled=$(( (used_int * bar_width + 99) / 100 ))
    [ "$filled" -gt "$bar_width" ] && filled=$bar_width
    empty=$(( bar_width - filled ))
    filled_bar=""
    empty_bar=""
    for i in $(seq 1 "$filled"); do filled_bar="${filled_bar}▓"; done
    for i in $(seq 1 "$empty");  do empty_bar="${empty_bar}░";  done
    context_segment=$(printf " ${ctx_color}${filled_bar}\033[0m${empty_bar} ${used_int}%%")
fi

# Assemble the line, inserting optional segments only when non-empty
line="$cwd_segment"
[ -n "$git_segment" ]  && line="$line  $git_segment"
[ -n "$kube_segment" ] && line="$line  $kube_segment"
line="$line  $model_segment"
[ -n "$context_segment" ] && line="$line$context_segment"

printf '%s\n' "$line"
