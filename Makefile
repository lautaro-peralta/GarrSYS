.PHONY: help load-data start stop clean

help: ## Muestra comandos disponibles
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

load-data: ## Carga datos de prueba en la BD
	@bash scripts/load-test-data.sh

start: ## Levanta Docker
	@cd infra && docker-compose up -d

stop: ## Detiene Docker
	@cd infra && docker-compose down

clean: ## Limpia contenedores y volúmenes
	@cd infra && docker-compose down -v
