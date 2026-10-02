# Registro metodológico

**Proyecto:** Jóvenes que no estudian ni trabajan en el Perú, 2015–2025
**Curso:** Fundamentos de R — Diplomatura de Especialización en Ciencia de Datos para las Ciencias Sociales y la Gestión Pública (2026)
**Última actualización:** 2 de octubre de 2026

> Este documento es el acta del proyecto: deja por escrito qué se verificó, qué se decidió y con qué
> evidencia. No reemplaza al reporte (`reporte_ninis.qmd`), que es el entregable. Existe para que
> dentro de seis meses cualquier integrante del grupo pueda reconstruir por qué el reporte dice lo
> que dice, y para responder preguntas de la exposición sin depender de la memoria.

**Documentos relacionados**

| Archivo | Contenido |
|---|---|
| [`diccionario_variables.md`](diccionario_variables.md) | Codificación de las 37 variables, año por año, generada automáticamente |
| [`etiquetas_enaho_2014_2025.tsv`](etiquetas_enaho_2014_2025.tsv) | Evidencia cruda: una fila por año × variable × código |
| `reporte_ninis.qmd` | El entregable: análisis completo, de la importación a las conclusiones |
| `../scripts/01_descargar_enaho.R` | Descarga de los 48 ZIP desde el portal del INEI |
| `../scripts/02_generar_diccionario.R` | Genera el diccionario y la evidencia cruda |

---

## 1. Pregunta de investigación

> ¿Cómo evolucionó la proporción de jóvenes peruanos de 15 a 29 años que no estudian ni trabajan
> entre 2015 y 2025, y en qué grupos se concentra esta condición?

El rango 15 a 29 años no es arbitrario: es el que define como *joven* la Ley N.º 27802, Ley del
Consejo Nacional de la Juventud (Congreso de la República del Perú, 2002). El indicador 8.6.1 de los
Objetivos de Desarrollo Sostenible usa en cambio el rango 15 a 24 (Naciones Unidas, 2015), por lo que
ese tramo se reporta como análisis de robustez y permite comparación internacional.

### Cómo se mapea a la rúbrica

| Criterio de evaluación | Puntos | Dónde se resuelve |
|---|---|---|
| Pregunta de investigación y descripción de los datos (con fuente) | 2 | Secciones 1 y 2 del reporte |
| Preprocesamiento y limpieza con tidyverse, documentados | 4 | Sección 3 del reporte, con `code-fold: show` |
| Tablas y gráficos pertinentes, claros y bien presentados | 4 | Sección 4: **7 gráficos y 11 tablas** (el mínimo exigido son 3 gráficos) |
| Interpretación de resultados y conclusiones | 4 | Sección 5 |
| Limitaciones | 1 | Sección 6 |
| Reproducibilidad, presentación y fuentes | 1 | Sección 7, citas en APA 7 |

---

## 2. Fuente de datos

Encuesta Nacional de Hogares (ENAHO), metodología actualizada, del Instituto Nacional de Estadística
e Informática (INEI, 2026). Se descargaron **48 archivos ZIP**: 12 años (2014–2025) × 4 módulos
(02, 03, 04 y 05), **693 MB** comprimidos.

- **Unidad de análisis:** la persona residente habitual del hogar.
- **Periodo:** 2014–2025. El titular del reporte es 2015–2025; 2014 entra como año de contexto previo.
- **Cobertura:** nacional, urbana y rural, 24 departamentos y la Provincia Constitucional del Callao.
- **Formato:** Stata (`.dta`). No hay `.sav` ni `.csv` en ningún ZIP.
- **URL de descarga:** `https://proyectos.inei.gob.pe/iinei/srienaho/descarga/STATA/<codigo>-Modulo<NN>.zip`

### Códigos de encuesta por año

| Año | Código | Año | Código | Año | Código |
|---|---|---|---|---|---|
| 2014 | 440 | 2018 | 634 | 2022 | 784 |
| 2015 | 498 | 2019 | 687 | 2023 | 906 |
| 2016 | 546 | 2020 | 737 | 2024 | 966 |
| 2017 | 603 | 2021 | 759 | 2025 | 1031 |

