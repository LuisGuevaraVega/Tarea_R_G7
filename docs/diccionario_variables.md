# Diccionario de variables ENAHO 2014-2025

> Documento generado por `scripts/02_generar_diccionario.R`. **No editar a mano.**

Fuente: *value labels* de Stata embebidos en los 36 archivos `.dta` (12 anios x modulos 200, 300 y 500) que el INEI distribuye dentro de los ZIP de `data/raw/`. Se usan los labels del dato y no los PDF de diccionario porque son la codificacion tal como quedo efectivamente aplicada al microdato.

Evidencia cruda completa: [`etiquetas_enaho_2014_2025.tsv`](etiquetas_enaho_2014_2025.tsv).

## 1. Resumen de estabilidad

La columna *Versiones* cuenta variantes de etiqueta **ignorando mayusculas, tildes y puntuacion**: solo se reportan diferencias reales de redaccion, no de formato.

| Modulo | Variable | Rol en el analisis | Anios | Versiones | Diagnostico |
|---|---|---|---|---|---|
| 200 | `codperso` | Llave de persona | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 200 | `conglome` | Llave / UPM del diseno muestral | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 200 | `dominio` | Region natural + Lima Metropolitana | 12 | 1 | Identica en los 12 anios |
| 200 | `estrato` | Area urbano/rural (1-5 urbano, 6-8 rural) | 12 | 3 | Solo cambia la redaccion; los codigos son los mismos |
| 200 | `facpob07` | Factor de expansion poblacional (modulo 200) | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 200 | `hogar` | Llave | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 200 | `mes` | Mes de entrevista (control de estacionalidad) | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 200 | `p203` | Parentesco (rol en el hogar) | 12 | 2 | CAMBIO DE ESTRUCTURA: aparecen o desaparecen codigos |
| 200 | `p204` | Residencia habitual | 12 | 1 | Identica en los 12 anios |
| 200 | `p205` | Residencia habitual (ausencia 30+ dias) | 12 | 1 | Identica en los 12 anios |
| 200 | `p206` | Residencia habitual (presencia 30+ dias) | 12 | 1 | Identica en los 12 anios |
| 200 | `p207` | Sexo | 12 | 1 | Identica en los 12 anios |
| 200 | `p208a` | Edad en anios cumplidos (filtro 15-29) | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 200 | `p209` | Estado civil | 12 | 1 | Identica en los 12 anios |
| 200 | `ubigeo` | Departamento = primeros 2 digitos | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 200 | `vivienda` | Llave | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 300 | `codperso` | Llave de persona | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 300 | `conglome` | Llave / UPM del diseno muestral | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 300 | `factora07` | Factor del modulo 300 (NO se usa para ponderar) | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 300 | `hogar` | Llave | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 300 | `p301a` | Nivel educativo alcanzado | 12 | 6 | CAMBIO DE ESTRUCTURA: aparecen o desaparecen codigos |
| 300 | `p306` | Matriculado el presente anio -> ESTUDIA | 12 | 1 | Identica en los 12 anios |
| 300 | `p307` | Asiste actualmente -> ESTUDIA | 12 | 1 | Identica en los 12 anios |
| 300 | `p313` | Razon para no estudiar (11 categorias) | 12 | 3 | Solo cambia la redaccion; los codigos son los mismos |
| 300 | `t313a` | Razon recodificada por INEI (18 cat., incluye COVID) | 12 | 4 | CAMBIO DE ESTRUCTURA: aparecen o desaparecen codigos |
| 300 | `vivienda` | Llave | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 500 | `codperso` | Llave de persona | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 500 | `conglome` | Llave / UPM del diseno muestral | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 500 | `fac500a` | Factor de expansion de empleo -> EL QUE USAMOS | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 500 | `hogar` | Llave | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |
| 500 | `ocu500` | Indicador de la PEA -> TRABAJA | 12 | 1 | Identica en los 12 anios |
| 500 | `p501` | Trabajo la semana pasada | 12 | 1 | Identica en los 12 anios |
| 500 | `p502` | Tiene empleo fijo al que volvera | 12 | 1 | Identica en los 12 anios |
| 500 | `p503` | Tiene negocio propio al que volvera | 12 | 1 | Identica en los 12 anios |
| 500 | `p545` | Busco trabajo la semana pasada | 12 | 1 | Identica en los 12 anios |
| 500 | `p546` | Que estuvo haciendo -> situacion del nini | 12 | 3 | Solo cambia la redaccion; los codigos son los mismos |
| 500 | `p547` | Deseaba trabajar (desempleo oculto) | 12 | 1 | Identica en los 12 anios |
| 500 | `vivienda` | Llave | 12 | - | Sin etiquetas de valor (continua o alfanumerica) |

