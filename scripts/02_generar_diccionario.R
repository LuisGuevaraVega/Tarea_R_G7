## -----------------------------------------------------------------------------
## 02_generar_diccionario.R
##
## Audita la codificacion de las variables ENAHO usadas en el reporte, leyendo los
## value labels de Stata embebidos en cada .dta. Esos labels son la fuente de
## verdad: son el diccionario tal como quedo aplicado al dato, no la version PDF
## que puede ir por detras.
##
## Produce DOCUMENTACION, no insumos del analisis. El reporte
## (docs/reporte_ninis.qmd) vuelve a extraer las etiquetas por su cuenta para
## mostrar la evidencia de limpieza; este script existe para dejar el diccionario
## completo por escrito.
##
## Salidas:
##   docs/diccionario_variables.md        diccionario legible, codificacion anio por anio
##   docs/etiquetas_enaho_2014_2025.tsv   evidencia cruda (anio x variable x codigo)
##
## Uso: "C:/Program Files/R/R-4.6.1/bin/Rscript.exe" scripts/02_generar_diccionario.R
## -----------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(haven); library(dplyr); library(purrr); library(tidyr)
  library(stringr); library(tibble); library(readr)
})

raiz  <- if (dir.exists("data/raw")) "." else ".."
anios <- 2014:2025

codigos <- c("2014" = "440", "2015" = "498", "2016" = "546", "2017" = "603",
             "2018" = "634", "2019" = "687", "2020" = "737", "2021" = "759",
             "2022" = "784", "2023" = "906", "2024" = "966", "2025" = "1031")

llaves <- c("conglome", "vivienda", "hogar", "codperso")

vars_modulo <- list(
  "200" = c(llaves, "mes", "ubigeo", "dominio", "estrato", "p203", "p204", "p205",
            "p206", "p207", "p208a", "p209", "facpob07"),
  "300" = c(llaves, "p301a", "p306", "p307", "p313", "t313a", "factora07"),
  "500" = c(llaves, "ocu500", "p501", "p502", "p503", "p545", "p546", "p547", "fac500a")
)

## --- Metadatos curados: universo y rol de cada variable -----------------------
meta <- tribble(
  ~variable,   ~universo,                             ~rol,
  "conglome",  "Todos",                               "Llave / UPM del diseno muestral",
  "vivienda",  "Todos",                               "Llave",
  "hogar",     "Todos",                               "Llave",
  "codperso",  "Todos",                               "Llave de persona",
  "mes",       "Todos",                               "Mes de entrevista (control de estacionalidad)",
  "ubigeo",    "Todos",                               "Departamento = primeros 2 digitos",
  "dominio",   "Todos",                               "Region natural + Lima Metropolitana",
  "estrato",   "Todos",                               "Area urbano/rural (1-5 urbano, 6-8 rural)",
  "p203",      "Miembros del hogar",                  "Parentesco (rol en el hogar)",
  "p204",      "Miembros del hogar",                  "Residencia habitual",
  "p205",      "Miembros del hogar",                  "Residencia habitual (ausencia 30+ dias)",
  "p206",      "No miembros presentes en el hogar",   "Residencia habitual (presencia 30+ dias)",
  "p207",      "Miembros del hogar",                  "Sexo",
  "p208a",     "Miembros del hogar",                  "Edad en anios cumplidos (filtro 15-29)",
  "p209",      "Personas de 12 anios y mas",          "Estado civil",
  "facpob07",  "Miembros del hogar",                  "Factor de expansion poblacional (modulo 200)",
  "p301a",     "Personas de 3 anios y mas",           "Nivel educativo alcanzado",
  "p306",      "Personas de 3 anios y mas",           "Matriculado el presente anio -> ESTUDIA",
  "p307",      "Matriculados (p306 = 1)",             "Asiste actualmente -> ESTUDIA",
  "p313",      "No matriculados o que no asisten",    "Razon para no estudiar (11 categorias)",
  "t313a",     "No matriculados o que no asisten",    "Razon recodificada por INEI (18 cat., incluye COVID)",
  "factora07", "Personas de 3 anios y mas",           "Factor del modulo 300 (NO se usa para ponderar)",
  "ocu500",    "Personas de 14 anios y mas",          "Indicador de la PEA -> TRABAJA",
  "p501",      "Personas de 14 anios y mas",          "Trabajo la semana pasada",
  "p502",      "No trabajaron la semana pasada",      "Tiene empleo fijo al que volvera",
  "p503",      "No trabajaron la semana pasada",      "Tiene negocio propio al que volvera",
  "p545",      "No ocupados",                         "Busco trabajo la semana pasada",
  "p546",      "No ocupados que no buscaron trabajo", "Que estuvo haciendo -> situacion del nini",
  "p547",      "Inactivos",                           "Deseaba trabajar (desempleo oculto)",
  "fac500a",   "Personas de 14 anios y mas",          "Factor de expansion de empleo -> EL QUE USAMOS"
)

