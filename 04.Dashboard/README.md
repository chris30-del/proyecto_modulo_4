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

El dashboard está construido con la finalizar de analizar lo siguiente:

```text
Jugador
   │
   ├── Temporada
   │
   ├── Producción Ofensiva(Información a nivel partido)
   │      ├── Puntos
   │      ├── Puntos de 2 y % de efectividad
   │      ├── Puntos de 3 y % de efectividad
   │      └── Puntos de tiro libre y % de efectividad
   │
   ├── Rendimiento en Cancha(Información a nivel jugador)
   │      ├── Rebotes
   │      ├── Asistencias
   │      ├── Perdidas de Balón
   │      ├── Robos
   │      ├── Bloqueos
   │      └── Minutos Jugados
   │
   └── Eficiencia de Tiro(Información a nivel total)
          ├── Tiros de 2(A/M)
          ├── Tiros de 3 (A/M)
          └── Distribución de tiros
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
