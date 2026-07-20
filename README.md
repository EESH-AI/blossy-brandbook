<div align="center">

<img src="01_Logo_and_Icon/logo-lockup-light@512.png" alt="Blossy" width="320">

# Blossy Brand Kit

**Logos, colours, typography and brand elements for blossy.ai.**
One warm theme: cream paper, terracotta accent, editorial serif, liquid glass.

</div>

---

## Contents

| Folder | What's inside |
|---|---|
| [`01_Logo_and_Icon/`](01_Logo_and_Icon) | The lockup, mark, icon and wordmark — SVG + PNG, light & dark |
| [`02_Social/`](02_Social) | Profile images, banner cover |
| [`03_Color/`](03_Color) | The palette — CSS / SCSS / JSON tokens + a swatch sheet |
| [`04_Typography/`](04_Typography) | The five typefaces, specimen sheet, licensing |
| [`05_Brand_Elements/`](05_Brand_Elements) | Gradients, blob field |
| [`06_Brandbook/`](06_Brandbook) | The full interactive brandbook (open `index.html`) |
| [`tools/`](tools) | Scripts to re-render assets and build the brandbook |

**Start here:** open [`06_Brandbook/index.html`](06_Brandbook/index.html) in a browser — it's the whole system on one page, self-contained.

---

## The brand in 30 seconds

|  | |
|---|---|
| **Accent** | Terracotta `#E96A2E` — the *one* accent. Use it for the single lead action; don't stamp it on everything. |
| **Ground** | Cream paper `#faf5ed` (product) / `#FAF4EC` (landing) |
| **Ink** | `#1A1A1A` headings · `#5A5550` running text |
| **Display** | Playfair Display — weight **400 only**, tracked −0.02em |
| **Body** | Figtree (landing/auth) · Geist (product UI) |
| **Mark** | Six-petal blossom, coral→magenta `#FF9A6B → #F2497E` |
| **Material** | Liquid glass — translucent white panes over a static pastel blob field |

> **The mark lives in a pinker world than the UI.** The logo gradient
> (`#FF9A6B → #F2497E`) is warmer and more saturated than the terracotta
> accent. That's deliberate — keep them separate. Logo colours are for
> identity only, never for UI chrome.

---

## Logo

| Asset | Use it for |
|---|---|
| `logo-lockup-light` | Default. Mark + wordmark on light/cream grounds. |
| `logo-lockup-dark` | Dark or coloured grounds — wordmark goes white, petals switch to normal blend. |
| `mark` | The blossom alone, where the wordmark won't fit. |
| `icon-light` / `icon-dark` | Favicon / app icon (mark + centre dot). |
| `wordmark-blossy-ai` | The `blossy.ai` watermark lockup. |

Every SVG has its **wordmark outlined as paths**, so it renders correctly
without Outfit installed. PNGs are provided at `@512` / `@1024`.

### Rules

- **Do** keep clear space around the lockup of at least the height of one petal.
- **Do** use `-dark` on any ground darker than the peach `#F5C9A8`.
- **Don't** recolour the petals, rotate the mark, or re-set the wordmark in another face.
- **Don't** put the light lockup on a mid-tone or busy photo — use `-dark`.
- **Don't** stretch: the lockup is a fixed 430 × 150 (≈2.87 : 1).

---

## Colour

Tokens are provided in three formats — pick whichever your stack wants:

```
03_Color/blossy-colors.css     CSS custom properties  (--blossy-orange)
03_Color/_blossy-colors.scss   SCSS variables         ($blossy-orange)
03_Color/blossy-colors.json    Design tokens (JSON)
03_Color/palette.png|svg       Visual swatch sheet
```

```css
@import "03_Color/blossy-colors.css";

.cta { background: var(--blossy-orange); color: var(--blossy-cream); }
```

The palette is grouped as **brand accent** · **logo/identity** · **surfaces** ·
**borders** · **text** · **landing pastels** · **status** · **atmosphere**.

Two things worth knowing:

- **Shadows are warm, never grey** — `rgba(80, 50, 25, α)`. A grey shadow
  greys the cream and the whole thing goes muddy.
- **Status colours** each come as four shades: `base` (text), `strong`
  (bold text / hover), `surface` (banner fill), `line` (border).

---

## Typography

| Face | Role | Licence |
|---|---|---|
| **Playfair Display** | Display — all headings, weight 400 only | SIL OFL |
| **Figtree** | Body — landing + auth | SIL OFL |
| **Geist** | Body — the product UI | SIL OFL |
| **Geist Mono** | Kickers, labels, tabular data | SIL OFL |
| **Outfit** | The wordmark, and nothing else | SIL OFL |

All five faces are SIL OFL — free for commercial use, including self-hosted
webfonts. See [`04_Typography/README.md`](04_Typography/README.md) for the weight
ladder and type scale.

---

## Licence

Brand assets © Blossy. See [`LICENSE.md`](LICENSE.md).

The **Blossy logo, wordmark and mark are trademarks** — the permission to copy
this kit is not permission to use the marks as your own.
