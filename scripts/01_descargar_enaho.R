# =========================================================================
# 01_descargar_enaho.R
#
# Objetivo:   Descargar los modulos de la ENAHO anual (metodologia actualizada)
#             de 2014 a 2025 desde el portal de microdatos del Instituto
#             Nacional de Estadistica e Informatica del Peru.
# Producto:   data/raw/<anio>/<codigo>-Modulo<NN>.zip  (48 archivos, ~693 MB)
# Requiere:   conexion a internet
#
# Adaptado a R desde scraping_enaho.do
#
# Uso:  "C:/Program Files/R/R-4.6.1/bin/Rscript.exe" scripts/01_descargar_enaho.R
#       o abrir Tarea_R_G7.Rproj y hacer source() de este archivo.
#
# El reporte (docs/reporte_ninis.qmd) muestra este mismo codigo en un bloque sin
# ejecutar, para que se pueda leer sin salir del documento. Vive aparte porque
# descarga 693 MB y no puede correr en cada render.
# =========================================================================

# ---- 1. Configuracion ----------------------------------------------------

# Ruta donde se descargaran los modulos, ordenados en carpetas por anio.
# Relativa a la raiz del proyecto (abrir el .Rproj o hacer setwd() ahi antes de correr).
# vvv LINEA MODIFICABLE vvv
ruta_base <- "data/raw"
# ^^^ LINEA MODIFICABLE ^^^

# Codigos de la ENAHO por anio (ENAHO Metodologia Actualizada, INEI)
# anio:   2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025
codigos_enaho <- c(440, 498, 546, 603, 634, 687, 737, 759, 784, 906, 966, 1031)
anios <- 2014:2025

# Modulos a descargar (102, 103, 104, 105)
#   102 Caracteristicas de los miembros del hogar
#   103 Educacion
#   104 Salud            (se descarga por completitud; el reporte no lo usa)
#   105 Empleo e ingresos
modulos <- 102:105

# Reintentos maximos por archivo antes de darse por vencido
intentos_max <- 9

# El timeout por defecto de R es de 60 segundos, insuficiente para ZIP de 20-27 MB
# en conexiones lentas: la descarga se aborta a medias y se gastan los 9 intentos.
options(timeout = max(600, getOption("timeout")))

# ---- 2. Validacion de integridad -----------------------------------------

# Un archivo truncado o corrupto igual "existe", asi que comprobar file.exists()
# no alcanza: el ZIP malo se queda en disco y nunca se reintenta. Se valida
# abriendo el indice del ZIP, que falla si el archivo no esta completo.
zip_valido <- function(ruta) {
  if (!file.exists(ruta) || file.size(ruta) == 0) return(FALSE)
  indice <- tryCatch(utils::unzip(ruta, list = TRUE), error = function(e) NULL)
  !is.null(indice) && nrow(indice) > 0
}

# ---- 3. Funcion para descargar un modulo con reintentos ------------------

descargar_modulo <- function(codigo, modulo, carpeta, intentos_max) {

  nombre_archivo <- paste0(codigo, "-Modulo", modulo, ".zip")
  ruta_archivo   <- file.path(carpeta, nombre_archivo)

  if (zip_valido(ruta_archivo)) {
    message("  ya estaba descargado y es legible")
    return(invisible(TRUE))
  }

  # Habia un archivo, pero esta incompleto o corrupto: se descarta y se baja de nuevo.
  if (file.exists(ruta_archivo)) {
    message("  el archivo existente esta corrupto o incompleto; se vuelve a descargar")
    unlink(ruta_archivo)
  }

  url <- paste0(
    "https://proyectos.inei.gob.pe/iinei/srienaho/descarga/STATA/",
    nombre_archivo
  )

  for (intento in seq_len(intentos_max)) {
    message("  intento ", intento, " de ", intentos_max)

    # withCallingHandlers captura ademas los warnings: download.file avisa de una
    # descarga incompleta con un warning, no con un error, y el tryCatch original
    # la daba por buena.
    ok <- tryCatch(
      withCallingHandlers({
        download.file(url, destfile = ruta_archivo, mode = "wb", quiet = TRUE)
        TRUE
      }, warning = function(w) {
        message("    aviso: ", conditionMessage(w))
        invokeRestart("muffleWarning")
      }),
      error = function(e) {
        message("    error: ", conditionMessage(e))
        FALSE
      }
    )

    # La descarga solo se da por buena si el ZIP resultante se puede abrir.
    if (isTRUE(ok) && zip_valido(ruta_archivo)) {
      message("    descargado: ", round(file.size(ruta_archivo) / 1024^2, 1), " MB")
      return(invisible(TRUE))
    }
    unlink(ruta_archivo)
  }

  message("  NO se pudo descargar ", nombre_archivo, " tras ", intentos_max, " intentos")
  invisible(FALSE)
}

# ---- 4. Loop principal: por cada anio, por cada modulo --------------------

fallidos <- character()

for (i in seq_along(anios)) {

  anio   <- anios[i]
  codigo <- codigos_enaho[i]

  carpeta_anio <- file.path(ruta_base, anio)
  if (!dir.exists(carpeta_anio)) dir.create(carpeta_anio, recursive = TRUE)

  for (modulo in modulos) {
    modulo_str <- sprintf("%02d", modulo %% 100)
    message(anio, " Modulo", modulo_str)
    ok <- descargar_modulo(codigo, modulo_str, carpeta_anio, intentos_max)
    if (!ok) fallidos <- c(fallidos, paste0(anio, "-Modulo", modulo_str))
  }
}

# ---- 5. Resumen ----------------------------------------------------------

message("\n", strrep("-", 60))
if (length(fallidos) == 0) {
  message("Descarga completa: los ", length(anios) * length(modulos),
          " archivos estan en disco y son legibles.")
} else {
  message("Quedaron ", length(fallidos), " archivos sin descargar:")
  message("  ", paste(fallidos, collapse = "\n  "))
  message("Volver a correr el script: los ya descargados no se vuelven a bajar.")
}
