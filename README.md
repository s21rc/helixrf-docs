# helixrf-docs

HelixRF product documentation (https://docs.helixrf.com), built with MkDocs Material and versioned with mike.

## Layout

```
products/<product>/mkdocs.yml   one MkDocs project per product (docs in products/<product>/docs)
shared/                         snippets included with --8<-- (pymdownx.snippets, base_path: [shared])
overrides/                      shared theme dir: HelixRF colours, self-hosted fonts, logos
  assets/stylesheets/helixrf.css   same tokens as the WordPress theme (slate = dark, default = light)
landing/                        static landing page for the root of docs.helixrf.com
```

Each product's `mkdocs.yml` sets `theme.custom_dir: ../../overrides` and `theme.font: false`
(no Google Fonts request). Product-specific CSS goes in `products/<product>/docs/stylesheets/extra.css`.

Product pages on helixrf.com link to `docs.helixrf.com/<docs_slug>/latest/` and to the
`build/`, `setup/` and `firmware/` sections, so keep those folder names in every product.

## Commands (repo root, `.venv` active)

```powershell
mkdocs serve -f products/helixrf-sspa-controller/mkdocs.yml          # local preview
mkdocs build --strict -f products/helixrf-sspa-controller/mkdocs.yml # check
```

## Publishing (public)

docs.helixrf.com is GitHub Pages, served from the `gh-pages` branch (custom domain in
`CNAME`; DNS: CNAME `docs` -> `s21rc.github.io`). Commit and push `main` first, then:

```powershell
.\publish-docs.ps1 -Version 1.1               # SSPA Controller 1.1, moves "latest"
.\publish-docs.ps1 -Version 1.1 -NoLatest     # publish without moving "latest"
.\publish-docs.ps1 -Product helixrf-nmos-highside-switch -Version 1.0
.\publish-docs.ps1 -Landing                   # copy landing/ to the gh-pages root
.\publish-docs.ps1 -List                      # published versions
```

Re-publishing the same version number overwrites it (fine for typo fixes).
Versions follow firmware minor releases; hardware revisions are content tabs inside pages.

New product: copy `products/helixrf-sspa-controller` to `products/<brand>-<product>`, change
`site_name`, `site_description`, `site_url`, `edit_uri` and `nav`, keep the `build/`, `setup/`
and `firmware/` folders, add a card to `landing/index.html`, then publish both.
