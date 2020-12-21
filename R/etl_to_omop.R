 omop_cdm_schema <- "cdm_synthea10"
 synthea_schema <- "native"
 path_to_synthea_csvs <- "/tmp/synthea/output/csv"


 cd <- DatabaseConnector::createConnectionDetails(
  dbms     = "postgresql", 
  server   = "localhost/synthea10", 
  user     = "postgres", 
  password = "lollipop", 
  port     = 5432
)

ETLSyntheaBuilder::DropVocabTables(connectionDetails = cd,
                                   vocabDatabaseSchema = omop_cdm_schema)

ETLSyntheaBuilder::DropEventTables(connectionDetails = cd,
                                   cdmDatabaseSchema = omop_cdm_schema)
                                   
ETLSyntheaBuilder::DropSyntheaTables(connectionDetails = cd, 
                                     syntheaDatabaseSchema = synthea_schema)
                                     
ETLSyntheaBuilder::DropMapAndRollupTables (connectionDetails = cd, 
                                           cdmDatabaseSchema = omop_cdm_schema)
                                           
ETLSyntheaBuilder::CreateVocabTables(connectionDetails = cd, 
                                     vocabDatabaseSchema = omop_cdm_schema)
                                     
ETLSyntheaBuilder::CreateEventTables(connectionDetails = cd, 
                                     cdmDatabaseSchema = omop_cdm_schema)
                                     
ETLSyntheaBuilder::CreateSyntheaTables(connectionDetails = cd, 
                                       syntheaDatabaseSchema = synthea_schema)
                                       
ETLSyntheaBuilder::LoadSyntheaTables(connectionDetails = cd, 
                                     syntheaDatabaseSchema = synthea_schema, 
                                     syntheaFileLoc = path_to_synthea_csvs)
                                     
ETLSyntheaBuilder::LoadVocabFromCsv(connectionDetails = cd, 
                                    vocabDatabaseSchema = omop_cdm_schema, 
                                    vocabFileLoc = "/tmp/Vocabulary_20181119")
                                    
ETLSyntheaBuilder::CreateVocabMapTables(connectionDetails = cd, 
                                        cdmDatabaseSchema = omop_cdm_schema)
                                        
ETLSyntheaBuilder::CreateVisitRollupTables(connectionDetails = cd, 
                                           cdmDatabaseSchema = omop_cdm_schema, 
                                           syntheaDatabaseSchema = synthea_schema)

ETLSyntheaBuilder::LoadEventTables(connectionDetails = cd, 
                                   cdmDatabaseSchema = omop_cdm_schema, 
                                   syntheaDatabaseSchema = synthea_schema)