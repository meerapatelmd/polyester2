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
#' Simulated data in the `./synthea/output` path.
#' @seealso
#'  \code{\link[cli]{cat_line}}
#'  \code{\link[glitter]{clone}}
#'  \code{\link[secretary]{typewrite}}
#' @rdname run_synthea
#' @export
#' @importFrom cli cat_rule
#' @importFrom glitter clone
#' @importFrom secretary typewrite
run_synthea <-
        function(seed,
                 populationSize,
                 moduleFilter,
                 state,
                 city,
                 edit_synthea.properties = TRUE) {

                if (missing(state) && !missing(city)) {

                        stop("state must be provided with city")

                }

                # Clone synthea and setup if not already exists

                if (!("synthea" %in% list.files())) {


                        cli::cat_rule("Clone synthetichealth/synthea")
                        glitter::clone(github_user =  "synthetichealth",
                                       repo = "synthea",
                                       destination_path = getwd())

                        cli::cat_rule("Setup")
                        secretary::typewrite("\n\t\t\tcd synthea\n\t\t\t./gradlew build check test")
                        system("cd synthea\n./gradlew build check test")


                } else {

                        cli::cat_rule("Clone synthetichealth/synthea")
                        time_diff <- signif(difftime(Sys.time(),file.info("synthea")$ctime), 2)
                        time_diff_num <- time_diff[[1]]
                        time_diff_unit <- units(time_diff)
                        secretary::typewrite(sprintf("synthetichealth/synthea cloned %s %s ago...", time_diff_num, time_diff_unit))
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

                                system(sprintf("open %s", "synthea/src/main/resources/synthea.properties"))
                        }
                } else {

                cli::cat_rule("Run Synthea")
                secretary::typewrite(sprintf("\n\t\t\tcd synthea\n\t\t\t./run_synthea %s", args))
                system(sprintf("cd synthea\n./run_synthea %s", args))

                }
        }
