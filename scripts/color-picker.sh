#!/usr/bin/env bash

COLOR=$(grabc -hex)

[ -z "$COLOR" ] && exit 1

echo -n "$COLOR" | xclip -selection clipboard
