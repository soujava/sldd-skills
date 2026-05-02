#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$REPO_ROOT/skills"
TARGET_DIR="$HOME/.agents/skills"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: skills source directory not found: $SOURCE_DIR" >&2
  echo "Place this script in the repository root before running it." >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"

echo
echo "SLDD skills development install"
echo "Source: $SOURCE_DIR"
echo "Target: $TARGET_DIR"
echo

echo "Cleaning previous SLDD entries"

removed_links=0
removed_dirs=0
skipped_files=0

for entry in "$TARGET_DIR"/sldd-*; do
  [ -e "$entry" ] || [ -L "$entry" ] || continue

  entry_name="$(basename "$entry")"

  if [ -L "$entry" ]; then
    echo "  remove symlink  $entry_name"
    rm "$entry"
    removed_links=$((removed_links + 1))
  elif [ -d "$entry" ]; then
    echo "  remove dir      $entry_name"
    rm -rf "$entry"
    removed_dirs=$((removed_dirs + 1))
  else
    echo "  skip file       $entry_name"
    skipped_files=$((skipped_files + 1))
  fi
done

if [ "$removed_links" -eq 0 ] && [ "$removed_dirs" -eq 0 ] && [ "$skipped_files" -eq 0 ]; then
  echo "  none"
fi

echo
echo "Creating symbolic links"

created=0

for skill_dir in "$SOURCE_DIR"/sldd-*; do
  [ -d "$skill_dir" ] || continue

  skill_name="$(basename "$skill_dir")"
  target_link="$TARGET_DIR/$skill_name"

  ln -s "$skill_dir" "$target_link"
  echo "  link            $skill_name"

  created=$((created + 1))
done

echo
echo "Summary"
echo "  symlinks removed:   $removed_links"
echo "  directories removed: $removed_dirs"
echo "  files skipped:       $skipped_files"
echo "  links created:       $created"
echo
echo "Done."
