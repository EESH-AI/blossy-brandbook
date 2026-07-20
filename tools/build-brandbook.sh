#!/usr/bin/env sh
# ─────────────────────────────────────────────────────────────────────────────
# Build 06_Brandbook/index.html from tools/brandbook.template.html.
#
# Embeds all five brand faces — Playfair Display, Figtree, Geist, Geist Mono,
# Outfit — as base64 data URIs. Every face is SIL OFL (freely redistributable),
# so the output is self-contained and safe to host publicly.
#
#   ./tools/build-brandbook.sh
# ─────────────────────────────────────────────────────────────────────────────
set -eu

HERE=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(dirname "$HERE")
TEMPLATE="$HERE/brandbook.template.html"
OUT="$ROOT/06_Brandbook/index.html"
OFL_DIR="$HERE/fonts"

for arg in "$@"; do
  case "$arg" in
    -h|--help) sed -n '2,11p' "$0"; exit 0 ;;
    *) echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

[ -f "$TEMPLATE" ] || { echo "missing template: $TEMPLATE" >&2; exit 1; }
command -v base64 >/dev/null 2>&1 || { echo "base64 not found" >&2; exit 1; }

TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
FF="$TMP/fontfaces.css"; : > "$FF"

# b64 <file> — base64 with no line wrapping (GNU vs BSD)
b64() { base64 -w0 "$1" 2>/dev/null || base64 "$1" | tr -d '\n'; }

face_woff2() { # family, style, weight, file
  printf '@font-face{font-family:"%s";font-style:%s;font-weight:%s;font-display:swap;src:url(data:font/woff2;base64,' "$1" "$2" "$3" >> "$FF"
  b64 "$4" >> "$FF"
  printf ') format("woff2")}\n' >> "$FF"
}

echo "→ embedding OFL faces"
face_woff2 "Playfair Display" normal "400 900" "$OFL_DIR/playfair-roman.woff2"
face_woff2 "Playfair Display" italic "400 900" "$OFL_DIR/playfair-italic.woff2"
face_woff2 "Outfit"           normal "500 700" "$OFL_DIR/outfit.woff2"
face_woff2 "Geist"            normal "100 900" "$OFL_DIR/geist.woff2"
face_woff2 "Geist Mono"       normal "100 900" "$OFL_DIR/geistmono.woff2"
face_woff2 "Figtree"          normal "300 900" "$OFL_DIR/figtree.woff2"

# 1. Inject the @font-face block into the template.
awk -v ff="$FF" '
  BEGIN { while ((getline line < ff) > 0) f = f line "\n" }
  { gsub(/\/\*__FONTS__\*\//, f); print }
' "$TEMPLATE" > "$TMP/page.html"

if grep -q '__FONTS__' "$TMP/page.html"; then
  echo "! font marker not replaced — build failed" >&2; exit 1
fi

# 2. Wrap the fragment in a real HTML document.
#
# The template is a FRAGMENT (it opens at <title>/<style>) because the Artifact
# host supplies its own <head>. A standalone file gets no such wrapper, so
# without an explicit <meta charset="utf-8"> browsers fall back to windows-1252
# and every em-dash renders as "â€”". Split at the first </style>:
# <title>+<style> belong in <head>, everything after it in <body>.
echo "→ wrapping as a standalone HTML document (doctype + utf-8)"
FAVICON=$(b64 "$ROOT/01_Logo_and_Icon/icon-light.svg")
{
  cat <<HTML_HEAD
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="color-scheme" content="light dark">
<meta name="description" content="Blossy brand system — logo, colour, typography and surfaces.">
<link rel="icon" type="image/svg+xml" href="data:image/svg+xml;base64,${FAVICON}">
HTML_HEAD
  awk '{ print } /<\/style>/ { exit }' "$TMP/page.html"
  printf '</head>\n<body>\n'
  awk 'p { print } /<\/style>/ && !p { p = 1 }' "$TMP/page.html"
  printf '</body>\n</html>\n'
} > "$OUT"

# 3. Verify the wrapper landed and the result is valid UTF-8.
for probe in '<!doctype html>' '<meta charset="utf-8">' '</body>' '</html>'; do
  grep -qF "$probe" "$OUT" || { echo "! wrapper incomplete, missing: $probe" >&2; exit 1; }
done
if command -v python3 >/dev/null 2>&1; then
  python3 -c "import io,sys; io.open(sys.argv[1],encoding='utf-8').read()" "$OUT" 2>/dev/null \
    || { echo "! output is not valid UTF-8" >&2; exit 1; }
fi

echo "✓ built $OUT ($(wc -c < "$OUT") bytes, $(grep -c '@font-face' "$OUT") faces)"
exit 0
