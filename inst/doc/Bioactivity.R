## ----include = FALSE----------------------------------------------------------
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
# helper function for printing
printFormattedTable <- function(res_dt, widen = c()) {
  DT::datatable(res_dt, style = 'bootstrap', class = 'table-bordered table-condensed', rownames = FALSE, options = list(scrollX = TRUE, autoWidth = TRUE, dom = 't', columnDefs = list(list(width = '1250px', targets = widen))))
}

## ----ccdR annotation by aeid, message=FALSE-----------------------------------
assay <- get_annotation_by_aeid(AEID = "891")

## ----echo=FALSE---------------------------------------------------------------
printFormattedTable(assay, c(4, 18, 33, 51)) # printed using custom formatted table

## ----ccdR annotation by aeid batch, message=FALSE-----------------------------
assays <- get_annotation_by_aeid_batch(AEID = c(759,700,891))
# return is in list form by aeid, convert to table for output
assays <- data.table::rbindlist(assays)

## ----ccdR-all-assays, message=FALSE, eval=FALSE-------------------------------
#  printFormattedTable(assays, c(4, 18, 19, 33, 51)) # printed using custom formatted table

## ----ccdR all assays, message=FALSE, eval=FALSE-------------------------------
#  all_assays <- get_all_assays()

## ----ccdR summary by aeid, message=FALSE--------------------------------------
summary <- get_bioactivity_summary(AEID = "891")

## ----echo=FALSE---------------------------------------------------------------
printFormattedTable(summary) # printed using custom formatted table

## ----ccdR summary by aeid batch, message=FALSE--------------------------------
summary <- get_bioactivity_summary_batch(AEID = c(759,700,891))
summary <- data.table::rbindlist(summary)

## ----echo=FALSE---------------------------------------------------------------
printFormattedTable(summary) # printed using custom formatted table

## ----ccdR data by spid, message=FALSE, results = FALSE------------------------
# By spid
spid_data <- get_bioactivity_details(SPID = 'TP0000904H05')

## ----echo=FALSE---------------------------------------------------------------
printFormattedTable(head(spid_data), c(ncol(spid_data)-2)) # printed using custom formatted table

## ----ccdR data by m4id, message=FALSE, results = FALSE------------------------
# By m4id
m4id_data <- get_bioactivity_details(m4id = 739695)

## ----echo=FALSE---------------------------------------------------------------
printFormattedTable(m4id_data, c(ncol(m4id_data) - 2)) # printed using custom formatted table

## ----ccdR data by dtxsid, message=FALSE, results = FALSE----------------------
# By DTXSID
dtxsid_data <- get_bioactivity_details(DTXSID = "DTXSID30944145")

## ----echo=FALSE---------------------------------------------------------------
printFormattedTable(dtxsid_data, c(ncol(dtxsid_data)-2)) # printed using custom formatted table

## ----ccdR data by aeid, message=FALSE, results = FALSE------------------------
# By aeid
aeid_data <- get_bioactivity_details(AEID = 704)

## ----echo=FALSE---------------------------------------------------------------
printFormattedTable(head(aeid_data), c(ncol(aeid_data)-2)) # printed using custom formatted table

## ----ccdR data by aeid batch, message=FALSE, eval=FALSE-----------------------
#  aeid_data_batch <- get_bioactivity_details_batch(AEID = c(759,700,891))
#  aeid_data_batch <- data.table::rbindlist(aeid_data_batch, fill = TRUE)

## ----breakdown, echo = FALSE, results = 'hide'--------------------------------
# This chunk will be hidden in the final product. It serves to undo defining the
# custom print function to prevent unexpected behavior after this module during
# the final knitting process

knit_print.data.table = knitr::normal_print
  
registerS3method(
  "knit_print", "data.table", knit_print.data.table,
  envir = asNamespace("knitr")
)

## ----include=FALSE------------------------------------------------------------
end_vignette()

