#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param connDetails PARAM_DESCRIPTION, Default: cd
#' @param omop_cdm_schema PARAM_DESCRIPTION, Default: 'cdm_synthea10'
#' @param synthea_schema PARAM_DESCRIPTION, Default: 'native'
#' @param path_to_synthea_csvs PARAM_DESCRIPTION, Default: '/tmp/synthea/output/csv'
#' @param path_to_omop_vocab_csvs PARAM_DESCRIPTION, Default: '/tmp/Vocabulary_20181119'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[secretary]{typewrite}}
#'  \code{\link[ETLSyntheaBuilder]{DropVocabTables}},\code{\link[ETLSyntheaBuilder]{DropEventTables}},\code{\link[ETLSyntheaBuilder]{DropSyntheaTables}},\code{\link[ETLSyntheaBuilder]{DropMapAndRollupTables}},\code{\link[ETLSyntheaBuilder]{CreateVocabTables}},\code{\link[ETLSyntheaBuilder]{CreateEventTables}},\code{\link[ETLSyntheaBuilder]{CreateSyntheaTables}},\code{\link[ETLSyntheaBuilder]{LoadSyntheaTables}},\code{\link[ETLSyntheaBuilder]{LoadVocabFromCsv}},\code{\link[ETLSyntheaBuilder]{CreateVocabMapTables}},\code{\link[ETLSyntheaBuilder]{CreateVisitRollupTables}},\code{\link[ETLSyntheaBuilder]{LoadEventTables}}
#' @rdname etl_to_omop
#' @export
#' @importFrom secretary typewrite
#' @importFrom ETLSyntheaBuilder DropVocabTables DropEventTables DropSyntheaTables DropMapAndRollupTables CreateVocabTables CreateEventTables CreateSyntheaTables LoadSyntheaTables LoadVocabFromCsv CreateVocabMapTables CreateVisitRollupTables LoadEventTables
etl_to_omop <-
    function(connDetails = cd,
              omop_cdm_schema = "cdm_synthea10",
              synthea_schema = "native",
              path_to_synthea_csvs = "/tmp/synthea/output/csv",
              path_to_omop_vocab_csvs = "/tmp/Vocabulary_20181119") {

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
