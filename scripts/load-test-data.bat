@echo off
REM Script para cargar datos de prueba en la base de datos

echo Cargando datos de prueba...
echo.

cd /d "%~dp0..\apps\backend"
node scripts/seed-test-data.mjs

echo.
echo Proceso completado!
pause
