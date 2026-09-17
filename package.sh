#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_DIR="$ROOT_DIR/themes"
DIST_DIR="$ROOT_DIR/dist"

usage() {
    echo "Uso: $0 <nombre-del-tema|--all>"
    echo ""
    echo "Temas disponibles en themes/:"
    for d in "$THEMES_DIR"/*/; do
        if [ -d "$d" ]; then
            echo "  - $(basename "$d")"
        fi
    done
    exit 1
}

package_theme() {
    local theme_name="$1"
    local theme_path="$THEMES_DIR/$theme_name"

    if [ ! -d "$theme_path" ]; then
        echo "Error: No se encontró el tema '$theme_name' en $THEMES_DIR" >&2
        return 1
    fi

    local manifest="$theme_path/manifest.json"
    if [ ! -f "$manifest" ]; then
        echo "Error: '$theme_name' no contiene manifest.json" >&2
        return 1
    fi

    # Validar JSON
    if ! python3 -m json.tool "$manifest" > /dev/null 2>&1; then
        echo "Error: $manifest contiene JSON inválido" >&2
        return 1
    fi

    mkdir -p "$DIST_DIR"
    local output_file="$DIST_DIR/${theme_name}.xpi"

    # Eliminar xpi anterior si existe
    rm -f "$output_file"

    # Empaquetar el contenido del directorio del tema en la raíz del zip
    (
        cd "$theme_path"
        zip -q -r -FS "$output_file" . -x ".*" -x "*.bak" -x "*~"
    )

    echo "✓ Empaquetado exitoso: dist/${theme_name}.xpi"
    echo "  Contenido:"
    unzip -l "$output_file" | sed 's/^/    /'
    echo ""
}

if [ $# -eq 0 ]; then
    usage
fi

if [ "$1" = "--all" ]; then
    mkdir -p "$DIST_DIR"
    for d in "$THEMES_DIR"/*/; do
        if [ -d "$d" ]; then
            theme=$(basename "$d")
            package_theme "$theme"
        fi
    done
else
    package_theme "$1"
fi