## --- Lectura de los value labels ----------------------------------------------
leer_meta <- function(anio, modulo) {
  cod  <- codigos[[as.character(anio)]]
  zipf <- file.path(raiz, "data/raw", anio,
                    sprintf("%s-Modulo%02d.zip", cod, modulo %/% 100))
  stopifnot("ZIP no encontrado" = file.exists(zipf))

  entradas <- unzip(zipf, list = TRUE)$Name
  ## Se ancla al NOMBRE DE ARCHIVO, no a la carpeta: la estructura interna de los
  ## ZIP del INEI no es consistente. Ejemplos reales: 2015 M02 usa "498_Modulo02/"
  ## con guion bajo, y 2015 M03 trae el .dta en la raiz del ZIP, sin carpeta.
  ## El guion antes del modulo descarta el duplicado "enaho01a-2015_500.dta" y el
  ## sufijo "a" descarta los complementarios "enaho01a-2014-300a.dta".
  ## useBytes evita que los nombres en latin1 de 2014 rompan el grep.
  patron   <- sprintf("(^|/)enaho01a?-%s-%s[.]dta$", anio, modulo)
  objetivo <- grep(patron, entradas, value = TRUE, ignore.case = TRUE, useBytes = TRUE)
  stopifnot("El .dta debe resolverse a exactamente un archivo" = length(objetivo) == 1)

  tmp <- file.path(tempdir(), paste0("dicc_", anio, "_", modulo))
  dir.create(tmp, showWarnings = FALSE, recursive = TRUE)
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)
  unzip(zipf, files = objetivo, exdir = tmp, junkpaths = TRUE)

  d <- read_dta(file.path(tmp, basename(objetivo)),
                col_select = any_of(vars_modulo[[as.character(modulo)]]),
                n_max = 100)

  map_dfr(names(d), function(v) {
    x   <- d[[v]]
    e   <- attr(x, "labels")
    lab <- attr(x, "label")
    base <- tibble(
      anio = anio, modulo = modulo, variable = v, clase = class(x)[1],
      etiqueta_variable = if (is.null(lab)) NA_character_ else as.character(lab)
    )
    if (is.null(e) || !length(e)) {
      mutate(base, valor = NA_real_, etiqueta_valor = NA_character_)
    } else {
      base[rep(1, length(e)), ] |>
        mutate(valor = as.numeric(unname(e)), etiqueta_valor = names(e))
    }
  })
}

message("Leyendo los 36 archivos .dta ...")
largo <- expand_grid(anio = anios, modulo = c(200, 300, 500)) |>
  pmap_dfr(function(anio, modulo) {
    message(sprintf("  %s  modulo %s", anio, modulo))
    leer_meta(anio, modulo)
  })

dir.create(file.path(raiz, "docs"), showWarnings = FALSE)
write_tsv(largo, file.path(raiz, "docs/etiquetas_enaho_2014_2025.tsv"), na = "")

## --- Normalizacion para comparar entre anios ----------------------------------
normalizar <- function(s) {
  s |>
    str_to_lower() |>
    iconv(to = "ASCII//TRANSLIT") |>
    str_replace_all("[^a-z0-9 ]", " ") |>
    str_squish()
}

largo <- largo |> mutate(etiqueta_norm = normalizar(etiqueta_valor))

firmas <- largo |>
  filter(!is.na(valor)) |>
  arrange(modulo, variable, anio, valor) |>
  group_by(modulo, variable, anio) |>
  summarise(firma   = paste0(valor, "=", etiqueta_norm, collapse = " | "),
            codigos = paste(sort(unique(valor)), collapse = ","),
            .groups = "drop")

## Se parte del inventario COMPLETO de variables leidas, para que las que no
## tienen value labels (edad, factores de expansion, llaves) tampoco se pierdan.
inventario <- largo |>
  distinct(modulo, variable) |>
  left_join(largo |> distinct(modulo, variable, anio) |>
              count(modulo, variable, name = "anios_presente"),
            by = c("modulo", "variable"))

