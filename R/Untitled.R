etl_to_omop(server = "localhost/polyester",
            port = 5432,
            path_to_synthea_csvs = "synthea_output/2020-12-20 20:12:56/csv/",
            path_to_omop_vocab_csvs = "~/Desktop/athena/")


conn <- pg13::local_connect("polyester")
output <-
        pg13::summarize_schema(
                conn = conn,
                schema = "omop_cdm"
        )

pg13::summarize_table()

cdm_tables <- c('PERSON', 'OBSERVATION_PERIOD', 'VISIT_OCCURRENCE', 'VISIT_DETAIL', 'CONDITION_OCCURRENCE', 'DRUG_EXPOSURE', 'PROCEDURE_OCCURRENCE', 'DEVICE_EXPOSURE', 'MEASUREMENT', 'OBSERVATION', 'NOTE', 'NOTE_NLP', 'SPECIMEN', 'FACT_RELATIONSHIP', 'SURVEY_CONDUCT', 'LOCATION', 'LOCATION_HISTORY', 'CARE_SITE', 'PROVIDER', 'PAYER_PLAN_PERIOD', 'COST', 'DRUG_ERA', 'DOSE_ERA', 'CONDITION_ERA', 'METADATA', 'CDM_SOURCE')
objs <- tolower(cdm_tables)

for (i in seq_along(cdm_tables)) {
        cat(sprintf("%s = %s,", cdm_tables[i], objs[i]))
        cat("\n")
}

output <- list()
for (i in seq_along(cdm_tables)) {
        output[[i]] <-
        c(#sprintf("\n## %s  \n", cdm_tables[i]),
          #sprintf("```{r}  %s", tolower(cdm_tables[i])),
          sprintf("\n%s <- summarize_table(conn = conn,
                           schema = 'omop_cdm',
                           table = '%s')", tolower(cdm_tables[i]), cdm_tables[i]) #,
          #"```\n\n"
          ) %>%
                paste(collapse = "\n")
}

for (i in seq_along(output)) {

        cat(output[[i]],
            file = "vignettes/rmd/summary-by-cdm-table.Rmd",
            append = TRUE)
}
