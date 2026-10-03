#!/usr/bin/env bash

BOOKS_DIR="$HOME/books"

if [ ! -d "$BOOKS_DIR" ]; then
  echo "Error: Directory '$BOOKS_DIR' does not exist." >&2
  exit 1
fi

selected=$(ls "$BOOKS_DIR" | dmenu)

if [ -n "$selected" ]; then
  zathura "$BOOKS_DIR/$selected" >/dev/null 2>&1 &
fi
