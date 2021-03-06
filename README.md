
<!-- README.md is generated from README.Rmd. Please edit that file -->

# polyester2 <img src="man/figures/logo.png" align="right" alt="" width="120" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/polyester2)](https://CRAN.R-project.org/package=polyester2)
<!-- badges: end -->

This package creates a simulated patient population using Synthea and
ETL it into the OMOP Common Data Model. It is centered around 2 major
operations: 1. Creating a synthetic database using Synthea and 2. the
ETL to OMOP, governed by function `etl_to_omop` that is a convenience
wrapper function around the suite of ETL functions in [OHDI’s
ETL-Synthea package](https://github.com/OHDSI/ETL-Synthea)

## Installation

You can install polyester2 with:

``` r
devtools::install_github("meerapatelmd/polyester2")
```

## Example

Artificial data is first generated using Synthea by:

``` r
library(polyester2)
run_synthea(populationSize = 1000,
            state = "California",
            city = "Los Angeles")
```

The output data is located in a subdirectory `synthea_output` folder in
the working directory named by timestamp. This way, multiple rounds of
Synthea can be executed and saved without being overwritten.

The native Synthea output can be ETL’d into the OMOP CDM:

``` r
library(polyester2)
etl_to_omop(user = "root",
            password = "candycane",
            server = "localhost/taffeta",
            port = 5432,
            omop_cdm_schema = "omop",
            synthea_schema = "synthea",
            path_to_synthea_csvs = "synthea_output/2020-11-14 11:00:00:00/csv",
            path_to_omop_vocab_csvs = "~/athena_vocabulary")
```

The function will fail to execute if a connection cannot be made using
the credentials provided or if the schemas do not exist.
