#!/usr/bin/env bash

snap list --all | awk '/disabled/{print $1, $3}' | while read name rev; do
	sudo snap remove --purge "$name" --revision="$rev"
done

sudo apt autoremove