## 2. Codificacion detallada

### Modulo 200 - `codperso`

**Etiqueta INEI (ultimo anio):** Numero de orden de la persona  
**Universo:** Todos  
**Rol:** Llave de persona  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 200 - `conglome`

**Etiqueta INEI (ultimo anio):** Numero de conglomerado  
**Universo:** Todos  
**Rol:** Llave / UPM del diseno muestral  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 200 - `dominio`

**Etiqueta INEI (ultimo anio):** Dominio geografico  
**Universo:** Todos  
**Rol:** Region natural + Lima Metropolitana  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Costa Norte | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | Costa Centro | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 3 | Costa Sur | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 4 | Sierra Norte | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 5 | Sierra Centro | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 6 | Sierra Sur | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 7 | Selva | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 8 | Lima Metropolitana | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 200 - `estrato`

**Etiqueta INEI (ultimo anio):** Estrato geografico  
**Universo:** Todos  
**Rol:** Area urbano/rural (1-5 urbano, 6-8 rural)  
**Diagnostico:** Solo cambia la redaccion; los codigos son los mismos

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | centros poblados con más de 100,000 viviendas | 2014 |
| 1 | mayor de 100,000 viviendas | 2015 |
| 1 |  De 500 000 a mas habitantes | 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | centros poblados de 20,001 a 100,000 viviendas | 2014 |
| 2 | de 20,001 a 100,000 viviendas | 2015 |
| 2 |  De 100 000 a 499 999 habitantes | 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 3 | centros poblados de 10,001 a 20,000 viviendas | 2014 |
| 3 | de 10,001 a 20,000 viviendas | 2015 |
| 3 |  De 50 000 a 99 999 habitantes | 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 4 | centros poblados de 4,001 a 10,000 viviendas | 2014 |
| 4 | de 4,001 a 10,000 viviendas | 2015 |
| 4 |  De 20 000 a 49 999 habitantes | 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 5 | centros poblados de 401 a 4,000 viviendas | 2014 |
| 5 | 401 a 4,000 viviendas | 2015 |
| 5 | De 2 000 a 19 999 habitantes | 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 6 | centros poblados con menos de 401 viviendas | 2014 |
| 6 | menos de 401 viviendas | 2015 |
| 6 |  De 500 a 1 999 habitantes | 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 7 | Area de Empadronamiento Rural (AER) Compuesto | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 8 | Area de Empadronamiento Rural (AER) Simple | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 200 - `facpob07`

**Etiqueta INEI (ultimo anio):** Factor de expansion anual de poblacion proyecciones CPV-2007  
**Universo:** Miembros del hogar  
**Rol:** Factor de expansion poblacional (modulo 200)  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 200 - `hogar`

**Etiqueta INEI (ultimo anio):** Numero secuencial del Hogar  
**Universo:** Todos  
**Rol:** Llave  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 200 - `mes`

**Etiqueta INEI (ultimo anio):** Mes de ejecucion de la encuesta  
**Universo:** Todos  
**Rol:** Mes de entrevista (control de estacionalidad)  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 200 - `p203`

**Etiqueta INEI (ultimo anio):** Cual es la relacion de parentesco con el jefe(a) del hogar  
**Universo:** Miembros del hogar  
**Rol:** Parentesco (rol en el hogar)  
**Diagnostico:** CAMBIO DE ESTRUCTURA: aparecen o desaparecen codigos