### Módulos usados

| Módulo | Archivo | Universo | Aporte al análisis |
|---|---|---|---|
| 200 | `enaho01-<año>-200.dta` | Miembros del hogar | Edad, sexo, parentesco, residencia habitual, geografía |
| 300 | `enaho01a-<año>-300.dta` | Personas de 3 años y más | Nivel educativo, matrícula y asistencia → **estudia** |
| 500 | `enaho01a-<año>-500.dta` | Personas de 14 años y más | Condición de actividad → **trabaja** |

El módulo 04 (Salud) se descarga pero **no se usa**. El módulo Sumaria (pobreza e ingresos del hogar)
no se descarga; su incorporación queda señalada como extensión natural del trabajo.

---

## 3. Auditoría de codificación

Antes de analizar nada se verificó que las variables significaran lo mismo en los 12 años. No se
asumió: se leyeron los *value labels* de Stata embebidos en los 36 archivos `.dta` relevantes, que son
la codificación tal como quedó efectivamente aplicada al microdato. El procedimiento está en
`scripts/02_generar_diccionario.R` y corre en unos 20 segundos.

### 3.1 Resultado general

| Diagnóstico | Variables |
|---|---|
| **Idéntica en los 12 años** | `ocu500`, `p306`, `p307`, `p545`, `p547`, `p501`, `p502`, `p503`, `p204`, `p205`, `p206`, `p207`, `p209`, `dominio` |
| **Solo cambia la redacción; los códigos son los mismos** | `estrato`, `p313`, `p546` |
| **Cambio de estructura: aparecen códigos nuevos** | `p203`, `p301a`, `t313a` |

**El núcleo del indicador —`ocu500`, `p306` y `p307`— es perfectamente comparable 2014–2025.** Esto
es lo más importante del ejercicio: la serie se puede construir sin ajustes de armonización.

### 3.2 `ocu500` en la ENAHO 2025

Existía la duda de si la variable `ocu500` seguía presente en la entrega 2025. **Está, y con la misma
codificación de siempre:**

| Código | Etiqueta | Años |
|---|---|---|
| 1 | Ocupado | 2014–2025 |
| 2 | Desocupado abierto | 2014–2025 |
| 3 | Desocupado oculto | 2014–2025 |
| 4 | No PEA | 2014–2025 |

Además, la ENAHO 2025 es un **año completo**: el campo `mes` recorre de 01 a 12.

### 3.3 Cambios de estructura y cómo se manejan

**`p203` (parentesco).** El código 11 «Hermano(a)» aparece **desde 2018**; antes la escala llegaba a
10. En paralelo, el código 3 pasa de «hijo/hija» a «hijo(a)/hijastro(a)» y el 2 de «esposo/esposa» a
«esposo(a)/compañero(a)». *Decisión:* agrupar en tres categorías (jefe o cónyuge · hijo(a) · otro),
de modo que el código 11 se absorbe sin romper la comparabilidad de la serie.

**`p301a` (nivel educativo).** El código 12 «básica especial» aparece **desde 2017**. El código 11
oscila entre «post grado universitario», «postgrado», «postgrado universitario» y «maestría /
doctorado» según el año, pero designa lo mismo. Los códigos 1 a 10 son idénticos en los 12 años.
*Decisión:* agrupar por nivel y documentar que el 12 no existe antes de 2017.

**`t313a` (razón para no estudiar, recodificada por INEI).** Es más rica que `p313`: suma los códigos
12 a 18, entre ellos **cinco categorías específicas de la pandemia** incorporadas en 2020
(suspensión de clases por COVID-19, falta de señal o equipo tecnológico, no matriculado por
cuarentena, traslado en proceso, institución no licenciada) y una más en 2022 (no le gustan las
clases virtuales). *Decisión:* usar `t313a` para la lectura de las razones de no estudiar, porque
permite explicar el salto de 2020 con las categorías del propio INEI en lugar de con una conjetura.

Se extraen **ambas**: `p313` para la corrección de vacaciones escolares (su código 6 es estable en
los doce años) y `t313a` cuando interesa el detalle de pandemia. La corrección de vacaciones acepta
cualquiera de las dos, por redundancia.

