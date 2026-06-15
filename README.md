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
| **SQL avanzado**       | 3 Queries; 2 con CTE, para obtener jugadores con mayores puntos anotados por año, y con mayor número de porcentajes de efectividad. Estos resultados los vamos a ocupar en el Dashboard para ver el comportamiento de cada jugador                                                                                                                                                                                |
| **Dashboard**          | 4 páginas; portada, puntos por partido, rendimiento en cancha y tiros                                                                                                                                                                              |

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
* Tener el punto de enlace y la contraseña para poder correr el etl.
### Python 
* Tener version de python 3.12.13 (ideal).
* Tener instaladas las siguientes paqueterias: kaggle, pandas, os, sqlalchemy y re.

## 📁 Estructura del repositorio
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
## :wrench: Cómo ejecutar

### 1. Setup del schema en Aurora
Asume que ya tienes tu cluster e instancia de Aurora `aurora-mod4`.  Desde DBeaver ejecutar:

```bash
     -f 02.Scrips_sql/DDL_nba.sql
```
Esto crea el schema `nba_dwh_py` con las 6 tablas vacias. 

### 2. Poblar las 5 dimensiones y la tabla de hechos

Leer los datos desde la API de kaggle y cargarlos a la base de datos
```bash
# Instalar dependencias (si no las tienes ya del Tema 04)
pip install kaggle pandas os sqlalchemy re

# Leer los CSV's
python 03.Scrips_py/etl.ipynb \
    --host aurora-mod4.cluster-XXX.us-east-1.rds.amazonaws.com \
    --password TU_PASSWORD \
    --database northwind 
```
Esto pobla las tablas que creamos en el paso 1. 


### 3. Conectar/ Reconectar nuestro Dashboard

Aqui ya tenemos el Dashboard, en caso de requerir una reconección : 

```bash
1. Ir a obtenr datos y buscar Base de datos PostgreSQL
2. En Servidor poner el punto y de enlace y la contraseña 
3. Seleccionar las tablas que pertenecen a nbs_dwh_py y cargarlas
4. Poner la opcion de importar
```
Una vez cargado el dwh, se habilita la informacion y las graficas del dashboard


## 🛢 Modelo Dimensional


El modelo sigue un esquema estrella (*Star Schema*) donde la tabla de hechos `fact_statistics` almacena las estadísticas de los jugadores por partido y se relaciona directamente con las dimensiones de fecha, partido, jugador, equipo y posición inicial.



### Tabla de Hechos

#### 𝄜 `fact_statistics`

Contiene las métricas estadísticas registradas para cada jugador en cada partido.

| Campo | Tipo |
|---------|---------|
| date_id | FK |
| game_id | FK |
| player_id | FK |
| team_id | FK |
| start_position_id | FK |
| pts | Medida |
| reb | Medida |
| ast | Medida |
| stl | Medida |
| blk | Medida |
| tos | Medida |
| sec | Medida |
| fgm | Medida |
| fga | Medida |
| fg3m | Medida |
| fg3a | Medida |
| ftm | Medida |
| fta | Medida |

### Granularidad

Cada registro representa:

> Las estadísticas de un jugador en un partido específico, jugando para un equipo determinado, en una fecha determinada y ocupando una posición inicial determinada.

---

### Dimensiones

#### 📆`dim_date`

Dimensión temporal utilizada para analizar las estadísticas por diferentes periodos.

| Campo |
|---------|
| date_id (PK) |
| full_date |
| day_of_month |
| day_of_week_name |
| day_of_week_number |
| is_weekend |
| month_name |
| month_number |
| quarter |

---

#### 🆚 `dim_games`

Dimensión que almacena información de los partidos.

| Campo |
|---------|
| game_id (PK) |
| game_name |

---

#### 🏃🏽‍♂️`dim_player`

Dimensión de jugadores.

| Campo |
|---------|
| player_id (PK) |
| player_name |

---

#### 👥`dim_team`

Dimensión de equipos de la NBA.

| Campo |
|---------|
| team_id (PK) |
| nickname |
| city |
| conference |

---

#### 🏀`dim_start_position`

Dimensión que representa la posición inicial del jugador dentro del partido.

| Campo |
|---------|
| start_position_id (PK) |
| position_name |
| flag_holder |


### Esquema estrella

```text
                  +--------------------+
                  | dim_start_position |
                  +--------------------+
                            |
                            |
                            |
+-----------+      +------------------+      +-----------+
| dim_games |-----|  fact_statistics   |-----| dim_date  |
+-----------+      +------------------+      +-----------+
                     |              |
                     |              |
                +-----------+   +-----------+
                | dim_player|   | dim_team  |
                +-----------+   +-----------+

```

---

### Llaves del Modelo

#### Llaves Primarias

| Tabla | Clave Primaria |
|---------|---------|
| dim_date | date_id |
| dim_games | game_id |
| dim_player | player_id |
| dim_team | team_id |
| dim_start_position | start_position_id |

#### Llaves Foráneas en la Tabla de Hechos

| Campo |
|---------|
| date_id |
| game_id |
| player_id |
| team_id |
| start_position_id |

### Decisiones de diseño
En el caso de la NBA, se pueden definir tres granos: 
* Grano 1: por equipo, juegos que tuvo cada equipo por temporada, partidos ganados vs partidos perdidos. 
* Grano 2: por partido, partido concretado en una temporada, estadísticas básicas por equipo. 
* Grano 3: por partido y jugador, registro de estadísticas de un jugador por juego, estadísticas a nivel jugador. 

