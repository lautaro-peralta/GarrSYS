#!/bin/bash
# Script para cargar datos de prueba en la base de datos

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🔄 Cargando datos de prueba..."
echo ""

cd "$ROOT_DIR/apps/backend"
node scripts/seed-test-data.mjs

echo ""
echo "✅ Proceso completado!"