### 3.4 Variables cuya redacción cambia pero cuyos códigos no

**`p313`** mantiene sus 11 códigos con el mismo significado en los 12 años. En particular, el
**código 6 «De vacaciones» existe en todos**, lo que habilita la corrección del artefacto estacional
descrita en la sección 4.3. Las diferencias son cosméticas: en 2025 «preuniversitaria» aparece
truncado a «preuniv»; en 2015 el código 4 omite la precisión «para el grupo 3-5 años».

**`p546`** mantiene sus 8 códigos. Entre ellos, 4 «Estudiando», 5 «Quehaceres del hogar»,
6 «Vivía de su pensión o jubilación u otras rentas» y 7 «Enfermo o incapacitado» en los 12 años.
Dato menor pero ilustrativo del valor de auditar: el diccionario 2023 trae el código 1 con el error
tipográfico «hizo **thiramites**».

### 3.5 Suposiciones derribadas

| Suposición frecuente | Qué muestra la evidencia |
|---|---|
| `factora07` es el factor del módulo 500 | **No existe en el módulo 500** en ningún año. Es del módulo 300. |
| El factor de empleo puede llamarse `fac500a7` en años antiguos | No existe. Se llama `fac500a` en los 12 años. |
| La recodificada de `p313` se llama `t313` | **`t313` no existe en ningún año.** Siempre es `t313a`. |
| `factor07` está en los módulos 200 y 500 | No está. El peso del módulo 200 es `facpob07`. |

---

## 4. Decisiones metodológicas

### 4.1 Definición operativa de nini

Una persona de 15 a 29 años, residente habitual, se clasifica como **nini** cuando no estudia y no
trabaja:

- **No estudia:** no está matriculada en el año en curso o, estándolo, no asiste actualmente
  (`p306 ≠ 1` o `p307 ≠ 1`). La variable `p307` solo se pregunta a quienes declararon `p306 = 1`,
  de modo que la ausencia de respuesta se trata explícitamente como «no asiste».
- **No trabaja:** no está ocupada según el indicador oficial de la PEA (`ocu500 ≠ 1`).

**Residente habitual.** La Ficha Técnica (INEI, 2025) lo define como quien cumple alguno de estos
requisitos: ser miembro del hogar familiar, hallarse presente 30 días o más aunque no sea su hogar, o
ser trabajador del hogar con cama adentro. Se implementa como
`(p204 == 1 & p205 == 2) | (p204 == 2 & p206 == 1)`.

**Nota sobre la PEA.** La Población en Edad de Trabajar del INEI arranca en los **14 años**, no en
los 15. El rango 15–29 cae por completo dentro del universo del módulo 500, de modo que no hay
truncamiento.

### 4.2 Área urbana y rural

Esta decisión se resolvió con la fuente, no por convención heredada. Las Fichas Técnicas de 2015 y de
2025 dicen **exactamente lo mismo** al definir las unidades de muestreo:

> *En el Área Urbana: la Unidad Primaria de Muestreo (UPM) es el centro poblado urbano con 2 mil y
> más habitantes.*
>
> *En el Área Rural: la UPM es de dos tipos: el centro poblado urbano con 500 a menos de 2 mil
> habitantes, y el Área de Empadronamiento Rural (AER).*
> (INEI, 2015, p. 3; INEI, 2025, p. 7)

El estrato 6 corresponde a «de 500 a 1 999 habitantes» y los estratos 7 y 8 a las AER. Por lo tanto,
para el INEI, **los estratos 6, 7 y 8 son área rural**.

En 2016 cambió la unidad con que el INEI describe el estrato —de número de viviendas a número de
habitantes— pero **la frontera no se movió**: los estratos 1 a 5 agrupan en 2014–2015 a los centros
poblados de 401 y más viviendas y en 2016–2025 a los de 2 000 y más habitantes, que son el mismo
umbral expresado de dos maneras.

**Regla aplicada:** `estrato <= 5` → Urbano; `estrato >= 6` → Rural, en los 12 años.

### 4.3 Artefacto estacional de enero a marzo

