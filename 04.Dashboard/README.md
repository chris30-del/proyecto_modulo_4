# Resumen Ejecutivo – Dashboard NBA Analytics

## Descripción General

Este dashboard interactivo fue desarrollado para analizar el rendimiento histórico de jugadores de la NBA mediante indicadores ofensivos, eficiencia de tiro y desempeño en cancha.

La solución está estructurada en **4 páginas principales**.

## Objetivo

Proporcionar una herramienta visual para:

- Analizar la evolución ofensiva de los jugadores.
- Comparar eficiencia de tiro a lo largo del tiempo.
- Evaluar desempeño defensivo y de creación de juego.
- Identificar patrones de rendimiento por posición.

---

# Estructura del Dashboard

## 1. Portada

Página de navegación principal.

### Funcionalidades

- Presentación del proyecto.
- Menú de navegación mediante botones.
- Acceso directo a cada módulo analítico.

### Objetivo

Servir como punto de entrada para la exploración del dashboard.

---

## 2. Puntos por Partido

Módulo enfocado en la producción ofensiva de los jugadores.

### Indicadores Analizados

- Puntos por partido.
- Puntos provenientes de tiros de 2 puntos.
- Puntos provenientes de tiros de 3 puntos.
- Puntos provenientes de tiros libres.

### Métricas de Eficiencia

- Porcentaje de efectividad en tiros de campo de 2 puntos.
- Porcentaje de efectividad en triples.
- Porcentaje de efectividad en tiros libres.

### Visualizaciones

- Gráficos combinados de líneas y columnas.
- Evolución histórica por temporada.
- Comparación entre volumen de anotación y eficiencia.

### Filtros Disponibles

- Jugador.
- Posición.
- Conferencia.

### Objetivo

Analizar cómo evoluciona la capacidad anotadora de los jugadores a lo largo de los años.

---

## 3. Rendimiento en Cancha

Módulo orientado al análisis integral del desempeño durante los partidos.

### Indicadores Analizados

#### Defensa

- Robos de balón (STL).
- Bloqueos (BLK).
- Rebotes (REB).

#### Creación de Juego

- Asistencias (AST).
- Pérdidas de balón (TOS).

#### Participación

- Tiempo promedio en cancha.

### Visualizaciones

#### Gráfico de Líneas

Muestra la evolución de:

- Robos promedio.
- Bloqueos promedio.

#### Gráfico Donut

Distribución de rebotes promedio por posición.

#### Gráfico de Líneas

Evolución de minutos promedio jugados.

#### Scatter Plot

Relación entre:

- Asistencias.
- Pérdidas de balón.

### Filtros Disponibles

- Jugador.
- Temporada.

### Objetivo

Evaluar el impacto global de un jugador más allá de la anotación.

---

## 4. Tiros

Módulo especializado en análisis de volumen y eficiencia de lanzamiento.

### Indicadores Analizados

#### Tiros de Campo

- Intentos de tiro (FGA).
- Tiros convertidos (FGM).

#### Triples

- Intentos de triple (FG3A).
- Triples convertidos (FG3M).

#### Tiros Libres

- Intentos de tiro libre (FTA).
- Tiros libres convertidos (FTM).

### Visualizaciones

#### Gráficos de Columnas

Comparación entre:

- Intentos y conversiones de triples.
- Intentos y conversiones de tiros de campo.

#### Gráfico Circular

Distribución porcentual de todos los tipos de lanzamiento.

#### Área Acumulada

Evolución histórica de:

- % Tiros de 2 puntos.
- % Tiros de 3 puntos.
- % Tiros libres.

### Filtros Generales

- Jugador.

### Objetivo

Analizar la eficiencia y rendimiento de cada jugador.

---

# Modelo Analítico


El modelo sigue un esquema estrella (*Star Schema*) donde la tabla de hechos `fact_statistics` almacena las estadísticas de los jugadores por partido y se relaciona directamente con las dimensiones de fecha, partido, jugador, equipo y posición inicial.



## Tabla de Hechos

### `fact_statistics`

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

## Dimensiones

### `dim_date`

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

### `dim_games`

Dimensión que almacena información de los partidos.

| Campo |
|---------|
| game_id (PK) |
| game_name |

---

### `dim_player`

Dimensión de jugadores.

| Campo |
|---------|
| player_id (PK) |
| player_name |

---

### `dim_team`

Dimensión de equipos de la NBA.

| Campo |
|---------|
| team_id (PK) |
| nickname |
| city |
| conference |

---

### `dim_start_position`

Dimensión que representa la posición inicial del jugador dentro del partido.

| Campo |
|---------|
| start_position_id (PK) |
| position_name |
| flag_holder |


## Diagrama Lógico

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

## Claves del Modelo

### Claves Primarias

| Tabla | Clave Primaria |
|---------|---------|
| dim_date | date_id |
| dim_games | game_id |
| dim_player | player_id |
| dim_team | team_id |
| dim_start_position | start_position_id |

### Claves Foráneas en la Tabla de Hechos

| Campo |
|---------|
| date_id |
| game_id |
| player_id |
| team_id |
| start_position_id |

---

## Tipo de Modelo

**Star Schema (Esquema Estrella)**

La tabla `fact_statistics` actúa como tabla central de hechos y todas las dimensiones se conectan directamente a ella, sin relaciones entre dimensiones.
```

---

# KPIs Principales

El dashboard permite monitorear:

- Puntos promedio por partido.
- Porcentaje de tiros de campo.
- Porcentaje de triples.
- Porcentaje de tiros libres.
- Rebotes promedio.
- Asistencias promedio.
- Robos promedio.
- Bloqueos promedio.
- Minutos promedio jugados.
- Relación asistencias/pérdidas.

---

# Conclusión

El dashboard integra indicadores ofensivos, defensivos y de eficiencia de tiro en una única solución analítica, permitiendo evaluar el desempeño de jugadores NBA desde múltiples perspectivas mediante filtros interactivos y visualizaciones dinámicas.
