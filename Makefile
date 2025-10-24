.PHONY: help load-data start stop clean start-prod stop-prod build-prod logs logs-prod status status-prod

help: ## Muestra comandos disponibles
	@echo "Comandos de desarrollo:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | grep -v "prod" | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'
	@echo ""
	@echo "Comandos de producción:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | grep "prod" | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

# =============================================================================
# Comandos de Desarrollo (solo infraestructura)
# =============================================================================

load-data: ## Carga datos de prueba en la BD
	@bash scripts/load-test-data.sh

start: ## Levanta infraestructura (PostgreSQL + Redis)
	@cd infra && docker compose up -d
	@echo "✓ Infraestructura iniciada (PostgreSQL:5432, Redis:6379)"
	@echo "  Inicia backend: cd apps/backend && pnpm start:dev"
	@echo "  Inicia frontend: cd apps/frontend && pnpm start"

stop: ## Detiene infraestructura
	@cd infra && docker compose down

clean: ## Limpia contenedores y volúmenes
	@cd infra && docker compose down -v

logs: ## Ver logs de infraestructura
	@cd infra && docker compose logs -f

status: ## Ver estado de contenedores
	@cd infra && docker compose ps

# =============================================================================
# Comandos de Producción (stack completo)
# =============================================================================

start-prod: ## Levanta stack completo (PostgreSQL + Redis + Backend + Frontend)
	@if [ ! -f infra/.env.production ]; then \
		echo "❌ Error: infra/.env.production no existe"; \
		echo "   Copia infra/.env.production.example y configúralo"; \
		exit 1; \
	fi
	@cd infra && docker compose --profile production --env-file .env.production up -d
	@echo "✓ Stack completo iniciado"
	@echo "  Frontend: http://localhost"
	@echo "  Backend:  http://localhost:3000"
	@echo "  Swagger:  http://localhost:3000/api-docs"

stop-prod: ## Detiene stack completo
	@cd infra && docker compose --profile production down

build-prod: ## Reconstruye imágenes de producción
	@cd infra && docker compose --profile production build backend frontend
	@echo "✓ Imágenes reconstruidas. Ejecuta 'make start-prod' para reiniciar"

logs-prod: ## Ver logs del stack completo
	@cd infra && docker compose --profile production logs -f

status-prod: ## Ver estado del stack completo
	@cd infra && docker compose --profile production ps