El año escolar peruano comienza en marzo. Un joven entrevistado en enero o febrero responde que «este
año» todavía no está matriculado, lo que lo clasifica erróneamente como que no estudia. El efecto no
es menor: **infla la tasa de nini entre 3,7 y 5,1 puntos porcentuales**.

Hay dos formas de tratarlo:

1. Restringir la muestra a abril–diciembre, descartando cerca de la cuarta parte de las observaciones.
2. Reclasificar como estudiante a quien declara explícitamente estar «de vacaciones» (`p313 = 6` o
   `t313a = 6`), categoría presente en los 12 años.

**Se adopta la segunda** porque corrige la causa y no el síntoma, y conserva la muestra completa. La
primera se reporta como análisis de robustez, junto con la serie sin ninguna corrección, para que el
lector pueda ver cuánto depende el resultado de este supuesto.

### 4.4 Factor de expansión

Se pondera con **`fac500a`**, el factor del módulo 500: población de 14 años y más, ajustada por sexo
y grupos de edad. Es el coherente con el indicador, porque la condición de ocupación proviene de
`ocu500`, que vive en ese módulo.

No se usa `factora07` (módulo 300): ponderar una unión de los módulos 300 y 500 con el factor del 300
mezclaría poblaciones de referencia distintas. Como corolario operativo, la muestra analítica se
restringe a quienes tienen registro en el módulo 500; los jóvenes del módulo 200 sin ese registro se
cuentan y se reportan en la tabla de flujo de casos en lugar de desaparecer en silencio.

La Ficha Técnica precisa que los factores «son ajustados teniendo en cuenta las proyecciones de
población por grupos de edad y sexo para cada mes de encuesta y niveles de inferencia propuestos en
el diseño de la muestra» (INEI, 2025, p. 27).

### 4.5 Diseño muestral

La ENAHO es una muestra probabilística, de áreas, estratificada, bietápica e independiente en cada
departamento, con nivel de confianza del 95 % (INEI, 2025). Las estimaciones con intervalos de
confianza se calculan con `srvyr`, declarando el conglomerado como unidad primaria de muestreo y el
estrato geográfico como estrato, **ambos interactuados con el año**: el código de conglomerado se
reutiliza entre años y en 2014 tiene cuatro dígitos en lugar de seis.

**Niveles de inferencia oficiales** (idénticos en 2015 y 2025): Nacional, Urbano Nacional, Rural
Nacional, los 24 departamentos como dominios de estudio, Costa/Sierra/Selva por Urbano y Rural, y
Área Metropolitana de Lima y Callao. Las cuatro desagregaciones del reporte —sexo, área, grupo
etario, nivel educativo y región— se apoyan en dominios previstos por el diseño.

---

## 5. Trampas técnicas del pipeline

Verificadas en los archivos reales. Documentarlas evita repetir el trabajo de descubrirlas.

### 5.1 La estructura interna de los ZIP no es consistente

El archivo de datos no siempre está en una carpeta con el nombre del ZIP:

| Caso | Ejemplo real |
|---|---|
| Carpeta con guion (lo habitual) | `440-Modulo02/enaho01-2014-200.dta` |
| Carpeta con **guion bajo** | `498_Modulo02/enaho01-2015-200.dta` |
| **Sin carpeta**, en la raíz del ZIP | `enaho01a-2015-300.dta` |

Los dos últimos casos son de 2015 y **no se detectaron hasta ejecutar el pipeline**: un patrón
anclado a la carpeta (`^<código>-Modulo0N/...`) falla ahí de forma silenciosa.

Por eso el patrón de búsqueda se ancla al **nombre de archivo**, no a la carpeta:
`(^|/)enaho01a?-<año>-<módulo>[.]dta$`.

### 5.2 Archivos que un `*.dta` arrastraría por error

- Tablas auxiliares de clasificadores: `enaho_tabla_ciuo_88.dta`, `enaho_tabla_ciiu_rev3.dta`,
  `enaho_tabla_cno_2015.dta`, y sus variantes con guiones en los años antiguos.