| Codigo | Etiqueta | Anios |
|---|---|---|
| 0 | Panel | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 1 | Jefe/Jefa | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | esposo/esposa | 2014, 2015, 2016, 2017 |
| 2 | Esposo(a)/compañero(a) | 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 3 | hijo/hija | 2014, 2015, 2016, 2017 |
| 3 | Hijo(a)/Hijastro(a) | 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 4 | Yerno/Nuera | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 5 | nieto | 2014, 2015, 2016, 2017 |
| 5 | Nieto(a) | 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 6 | Padres/Suegros | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 7 | Otros parientes | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 8 | Trabajador Hogar | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 9 | Pensionista | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 10 | Otros no parientes | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 11 | Hermano(a) | 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 200 - `p204`

**Etiqueta INEI (ultimo anio):** Es miembro del hogar  
**Universo:** Miembros del hogar  
**Rol:** Residencia habitual  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Si | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | No | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 200 - `p205`

**Etiqueta INEI (ultimo anio):** Se encuentra ausente del hogar 30 dias o mas  
**Universo:** Miembros del hogar  
**Rol:** Residencia habitual (ausencia 30+ dias)  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Si | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | No | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 200 - `p206`

**Etiqueta INEI (ultimo anio):** Esta presente en el hogar 30 dias o mas  
**Universo:** No miembros presentes en el hogar  
**Rol:** Residencia habitual (presencia 30+ dias)  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Si | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | No | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 200 - `p207`

**Etiqueta INEI (ultimo anio):** Sexo  
**Universo:** Miembros del hogar  
**Rol:** Sexo  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Hombre | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | Mujer | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 200 - `p208a`

**Etiqueta INEI (ultimo anio):** Que edad tiene en años cumplidos (En años)  
**Universo:** Miembros del hogar  
**Rol:** Edad en anios cumplidos (filtro 15-29)  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 200 - `p209`

**Etiqueta INEI (ultimo anio):** Cual es su estado civil o conyugal  
**Universo:** Personas de 12 anios y mas  
**Rol:** Estado civil  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Conviviente | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | Casado(a) | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 3 | Viudo(a) | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 4 | Divorciado(a) | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 5 | Separado(a) | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 6 | Soltero(a) | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 200 - `ubigeo`

**Etiqueta INEI (ultimo anio):** Ubicacion geografica  
**Universo:** Todos  
**Rol:** Departamento = primeros 2 digitos  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 200 - `vivienda`

**Etiqueta INEI (ultimo anio):** Numero de seleccion de la vivienda  
**Universo:** Todos  
**Rol:** Llave  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 300 - `codperso`

**Etiqueta INEI (ultimo anio):** Codigo de la persona  
**Universo:** Todos  
**Rol:** Llave de persona  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 300 - `conglome`

**Etiqueta INEI (ultimo anio):** N° de conglomerado  
**Universo:** Todos  
**Rol:** Llave / UPM del diseno muestral  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 300 - `factora07`

**Etiqueta INEI (ultimo anio):** Factor de poblacion ajustado por grupo quinquenal Proyecciones CPV-2007  
**Universo:** Personas de 3 anios y mas  
**Rol:** Factor del modulo 300 (NO se usa para ponderar)  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 300 - `hogar`

**Etiqueta INEI (ultimo anio):**  N° secuencial del hogar  
**Universo:** Todos  
**Rol:** Llave  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 300 - `p301a`

**Etiqueta INEI (ultimo anio):** Cual es el ultimo año o grado de estudios y nivel que aprobo Nivel  
**Universo:** Personas de 3 anios y mas  
**Rol:** Nivel educativo alcanzado  
**Diagnostico:** CAMBIO DE ESTRUCTURA: aparecen o desaparecen codigos

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Sin nivel | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | Educacion inicial | 2014, 2015, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | inicial | 2016 |
| 3 | Primaria incompleta | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 4 | Primaria completa | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 5 | Secundaria incompleta | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 6 | Secundaria completa | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 7 | superior no universitaria incompleta | 2014, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 |
| 7 | sup. no univ. incompleta | 2015 |
| 7 | Superior no univ. Incompleta | 2025 |
| 8 | superior no universitaria completa | 2014, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 |
| 8 | sup. no univ. completa | 2015 |
| 8 | Superior no univ. completa | 2025 |
| 9 | superior universitaria incompleta | 2014, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 |
| 9 | sup. univ. incompleta | 2015 |
| 9 | Superior univ. incompleta | 2025 |
| 10 | superior universitaria completa | 2014, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 |
| 10 | sup. univ. completa | 2015 |
| 10 | Superior univ. completa | 2025 |
| 11 | post-grado universitario | 2014, 2016 |
| 11 | postgrado | 2015 |
| 11 | postgrado universitario | 2017 |
| 11 | Maestria / Doctorado | 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 12 | Basica especial | 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 300 - `p306`

