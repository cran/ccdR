## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(httptest)
start_vignette("3")

## ----setup, echo=FALSE, message=FALSE, warning=FALSE--------------------------
if (!library(ccdR, logical.return = TRUE)){
  devtools::load_all()
}
old_options <- options("width")

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

## ----ccdR all hazard, message=FALSE, eval=FALSE-------------------------------
#  res_dt <- get_hazard_by_dtxsid(DTXSID = 'DTXSID7020182')

## ----ccdR human hazard, message=FALSE, eval=FALSE-----------------------------
#  res_dt <- get_human_hazard_by_dtxsid(DTXSID = 'DTXSID7020182')

## ----ccdR ecotox hazard, message=FALSE, eval=FALSE----------------------------
#  res_dt <- get_ecotox_hazard_by_dtxsid(DTXSID = 'DTXSID7020182')

## ----ccdR skin and eye hazard, message=FALSE, eval=FALSE----------------------
#  res_dt <- get_skin_eye_hazard(DTXSID = 'DTXSID7020182')

## ----ccdR cancer hazard, message=FALSE, eval=FALSE----------------------------
#  res_dt <- get_cancer_hazard(DTXSID = 'DTXSID7020182')

## ----ccdR genetox summary hazard, message=FALSE, eval=FALSE-------------------
#  res_dt <- get_genetox_summary(DTXSID = 'DTXSID7020182')

## ----ccdR genetox detail hazard, message=FALSE, eval=FALSE--------------------
#  res_dt <- get_genetox_details(DTXSID = 'DTXSID7020182')

## -------------------------------------------------------------------------------------------------
options(width = 100)
ccl4_information <- get_public_chemical_list_by_name('CCL4')
print(ccl4_information, trunc.cols = TRUE)

natadb_information <- get_public_chemical_list_by_name('NATADB')
print(natadb_information, trunc.cols = TRUE)

## -------------------------------------------------------------------------------------------------
ccl4 <- get_chemicals_in_list('CCL4')
ccl4 <- data.table::as.data.table(ccl4)

natadb <- get_chemicals_in_list('NATADB')
natadb <- data.table::as.data.table(natadb)

## -------------------------------------------------------------------------------------------------
ccl4_genotox <- get_genetox_summary_batch(DTXSID = ccl4$dtxsid)
natadb_genetox <- get_genetox_summary_batch(DTXSID = natadb$dtxsid)

## ----fig.align='center',class.source="scroll-300",message=FALSE-----------------------------------
dim(ccl4_genotox)
dim(natadb_genetox)
colnames(ccl4_genotox)
head(ccl4_genotox)

## ----fig.align='center',class.source="scroll-300",message=FALSE-----------------------------------
ccl4[!(dtxsid %in% ccl4_genotox$dtxsid), 
     .(dtxsid, casrn, preferredName, molFormula)]
natadb[!(dtxsid %in% natadb_genetox$dtxsid), 
       .(dtxsid, casrn, preferredName, molFormula)]

## ----fig.align='center',class.source="scroll-300",message=FALSE-----------------------------------
ccl4_genetox_details <- get_genetox_details_batch(DTXSID = ccl4$dtxsid)
natadb_genetox_details <- get_genetox_details_batch(DTXSID = natadb$dtxsid)

## -------------------------------------------------------------------------------------------------
identical(ccl4_genetox_details[dtxsid %in% 'DTXSID0020153', ], 
          natadb_genetox_details[dtxsid %in% 'DTXSID0020153', ])

## ----fig.align='center',class.source="scroll-300",message=FALSE-----------------------------------
ccl4_genetox_details[, unique(assayCategory)]
natadb_genetox_details[, unique(assayCategory)]
ccl4_genetox_details[, unique(assayType)]
natadb_genetox_details[, unique(assayType)]

## ----fig.align='center',class.source="scroll-300",message=FALSE-----------------------------------
ccl4_genetox_details[, .(Assays = length(unique(assayType))), 
                     by = .(assayCategory)]
natadb_genetox_details[, .(Assays = length(unique(assayType))),
                       by = .(assayCategory)]

ccl4_genetox_details[, .N, by = .(assayCategory, assayType, assayResult)]
ccl4_genetox_details[, .N, by = .(assayCategory)]
ccl4_genetox_details[assayCategory == 'in vitro', .N, by = .(assayType)]
ccl4_genetox_details[assayCategory == 'ND', .N, by = .(assayType)]
ccl4_genetox_details[assayCategory == 'in vivo', .N, by = .(assayType)]

natadb_genetox_details[, .N, by = .(assayCategory, assayType, assayResult)]
natadb_genetox_details[, .N, by = .(assayCategory)]
natadb_genetox_details[assayCategory == 'in vitro', .N, by = .(assayType)]
natadb_genetox_details[assayCategory == 'ND', .N, by = .(assayType)]
natadb_genetox_details[assayCategory == 'in vivo', .N, by = .(assayType)]

## -------------------------------------------------------------------------------------------------
ccl4_genetox_details[, .(DTXSIDs = length(unique(dtxsid))), by = .(assayResult)]
natadb_genetox_details[, .(DTXSIDs = length(unique(dtxsid))), 
                       by = .(assayResult)]

## ----fig.align='center',class.source="scroll-300",message=FALSE-----------------------------------
ccl4_genetox_details[, .(is_positive = any(assayResult == 'positive')), 
                     by = .(dtxsid)][is_positive == TRUE, dtxsid]
natadb_genetox_details[, .(is_positive = any(assayResult == 'positive')),
                       by = .(dtxsid)][is_positive == TRUE, dtxsid]

## ----fig.align='center',class.source="scroll-300",message=FALSE-----------------------------------
ccl4_genetox_details[dtxsid == 'DTXSID0020153', .(Number = .N), 
                     by = .(assayResult)]
ccl4_genetox_details[dtxsid == 'DTXSID0020153' & assayResult == 'positive', 
                     .(Number_of_assays = .N), by = .(assayType)][order(-Number_of_assays),]

## ----eval = FALSE---------------------------------------------------------------------------------
#  ccl4_hazard <- get_hazard_by_dtxsid_batch(DTXSID = ccl4$dtxsid)
#  natadb_hazard <- get_hazard_by_dtxsid_batch(DTXSID = natadb$dtxsid)

## ----eval = FALSE, fig.align='center',class.source="scroll-300",message=FALSE---------------------
#  dim(ccl4_hazard)
#  dim(natadb_hazard)
#  colnames(ccl4_hazard)
#  head(ccl4_hazard)

## ----breakdown, echo = FALSE, results = 'hide'--------------------------------
# This chunk will be hidden in the final product. It serves to undo defining the
# custom print function to prevent unexpected behavior after this module during
# the final knitting process and restores original option values.

knit_print.data.table = knitr::normal_print
  
registerS3method(
  "knit_print", "data.table", knit_print.data.table,
  envir = asNamespace("knitr")
)

options(old_options)

## ----include=FALSE------------------------------------------------------------
end_vignette()