- **2015, módulo 05 trae el archivo duplicado**: `enaho01a-2015-500.dta` y
  `enaho01a-2015_500.dta`, este último con guion bajo. El patrón con guion antes del módulo lo
  descarta correctamente; una búsqueda por `500` se quedaría con los dos.
- Archivos complementarios `enaho01a-<año>-300a.dta` en 2014–2021, ausentes desde 2022.

### 5.3 La ENAHO 2025 cambió de formato Stata

| | 2014–2024 | 2025 |
|---|---|---|
| Release `.dta` | 113 (y 115 en algunos módulos) | **118** (Stata 14+) |
| Codificación | latin1 | UTF-8 |
| Inflación ZIP → DTA | ~11× | ~39× |

El módulo 500 de 2025 pasa de 23 MB comprimidos a **909 MB** descomprimidos, con 1 413 columnas. Es
el mismo contenido: el formato 118 reserva 4 bytes por carácter. **Consecuencia práctica: seleccionar
columnas al leer no es una optimización, es un requisito.** Sin ello el pipeline no corre en una
computadora normal.

### 5.4 Otras particularidades verificadas

- **La primera columna se llama `aÑo`, con eñe mayúscula**, en los 12 años. Se evita leerla: el año se
  inyecta desde el nombre de la carpeta.
- **Las llaves son de tipo texto y tienen ceros a la izquierda significativos**: `conglome`,
  `vivienda`, `hogar`, `codperso`, `ubigeo`, `mes`. Convertirlas a numérico rompe los cruces.
- **`conglome` tiene 4 dígitos en 2014 y 6 desde 2015.**
- `haven::read_dta()` acepta leer desde una conexión `unz()`, pero **`col_select` no funciona sobre
  una conexión**: exige una ruta real. Hay que descomprimir la entrada a un directorio temporal y leer
  desde ahí.
- `read_dta(..., n_max = 100)` devuelve los *value labels* completos. Auditar los 36 archivos, el de
  909 MB incluido, toma menos de 20 segundos.
- Los nombres de archivo dentro de los ZIP de 2014 están en latin1 y rompen `grep()` en R salvo que se
  use `useBytes = TRUE`.
- El PDF de diccionario viene en cada ZIP, pero **con nombre variable**: `Diccionario2014.pdf`,
  `Diccionario_2019.pdf`, `Diccionario2024.pdf`, `Diccionario_2025.pdf`. Hay que buscarlo por patrón.

### 4.6 Dos hallazgos que cambiaron la lectura de los resultados

Ambos aparecieron al ejecutar el análisis, no al planificarlo, y quedan registrados porque
condicionan cómo debe leerse el reporte.

**El nivel educativo está confundido con la edad.** A primera vista, «secundaria incompleta» muestra
una tasa de nini bajísima (6,8 % en 2025), lo que sugeriría que abandonar la secundaria protege. Es
un espejismo: entre los 15 y los 19 años, el **94,4 %** de quienes tienen secundaria incompleta
**sigue estudiando**, porque la están cursando. Su nivel no está incompleto, está *en curso*. El
gradiente educativo real solo se ve dentro del grupo de 25 a 29 años, donde la trayectoria ya
terminó: va de 40,7 % con primaria o menos a 13,4 % con universitaria completa. *Decisión:* el
reporte presenta la tabla de educación cruzada por grupo de edad y advierte el problema de forma
explícita.

**Un 16 % de los nini declara estar estudiando en el módulo de empleo.** La variable `p546` del
módulo 500 tiene el código 4 «Estudiando», que algunas personas marcan pese a no figurar
matriculadas en el módulo 300. Lo más probable es que se trate de academias preuniversitarias,
cursos cortos o centros técnico-productivos, es decir, formación fuera del sistema formal. Esto
importa porque el indicador 8.6.1 de los ODS excluye no solo a quienes estudian sino también a
quienes **reciben capacitación**. *Decisión:* mantener la definición basada en matrícula y
asistencia formal como principal, por ser la comparable con las estadísticas oficiales del INEI, y
reportar la variante estricta en la tabla de robustez, donde la tasa baja alrededor de 3 puntos
porcentuales. La advertencia queda escrita en el reporte para quien compare con fuentes
internacionales.

---

## 6. Limitaciones conocidas

