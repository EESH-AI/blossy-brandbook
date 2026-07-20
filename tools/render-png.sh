#!/usr/bin/env sh
# ─────────────────────────────────────────────────────────────────────────────
# Re-render every PNG in the kit from its source SVG.
#
#   ./tools/render-png.sh
#
# Uses rsvg-convert. If it isn't installed locally this falls back to running it
# in a throwaway Docker container, so it works on a bare machine.
#
# The text-bearing sheets (palette, specimen) need the brand fonts installed to
# render their labels. In the Docker path the OFL faces in tools/fonts/ (all five,
# including Figtree) are registered automatically.
# ─────────────────────────────────────────────────────────────────────────────
set -eu

HERE=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(dirname "$HERE")

# The render list — one source of truth, run by both paths below.
RENDER_CMDS='
set -e
for v in light dark; do
  rsvg-convert -w 1024 "01_Logo_and_Icon/logo-lockup-$v.svg" -o "01_Logo_and_Icon/logo-lockup-$v@1024.png"
  rsvg-convert -w 512  "01_Logo_and_Icon/logo-lockup-$v.svg" -o "01_Logo_and_Icon/logo-lockup-$v@512.png"
  rsvg-convert -w 256  "01_Logo_and_Icon/icon-$v.svg"        -o "01_Logo_and_Icon/icon-$v@256.png"
  rsvg-convert -w 512  "01_Logo_and_Icon/icon-$v.svg"        -o "01_Logo_and_Icon/icon-$v@512.png"
done
rsvg-convert -w 512  01_Logo_and_Icon/mark.svg -o 01_Logo_and_Icon/mark@512.png
rsvg-convert -w 1024 01_Logo_and_Icon/mark.svg -o 01_Logo_and_Icon/mark@1024.png
rsvg-convert -w 1024 01_Logo_and_Icon/wordmark-blossy-ai.svg -o 01_Logo_and_Icon/wordmark-blossy-ai@1024.png

rsvg-convert -w 512  02_Social/profile-dark-1x1.svg -o 02_Social/profile-dark-1x1@512.png
rsvg-convert -w 1500 02_Social/banner-cover.svg -o 02_Social/banner-cover@1500x500.png

rsvg-convert -w 1200 05_Brand_Elements/gradient-brand.svg -o 05_Brand_Elements/gradient-brand.png
rsvg-convert -w 1200 05_Brand_Elements/gradient-logo.svg  -o 05_Brand_Elements/gradient-logo.png
rsvg-convert -w 1200 05_Brand_Elements/gradient-hero.svg  -o 05_Brand_Elements/gradient-hero.png
rsvg-convert -w 1600 05_Brand_Elements/blob-field.svg     -o 05_Brand_Elements/blob-field.png

rsvg-convert -w 1600 03_Color/palette.svg       -o 03_Color/palette.png
rsvg-convert -w 1400 04_Typography/specimen.svg -o 04_Typography/specimen.png
echo "✓ rendered"
'

# Registers the kit fonts with fontconfig (Docker path only).
FONT_SETUP='
mkdir -p /usr/share/fonts/brand
cp /w/04_Typography/fonts/*.ttf /usr/share/fonts/brand/ 2>/dev/null || true
mkdir -p /tmp/w2
cp /w/tools/fonts/*.woff2 /tmp/w2/ 2>/dev/null || true
cd /tmp/w2 2>/dev/null && for f in *.woff2; do woff2_decompress "$f" >/dev/null 2>&1 || true; done
cp /tmp/w2/*.ttf /usr/share/fonts/brand/ 2>/dev/null || true
fc-cache -f >/dev/null 2>&1
cd /w
'

if command -v rsvg-convert >/dev/null 2>&1; then
  echo "→ using local rsvg-convert"
  cd "$ROOT"
  sh -c "$RENDER_CMDS"
elif command -v docker >/dev/null 2>&1; then
  echo "→ rsvg-convert not found; using Docker"
  docker run --rm -v "$ROOT":/w -w /w alpine:latest sh -c "
    apk add --no-cache rsvg-convert font-dejavu fontconfig woff2 >/dev/null 2>&1
    $FONT_SETUP
    $RENDER_CMDS
  "
else
  echo "need either rsvg-convert or docker" >&2
  exit 1
fi
