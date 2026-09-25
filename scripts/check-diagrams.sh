#!/usr/bin/env bash
# Check protocol diagrams against the rules in AGENTS.md:
#   - Markdown files contain no Mermaid blocks.
#   - Every SVG is well-formed XML whose root element has a viewBox, a
#     <title>, and a <desc>.
#   - SVG files contain no scripts, embedded HTML, or external resources.
# Runs on tracked and untracked files so local runs match CI.
set -u
cd "$(git rev-parse --show-toplevel)" || exit 2
command -v xmllint >/dev/null || { echo "xmllint not found (install libxml2-utils)"; exit 2; }

status=0
fail() { echo "FAIL $1: $2"; status=1; }

# 1. No Mermaid blocks in Markdown (``` or ~~~ fences of any length).
git grep -n -I -E --untracked '^[[:space:]]*(`{3,}|~{3,})[[:space:]]*mermaid' -- '*.md' ':!node_modules'
case $? in
  0) fail "Markdown" "Mermaid blocks are not allowed; use a self-contained SVG image (see AGENTS.md)" ;;
  1) ;;
  *) fail "Markdown" "git grep failed" ;;
esac

# 2. SVG structure and self-containment.
svg_root() { xmllint --nonet --xpath "boolean(/*[local-name()='svg']$2)" "$1" 2>/dev/null; }
count=0
while IFS= read -r svg; do
  count=$((count + 1))
  before=$status
  err=$(xmllint --nonet --noout "$svg" 2>&1 >/dev/null | head -n 1)
  if [ -n "$err" ]; then
    fail "$svg" "not well-formed XML: $err"; continue
  fi
  [ "$(svg_root "$svg" '/@viewBox')" = true ]                || fail "$svg" "root <svg> lacks a viewBox attribute"
  [ "$(svg_root "$svg" "/*[local-name()='title']")" = true ] || fail "$svg" "root <svg> lacks a <title> element"
  [ "$(svg_root "$svg" "/*[local-name()='desc']")" = true ]  || fail "$svg" "root <svg> lacks a <desc> element"
  grep -qiE '<script|<foreignObject|@import|@font-face' "$svg" \
    && fail "$svg" "contains a script, embedded HTML, or external font"
  # Any href or src that is not a fragment or data URI points outside the file.
  grep -oiE '(href|src)[[:space:]]*=[[:space:]]*["'"'"'][^"'"'"']*' "$svg" \
    | grep -qviE '=[[:space:]]*["'"'"'](#|data:)' && fail "$svg" "references an external resource"
  grep -qiE 'url\([[:space:]]*["'"'"']?[^)]*//' "$svg" && fail "$svg" "references an external resource in CSS"
  [ "$status" = "$before" ] && echo "ok   $svg"
done < <(git ls-files --cached --others --exclude-standard ':(icase)*.svg')

echo "Checked $count SVG file(s)."
exit $status
