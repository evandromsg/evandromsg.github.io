# Personal Academic Website

This repository holds my personal academic website, built with [Quarto](https://quarto.org) and published with GitHub Pages.

**Live site:** https://evandromsg.github.io

## Technology

Built in RStudio as a Quarto Website project. Source files are the `.qmd` pages and `_quarto.yml`; the rendered site lives in `docs/`, which is what GitHub Pages publishes.

## How to rebuild this site

1. In RStudio: **File → New Project → New Directory → Quarto Website**.
2. Edit `_quarto.yml`, making sure it includes `output-dir: docs`.
3. Each `.qmd` file becomes a page — this site uses `index.qmd`, `research.qmd`, `teaching.qmd`, and `cv.qmd`.
4. Preview with `quarto preview` and render the final version with `quarto render`.
5. Create an empty `.nojekyll` file in the project root **and** inside `docs/` (required so GitHub Pages serves the site's CSS/JS correctly).
6. Push the project to a GitHub repository named `<your-username>.github.io`.
7. In the repository's **Settings → Pages**, set Source to **Deploy from a branch**, Branch **main**, Folder **/docs**.

## Daily update workflow

```
quarto render
git add .
git commit -m "Describe what changed"
git push
```
