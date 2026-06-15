--- Queries Analiticas


---Query 1---
--Mediana de minutos jugados por cada tipo de jugador
select 
	dsp.position_name as posicion_inicial, 
	round((percentile_cont(0.50) within group (order by t.sec))::numeric/60,2) as mediana_minutos_jugados	
from 
	nba_dwh_py.fact_statistical t 
left join 
	nba_dwh_py.dim_start_position dsp 
	on t.start_position_id  = dsp.start_position_id
group by 
	dsp.position_name 
;



---Query 2---
-- Jugador con mayor numero de puntos por año y sus porcenatajes de tiros.
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




---Query 3---
-- Jugador con mayor porcentaje de tiro (se considera la suma de los 3 porcentajes) y con más del 50 % de los partidos jugado por año. 
-- Aqui hay que recalcar algo importante, puedes ser jugador con más puntos del año, pero no necesariamente 
-- ese mismo jugador es el que tenga los mejores porcentajes de tiros.
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

--Estos resultados los vamos a utilizar para analizar en el tablero,
--para ver como se comportaron a lo largo del tiempo estos jugadores. 





--Query aux-- 
-- Juegos jugados por año
select 
	year, 
	count(distinct t.game_id ) juegos_anio
from
	nba_dwh_py.fact_statistical t 
left join 
	nba_dwh_py.dim_date dd 
	on 
		t.date_id = dd.date_id 
group by 
	1
;	
--- Esto es importante por que en el Dashboard se ve que en 2011 hubo una baja pero, se debe a que hubo menos partidos jugados  