resumen <- firmas |>
  group_by(modulo, variable) |>
  summarise(versiones    = n_distinct(firma),
            sets_codigos = n_distinct(codigos),
            .groups = "drop") |>
  right_join(inventario, by = c("modulo", "variable")) |>
  mutate(diagnostico = case_when(
    is.na(versiones)  ~ "Sin etiquetas de valor (continua o alfanumerica)",
    versiones == 1    ~ "Identica en los 12 anios",
    sets_codigos == 1 ~ "Solo cambia la redaccion; los codigos son los mismos",
    TRUE              ~ "CAMBIO DE ESTRUCTURA: aparecen o desaparecen codigos"
  )) |>
  arrange(modulo, variable)

## --- Escritura del diccionario ------------------------------------------------
con <- file(file.path(raiz, "docs/diccionario_variables.md"), open = "wt", encoding = "UTF-8")
w <- function(...) writeLines(paste0(...), con)

w("# Diccionario de variables ENAHO 2014-2025")
w("")
w("> Documento generado por `scripts/02_generar_diccionario.R`. **No editar a mano.**")
w("")
w("Fuente: *value labels* de Stata embebidos en los 36 archivos `.dta` (12 anios x ",
  "modulos 200, 300 y 500) que el INEI distribuye dentro de los ZIP de `data/raw/`. ",
  "Se usan los labels del dato y no los PDF de diccionario porque son la codificacion ",
  "tal como quedo efectivamente aplicada al microdato.")
w("")
w("Evidencia cruda completa: [`etiquetas_enaho_2014_2025.tsv`](etiquetas_enaho_2014_2025.tsv).")
w("")
w("## 1. Resumen de estabilidad")
w("")
w("La columna *Versiones* cuenta variantes de etiqueta **ignorando mayusculas, tildes ",
  "y puntuacion**: solo se reportan diferencias reales de redaccion, no de formato.")
w("")
w("| Modulo | Variable | Rol en el analisis | Anios | Versiones | Diagnostico |")
w("|---|---|---|---|---|---|")
res <- resumen |> left_join(meta, by = "variable")
for (i in seq_len(nrow(res))) {
  w("| ", res$modulo[i], " | `", res$variable[i], "` | ",
    ifelse(is.na(res$rol[i]), "-", res$rol[i]), " | ",
    res$anios_presente[i], " | ",
    ifelse(is.na(res$versiones[i]), "-", res$versiones[i]), " | ",
    res$diagnostico[i], " |")
}
w("")
w("## 2. Codificacion detallada")
w("")
for (i in seq_len(nrow(res))) {
  m <- res$modulo[i]; v <- res$variable[i]
  sub <- largo |> filter(modulo == m, variable == v)
  w("### Modulo ", m, " - `", v, "`")
  w("")
  lab <- sub |> filter(!is.na(etiqueta_variable)) |> slice_tail(n = 1) |> pull(etiqueta_variable)
  if (length(lab)) w("**Etiqueta INEI (ultimo anio):** ", lab, "  ")
  if (!is.na(res$universo[i])) {
    w("**Universo:** ", res$universo[i], "  ")
    w("**Rol:** ", res$rol[i], "  ")
  }
  w("**Diagnostico:** ", res$diagnostico[i])
  w("")
  vals <- sub |> filter(!is.na(valor))
  if (nrow(vals) == 0) {
    w("Sin etiquetas de valor: variable numerica o alfanumerica continua.")
  } else {
    ## Se agrupa por etiqueta normalizada para no inflar la tabla con diferencias
    ## de mayusculas o tildes; se muestra la redaccion del anio mas reciente.
    tab <- vals |>
      group_by(valor, etiqueta_norm) |>
      summarise(etiqueta = etiqueta_valor[which.max(anio)],
                anios    = paste(sort(unique(anio)), collapse = ", "),
                .groups  = "drop") |>
      arrange(valor, anios)
    w("| Codigo | Etiqueta | Anios |")
    w("|---|---|---|")
    for (j in seq_len(nrow(tab))) {
      w("| ", tab$valor[j], " | ", tab$etiqueta[j], " | ", tab$anios[j], " |")
    }
  }
  w("")
}
close(con)

message("\nOK:")
message("  docs/diccionario_variables.md")
message("  docs/etiquetas_enaho_2014_2025.tsv\n")
print(as.data.frame(resumen), row.names = FALSE)
