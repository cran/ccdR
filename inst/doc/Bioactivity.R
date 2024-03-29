## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(httptest)
start_vignette("4")

## ----setup, echo=FALSE, message=FALSE, warning=FALSE--------------------------
if (!library(ccdR, logical.return = TRUE)){
  devtools::load_all()
}

## ----setup-print, echo = FALSE------------------------------------------------
# Redefining the knit_print method to truncate character values to 25 characters
# in each column and to truncate the columns in the print call to prevent 
# wrapping tables with several columns.
#library(ccdR)
knit_print.data.table = function(x, ...) {
  y <- data.table::copy(x)
  y <- y[, lapply(.SD, function(t){
    if (is.character(t)){
      t <- strtrim(t, 25)
    }
    return(t)
  })]
  print(y, trunc.cols = TRUE)
}

registerS3method(
  "knit_print", "data.table", knit_print.data.table,
  envir = asNamespace("knitr")
)

# Remove this once Bioactivity goes public
stg_bioactivity_server <- 'https://api-ccte-stg.epa.gov/bioactivity/data'

## ----ccdR annotation by aeid, message=FALSE, eval=FALSE-----------------------
#  res_dt <- get_annotation_by_aeid(AEID = "891", API_key = apikey, Server = url)
#  # optionally perform this unnest, apply names_repair = "unique" to give a unique column name
#  # note - the gene column may be an array of multiple genes rather than just one, meaning this step may not work
#  #res_dt <- res_dt |> tidyr::unnest_wider(col = c("citation", "gene", "assayList"), names_repair = "unique")

## ---- echo=FALSE, eval=FALSE--------------------------------------------------
#  printFormattedTable(head(res_dt), c(4, 18, 33, 51)) # printed using custom formatted table

## ----ccdR all assays, message=FALSE, eval=FALSE-------------------------------
#  res_dt <- get_all_assays(API_key = apikey, Server = url)
#  # optionally perform the following unnest, apply names_repair = "unique" to give a unique column name
#  # note - the gene column may be an array of multiple genes rather than just one, meaning this step may not work
#  #res_dt <- res_dt |> tidyr::unnest_wider(col = c("citation", "gene", "assayList"), names_repair = "unique")

## ---- echo=FALSE, eval=FALSE--------------------------------------------------
#  printFormattedTable(head(res_dt), c(4, 18, 19, 33, 51)) # printed using custom formatted table

## ----ccdR summary by aeid, message=FALSE, eval=FALSE--------------------------
#  res_dt <- get_bioactivity_summary(AEID = "891", API_key = apikey, Server = url)

## ---- echo=FALSE, eval=FALSE--------------------------------------------------
#  printFormattedTable(head(res_dt), c()) # printed using custom formatted table

## ----ccdR data by spid, message=FALSE, results = FALSE, eval=FALSE------------
#  res_dt <- get_bioactivity_details(SPID = "TP0001055F12", API_key = apikey, Server = paste0(url, "/data"))

## ---- echo=FALSE, eval=FALSE--------------------------------------------------
#  printFormattedTable(head(res_dt), c(ncol(res_dt)-2)) # printed using custom formatted table

## ----ccdR data by m4id, message=FALSE, results = FALSE, eval=FALSE------------
#  res_dt <- get_bioactivity_details(m4id = 739695, API_key = apikey, Server = paste0(url, "/data"))

## ---- echo=FALSE, eval=FALSE--------------------------------------------------
#  printFormattedTable(head(res_dt), c(ncol(res_dt)-2)) # printed using custom formatted table

## ----ccdR data by dtxsid, message=FALSE, results = FALSE, eval=FALSE----------
#  res_dt <- get_bioactivity_details(DTXSID = "DTXSID7020182", API_key = apikey, Server = paste0(url, "/data"))

## ---- echo=FALSE, eval=FALSE--------------------------------------------------
#  printFormattedTable(head(res_dt), c(ncol(res_dt)-2)) # printed using custom formatted table

## ----ccdR data by aeid, message=FALSE, results = FALSE, eval=FALSE------------
#  res_dt <- get_bioactivity_details(AEID = "891", API_key = apikey, Server = paste0(url, "/data"))

## ---- echo=FALSE, eval=FALSE--------------------------------------------------
#  printFormattedTable(res_dt[205:210,], c(ncol(res_dt)-2)) # printed using custom formatted table

## ----breakdown, echo = FALSE, results = 'hide'--------------------------------
# This chunk will be hidden in the final product. It serves to undo defining the
# custom print function to prevent unexpected behavior after this module during
# the final knitting process

knit_print.data.table = knitr::normal_print
  
registerS3method(
  "knit_print", "data.table", knit_print.data.table,
  envir = asNamespace("knitr")
)

## ---- include=FALSE-----------------------------------------------------------
end_vignette()