Para el caso de nuestro proyecto nos vamos a quedar con el Grano 3. Con este grano se nos permite diferencia si un jugador fue titular o no durante el partido; lo cual es beneficioso para nuestro análisis, ya que normalmente los equipos de la NBA siempre comienzan con los jugadores con mejores aptitudes/habilidades; entonces podríamos diferenciar entre titulares o no, también nos permite analizar si hay diferencias en las estadísticas según la posición inicial de cada jugador. 

## :computer: SQL avanzado destacado

Tres queries en [`Queries.sql`](02.Scripts_sql/Queries.sql) que cubren las técnicas del módulo:

### 1. Mediana de minutos jugados por cada tipo de jugador(percentile_cont)

```sql
select 
	dsp.position_name as posicion_inicial, 
	round((percentile_cont(0.50) within group (order by t.sec))::numeric/60,2) as mediana_minutos_jugados	
from 
	nba_dwh_py.fact_statistical t 
left join 
	nba_dwh_py.dim_start_position dsp 
	on t.start_position_id  = dsp.start_position_id
group by 
	dsp.position_name sql
;
```

### 2. Jugador con mayor número de puntos por año y sus pocentajes de tiro.(CTE y row_number) 


```sql
with __info as (
select 
	*
from 
	nba_dwh_py.fact_statistical t 
left join 
	nba_dwh_py.dim_date dd 
	on 
		t.date_id = dd.date_id 
left join 
	nba_dwh_py.dim_player dp 
	on 
		t.player_id  = dp.player_id 
)
, __info2 as (
select 
	year,
	player_name,
	sum(fgm ) as tiros_2_m, 
	sum(fga)  as tiros_2_a,
	sum(fg3m) as tiros_3_m,
	sum(fg3a) as tiros_3_a,
	sum(ftm)  as tiros_libres_m, 
	sum(fta)  as tiros_libres_a,	
	sum(pts)  as puntos
from 
	__info
group by 
	year, player_name
)
, __info3 as (
select distinct
	year,
	player_name,
    ROUND(100.0 * tiros_2_m / NULLIF(tiros_2_a, 0), 2) AS pct_tiros_2,
    ROUND(100.0 * tiros_3_m / NULLIF(tiros_3_a, 0), 2) AS pct_tiros_3,
    ROUND(100.0 * tiros_libres_m / NULLIF(tiros_libres_a, 0), 2) AS pct_tiros_libres,
	puntos,
	row_number() over (partition by year order by puntos desc ) as rn 
from 
	__info2 
)
select 
* 
from 
	__info3 
where 
	rn = 1 
order by 
	year asc
;
```

### 3. Jugador con mayor porcentaje de tiro (se considera la suma de los 3 porcentajes) y con más del 50 % de los partidos jugado por año(CTE referencia multiple y row_number) 


```sql
with __juegos_a as(
select 
	year, 
	count(distinct t.game_id )/(select count(*) from nba_dwh_py.dim_team dt ) as promedio
from 
	nba_dwh_py.fact_statistical t 
left join 
	nba_dwh_py.dim_date dd 
	on 
		t.date_id = dd.date_id 
group by 
	1
)
, __juegos_a2 as(
select 
	round(avg(promedio),0)::int as promedio 
from 
	__juegos_a 
)
--select * from __juegos_a2 ; 
,__info as (
select 
	*
from 
	nba_dwh_py.fact_statistical t 
left join 
	nba_dwh_py.dim_date dd 
	on 
		t.date_id = dd.date_id 
left join 
	nba_dwh_py.dim_player dp 
	on 
		t.player_id  = dp.player_id 
left join 
	nba_dwh_py.dim_start_position dsp 
	on 
		t.start_position_id  = dsp.start_position_id 
where 
	dsp.flag_holder = 1
)
--select * from __info limit 10;
, __par_anio_jugador as (
select 
	year, 
	player_name,
	count(distinct game_id ) partidos_jugados
from 
	__info
group by 
	1,2
)
, __info2 as (
select 
	year,
	player_name,
	sum(fgm ) as tiros_2_m, 
	sum(fga)  as tiros_2_a,
	sum(fg3m) as tiros_3_m,
	sum(fg3a) as tiros_3_a,
	sum(ftm)  as tiros_libres_m, 
	sum(fta)  as tiros_libres_a,	
	sum(pts)  as puntos
from 
	__info
group by 
	year, player_name
)
, __info3 as (
select distinct
	a.year,
	a.player_name,
    coalesce(ROUND(100.0 * tiros_2_m / NULLIF(tiros_2_a, 0), 2),0) AS pct_tiros_2,
    coalesce(ROUND(100.0 * tiros_3_m / NULLIF(tiros_3_a, 0), 2),0) AS pct_tiros_3,
    coalesce(ROUND(100.0 * tiros_libres_m / NULLIF(tiros_libres_a, 0), 2),0) AS pct_tiros_libres, 
    b.partidos_jugados 
from 
	__info2 as a
left join 
   __par_anio_jugador as b 
   on 
   	(a.year  = b.year and a.player_name = b.player_name)
where 
	b.partidos_jugados >= (select promedio from __juegos_a2 )
)
, __info4 as (
select 
	year, 
	player_name, 
	pct_tiros_2 + pct_tiros_3 + pct_tiros_libres as pct_total 
from __info3 
)
, __info5 as (
select 
	*, 
	row_number() over (partition by year order by pct_total desc ) as rn 
from 
	__info4
)
select 
*
from 
__info5 
where 
	rn = 1

;


```











