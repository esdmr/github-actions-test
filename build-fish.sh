#!/usr/bin/env bash

if test -f .fish-bin/fish; then
	cd .fish-bin
	chmod +x fish fish_indent

	if test "$FISH_MAJOR" -eq "3"; then
		chmod +x fish_key_reader
	fi

	exit
fi

wget "https://github.com/fish-shell/fish-shell/releases/download/$FISH_TAG/$FISH_FILE" || exit 1
tar xf "$FISH_FILE" || exit 2

if test -d "fish-$FISH_TAG"; then
	echo Directory: "fish-$FISH_TAG"
	cd "fish-$FISH_TAG" || exit 4
elif test -d fish; then
	echo Directory: fish
	cd fish || exit 4
else
	echo Directory not found.
	ls
	exit 4
fi

if test "$FISH_MAJOR" -eq "3"; then
	echo v3 detected

	sudo apt install build-essential cmake ncurses-dev libncurses5-dev libpcre2-dev gettext || exit 5

	mkdir build || exit 6
	cd build || exit 7
	cmake .. || exit 8
	make || exit 9
	mv fish fish_indent fish_key_reader ../../.fish-bin || exit 10
elif test "$FISH_MAJOR" -eq "2"; then
	echo v2 detected

	sudo apt install build-essential ncurses-dev libncurses5-dev gettext autoconf || exit 5

	autoreconf || exit 6
	./configure || exit 7
	make || exit 9
	mv fish fish_indent ../.fish-bin || exit 10
else
	echo Version "$FISH_MAJOR" unknown.
	exit 5
fi
