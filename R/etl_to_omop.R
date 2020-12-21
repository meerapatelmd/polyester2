#' @title
#' Synthea to OMOP ETL
#' @param connDetails  Connection Details object, Default: cd
#' @param omop_cdm_schema Destination schema for the OMOP Vocabulary Tables and ETL'd Synthea data
#' @param synthea_schema  Schema where the native synthea csvs will be loaded for the ETL.
#' @param path_to_synthea_csvs Path to the csvs produced by \code{\link{run_synthea}}.
#' @param path_to_omop_vocab_csvs Path to csvs downloaded the reconstituted (if CPT4 is desired) from \url{athena.ohdsi.org}.
#' @seealso
#'  \code{\link[secretary]{typewrite}}
#'  \code{\link[ETLSyntheaBuilder]{DropVocabTables}},\code{\link[ETLSyntheaBuilder]{DropEventTables}},\code{\link[ETLSyntheaBuilder]{DropSyntheaTables}},\code{\link[ETLSyntheaBuilder]{DropMapAndRollupTables}},\code{\link[ETLSyntheaBuilder]{CreateVocabTables}},\code{\link[ETLSyntheaBuilder]{CreateEventTables}},\code{\link[ETLSyntheaBuilder]{CreateSyntheaTables}},\code{\link[ETLSyntheaBuilder]{LoadSyntheaTables}},\code{\link[ETLSyntheaBuilder]{LoadVocabFromCsv}},\code{\link[ETLSyntheaBuilder]{CreateVocabMapTables}},\code{\link[ETLSyntheaBuilder]{CreateVisitRollupTables}},\code{\link[ETLSyntheaBuilder]{LoadEventTables}}
#' @rdname etl_to_omop
#' @export
#' @importFrom secretary typewrite
#' @importFrom ETLSyntheaBuilder DropVocabTables DropEventTables DropSyntheaTables DropMapAndRollupTables CreateVocabTables CreateEventTables CreateSyntheaTables LoadSyntheaTables LoadVocabFromCsv CreateVocabMapTables CreateVisitRollupTables LoadEventTables

etl_to_omop <-
    function(user = NULL,
             password = NULL,
             server = NULL,
             port = NULL,
              omop_cdm_schema = "omop_cdm",
              synthea_schema = "native_synthea",
              path_to_synthea_csvs = "synthea_output/2020-12-20 20:12:56/csv/",
              path_to_omop_vocab_csvs = "") {

      cd <-
      DatabaseConnector::createConnectionDetails(dbms = "postgresql",
                                                 user = user,
                                                 password = password,
                                                 server = server,
                                                 port = port)

      secretary::typewrite("Dropping OMOP Vocabulary Tables...")
      ETLSyntheaBuilder::DropVocabTables(connectionDetails = cd,
                                         vocabDatabaseSchema = omop_cdm_schema)
      secretary::typewrite("Dropping OMOP Vocabulary Tables...complete.")


      secretary::typewrite("Dropping OMOP Event Tables...")
      ETLSyntheaBuilder::DropEventTables(connectionDetails = cd,
                                         cdmDatabaseSchema = omop_cdm_schema)
      secretary::typewrite("Dropping OMOP Event Tables...complete.")

      secretary::typewrite("Dropping Synthea Tables...")
      ETLSyntheaBuilder::DropSyntheaTables(connectionDetails = cd,
                                     syntheaDatabaseSchema = synthea_schema)
      secretary::typewrite("Dropping Synthea Tables...complete.")

      secretary::typewrite("Dropping Map and Rollup Tables...")
      ETLSyntheaBuilder::DropMapAndRollupTables (connectionDetails = cd,
                                           cdmDatabaseSchema = omop_cdm_schema)
      secretary::typewrite("Dropping Map and Rollup Tables...complete.")

      secretary::typewrite("Creating OMOP Vocabulary Tables...")
      ETLSyntheaBuilder::CreateVocabTables(connectionDetails = cd,
                                     vocabDatabaseSchema = omop_cdm_schema)
      secretary::typewrite("Creating OMOP Vocabulary Tables...complete.")

      secretary::typewrite("Creating OMOP Event Tables...")
      ETLSyntheaBuilder::CreateEventTables(connectionDetails = cd,
                                     cdmDatabaseSchema = omop_cdm_schema)
      secretary::typewrite("Creating OMOP Event Tables...complete.")

      secretary::typewrite("Creating Synthea Tables...")
      ETLSyntheaBuilder::CreateSyntheaTables(connectionDetails = cd,
                                       syntheaDatabaseSchema = synthea_schema)
      secretary::typewrite("Creating Synthea Tables...complete.")

      secretary::typewrite("Loading Synthea Tables...")
      ETLSyntheaBuilder::LoadSyntheaTables(connectionDetails = cd,
                                     syntheaDatabaseSchema = synthea_schema,
                                     syntheaFileLoc = path_to_synthea_csvs)
      secretary::typewrite("Loading Synthea Tables...complete.")

      secretary::typewrite("Loading OMOP Vocabulary Tables...")
      ETLSyntheaBuilder::LoadVocabFromCsv(connectionDetails = cd,
                                    vocabDatabaseSchema = omop_cdm_schema,
                                    vocabFileLoc = path_to_omop_vocab_csvs)
      secretary::typewrite("Loading OMOP Vocabulary Tables...complete.")

      secretary::typewrite("Creating OMOP Vocabulary Map Tables...")
      ETLSyntheaBuilder::CreateVocabMapTables(connectionDetails = cd,
                                        cdmDatabaseSchema = omop_cdm_schema)
      secretary::typewrite("Creating OMOP Vocabulary Map Tables...complete.")

      secretary::typewrite("Creating Visit Rollup Tables...")
      ETLSyntheaBuilder::CreateVisitRollupTables(connectionDetails = cd,
                                           cdmDatabaseSchema = omop_cdm_schema,
                                           syntheaDatabaseSchema = synthea_schema)
      secretary::typewrite("Creating Visit Rollup Tables...complete.")

      secretary::typewrite("Loading OMOP Event Tables...")
      ETLSyntheaBuilder::LoadEventTables(connectionDetails = cd,
                                   cdmDatabaseSchema = omop_cdm_schema,
                                   syntheaDatabaseSchema = synthea_schema)
      secretary::typewrite("Loading OMOP Event Tables...complete.")
}
