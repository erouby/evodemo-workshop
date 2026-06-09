# EvoDemo-Hyper MPM — workshop materials

A reproducible, GitHub Pages–ready **Quarto book** that teaches the *EvoDemo-Hyper* matrix population
model (Van de Walle, Garnier, Bonnet & Jenouvrier 2025, *Methods in Ecology and Evolution*,
[doi:10.1111/2041-210X.70075](https://doi.org/10.1111/2041-210X.70075)) using the
[`evodemohypermpm`](https://src.koda.cnrs.fr/timotheebonnet/evodemohypermpm) R package.

The site is a 2-hour hands-on workshop (four core chapters) plus an optional "going further" part. It
renders to **a website and a downloadable PDF from the same source**.

## What's here

```
evodemo-workshop/
├── _quarto.yml              # book config: chapters, HTML + PDF formats, theme
├── index.qmd                # welcome, schedule, how the site works
├── setup.qmd                # pre-work: installation + smoke test
├── 01-big-picture.qmd       # core: life cycle + the model in one picture
├── 02-first-model.qmd       # core: run MPM(), read output, first plots
├── 03-selection-scenarios.qmd  # core: selection on each vital rate
├── 04-slow-fast.qmd         # core: five species + the "it depends" payoff
├── 05-under-the-hood.qmd    # depth: hyperstate construction, theory vs MPM
├── 06-export-and-extend.qmd # depth: PDF export + extensions
├── references.qmd / .bib    # bibliography
├── theme.scss               # muted, Proza Libre theme
├── R/_setup.R               # shared libraries, ggplot theme, palette, species table
├── R/theoretical_rates.R    # analytic adaptation-rate formulas (Table 2)
├── R/install.R              # one-shot dependency installer
├── templates/report.qmd     # parameterised PDF report participants can render
└── .github/workflows/publish.yml  # CI deploy to GitHub Pages
```

## Build it locally

You need [Quarto](https://quarto.org/docs/get-started/) and R, plus the workshop packages:

```r
source("R/install.R")        # installs CRAN deps + evodemohypermpm from Koda
```

For the PDF download button, install a LaTeX engine once:

```bash
quarto install tinytex
```

Then, from the project folder:

```bash
quarto preview     # live preview while editing
quarto render      # build the whole site + PDF into /_book
```

## Deploy to GitHub Pages

**Option A — one command (recommended).** From your machine, after `quarto render` works:

```bash
quarto publish gh-pages
```

This renders locally and pushes the built site to a `gh-pages` branch. In your repo settings, set
**Pages → Source → Deploy from branch → `gh-pages` / root**. Your site appears at
`https://USERNAME.github.io/evodemo-workshop/`.

**Option B — automatic CI.** The included Action (`.github/workflows/publish.yml`) redeploys on every
push. It uses Quarto's *freeze* feature, so the CI runner needs **no R and no Koda access** — it just
republishes the pre-computed results. Workflow:

1. Render locally once: `quarto render` (this populates `/_freeze`).
2. Commit **both** your `.qmd` changes **and** the updated `/_freeze` folder.
3. Push to `main`. The Action rebuilds and deploys.

(If you edit a chapter but forget to re-render and commit `/_freeze`, CI will fail loudly — by design.)

## Make it yours

A few one-time edits:

- In `_quarto.yml`, replace `USERNAME` in `repo-url` / `page-footer` with your GitHub handle, and set
  the `author`.
- The five species and all defaults live in **`R/_setup.R`** — change the `species` table or the
  palette there and every chapter updates consistently.
- Add or reorder chapters in the `chapters:` list in `_quarto.yml`.

## How the teaching is designed

The structure is deliberate, following a few evidence-based principles:

- **Run first, explain later.** Participants run a full projection (ch. 2) before seeing any matrix
  algebra (ch. 5) — motivation precedes mechanism, which lowers cognitive load and raises buy-in.
- **Worked example → faded scaffolding → independent practice.** Ch. 2 is fully worked; ch. 3 gives a
  reusable helper to adapt; ch. 4 has them drive the full sweep; ch. 6 is an open capstone.
- **Predict–observe–explain.** "Your turn" boxes ask for a prediction *before* the plot appears;
  committing to a guess is what makes the result stick.
- **Retrieval with feedback.** Exercises have collapsible solutions so participants self-check
  immediately.
- **Dual coding & consistent visual vocabulary.** One colour always means one thing (a species, a
  vital rate, an age class), defined once in `R/_setup.R`.
- **A single narrative thread.** The grass-vs-albatross prediction is planted in ch. 1 and paid off in
  ch. 4 — the "it depends on the definition" punchline.

## Credit

The model and the `evodemohypermpm` package are the work of **Joanie Van de Walle, Jimmy Garnier,
Timothée Bonnet and Stephanie Jenouvrier**. Please cite their paper in any work that uses the method.
Full code (MATLAB + R + IBM) is at [`fledge-whoi/Eco-EvoHyperstateModel`](https://github.com/fledge-whoi/Eco-EvoHyperstateModel);
the reproduction archive is on [Zenodo](https://doi.org/10.5281/zenodo.15236774). These workshop
materials are a teaching layer and carry no endorsement from the original authors.