1. **Imputación Hot Deck.** El INEI imputa las variables cualitativas de los módulos 300, 400 y 500 a
   los miembros del hogar que no informaron **los tres simultáneamente** (INEI, 2025, p. 28). Parte de
   los valores de `p306`, `p307` y `ocu500` son, por lo tanto, imputados y no declarados.
2. **La muestra tiene componente panel.** En 2025, 12 096 de las 36 594 viviendas son panel. Los años
   no son muestras independientes, lo que obliga a leer la serie como cortes transversales agrupados y
   no como seguimiento de personas.
3. **ENAHO 2020 se levantó con entrevista mixta** (presencial más telefónica) por la emergencia
   sanitaria. El salto de ese año combina un efecto real sobre el empleo y la educación con un posible
   efecto de modo de recolección.
4. **Códigos nuevos a mitad de la serie:** `p203` desde 2018, `p301a` desde 2017, `t313a` desde 2020.
   Las agrupaciones elegidas los absorben, pero conviene tenerlo presente al leer esas desagregaciones.
5. **El análisis es descriptivo, no causal.** Identifica en qué grupos se concentra la condición de
   nini; no establece qué la produce.
6. **Sin dimensión de pobreza ni ingreso del hogar:** requiere el módulo Sumaria, que no se descargó.
7. **El supuesto de vacaciones escolares es el más influyente del trabajo** y por eso se reporta su
   sensibilidad de manera explícita.

---

## 7. Decisiones de gestión del proyecto

| Decisión | Detalle |
|---|---|
| Desagregaciones del análisis | Sexo, área urbano/rural, grupo etario (15–19 / 20–24 / 25–29), nivel educativo y región natural o departamento |
| Datos crudos en el repositorio | Los 693 MB de `data/raw/` se mantienen versionables. Ningún ZIP supera los 100 MB por archivo. Conviene versionar y subir **año por año** para que el envío no expire |
| Autosuficiencia del entregable | Todo el pipeline vive dentro de `reporte_ninis.qmd`, con un caché invalidado por hash de la configuración. Solo la descarga queda en un script externo, y el `.qmd` la muestra igual en un bloque sin ejecutar |
| Citación | APA 7, resuelta con `bibliography` y `csl` de Quarto; no se escriben citas a mano |

---

## 8. Entorno de ejecución

| Componente | Versión |
|---|---|
| R | 4.6.1 (no está en el `PATH`: usar `C:\Program Files\R\R-4.6.1\bin\Rscript.exe`) |
| Quarto | 1.10.18 |
| haven | 2.5.5 |
| dplyr | 1.2.1 |
| survey / srvyr | 4.5 / 1.3.1 |
| ggplot2 | 4.0.3 |
| gt | 1.3.0 |

El `.qmd` vive en `docs/` pero lee rutas relativas a la raíz del proyecto gracias a
`execute-dir: project` en `_quarto.yml`.

---

## 9. Referencias

Congreso de la República del Perú. (2002). *Ley N.º 27802, Ley del Consejo Nacional de la Juventud*.
Diario Oficial El Peruano.

Instituto Nacional de Estadística e Informática. (2015). *Encuesta Nacional de Hogares sobre
Condiciones de Vida y Pobreza 2015: Ficha técnica*. INEI.

Instituto Nacional de Estadística e Informática. (2025). *Encuesta Nacional de Hogares: Ficha técnica
2025*. Dirección Nacional de Censos y Encuestas, INEI.

Instituto Nacional de Estadística e Informática. (2026). *Encuesta Nacional de Hogares (ENAHO)
2014–2025* [Conjunto de datos]. Microdatos INEI. https://proyectos.inei.gob.pe/microdatos/

Naciones Unidas. (2015). *Transformar nuestro mundo: la Agenda 2030 para el Desarrollo Sostenible*
(Resolución A/RES/70/1). Asamblea General de las Naciones Unidas.

Organización Internacional del Trabajo. (1983). *Resolución sobre estadísticas de la población
económicamente activa, del empleo, del desempleo y del subempleo*. XIII Conferencia Internacional de
Estadísticos del Trabajo. OIT.
