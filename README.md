# Análisis de las principales estadicticas de los jugadores de la NBA
Almuno: Christian Castillo Reynoso 
## :clipboard: Resumen ejecutivo

| Campo | Valor |
|---|---|
| **Pregunta analítica** | Entre 2010 y 2019 ¿El aumento en los puntos promedio por partido se explica principalmente por la mejora de los jugadores en los porcentajes de tiro de campo, triples y tiros libres? |
| **Dataset** | NBA games data |
| **Fuente** | [nba.data — Bases de datos](https://www.kaggle.com/datasets/nathanlauga/nba-games/data) |
| **Modelo** | Estrella con 1 fact + 4 dimensiones (date, hour, station, pollutant) |
| **Infraestructura** | Aurora PostgreSQL en AWS (mismo cluster `aurora-mod4` del módulo, schema `aire_dwh`) |
| **ETL** | `etl_pipeline.py` end-to-end con pandas + SQLAlchemy + validaciones post-carga |
| **SQL avanzado** | Window functions (rolling 24h average, ranking por estación), CTE con jerarquía de alcaldías, `PERCENTILE_CONT` y `COUNT FILTER` |
| **Dashboard** | 4 visualizaciones estáticas (matplotlib): mapa, serie mensual, top estaciones, heatmap hora × mes |
