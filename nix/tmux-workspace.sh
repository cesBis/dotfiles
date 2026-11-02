#!/bin/sh
# One project (including a Git worktree) per tmux session.
set -eu

action=${1:?Expected terminal, opencode, hide, or editor}
source_pane=${2:?Expected a tmux pane ID}
case "$action" in
    terminal|opencode|hide|editor) ;;
    *) printf 'Unknown workspace action: %s\n' "$action" >&2; exit 1 ;;
esac
session=$(tmux display-message -p -t "$source_pane" '#{session_id}')

get_option() {
    tmux show-options -qv -t "$session" "$1"
}

set_option() {
    tmux set-option -t "$session" "$1" "$2"
}

pane_exists() {
    [ -n "$1" ] &&
        [ "$(tmux display-message -p -t "$1" '#{session_id}:#{pane_dead}' 2>/dev/null)" = "$session:0" ]
}

parking_exists() {
    [ -n "$parking" ] &&
        [ "$(tmux display-message -p -t "$parking" '#{session_id}' 2>/dev/null)" = "$session" ] &&
        [ "$parking" != "$editor_window" ]
}

editor=$(get_option @workspace_editor)
if ! pane_exists "$editor"; then
    # Adopt an existing editor before starting another one.
    panes=$(tmux list-panes -s -t "$session" -F '#{pane_id} #{pane_current_command} #{pane_dead}')
    editor=
    while read -r pane command dead; do
        case "$command:$dead" in
            nvim:0|nvim.*:0|nvim-*:0) editor=$pane; break ;;
        esac
    done <<EOF
$panes
EOF
fi

root=$(get_option @workspace_root)
if [ -z "$root" ]; then
    directory=$(tmux display-message -p -t "${editor:-$source_pane}" '#{pane_current_path}')
    root=$(git -C "$directory" rev-parse --show-toplevel 2>/dev/null || printf '%s\n' "$directory")
    set_option @workspace_root "$root"
fi

if ! pane_exists "$editor"; then
    editor=$(tmux new-window -d -P -F '#{pane_id}' -t "$session:" -n editor -c "$root" "exec \"$(command -v nvim)\"")
fi
set_option @workspace_editor "$editor"

opencode=$(get_option @workspace_opencode)
if ! pane_exists "$opencode"; then
    # Adopt a standalone project TUI before creating another one.
    panes=$(tmux list-panes -s -t "$session" -F '#{pane_id} #{pane_current_command} #{pane_dead}')
    opencode=
    while read -r pane command dead; do
        case "$command:$dead" in
            opencode:0|opencode.*:0|opencode-*:0) opencode=$pane; break ;;
        esac
    done <<EOF
$panes
EOF
    set_option @workspace_opencode "$opencode"
fi

editor_window=$(tmux display-message -p -t "$editor" '#{window_id}')
parking=$(get_option @workspace_parking)
terminal=$(get_option @workspace_terminal)

# Reuse a tools window parked by the previous version of this helper.
if ! parking_exists; then
    for companion in "$terminal" "$opencode"; do
        if pane_exists "$companion" &&
            [ "$(tmux display-message -p -t "$companion" '#{window_name}')" = tools ]; then
            parking=$(tmux display-message -p -t "$companion" '#{window_id}')
            if parking_exists; then
                set_option @workspace_parking "$parking"
                break
            fi
        fi
    done
fi

focus_editor() {
    tmux select-window -t "$editor"
    tmux select-pane -t "$editor"
}

create_companion() {
    if parking_exists; then
        tmux split-window -d -P -F '#{pane_id}' -t "$parking" -c "$root" "$1"
    else
        tmux new-window -d -P -F '#{pane_id}' -t "$session:" -n tools -c "$root" "$1"
    fi
}

park_if_visible() {
    if pane_exists "$1" && [ "$1" != "$editor" ] &&
        [ "$(tmux display-message -p -t "$1" '#{window_id}')" = "$editor_window" ]; then
        if parking_exists; then
            tmux join-pane -d -s "$1" -t "$parking"
        else
            parking=$(tmux break-pane -d -P -F '#{window_id}' -s "$1" -n tools)
            set_option @workspace_parking "$parking"
        fi
    fi
}

show_companion() {
    # Leave manually created panes alone; only park managed companions.
    for companion in "$terminal" "$opencode"; do
        if [ "$companion" != "$1" ]; then
            park_if_visible "$companion"
        fi
    done
    # Unzoom before arranging panes; never restart a process to show it.
    if [ "$(tmux display-message -p -t "$editor" '#{window_zoomed_flag}')" = 1 ]; then
        tmux resize-pane -Z -t "$editor"
    fi
    if [ "$(tmux display-message -p -t "$1" '#{window_id}')" != "$editor_window" ]; then
        tmux join-pane -d -h -l 35% -s "$1" -t "$editor"
    fi
    focus_editor
}

case "$action" in
    terminal)
        if ! pane_exists "$terminal"; then
            terminal=$(create_companion "exec \"$(command -v zsh)\"")
            set_option @workspace_terminal "$terminal"
        fi
        show_companion "$terminal"
        ;;
    opencode)
        if ! pane_exists "$opencode"; then
            opencode=$(create_companion "exec \"$(command -v opencode)\"")
            set_option @workspace_opencode "$opencode"
        fi
        show_companion "$opencode"
        tmux select-pane -t "$opencode"
        ;;
    hide)
        park_if_visible "$terminal"
        park_if_visible "$opencode"
        focus_editor
        ;;
    editor)
        focus_editor
        ;;
esac
