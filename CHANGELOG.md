# Changelog

All notable changes to the Blossy Brand Kit.

## [1.0.0] — 2026-07-20

First release. Compiled from the blossy.ai app source, so every value is the
one actually shipping.

### Added

- **Logo & icon** — lockup (light/dark), blossom mark, favicon icons (light/dark),
  `blossy.ai` watermark. SVG + PNG at `@512`/`@1024`. Wordmarks are outlined as
  paths, so no font is needed to render them.
- **Social** — dark 1:1 profile image, 1500×500 banner cover.
- **Colour** — the full palette as CSS custom properties, SCSS variables and
  JSON design tokens, plus a rendered swatch sheet. Grouped: brand accent,
  logo/identity, surfaces, borders, text, landing pastels, status, atmosphere.
- **Typography** — specimen sheet for all five faces, weight ladder, type scale.
- **Brand elements** — brand/logo/hero gradients and the ambient blob field.
- **Brandbook** — a self-contained interactive `index.html` covering the whole
  system, with click-to-copy swatches and live glass surfaces.
- **Tools** — `build-brandbook.sh` (rebuild the brandbook) and `render-png.sh`
  (regenerate every PNG from SVG, via local rsvg-convert or Docker).

### Notes

- **Fonts.** All five faces (Playfair Display, Figtree, Geist, Geist Mono,
  Outfit) are SIL OFL. They're embedded in the brandbook and mirrored in
  `tools/fonts/` for rebuilds. See `04_Typography/README.md`.
- The kit covers the **product brand only**.
