#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SKILL="$REPO_ROOT/skills/sldd"
DEFAULT_TARGET_DIR="$HOME/.agents/skills"
TARGET_DIR="$DEFAULT_TARGET_DIR"

usage() {
  cat <<EOF
Usage: $(basename "$0") [--target DIR] [--help]

Install the local SLDD skill as a symbolic link.

Options:
  --target DIR  Destination skills directory. Default: $DEFAULT_TARGET_DIR
  --help        Show this help message.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --target)
      if [ "$#" -lt 2 ] || [ -z "${2:-}" ] || [ "${2#-}" != "$2" ]; then
        echo "Error: --target requires a directory path." >&2
        echo >&2
        usage >&2
        exit 2
      fi
      TARGET_DIR="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Error: unknown option or argument: $1" >&2
      echo >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [ ! -d "$SOURCE_SKILL" ]; then
  echo "Error: SLDD skill source directory not found: $SOURCE_SKILL" >&2
  echo "Place this script in the repository root before running it." >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"

echo
echo "SLDD skills development install"
echo "Source: $SOURCE_SKILL"
echo "Target: $TARGET_DIR"
echo

echo "Cleaning previous SLDD entries"

removed_links=0
removed_dirs=0
skipped_files=0

for entry in "$TARGET_DIR"/sldd "$TARGET_DIR"/sldd-*; do
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

target_link="$TARGET_DIR/sldd"
ln -s "$SOURCE_SKILL" "$target_link"
echo "  link            sldd"
created=1

echo
echo "Summary"
echo "  symlinks removed:   $removed_links"
echo "  directories removed: $removed_dirs"
echo "  files skipped:       $skipped_files"
echo "  links created:       $created"
echo
echo "Done."
