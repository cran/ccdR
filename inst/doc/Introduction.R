## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = (nchar(Sys.getenv('CTX_API_KEY')) > 0)
)
library(httptest)
start_vignette("1")

## ----setup, echo=FALSE--------------------------------------------------------
#  if (!library(ccdR, logical.return = TRUE)){
#    devtools::load_all()
#  }

## ----setup-print, echo = FALSE------------------------------------------------
#  # Redefining the knit_print method to truncate character values to 25 characters
#  # in each column and to truncate the columns in the print call to prevent
#  # wrapping tables with several columns.
#  #library(ccdR)
#  knit_print.data.table = function(x, ...) {
#    y <- data.table::copy(x)
#    y <- y[, lapply(.SD, function(t){
#      if (is.character(t)){
#        t <- strtrim(t, 25)
#      }
#      return(t)
#    })]
#    print(y, trunc.cols = TRUE)
#  }
#  
#  registerS3method(
#    "knit_print", "data.table", knit_print.data.table,
#    envir = asNamespace("knitr")
#  )

## ----eval=FALSE---------------------------------------------------------------
#  if (!library(devtools, logical.return = TRUE)){
#    install.packages(devtools)
#    library(devtools)}
#  
#  devtools::install_github("USEPA/ccdR")

## ----echo = FALSE-------------------------------------------------------------
#  my_key <- ctx_key()

## ----eval = FALSE, api-key----------------------------------------------------
#  my_key <- 'YOUR_CTX_API_key'

## ----register-ccdr, eval=FALSE------------------------------------------------
#  # This stores the key in the current session
#  register_ccdr(key = '<YOUR API KEY>')
#  
#  # This stores the key across multiple sessions and only needs to be run once. If the key changes, rerun this with the new key.
#  register_ccdr(key = '<YOUR API KEY>', write = TRUE)

## ----display-hide-key---------------------------------------------------------
#  # To show the API key
#  ccdr_show_api_key()
#  getOption('ccdr')$display_api_key
#  
#  # To hide the API key
#  ccdr_hide_api_key()
#  getOption('ccdr')$display_api_key

## ----ctx-key, eval = FALSE----------------------------------------------------
#  ctx_key()

## ----bpa-chem-details---------------------------------------------------------
#  bpa_details <- get_chemical_details(DTXSID = 'DTXSID7020182',
#                                      API_key = my_key)
#  bpa_details <- data.table::as.data.table(bpa_details)
#  head(bpa_details)

## ----bpa-chem-info------------------------------------------------------------
#  bpa_info <- get_chem_info(DTXSID = "DTXSID7020182",
#                            API_key = my_key)
#  bpa_info <- data.table::as.data.table(bpa_info)
#  
#  head(bpa_info)

## ----bpa-experimental---------------------------------------------------------
#  bpa_info_experimental <- get_chem_info(DTXSID = "DTXSID7020182",
#                                         type = 'experimental',
#                                         API_key = my_key)
#  bpa_info_experimental <- data.table::as.data.table(bpa_info_experimental)
#  
#  head(bpa_info_experimental)

## ----hazard-------------------------------------------------------------------
#  bpa_hazard <- get_hazard_by_dtxsid(DTXSID = 'DTXSID7020182',
#                                     API_key = my_key)
#  bpa_hazard <- data.table::as.data.table(bpa_hazard)
#  head(bpa_hazard)

## ----human-hazard-------------------------------------------------------------
#  bpa_human_hazard <- get_human_hazard_by_dtxsid(DTXSID = 'DTXSID7020182',
#                                                 API_key = my_key)
#  bpa_human_hazard <- data.table::as.data.table(bpa_human_hazard)
#  head(bpa_human_hazard)

## ----ecotox-hazard------------------------------------------------------------
#  bpa_eco_hazard <- get_ecotox_hazard_by_dtxsid(DTXSID = 'DTXSID7020182',
#                                                API_key = my_key)
#  bpa_eco_hazard <- data.table::as.data.table(bpa_eco_hazard)
#  head(bpa_eco_hazard)

## ----bioactivity-dtxsid-------------------------------------------------------
#  bpa_bioactivity <- get_bioactivity_details(DTXSID = 'DTXSID7020182',
#                                             API_key = my_key)
#  
#  bpa_bioactivity <- data.table::as.data.table(bpa_bioactivity)
#  head(bpa_bioactivity)

## ----bioactivity-aeid---------------------------------------------------------
#  assay_id_search <- get_bioactivity_details(AEID = 42,
#                                             API_key = my_key)
#  assay_id_search <- data.table::as.data.table(assay_id_search)
#  head(assay_id_search)

## ----breakdown, echo = FALSE, results = 'hide'--------------------------------
#  # This chunk will be hidden in the final product. It serves to undo defining the
#  # custom print function to prevent unexpected behavior after this module during
#  # the final knitting process
#  
#  knit_print.data.table = knitr::normal_print
#  
#  registerS3method(
#    "knit_print", "data.table", knit_print.data.table,
#    envir = asNamespace("knitr")
#  )

## ----include=FALSE------------------------------------------------------------
#  end_vignette()

