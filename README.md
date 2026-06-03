# Análisis de las principales estadicticas de los jugadores de la NBA
Almuno: Christian Castillo Reynoso 
## :clipboard: Resumen ejecutivo

| Campo | Valor |
|---|---|
| **Pregunta analítica** | Entre 2010 y 2019 ¿El aumento en los puntos promedio por partido se explica principalmente por la mejora de los jugadores en los porcentajes de tiro de campo, triples y tiros libres? |
| **Dataset** | NBA games data |
| **Fuente** | [nba.data — Bases de datos](https://www.kaggle.com/datasets/nathanlauga/nba-games/data) |
| **Modelo** | Estrella con 1 fact + 5 dimensiones (game, player, team, star_posicion , date) |
| **Infraestructura** | Aurora PostgreSQL en AWS (mismo cluster `aurora-mod4` del módulo, schema `nba_dwh`) |
| **ETL** | `etl_pipeline.py` end-to-end con pandas + SQLAlchemy + validaciones post-carga |
| **SQL avanzado** | FALTA |
| **Dashboard** | FALTA |

## 🏀 Contexto de la NBA
La NBA (National Basketball Association) es la liga profesional de baloncesto más importante de todo el mundo, la cual está formada por 30 equipos divididos en dos conferencias; la Conferencia Este y la Conferencia Oeste.

**Conferencia Este** (Eastern Conference): Atlanta Hawks, Boston Celtics, Brooklyn Nets, Charlotte Hornets, Chicago Bulls, Cleveland Cavaliers, Detroit Pistons, Indiana Pacers, Miami Heat, Milwaukee Bucks, New York Knicks, Orlando Magic, Philadelphia 76ers, Toronto Raptors, Washington Wizards.

**Conferencia Oeste** (Western Conference): Dallas Mavericks, Denver Nuggets, Golden State Warriors, Houston Rockets, Los Angeles Clippers, Los Angeles Lakers, Memphis Grizzlies, Minnesota Timberwolves, New Orleans Pelicans, Oklahoma City Thunder, Phoenix Suns, Portland Trail Blazers, Sacramento Kings, San Antonio Spurs, Utah Jazz.

Durante la temporada regular cada equipo juega un total de 82 partidos contra todos los equipos de la liga, con el propósito de acumular la mayor cantidad de victorias posibles y posicionarse en la clasificación de su conferencia. Los mejores 8 equipos de cada conferencia avanzan a los playoffs, donde compiten en series eliminatorias hasta definir el campeón de cada conferencia; en esta etapa de la liga todas las rondas se juegan al mejor de 7 partidos. Finalmente, los campeones del Este y Oeste se enfrentan en las finales de la NBA para disputar el titulo; aquí también se juega al mejor de 7 partidos. 

## :dart: Problema y motivación
Durante la década 2010–2019, los partidos de la NBA mostraron un incremento en los puntos promedio por juego. Sin embargo, no está claro si este aumento se debe principalmente a:

-Una mejora en la eficiencia de tiro de campo (field goals).
-El mayor uso y precisión de los tiros de tres puntos.
-Una mejora en los tiros libres.

El reto consiste en determinar si el incremento en el rendimiento ofensivo se explica por la eficiencia individual de los jugadores o por otros factores.

Este proyecto responde 2 preguntas concretas:
1. **¿Hubo aumento en los porcentajes de tiro durante esta decada?**
2. **¿Quienes fueron los juhadores con mayor numero de puntos (tiro de campo, tiro libre y tiro libre) durante cada año?**

## :package: Origen de los datos
Los datos provienen de un dataset disponible en **Kaggle**, el cual es sometido a un proceso de ETL (Extract, Transform, Load) que los descarga, transforma y finalmente los carga en el esquema `nba_dwh` dentro de un clúster Aurora. Es importante subrayar que Aurora funciona como el destino analítico, es decir, el repositorio donde se centraliza la información para su explotación, y no como la fuente original de los datos.

