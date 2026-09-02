# AGENTS.md

## What this is

Firefox theme extension (manifest v3) with animated APNG frame. No build step, no code — pure assets + `manifest.json`.

## Structure

- **Root `manifest.json`** — active/published version (`pixelcat-theme@gerardo0`). This is the one loaded for debugging and submitted to AMO.
- **`pixelcat-theme/manifest.json`** — older/alternate variant (`pixelcat-theme@gerardo0`). Same gecko.id but different version/name. Do not confuse with root.
- **`loop-final-b.png`** — the animated theme frame referenced by both manifests.
- **`images/`** — design source files (XCF, intermediate PNGs). Most are gitignored; only `images/loop-final.png` is tracked.

## Editing the theme

- To change colors, edit `colors` in root `manifest.json`.
- To swap the animated frame, replace `loop-final-b.png` at root and update `theme_frame` in `manifest.json` if the filename changes.
- Always validate the manifest is valid JSON after edits (Firefox is strict about this).

## Testing locally

1. Open `about:debugging` in Firefox.
2. Click "Load Temporary Add-on" → select root `manifest.json`.
3. Theme applies immediately. No build or compile step.

## Gotchas

- `.xpi` files are built/packaged zip archives, gitignored. Do not commit them.
- `.xcf` files are GIMP source files, gitignored. Do not commit them.
- There is no package.json, no linter, no formatter, no test suite.
- The two `manifest.json` files have different `gecko.id` values — they are distinct addons.
