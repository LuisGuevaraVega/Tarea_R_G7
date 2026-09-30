# =========================================================================
# Objetivo:   Descargar los modulos de la ENAHO anual (metodologia
#             actualizada) desde el ano 2014 hasta el 2025 desde la pagina
#             del Instituto Nacional de Estadistica e Informatica del Peru
# Adaptado a R desde scraping_enaho.do
# Requerimiento: conexion a internet
# Producto:   Archivos .ZIP
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
modulos <- 102:105

# Reintentos maximos por archivo antes de darse por vencido
intentos_max <- 9

# ---- 2. Funcion para descargar un modulo con reintentos ------------------

descargar_modulo <- function(codigo, modulo, carpeta, intentos_max) {

  nombre_archivo <- paste0(codigo, "-Modulo", modulo, ".zip")
  ruta_archivo <- file.path(carpeta, nombre_archivo)

  # Si el archivo ya existe, no se vuelve a descargar
  if (file.exists(ruta_archivo)) {
    message("El modulo ", modulo, " ya estaba descargado...")
    return(invisible(TRUE))
  }

  url <- paste0(
    "https://proyectos.inei.gob.pe/iinei/srienaho/descarga/STATA/",
    nombre_archivo
  )

  for (intento in 1:intentos_max) {
    message("Intento de descarga nro: ", intento)

    resultado <- tryCatch({
      download.file(url, destfile = ruta_archivo, mode = "wb", quiet = TRUE)
      TRUE
    }, error = function(e) FALSE)

    if (resultado) {
      return(invisible(TRUE))
    }
  }

  message("No se pudo descargar el modulo ", modulo, " de ", codigo,
          " tras ", intentos_max, " intentos.")
  invisible(FALSE)
}

# ---- 3. Loop principal: por cada anio, por cada modulo --------------------

for (i in seq_along(anios)) {

  anio <- anios[i]
  codigo <- codigos_enaho[i]

  # Carpeta del anio (se crea si no existe)
  carpeta_anio <- file.path(ruta_base, anio)
  if (!dir.exists(carpeta_anio)) {
    dir.create(carpeta_anio, recursive = TRUE)
  } else {
    message("La carpeta ", anio, " ya existia, no fue necesaria crearla...")
  }

  for (modulo in modulos) {
    modulo_str <- sprintf("%02d", modulo %% 100)
    message(anio, " Modulo", modulo_str)
    descargar_modulo(codigo, modulo_str, carpeta_anio, intentos_max)
  }
}
