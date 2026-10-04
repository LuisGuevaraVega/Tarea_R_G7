# Copias de figuras y tablas

Todo lo que hay acá lo **genera el reporte al renderizarse** (`quarto render docs/reporte_ninis.qmd`),
en el bloque `exportes`. No editar a mano: se sobrescribe en cada compilación.

Existe para reutilizar el material en la exposición de 10 minutos sin tener que recortarlo del HTML.

## `figures/`

Las 7 figuras del reporte en PNG, 8 pulgadas de ancho a **300 ppp** (el HTML usa 150), listas para
proyectar. Numeradas en el orden en que aparecen en el documento.

| Archivo | Qué responde |
|---|---|
| `01_tasa_por_mes.png` | Por qué hubo que corregir el sesgo de las vacaciones escolares |
| `02_tendencia_nacional.png` | La evolución 2015-2025 con intervalo de confianza |
| `03_condiciones_actividad.png` | Las cuatro combinaciones entre estudiar y trabajar |
| `04_tasa_por_sexo.png` | La brecha de género |
| `05_tasa_por_grupo.png` | En qué grupos se concentra la condición |
| `06_situacion_nini.png` | Qué hacen los jóvenes nini |
| `07_tasa_por_departamento.png` | La dimensión territorial |

## `tables/`

Las 11 tablas del reporte, cada una en dos formatos:

- **`.html`** — con el mismo formato que en el reporte, para pegar en las diapositivas.
- **`.csv`** — los datos crudos detrás de la tabla, por si hay que rehacerla o recalcular algo.

`12_tasas_por_departamento.csv` no tiene tabla en el reporte: son los datos de la figura 7.
