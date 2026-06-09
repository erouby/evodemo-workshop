# R/install.R
# Run once to install everything the workshop needs.
#   source("R/install.R")

cran <- c("remotes", "tidyverse", "pracma", "gsignal", "purrr", "tidyr", "Matrix")
to_get <- setdiff(cran, rownames(installed.packages()))
if (length(to_get)) install.packages(to_get)

# The workshop package, from the CNRS Koda forge:
remotes::install_gitlab(
  repo = "timotheebonnet/evodemohypermpm",
  host = "https://src.koda.cnrs.fr/"
)

message("Done. Test with: library(evodemohypermpm); ?MPM")
