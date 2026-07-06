#!/usr/bin/env bash
# Rename the zellij tab hosting THIS claude session, by tab id (focus-independent).
# Fixes the glitch where `rename-tab` hit whatever tab was focused.
# $1 = optional state icon suffix (e.g. ⏳ / ❓); empty = idle (no icon).
[ -n "$ZELLIJ" ] || exit 0

# Find the tab id (0-based) of the tab whose pane runs `claude`, within this session.
tid=$(zellij action dump-layout 2>/dev/null \
  | awk '/^[[:space:]]*tab /{i++} /command="claude"/{print i-1; exit}')
[ -n "$tid" ] || exit 0

name="$(basename "$PWD"): claude"
[ -n "$1" ] && name="$1 $name"

zellij action rename-tab --tab-id "$tid" "$name" 2>/dev/null
exit 0