**Etiqueta INEI (ultimo anio):** Este año, esta matriculado en algun centro o Prog. de educacion basica o superior  
**Universo:** Personas de 3 anios y mas  
**Rol:** Matriculado el presente anio -> ESTUDIA  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Si | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | No | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 300 - `p307`

**Etiqueta INEI (ultimo anio):** Actualmente, Asiste a algun centro o Prog. de educación basica o superior  
**Universo:** Matriculados (p306 = 1)  
**Rol:** Asiste actualmente -> ESTUDIA  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Si | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | No | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 300 - `p313`

**Etiqueta INEI (ultimo anio):** Cual es la principal razon por la que no esta matriculado o no asiste a algun ctro. o prog. de educacion...  
**Universo:** No matriculados o que no asisten  
**Rol:** Razon para no estudiar (11 categorias)  
**Diagnostico:** Solo cambia la redaccion; los codigos son los mismos

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Problemas economicos | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | Estoy trabajando | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 3 | termino sus estudios: secundarios/ superiores /asiste a academia preuniversitaria | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 |
| 3 | Termino sus estudios: secundarios/ superiores /asiste a academia preuniv. | 2025 |
| 4 | No tiene la edad suficiente (para el grupo 3-5 años) | 2014, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 4 | no tiene la edad suficiente | 2015 |
| 5 | Problemas familiares | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 6 | De vacaciones | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 7 | No existe centro de educacion basica o superior en el centro poblado | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 8 | Asiste a un centro de educacion tecnico productiva | 2014, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 8 | asiste a un centro de educación técnico productivo | 2015 |
| 9 | No me interesa/no me gusta el estudio | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 10 | Se dedica a los quehaceres del hogar | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 11 | Otra razon | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 300 - `t313a`

**Etiqueta INEI (ultimo anio):** (Recodificada ) Cual es la principal razon por la que no esta matriculado...  
**Universo:** No matriculados o que no asisten  
**Rol:** Razon recodificada por INEI (18 cat., incluye COVID)  
**Diagnostico:** CAMBIO DE ESTRUCTURA: aparecen o desaparecen codigos

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Problemas economicos | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | Estoy trabajando | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 3 | termino sus estudios: secundarios/ superiores /asiste a academia preuniversitaria | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 |
| 3 | Termino sus estudios: secundarios/ superiores /asiste a academia preuniv. | 2025 |
| 4 | No tiene la edad suficiente | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 5 | Problemas familiares | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 6 | De Vacaciones | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 7 | no existe centro de educacion basica o superior en el centro poblado | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024 |
| 7 | No existe centro de educacion basica o superior en el CCPP. | 2025 |
| 8 | Asiste a un centro de educacion tecnico productivo | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 9 | No me interesa/no me gusta el estudio | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 10 | Se dedica a los quehaceres del hogar | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 11 | Otra razon | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 12 | Asiste a un centro de enseñanza no regular | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 13 | Suspension de clases por COVID-19 | 2020, 2021, 2022, 2023, 2024, 2025 |
| 14 | Sin señal/equipo tecnologico/internet/electricidad | 2020, 2021, 2022, 2023, 2024, 2025 |
| 15 | No matriculado por cuarentena | 2020, 2021, 2022, 2023, 2024, 2025 |
| 16 | Traslado en proceso de centro estudios por COVID-19 | 2020, 2021, 2022, 2023, 2024, 2025 |
| 17 | Institucion educativa no licenciada | 2020, 2021, 2022, 2023, 2024, 2025 |
| 18 | No le gusta las clases virtuales/ No aprende en clases virtuales | 2022, 2023, 2024, 2025 |

### Modulo 300 - `vivienda`

