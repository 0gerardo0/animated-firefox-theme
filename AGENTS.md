# AGENTS.md

## What this is

Repository for animated Firefox themes (Manifest V3) with looping APNG frames. Each theme is self-contained under the `themes/` directory.

## Structure

```
animated-firefox-theme/
├── themes/
│   ├── pixelcat/              # Active/published theme ("animated|catbutterflywindby0gerardo0")
│   │   ├── manifest.json      # Extension manifest (gecko.id: pixelcat-theme@gerardo0)
│   │   ├── loop-final-b.png   # Animated APNG theme frame
│   │   └── icon.svg           # Theme icon
│   └── <new-theme>/           # Additional themes follow the same structure
│       ├── manifest.json
│       ├── <frame>.png
│       └── icon.svg
├── images/                    # Design source files (XCF, intermediate PNGs, gitignored)
├── dist/                      # Output directory for generated .xpi packages (gitignored)
├── package.sh                 # Packaging script for AMO
├── README.md
└── .gitignore
```

## Adding a New Theme

1. Create a new folder under `themes/<new-theme-name>/`.
2. Add:
   - `manifest.json`: Set a unique `name`, `version`, `browser_specific_settings.gecko.id`, theme `colors`, and relative path to `theme_frame`.
   - Animated APNG image (referenced in `manifest.json` under `theme.images.theme_frame`).
   - Icon (e.g. `icon.svg` or `icon.png`).
3. Validate that `manifest.json` is valid JSON.

## Packaging for AMO

Run the packaging script to generate `.xpi` files in `dist/`:

```bash
# Package a single theme
./package.sh <theme-name>

# Package all themes
./package.sh --all
```

## Testing Locally

1. Open `about:debugging` in Firefox.
2. Click "This Firefox" → "Load Temporary Add-on...".
3. Select `themes/<theme-name>/manifest.json`.
4. The theme applies immediately.

## Gotchas

- Each theme folder must be self-contained: relative paths in `manifest.json` resolve from that theme's folder.
- Each published theme on AMO must have its own unique `browser_specific_settings.gecko.id`.
- `.xpi` files in `dist/` are zip archives and are gitignored. Do not commit them.
- Source `.xcf` / work images in `images/` are gitignored. Do not commit them.
