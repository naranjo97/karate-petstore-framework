# 🥋 Karate PetStore Framework

Framework de pruebas API profesional construido con **Karate DSL 1.5.1** sobre la API pública de PetStore (Swagger).

## 🛠 Tecnologías
- Java 22
- Karate DSL 1.5.1 (io.karatelabs)
- JUnit 5
- Maven

## 📁 Estructura
```
src/test/
├── java/com/petstore/runner/
│   ├── TestRunner.java       # Runner completo paralelo
│   └── SmokeRunner.java      # Runner smoke
└── resources/
    ├── karate-config.js      # Config multi-ambiente
    └── com/petstore/
        ├── features/
        │   ├── pets/         # CRUD mascotas (31 escenarios)
        │   ├── store/        # Inventario y órdenes (9 escenarios)
        │   └── auth/         # Autenticación (2 escenarios)
        └── data/
            ├── pets.json
            └── orders.json
```

## 📊 Cobertura — 42 escenarios

| Módulo | Escenarios | Tags |
|---|---|---|
| Crear mascotas | 10 | @smoke @create @data-driven |
| Consultar mascotas | 12 | @smoke @read @negative |
| Actualizar mascotas | 6 | @smoke @update @data-driven |
| Eliminar mascotas | 3 | @smoke @delete @negative |
| Órdenes | 6 | @smoke @orders @negative |
| Inventario | 3 | @smoke @inventory |
| Autenticación | 2 | @smoke @auth |

## ▶️ Ejecutar
```bash
# Todos los tests
mvn clean test -Dtest=TestRunner

# Solo smoke
mvn clean test -Dtest=SmokeRunner

# Ambiente staging
mvn clean test -Dtest=TestRunner -Dkarate.env=staging
```

## 📈 Reporte HTML
El reporte se genera automáticamente en:
```
target/karate-reports/karate-summary.html
```

## 🏷 Tags disponibles
- `@smoke` — Escenarios críticos de humo
- `@regression` — Suite completa de regresión
- `@negative` — Validaciones negativas
- `@data-driven` — Scenario Outlines con múltiples datos