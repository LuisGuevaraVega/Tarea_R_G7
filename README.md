# Jóvenes que no estudian ni trabajan en el Perú, 2015-2025

Trabajo final del curso **Fundamentos de R** — Diplomatura de Especialización en Ciencia de Datos
para las Ciencias Sociales y la Gestión Pública (2026).

**Grupo 7:** Luis Guevara, Rodrigo Norabuena y Marco Virú.

## Pregunta de investigación

> ¿Cómo evolucionó la proporción de jóvenes peruanos de 15 a 29 años que no estudian ni trabajan
> entre 2015 y 2025, y en qué grupos se concentra esta condición?

## Datos

Encuesta Nacional de Hogares (ENAHO), metodología actualizada, del Instituto Nacional de Estadística
e Informática del Perú. Se usan los módulos 02 (miembros del hogar), 03 (educación) y 05 (empleo e
ingresos) de los años 2014 a 2025: 36 archivos de microdatos, con más de 1,5 millones de registros de
personas.

Descarga: <https://proyectos.inei.gob.pe/microdatos/>

Los 48 archivos ZIP originales están versionados en `data/raw/`, de modo que el análisis es
reproducible sin volver a descargar nada.

## Cómo reproducir

1. Clonar el repositorio y abrir `Tarea_R_G7.Rproj` en RStudio.
2. Si faltaran los datos, ejecutar `scripts/01_descargar_enaho.R`.
3. Renderizar el reporte:

   ```
   quarto render docs/reporte_ninis.qmd
   ```

La primera compilación lee los 36 archivos de microdatos y tarda alrededor de un minuto. Las
siguientes usan el extracto cacheado en `data/processed/`, que se invalida solo si cambian los años
o la lista de variables.

Requiere R 4.4 o superior con `tidyverse`, `haven`, `survey`, `srvyr`, `gt` y `scales`, y Quarto 1.4
o superior.

## Estructura

```
├── _quarto.yml                 Configuración del proyecto (execute-dir: project)
├── data/
│   ├── raw/<año>/              48 ZIP de la ENAHO, tal como los distribuye el INEI
│   └── processed/              Extracto cacheado que genera el propio reporte
├── docs/
│   ├── reporte_ninis.qmd       EL ENTREGABLE: todo el análisis, de punta a punta
│   ├── reporte_ninis.html      Reporte renderizado
│   ├── registro_metodologico.md    Decisiones, verificaciones y evidencia
│   ├── diccionario_variables.md    Codificación de cada variable, año por año
│   ├── etiquetas_enaho_2014_2025.tsv   Evidencia cruda de la auditoría
│   ├── referencias.bib         Bibliografía
│   └── apa.csl                 Estilo de citación APA 7.ª edición
├── scripts/
│   ├── 01_descargar_enaho.R    Descarga de los microdatos
│   └── 02_generar_diccionario.R    Genera el diccionario de variables
└── outputs/                    Tablas y figuras sueltas para la exposición
```

El reporte es **autosuficiente**: contiene la importación, la limpieza, el análisis y la redacción.
Lo único que vive fuera es la descarga de los datos, porque baja 693 MB y no puede correr en cada
compilación; aun así el `.qmd` muestra ese código sin ejecutarlo.

## Documentación

- [`docs/registro_metodologico.md`](docs/registro_metodologico.md) — por qué el reporte dice lo que
  dice: definición operativa, criterio de área urbana y rural con la cita oficial, elección del
  factor de expansión, corrección del sesgo estacional y trampas técnicas del pipeline.
- [`docs/diccionario_variables.md`](docs/diccionario_variables.md) — las 37 variables usadas, con su
  codificación verificada en los doce años.

## Licencia

MIT. Ver [LICENSE](LICENSE).
