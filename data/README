# Resumen Ejecutivo – NBA Games Dataset (Nathan Lauga)

Este proyecto utiliza el dataset **NBA Games**, una colección de datos históricos de la NBA obtenida a través de la API oficial de estadísticas de la NBA. El conjunto de datos cubre partidos desde la temporada **2004 hasta diciembre de 2020** e integra información de juegos, estadísticas individuales de jugadores, rankings de equipos y datos maestros de franquicias y jugadores.

## Estructura General de la Información

La información está organizada en **5 archivos CSV** que pueden relacionarse mediante identificadores de equipos, jugadores y partidos. El modelo está orientado al análisis estadístico, predicción de resultados y desarrollo de modelos de Machine Learning.

## 1. Catálogo Maestro

Contiene la información base de jugadores y equipos.

| Archivo | Descripción |
|----------|-------------|
| `players.csv` | Información básica de los jugadores (ID y nombre). |
| `teams.csv` | Información de las franquicias NBA, incluyendo ciudad, nombre, año de fundación y datos organizacionales. |

Estas tablas funcionan como dimensiones de referencia para el resto del modelo.

## 2. Información de Partidos

Representa el núcleo del dataset.

| Archivo | Descripción |
|----------|-------------|
| `games.csv` | Información general de cada partido, incluyendo fecha, equipos participantes, marcador final y estadísticas agregadas por equipo. |

Entre las variables más relevantes se encuentran:

- Fecha del partido (`GAME_DATE_EST`)
- Identificador del partido (`GAME_ID`)
- Equipo local y visitante
- Puntos anotados por cada equipo
- Porcentajes de tiro de campo
- Porcentaje de tiros libres
- Porcentaje de triples
- Asistencias
- Rebotes
- Resultado del encuentro (`HOME_TEAM_WINS`)

## 3. Estadísticas Individuales de Jugadores

Es el componente más detallado del dataset.

| Archivo | Descripción |
|----------|-------------|
| `games_details.csv` | Estadísticas individuales de cada jugador para cada partido. |

Cada registro representa la actuación de un jugador en un juego específico e incluye métricas como:

- Minutos jugados
- Puntos
- Rebotes
- Asistencias
- Robos
- Bloqueos
- Pérdidas de balón
- Faltas personales
- Tiros de campo convertidos e intentados
- Tiros libres convertidos e intentados
- Triples convertidos e intentados
- Posición inicial del jugador (`START_POSITION`)

Esta tabla contiene aproximadamente **650,000 registros**, convirtiéndose en la principal fuente para análisis de rendimiento individual.

## 4. Ranking de Equipos

Permite analizar el contexto competitivo de cada franquicia durante la temporada.

| Archivo | Descripción |
|----------|-------------|
| `ranking.csv` | Clasificación diaria de los equipos NBA. |

Incluye información como:

- Conferencia (Este/Oeste)
- Partidos ganados y perdidos
- Porcentaje de victorias
- Récord como local
- Récord como visitante
- Posición en la clasificación general

Esta tabla es especialmente útil para generar variables predictivas previas a cada partido.

## Modelo Relacional Simplificado

```text
TEAMS
  │
  ├── GAMES
  │      │
  │      ├── GAMES_DETAILS
  │      │
  │      └── RANKING
  │
PLAYERS
  │
  └── GAMES_DETAILS
```

## Cobertura del Dataset

| Métrica | Valor Aproximado |
|----------|-----------------|
| Temporadas | 2004 – 2020 |
| Equipos NBA | 30 |
| Partidos | ~26,000 |
| Jugadores | ~7,000 |
| Rankings diarios | ~200,000 registros |
| Estadísticas jugador-partido | ~650,000 registros |


Mientras el dataset de Wyatt Walsh está orientado a una **base histórica completa de la NBA (1946–actualidad) con eventos play-by-play**, el dataset de Nathan Lauga está enfocado en **estadísticas agregadas de juegos y rendimiento de jugadores desde 2004**, siendo más ligero y adecuado para proyectos de Machine Learning, análisis exploratorio y predicción de resultados.
