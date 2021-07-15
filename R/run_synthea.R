#' @title
#' Run Synthea
#' @description
#' Run synthea according to the README guide found \href{here}{https://github.com/synthetichealth/synthea/blob/master/README.md}. The default setting opens the synthea.properties file to set the output parameters, such as setting the exporter.csv.export option to TRUE, which is required for \href{Synthea to OMOP builder}{https://github.com/OHDSI/ETL-Synthea}, which works off of the csv files and not the fhir files. To complete the run, this function should be re-called after saving any changes to the synthea.properties file and setting edit_synthea.properties to FALSE.
#' @param seed (Optional) Seed.
#' @param populationSize (Optional) Integer of simulated population size.
#' @param moduleFilter (Optional) Filter for a module. For example, "metabolic*" for all metabolic modules.
#' @param state (Optional) Population state. Defaults to Massachusetts.
#' @param city  (Optional) Population city. If provided, `state` must be provided.
#' @param edit_synthea.properties If TRUE and the session is interactive, the synthea.properties file is opened for editing and the run is skipped. To run Synthea using the new properties, the function should be called again with this argument set to FALSE.
#' @return
#' Simulated data in a timestamped folder in a `synthea_output` path.
#' @seealso
#'  \code{\link[cli]{cat_line}}
#'  \code{\link[glitter]{clone}}
#'  \code{\link[secretary]{typewrite}}
#' @rdname run_synthea
#' @export
#' @importFrom cli cat_rule
#' @importFrom glitter clone
#' @importFrom secretary typewrite
#' @importFrom R.utils copyDirectory
run_synthea <-
        function(seed,
                 populationSize = 1000,
                 moduleFilter,
                 state,
                 city,
                 edit_synthea.properties = TRUE) {

                if (missing(state) && !missing(city)) {

                        stop("state must be provided with city")

                }

                # Clone synthea to ~/Library if it does not exist
                installation_path <- "~/Library"
                installation_path <- path.expand(installation_path)
                synthea_path <- file.path(installation_path, "synthea")
                if (!("synthea" %in% list.files(installation_path))) {


                        cli::cat_rule("Clone synthetichealth/synthea")
                        glitter::clone(github_user =  "synthetichealth",
                                       repo = "synthea",
                                       destination_path = installation_path)

                        cli::cat_rule("Setup")
                        secretary::typewrite(
                                sprintf("\n\t\t\tcd %s\n\t\t\t./gradlew build check test",
                                        synthea_path))

                        if (interactive()) {

                                resp <- readline("Build check test gradlew? (Y/n): ")
                                if (resp == "Y") {
                                        system(sprintf("cd %s\n./gradlew build check test",
                                                       synthea_path))
                                } else {
                                        secretary::typewrite(sprintf("Skipped.", synthea_path))
                                }

                        }


                } else {
                        command <-
                                c("cd",
                                  sprintf("cd %s", synthea_path),
                                  "git pull --ff-only")
                        command <-
                                paste(command, collapse = "\n")
                        cli::cat_rule("Pull synthetichealth/synthea")
                        system(command = command)
                }


                # Make arguments
                args <- vector()

                if (!missing(seed)) {

                        args <-
                                c(args,
                                  sprintf("-s %s", seed))

                }

                if (!missing(populationSize)) {

                        args <-
                                c(args,
                                  sprintf("-p %s", populationSize))

                }

                if (!missing(moduleFilter)) {

                        args <-
                                c(args,
                                  sprintf("-m %s", moduleFilter))

                }

                if (!missing(state)) {

                        args <-
                                c(args,
                                  state)

                }

                if (!missing(city)) {

                        args <-
                                c(args,
                                  city)
                }
                args <- paste(args, collapse = " ")

                if (edit_synthea.properties) {

                        if (interactive()) {

                                cli::cat_rule("Edit Synthea Properties")
                                synthea.properties_path <-
                                        file.path(synthea_path,
                                                  "src/main/resources/synthea.properties")
                                file.edit(synthea.properties_path)
                                #system(sprintf("open %s", synthea.properties_path))
                        } else {
                                stop("Cannot edit synthea.properties in a non-interactive session.")
                        }
                } else {

                cli::cat_rule("Run Synthea")
                secretary::typewrite(sprintf("\n\t\t\tcd %s\n\t\t\t./run_synthea %s", synthea_path, args))
                system(sprintf("cd %s\n./run_synthea %s", synthea_path, args))


                cli::cat_rule("Copy Data To 'synthea_output'")
                if (!("synthea_output" %in% list.files(getwd()))) {
                        secretary::typewrite("'synthea_output' folder created")
                        dir.create("synthea_output")
                }
                new_dir <- file.path("synthea_output", as.character(Sys.time()))
                R.utils::copyDirectory(from = file.path(synthea_path, "output"),
                                       to = new_dir)

                secretary::typewrite(sprintf("data copied to '%s'", new_dir))

                }
        }
