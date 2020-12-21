run_synthea <-
        function(seed,
                 populationSize,
                 moduleFilter,
                 state,
                 city) {

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

                cli::cat_rule("Run Synthea")
                secretary::typewrite(sprintf("\n\t\t\tcd synthea\n\t\t\t./run_synthea %s", args))
                system(sprintf("cd synthea\n./run_synthea %s", args))


        }
