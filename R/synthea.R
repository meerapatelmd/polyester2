download_synthea_jar <-
        function(url = "https://github.com/synthetichealth/synthea/releases/download/master-branch-latest/synthea-with-dependencies.jar") {

                file <- basename(url)
                tmpDir <- tempdir(check = TRUE)
                destfile <- file.path(tmpDir, file)
                download.file(url = url,
                              destfile = destfile)


                invisible(destfile)

        }



run_synthea <-
        function() {

                if (!("synthea" %in% list.files())) {


                        cli::cat_rule("Clone synthetichealth/synthea")
                        glitter::clone(github_user =  "synthetichealth",
                                       repo = "synthea",
                                       destination_path = getwd())

                        cli::cat_rule("Setup")
                        secretary::typewrite("\n\t\t\tcd synthea\n\t\t\t./gradlew build check test")
                        system("cd synthea\n./gradlew build check test")


                }

                cli::cat_rule("Run Synthea")
                secretary::typewrite("\n\t\t\tcd synthea\n\t\t\t./run_synthea")
                system("cd synthea\n./run_synthea")


        }
