# R/theoretical_rates.R
#
# Analytic rates of adaptation for the two-stage life cycle, from Table 2 of
# Van de Walle, Garnier, Bonnet & Jenouvrier (2025) Methods Ecol. Evol.
# Adapted (and tidied) from Timothée Bonnet's `TheoreticalDerivations.R` in
# https://github.com/fledge-whoi/Eco-EvoHyperstateModel  -- please cite the paper.
#
# Returns, for one species, the per-year (RAT) and per-generation (RAG) rate of
# adaptation when selection (strength `beta`, on the link scale) acts on each of
# the four vital rates. These are the "linear-scale" definitions; the package
# itself can be used for the selection- and fitness-standardised definitions.

theoretical_rates <- function(F, SA, SJ, Y, Va = 0.2, Vp = 1, beta = 0.15) {
  h2 <- Va / Vp
  f  <- F / SJ                                   # per-capita offspring per year

  # Asymptotic growth rate of the 2x2 Leslie matrix (dominant eigenvalue)
  lambda <- (SJ * (1 - Y) + SA) / 2 +
            sqrt((SJ * (1 - Y) - SA)^2 + 4 * f * SJ^2 * Y) / 2

  # Left (v) and right (w) eigenvectors, and generation time T
  v <- c(Y * SJ,  lambda - SJ * (1 - Y))
  w <- c(f * SJ,  lambda - SJ * (1 - Y))
  Tgen <- lambda * sum(v * w) / (v[1] * w[2] * f * SJ)

  # Per-generation rates (RAG), one expression per vital rate (Table 2, "beta" column)
  rag <- c(
    Fe = h2 * Vp * beta,
    SJ = h2 * Vp * beta * (1 + lambda / (lambda - SJ * (1 - Y))) * (1 - SJ),
    Y  = h2 * Vp * beta * ((lambda - SJ) * (1 - Y) / (lambda - SJ * (1 - Y))),
    SA = h2 * Vp * beta * (SA * (1 - SA) / (lambda - SA))
  )

  tibble::tibble(
    rate     = names(rag),
    per_gen  = unname(rag),
    per_year = unname(rag) / Tgen,               # RAT = RAG / T
    Tgen     = Tgen,
    lambda   = lambda
  )
}
