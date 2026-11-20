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
mkdocs serve -f products/sspa-controller/mkdocs.yml
mkdocs build --strict -f products/sspa-controller/mkdocs.yml

# Publish a version (firmware minor release) and move "latest"
mike deploy -F products/sspa-controller/mkdocs.yml --deploy-prefix sspa-controller --push --update-aliases <ver> latest
mike set-default -F products/sspa-controller/mkdocs.yml --deploy-prefix sspa-controller --push latest
```

### Landing page

`landing/` is the page at the root of docs.helixrf.com. Copy it to the root of the `gh-pages`
branch (next to the product folders, keep the `CNAME` file there) and push:

```powershell
git worktree add ..\helixrf-docs-pages gh-pages
Copy-Item -Recurse -Force landing\* ..\helixrf-docs-pages\
cd ..\helixrf-docs-pages; git add -A; git commit -m "Update landing page"; git push; cd ..\helixrf-docs
git worktree remove ..\helixrf-docs-pages
```

Versions follow firmware minor releases; hardware revisions are content tabs inside pages.
