#!/usr/bin/env bash

COLOR=$(grabc)

[ -z "$COLOR" ] && exit 1

echo -n "$COLOR" | xclip -selection clipboard
