# Análisis de las principales estadísticas de los jugadores de la NBA

**Alumno:** Christian Castillo Reynoso

## 📋 Resumen ejecutivo

| Campo                  | Valor                                                                                                                                                                                   |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Pregunta analítica** | Entre 2005 y 2019, ¿el aumento en los puntos promedio por partido se explica principalmente por la mejora de los jugadores en los porcentajes de tiro de campo, triples y tiros libres? |
| **Dataset**            | NBA Games Data                                                                                                                                                                          |
| **Fuente**             | [nba.data — Bases de datos](https://www.kaggle.com/datasets/nathanlauga/nba-games/data)                                                                                                 |
| **Modelo**             | Esquema estrella con 1 tabla de hechos y 5 dimensiones (game, player, team, start_position y date)                                                                                      |
| **Infraestructura**    | Aurora PostgreSQL en AWS (mismo clúster `aurora-mod4` del módulo, esquema `nba_dwh`)                                                                                                    |
| **ETL**                | `etl_pipeline.py` end-to-end con pandas, SQLAlchemy y validaciones posteriores a la carga                                                                                               |
| **SQL avanzado**       | 2 Queries con CTE, para obtener jugadores con mayores puntos anotados por año, y con mayor número de porcentajes de efectividad. Estos resultados los vamos a ocupar en el Dashboard para ver el comportamiento de cada jugador                                                                                                                                                                                |
| **Dashboard**          | 4 páginas, portada, puntos por partido, rendimiento en cancha y tiros                                                                                                                                                                              |

## 🏀 Contexto de la NBA

La NBA (*National Basketball Association*) es la liga profesional de baloncesto más importante del mundo. Está conformada por 30 equipos divididos en dos conferencias: la Conferencia Este y la Conferencia Oeste.

**Conferencia Este (Eastern Conference):** Atlanta Hawks, Boston Celtics, Brooklyn Nets, Charlotte Hornets, Chicago Bulls, Cleveland Cavaliers, Detroit Pistons, Indiana Pacers, Miami Heat, Milwaukee Bucks, New York Knicks, Orlando Magic, Philadelphia 76ers, Toronto Raptors y Washington Wizards.

**Conferencia Oeste (Western Conference):** Dallas Mavericks, Denver Nuggets, Golden State Warriors, Houston Rockets, Los Angeles Clippers, Los Angeles Lakers, Memphis Grizzlies, Minnesota Timberwolves, New Orleans Pelicans, Oklahoma City Thunder, Phoenix Suns, Portland Trail Blazers, Sacramento Kings, San Antonio Spurs y Utah Jazz.

Durante la temporada regular, cada equipo disputa un total de 82 partidos con el objetivo de acumular la mayor cantidad posible de victorias y obtener una mejor posición en la clasificación de su conferencia. Los ocho mejores equipos de cada conferencia avanzan a los *playoffs*, donde compiten en series eliminatorias hasta definir al campeón de cada conferencia. En esta etapa, todas las rondas se juegan al mejor de siete partidos.

Finalmente, los campeones de las conferencias Este y Oeste se enfrentan en las Finales de la NBA para disputar el título de la liga, también bajo el formato de una serie al mejor de siete partidos.

## 🎯 Problema y motivación

Durante el periodo de 2005 a 2019, los partidos de la NBA mostraron un incremento en la cantidad promedio de puntos anotados por juego. Sin embargo, no está claro si este aumento se debe principalmente a:

* Una mejora en la eficiencia de tiro de campo (*field goals*).
* Un mayor uso y una mayor precisión en los tiros de tres puntos.
* Una mejora en la efectividad de los tiros libres.

El reto consiste en determinar si el incremento en el rendimiento ofensivo se explica por una mejora en la eficiencia individual de los jugadores o por otros factores relacionados con la evolución del juego.

Este proyecto busca responder dos preguntas concretas:

1. **¿Hubo un aumento en los porcentajes de efectividad de tiro durante este periodo?**
2. **¿Quiénes fueron los jugadores con mayor número de puntos anotados (tiros de campo, triples y tiros libres) en cada año?**

## 📦 Origen de los datos

Los datos provienen de un conjunto de datos disponible en **Kaggle**, el cual es sometido a un proceso ETL (*Extract, Transform, Load*) que permite su descarga, transformación y posterior carga en el esquema `nba_dwh` dentro de un clúster Aurora PostgreSQL.

Es importante destacar que Aurora actúa como el destino analítico de la solución, es decir, el repositorio donde se centraliza y organiza la información para su explotación mediante consultas y visualizaciones, mientras que Kaggle constituye la fuente original de los datos.

### Flujo end-to-end

```
        ┌──────────────────────────────────────┐
        │  Kaggle                              │
        │  https://www.kaggle.com              │
        │                                      │
        │  • 5 CSVs:                           │
        │    games, games_details, players,    │
        │    ranking y teams                   │
        └──────────────────┬───────────────────┘
                           │  HTTP GET
                           ▼
        ┌──────────────────────────────────────┐
        │  ETL Python — etl_pipeline.ipynb     │
        │                                      │
        │  Extract:   Kaggle API               │
        │  Transform:  Pandas                  │
        │  Load:      to_sql(method='multi')   │
        └──────────────────┬───────────────────┘
                           │  INSERT
                           ▼
        ┌──────────────────────────────────────┐
        │  Aurora PostgreSQL                   │
        │  aurora-mod4.cluster-XXX.../northwind│
        │  Schema: nba_dwh_py                  │
        │                                      │
        │  • 5 dims pobladas por ETL           │
        │  • fact_statistical poblada por ETL  │
        └──────────────────┬───────────────────┘
                           │  SELECT
                           ▼
        ┌──────────────────────────────────────┐
        │  Dashboard: NBA Analytics(4 páginas) │
        │  Queries analíticas SQL (2 queries)  │
        └──────────────────────────────────────┘
```
## Consideraciones antes correr el ETL
### AWS
* Tener un clúster de base de datos (aurora-mod4), el cual debe de estar disponible y utilizando el motor Aurora PostgreSQL. Dentro de este cluster debe de existir una instancia (aurora-mod4-instance-1).
### Python 
* Tener version de python 3.12.13 (ideal).
* Tener instaladas las siguientes paqueterias: kaggle, pandas, os, sqlalchemy y re.

##📁 Estructura del repositorio
```
proyecto_modulo_4/
│
├── README.md                     ← documentación principal
│
├── 01.Data/
│   ├── nba_data.zip              ← archivos .csv, solo utilizar en caso de que la API no funcione
│   └── README.md                 ← explicación de como esta la data 
│
├── 02.Scrips_sql/
│   ├── DDL_nba.sql               ← Data Definition Language
│   └── Queries.sql               ← consultas con CTE y funciones de ventana
│
├── 03.Scrips_py/
│   ├── etl.ipynb                 ← ETL
│
└── 04.Dashboard/
    ├── NBA_Dash_V1.pbix          ← dashboard Power BI
    └── README.md                 ← Expliacion del Dashboard
```