**Etiqueta INEI (ultimo anio):**  N° de seleccion de la vivienda  
**Universo:** Todos  
**Rol:** Llave  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 500 - `codperso`

**Etiqueta INEI (ultimo anio):** N° de orden de la persona  
**Universo:** Todos  
**Rol:** Llave de persona  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 500 - `conglome`

**Etiqueta INEI (ultimo anio):** N° de Conglomerado  
**Universo:** Todos  
**Rol:** Llave / UPM del diseno muestral  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 500 - `fac500a`

**Etiqueta INEI (ultimo anio):** Factor de Expansion de Empleo/ingreso proyecciones CPV-2007  
**Universo:** Personas de 14 anios y mas  
**Rol:** Factor de expansion de empleo -> EL QUE USAMOS  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 500 - `hogar`

**Etiqueta INEI (ultimo anio):** N° secuencial del Hogar  
**Universo:** Todos  
**Rol:** Llave  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

### Modulo 500 - `ocu500`

**Etiqueta INEI (ultimo anio):** Indicador de la PEA  
**Universo:** Personas de 14 anios y mas  
**Rol:** Indicador de la PEA -> TRABAJA  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Ocupado | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | Desocupado abierto | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 3 | Desocupado oculto | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 4 | No PEA | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 500 - `p501`

**Etiqueta INEI (ultimo anio):** La semana pasada, del .. al ..., Tuvo Ud. algun trabajo  
**Universo:** Personas de 14 anios y mas  
**Rol:** Trabajo la semana pasada  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Si | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | No | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 500 - `p502`

**Etiqueta INEI (ultimo anio):** Aunque no trabajo la semana pasada, Tiene algun empleo fijo al que proximamente volvera  
**Universo:** No trabajaron la semana pasada  
**Rol:** Tiene empleo fijo al que volvera  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Si | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | No | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 500 - `p503`

**Etiqueta INEI (ultimo anio):** Aunque no trabajo la semana pasada, Tiene algun negocio propio al que proximamente volvera  
**Universo:** No trabajaron la semana pasada  
**Rol:** Tiene negocio propio al que volvera  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Si | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | No | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 500 - `p545`

**Etiqueta INEI (ultimo anio):** La semana pasada, Hizo algo para conseguir trabajo  
**Universo:** No ocupados  
**Rol:** Busco trabajo la semana pasada  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Si | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | No | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 500 - `p546`

**Etiqueta INEI (ultimo anio):** Que estuvo haciendo la semana pasada:  
**Universo:** No ocupados que no buscaron trabajo  
**Rol:** Que estuvo haciendo -> situacion del nini  
**Diagnostico:** Solo cambia la redaccion; los codigos son los mismos

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | hizo trámites, buscó local, gestionó préstamos por negocio | 2014, 2015 |
| 1 | Hizo tramites, busco local, gestiono prestamos para establecer su propio negocio | 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2024, 2025 |
| 1 | hizo thiramites, busco local, gestiono prestamos para establecer su propio negocio | 2023 |
| 2 | Reparando sus activos (local, maquina, equipo) | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 3 | esperando el inicio de un trabajo dependiente | 2014, 2015 |
| 3 | Esperando el inicio de un trabajo dependiente (como obrero, empleado, o trabajador del hogar) | 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 4 | Estudiando | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 5 | Quehaceres del hogar | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 6 | Vivia de su pension o jubilacion u otras rentas | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 7 | Enfermo o incapacitado | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 8 | Otro | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 500 - `p547`

**Etiqueta INEI (ultimo anio):** La semana pasada, Queria Ud. trabajar  
**Universo:** Inactivos  
**Rol:** Deseaba trabajar (desempleo oculto)  
**Diagnostico:** Identica en los 12 anios

| Codigo | Etiqueta | Anios |
|---|---|---|
| 1 | Si | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |
| 2 | No | 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025 |

### Modulo 500 - `vivienda`

**Etiqueta INEI (ultimo anio):** N° de Seleccion de Vivienda  
**Universo:** Todos  
**Rol:** Llave  
**Diagnostico:** Sin etiquetas de valor (continua o alfanumerica)

Sin etiquetas de valor: variable numerica o alfanumerica continua.

