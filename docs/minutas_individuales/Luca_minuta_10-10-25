Proyecto: TGS-Backend
Fecha: 10/10/2025
Responsable: Luca Delprato

Objetivo

Dejar el backend con una infraestructura de testing completa y automatizada alineada a tu plan (unitario, integración, cobertura, performance, seguridad y CI/CD).

Cambios principales

Testing

Instalado y configurado Vitest (unit + integración) con c8 (cobertura ≥80%).

Supertest para pruebas HTTP sobre endpoints.

Separación de TypeScript para tests: tsconfig.spec.json.

vitest.config.ts con setupFiles, cobertura, y paralelismo (pool: 'threads').

Setups:

test/setup-app.ts — fija NODE_ENV='test' antes de importar la app y expone __APP__.

test/setup-db.ts — dropSchema() + createSchema() por test run.

Tests iniciales:

Unitario: test/unit/partner.mapper.spec.ts (DTO de Partner).

Integración: test/integration/partners.http.spec.ts (GET /api/partners).

Base de datos para tests

Cambio en src/shared/db/orm.ts para usar SQLite en memoria cuando NODE_ENV='test' y MySQL en dev/prod.

Helpers: syncSchema() y resetSchema().

Seguridad

SAST con eslint + eslint-plugin-security y script lint:sec.

Rendimiento

k6 smoke test (perf/smoke.js) con umbrales (p95 < 400ms, error rate < 1%).

DAST

OWASP ZAP baseline en pipeline contra la API levantada.

CI/CD

Workflow .github/workflows/ci.yml:

Job test: lint:sec + vitest con cobertura y artefacto coverage.

Job perf: levanta API, corre k6.

Job dast: ZAP baseline sobre http://localhost:3000.

Job opcional notify (Slack) si configurás SLACK_WEBHOOK_URL.

Archivos creados/modificados (principal)

package.json → scripts: test, test:cov, test:ci, lint:sec, perf:smoke.

tsconfig.spec.json, vitest.config.ts.

test/setup-app.ts, test/setup-db.ts.

test/unit/partner.mapper.spec.ts, test/integration/partners.http.spec.ts.

src/shared/db/orm.ts (switch MySQL/SQLite).

.eslintrc.cjs.

perf/smoke.js.

.github/workflows/ci.yml.

Cómo ejecutar (local)
pnpm lint:sec
pnpm test
pnpm test:cov   # reporte HTML en ./coverage/index.html
pnpm perf:smoke # requiere API corriendo en :3000

Cumplimiento con la política de Testing (backend)

✅ Unit tests (umbral ≥80%)

✅ Integración

✅ Regresión automatizada

✅ Paralelismo

✅ Cobertura (text/html/lcov)

✅ Rendimiento (k6 smoke)

✅ Seguridad SAST/DAST

✅ CI/CD (GitHub Actions)
