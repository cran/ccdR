## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(httptest)
start_vignette("5")

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

## ----exposure functional use--------------------------------------------------
exp_fun_use <- get_exposure_functional_use(DTXSID = 'DTXSID7020182')
head(data.table::as.data.table(exp_fun_use))

## -----------------------------------------------------------------------------
exp_fun_use_prob <- get_exposure_functional_use_probability(DTXSID = 'DTXSID7020182')
exp_fun_use_prob

## -----------------------------------------------------------------------------
exp_fun_use_cat <- get_exposure_functional_use_category()
head(data.table::as.data.table(exp_fun_use_cat))

## -----------------------------------------------------------------------------
exp_prod_dat <- get_exposure_product_data(DTXSID = 'DTXSID7020182')
head(data.table::as.data.table(exp_prod_dat))

## -----------------------------------------------------------------------------
exp_prod_data_puc <- get_exposure_product_data_puc()
head(data.table::as.data.table(exp_prod_data_puc))

## -----------------------------------------------------------------------------
exp_list_tags <- get_exposure_list_presence_tags()
head(data.table::as.data.table(exp_list_tags))

## -----------------------------------------------------------------------------
exp_list_tags_dat <- get_exposure_list_presence_tags_by_dtxsid(DTXSID = 'DTXSID7020182')
head(data.table::as.data.table(exp_list_tags_dat))

## -----------------------------------------------------------------------------
bpa_prob <- get_exposure_functional_use_probability(DTXSID = 'DTXSID7020182')
caf_prob <- get_exposure_functional_use_probability(DTXSID = 'DTXSID0020232')

bpa_caf_prob <- get_exposure_functional_use_probability_batch(DTXSID = c('DTXSID7020182', 'DTXSID0020232'))

## ----echo=FALSE---------------------------------------------------------------
bpa_prob

## ----echo=FALSE---------------------------------------------------------------
caf_prob

## ----echo=FALSE---------------------------------------------------------------
bpa_caf_prob

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

