#!/usr/bin/env bash
set -u

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root" || exit 1
fail=0

required=(
  README.md
  AGENTS.md
  CHANGELOG.md
  LICENSE
  guia/01-modelo-hibrido.md
  guia/02-fase-cero.md
  guia/03-porciones.md
  guia/04-verificacion.md
  guia/05-refactor.md
  guia/06-contexto.md
  guia/07-delegacion.md
  guia/08-antipatrones.md
  guia/09-herramientas.md
  guia/10-sistemas-no-deterministas.md
  guia/11-riesgos-no-funcionales.md
  ejemplo/caso-bot-gastos.md
  ejemplo/caso-asistente-soporte.md
  plantillas/brief-porcion.md
  plantillas/plan.md
  plantillas/decisiones.md
  plantillas/AGENTS.md
  plantillas/objetivos-proyecto.md
  plantillas/especificaciones-proyecto.md
  scripts/check-links.sh
  .github/workflows/docs-check.yml
)

echo "== Archivos obligatorios =="
for f in "${required[@]}"; do
  if [ ! -f "$f" ]; then
    echo "FALTA archivo obligatorio: $f"
    fail=1
  fi
done

echo "== Encabezados H1 =="
mapfile -t docs < <(find . -name "*.md" -not -path "./.git/*" | sort)
for d in "${docs[@]}"; do
  h1=$(grep -c "^# " "$d")
  if [ "$h1" -ne 1 ]; then
    echo "$d: $h1 encabezados H1 (se espera 1)"
    fail=1
  fi
done

echo "== Enlaces relativos =="
for d in "${docs[@]}"; do
  dir=$(dirname "$d")
  links=$(grep -o "]([^)]*)" "$d" | sed "s/^](//; s/)$//")
  while IFS= read -r link; do
    [ -z "$link" ] && continue
    case "$link" in
      http*|mailto:*|"#"*) continue ;;
    esac
    target="${link%%#*}"
    [ -z "$target" ] && continue
    case "$target" in
      /*)
        echo "$d: ruta absoluta -> $link"
        fail=1
        continue
        ;;
    esac
    if [ ! -e "$dir/$target" ]; then
      echo "$d: enlace roto -> $link"
      fail=1
    fi
  done <<< "$links"
done

if [ "$fail" -ne 0 ]; then
  echo "Verificación: FALLA"
  exit 1
fi

echo "Verificación: OK"
