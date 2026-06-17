# R/_setup.R
# Sourced at the top of every chapter (the project uses execute-dir: project).
# Keeps each chapter free of repetitive boilerplate so the teaching code stays readable.

suppressPackageStartupMessages({
  library(evodemohypermpm)   # the workshop package (installed from Koda; see "Before you arrive")
  library(tidyverse)
})

# A calm, publication-style ggplot theme used throughout -----------------------
theme_evodemo <- function(base_size = 12) {
  theme_minimal(base_size = base_size) +
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(colour = "grey90", linewidth = 0.3),
      plot.title       = element_text(face = "bold", size = rel(1.05)),
      plot.subtitle    = element_text(colour = "grey35"),
      legend.position  = "bottom",
      strip.text       = element_text(face = "bold")
    )
}
theme_set(theme_evodemo())

# Shared colour vocabulary so a colour always means the same thing --------------
# Five species along the slow-fast continuum (fast = warm, slow = cool):
species_pal <- c("1" = "#D8A657", "2" = "#A9A23F", "3" = "#6E9B8C",
                 "4" = "#3E6E83", "5" = "#2D3E54")

# The four vital rates that can be put under selection:
vital_pal <- c(Fe = "#B5651D", SJ = "#5B8C5A", SA = "#3E6E83", Y = "#8E7CC3")
vital_lab <- c(Fe = "Fertility (F)", SJ = "Juvenile survival (S_J)",
               SA = "Adult survival (S_A)", Y = "Maturation (\u03b3)")

# Age classes:
age_pal <- c(adult = "#2D3748", juvenile = "#D8A657")

# The five species of Van de Walle et al. (2025), Table 1 ----------------------
# Column `F` is the paper's fertility F (the value passed to MPM(Fe = ...)).
species <- tibble::tibble(
  species = factor(1:5),
  label   = c("Grass / insect", "Small mammal / bird", "Deer", "Primate", "Albatross / whale"),
  F       = c(10.9868, 4.9958, 0.9987, 0.3004, 0.2286),
  SA      = c(0.0365, 0.2000, 0.8000, 0.9300, 0.9500),
  SJ      = c(0.0965, 0.2500, 0.3850, 0.5050, 0.8000),
  gamma   = c(0.9000, 0.5720, 0.4000, 0.3000, 0.0700),
  Tgen    = c(2.0476, 2.3698, 6.3004, 15.7521, 23.9042)
)
