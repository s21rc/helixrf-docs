# HelixRF docs: how to edit, preview and publish

Your reference for working on **https://docs.helixrf.com**.
Repo: `D:\helixrf_web\helixrf-docs` (GitHub: `s21rc/helixrf-docs`).

In short: you edit Markdown (`.md`) files on the PC, preview them locally, back them up to git,
then publish with one command. Nothing is edited on the website itself.

---

## 1. Where things are

```
helixrf-docs\
├─ products\
│  └─ helixrf-sspa-controller\        one folder per product
│     ├─ mkdocs.yml                   site name, menu (nav:), settings
│     └─ docs\
│        ├─ index.md                  manual home page (block diagram)
│        ├─ getting-started.md
│        ├─ build\index.md            build and first power-up
│        ├─ build\connectors.md       connectors and wiring
│        ├─ using\index.md            main screen, faces, gestures, faults
│        ├─ setup\index.md            setup and calibration
│        ├─ setup\band-data.md        band data, radio profiles, antennas
│        ├─ setup\network.md          WiFi, remote, display, CAN power supply
│        ├─ firmware\index.md         firmware and release notes
│        ├─ reference.md              technical reference and parts count
│        ├─ assets\images\            display screenshots (.webp)
│        └─ assets\wiring\            wiring diagrams and PDFs
├─ shared\                            text reused by every product (e.g. safety-rf.md)
├─ overrides\                         HelixRF colours, fonts, logos (shared look)
├─ landing\index.html                 the docs.helixrf.com front page (product cards)
├─ publish-docs.ps1                   publishes to the public site
├─ README.md                          short technical notes
└─ EDITING.md                         this file
```

Keep the folder names `build\`, `setup\` and `firmware\`. The product pages on helixrf.com link to them.

---

## 2. Everyday editing

### Step 1: start the live preview

Open a terminal in VS Code (Terminal → New Terminal) and run:

```powershell
cd D:\helixrf_web\helixrf-docs
.venv\Scripts\mkdocs serve -f products/helixrf-sspa-controller/mkdocs.yml
```

Open **http://127.0.0.1:8000** in your browser. Each time you save a file, the page reloads by itself.
Leave it running while you work, and press **Ctrl+C** in the terminal to stop it.

### Step 2: edit and save

Open the `.md` file in VS Code, change the text and save (Ctrl+S). Then check the browser.

To find the unfinished parts, use **Ctrl+Shift+F** and search for `TODO`.

### Step 3: back up to git

When you finish a session:

```powershell
git add -A
git commit -m "Docs: describe what you changed"
git push
```

This is only a backup. It does **not** change the public site.

### Step 4: publish to the public site

```powershell
.\publish-docs.ps1 -Version 1.0
```

The script checks the build first, then asks `(y/N)`. Answer `y`. The site updates within about
1–2 minutes. If the browser still shows the old page, refresh with Ctrl+F5.

You don't need to activate `.venv` first; the script finds it by itself.

---

## 3. Formatting cheat-sheet

Copy these patterns; the existing pages use all of them.

### Headings and text

```markdown
# Page title            (one per page)
## Section
### Sub-section

**bold**   *italic*   `code or pin name`
```

### Lists

```markdown
- bullet point
- another

1. numbered step
2. next step
```

### Table

```markdown
| Pin | Signal | Notes |
| --- | --- | --- |
| 1 | GND | |
| 2 | +12 V | Fused on board |
```

### Image

Put the file in `docs\assets\wiring\` (or another folder under `assets`). Use lowercase names
with no spaces, for example `fan-wiring.png`.

```markdown
![Short description of the picture](../assets/wiring/fan-wiring.png){ loading=lazy }
```

The path is **relative to the page**:
- from `index.md` or `getting-started.md`: `assets/wiring/...`
- from a page inside `build\`, `setup\` or `firmware\`: `../assets/wiring/...`

Image you can click to enlarge, with a caption:

```markdown
<figure markdown>
  [![Description](assets/wiring/picture.png){ loading=lazy }](assets/wiring/picture.png)
  <figcaption>Caption text.</figcaption>
</figure>
```

### Download link (PDF etc.)

```markdown
[Download the PDF](../assets/wiring/my-file.pdf)
```

### Revision tabs (Rev 4.01 / Rev 4.02)

Indent the content under each tab by **4 spaces**:

```markdown
=== "Rev 4.01"

    Connect the cable to J20.

=== "Rev 4.02"

    Connect the cable to J20. The extra pin 5 is raw PWM.
```

### Coloured boxes

```markdown
!!! warning "Test before going on the air"
    Indented text inside the box.
```

Box types: `note`, `info`, `tip`, `warning`, `danger`.
Use `??? note "Title"` for a box that starts collapsed.

### Links

```markdown
[Setup and calibration](../setup/index.md)                    another page
[Fan connector](connectors.md#j20-j21-fan)                    a section on a page
[HelixRF shop](https://helixrf.com/shop/)                     a website
```

The `#...` part is the section heading in lower case, with spaces turned into `-` and most
punctuation removed. Hover a heading in the preview and click the `¶` sign to copy its exact link.

### Wiring sketches (text drawings)

Text drawings go inside a ```` ```text ```` block, so the spacing stays exact:

````markdown
```text
 Controller J20                 Fan
 ┌──────────────┐              ┌──────────┐
 │ 4  +12V      ├──────────────┤ + (red)  │
 │ 3  FAN −     ├──────────────┤ − (black)│
 └──────────────┘              └──────────┘
```
````

To swap one for a proper drawing, delete the block and put an image line in its place.

### Shared text

Text in `shared\` can be included in any page of any product:

```markdown
--8<-- "safety-rf.md"
```

Edit `shared\safety-rf.md` once and every page that includes it changes.

---

## 4. Common jobs

### Add a new page

1. Create the file, for example `docs\setup\remote.md`.
2. Add it to the menu in `products\helixrf-sspa-controller\mkdocs.yml` under `nav:`:

   ```yaml
   nav:
     - Home: index.md
     - Getting started: getting-started.md
     - Build guide:
         - build/index.md
         - Connectors and wiring: build/connectors.md
     - Setup and calibration:
         - setup/index.md
         - Remote monitoring: setup/remote.md
     - Firmware and release notes: firmware/index.md
   ```

   Indentation matters in `mkdocs.yml`: use spaces, never tabs.

### Replace a diagram

Export the new picture with the **same file name** over the old one in `docs\assets\wiring\`.
Every page that shows it updates automatically.

Current files:

| File | Shown on |
| --- | --- |
| `system-block-diagram.png` | Home page, Connectors (System tab) |
| `helixrf-sspa-v4-block-diagram.pdf` | Download link on both |
| `control-harness.png` | Connectors (Control harness tab) |
| `power-wiring.png` | Connectors (Power tab) |
| `rf-signal-path.png` | Connectors (RF path tab) |
| `other-connectors.png` | Connectors (Other I/O tab) |

### Fix a typo on the live site

Edit, then run `.\publish-docs.ps1 -Version 1.0` again. Republishing the same version number replaces it.

### New firmware release (new manual version)

The manual's versions follow **firmware minor releases**. Hardware revisions are tabs inside pages,
not versions.

1. Update the pages (release notes in `firmware\index.md`, and any changed steps).
2. Commit and push.
3. Publish the new number:

   ```powershell
   .\publish-docs.ps1 -Version 1.1
   ```

   `latest` moves to 1.1, and 1.0 stays online so readers can pick it from the version menu.
   Product pages on helixrf.com always link to `latest`.

To publish without moving `latest` (e.g. a preview): `.\publish-docs.ps1 -Version 1.1 -NoLatest`.

To see what's published: `.\publish-docs.ps1 -List`.

### Change the docs front page (product cards)

Edit `landing\index.html`, then:

```powershell
.\publish-docs.ps1 -Landing
```

### Add a manual for a new product

Example: NMOS high-side switch, slug `helixrf-nmos-highside-switch`.

1. Copy the folder:

   ```powershell
   Copy-Item -Recurse products\helixrf-sspa-controller products\helixrf-nmos-highside-switch
   ```

2. In the new `mkdocs.yml`, change:

   ```yaml
   site_name: Helix NMOS High-Side Switch
   site_description: Build guide, setup and reference for the Helix NMOS high-side switch by HelixRF.
   site_url: https://docs.helixrf.com/helixrf-nmos-highside-switch/
   edit_uri: edit/main/products/helixrf-nmos-highside-switch/docs/
   ```

   Then adjust `nav:`.
3. Rewrite the pages. Keep `build\`, `setup\` and `firmware\`. If there's no firmware, keep a short
   `firmware\index.md` that says so.
4. Preview it:

   ```powershell
   .venv\Scripts\mkdocs serve -f products/helixrf-nmos-highside-switch/mkdocs.yml
   ```

5. Add a card to `landing\index.html` (copy the SSPA Controller `<a class="card" ...>` block and
   change the link to `helixrf-nmos-highside-switch/latest/`).
6. Commit, push, then publish both:

   ```powershell
   .\publish-docs.ps1 -Product helixrf-nmos-highside-switch -Version 1.0
   .\publish-docs.ps1 -Landing
   ```

7. In WooCommerce, on that product's **HelixRF** tab, set **Docs slug** to
   `helixrf-nmos-highside-switch`.

---

## 5. Editing on GitHub in the browser (optional)

You can open any file on **github.com/s21rc/helixrf-docs**, click the pencil icon, edit and commit.
That's handy for a quick typo fix away from the PC.

Afterwards, **before editing on the PC again**, run:

```powershell
git pull
```

Otherwise the two copies conflict. A GitHub edit does not publish by itself; you still run
`publish-docs.ps1` from the PC.

---

## 6. How the hosting works (for reference)

- **docs.helixrf.com** is served by **GitHub Pages** from the `gh-pages` branch of the repo.
  Hostinger only holds the DNS record.
- DNS (hPanel → helixrf.com → DNS records): **CNAME** `docs` → `s21rc.github.io`. Don't delete it.
- GitHub → repo **Settings → Pages**: Source `gh-pages` / `(root)`, Custom domain `docs.helixrf.com`,
  **Enforce HTTPS** ticked.
- The `gh-pages` branch is written by `publish-docs.ps1` (it uses the tool **mike**). Never edit
  that branch by hand. Your files are on `main`.
- Address layout:

  ```
  docs.helixrf.com/                                   landing page
  docs.helixrf.com/helixrf-sspa-controller/           → redirects to latest
  docs.helixrf.com/helixrf-sspa-controller/latest/    newest version
  docs.helixrf.com/helixrf-sspa-controller/1.0/       a specific version
  ```

---

## 7. Troubleshooting

| Problem | Fix |
| --- | --- |
| `running scripts is disabled on this system` | Run once: `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` |
| `mkdocs` or `mike` not found / `.venv` missing (new PC) | `python -m venv .venv` then `.venv\Scripts\pip install -r requirements.txt` |
| Preview page doesn't change | Check the terminal for an error; make sure you saved the file; restart `mkdocs serve`. |
| "Strict build failed" when publishing | Read the `WARNING` lines above it: usually a broken link or a missing image path. Fix it and run again. |
| `[Errno 10048]` / address in use when starting preview | A preview is already running. Use it, or close the other terminal. |
| Image doesn't show | Check the path is relative to the page (`../assets/...` from sub-folders) and the file name matches exactly. |
| Tab content shows as code or doesn't appear in the tab | The content under `=== "..."` must be indented by exactly 4 spaces. |
| Live site still old after publishing | Wait 2 minutes, then Ctrl+F5. Check with `.\publish-docs.ps1 -List`. |
| `git push` rejected | Someone (or you, on GitHub) changed it online: run `git pull`, then push again. |
| A warning about Material for MkDocs end of life (May 2027) | Information only. Nothing to do now; a move to its successor (Zensical) can be planned for 2027. |

---

## 8. Quick reference

```powershell
cd D:\helixrf_web\helixrf-docs

# preview (Ctrl+C to stop)
.venv\Scripts\mkdocs serve -f products/helixrf-sspa-controller/mkdocs.yml

# back up
git add -A; git commit -m "Docs: ..."; git push

# publish
.\publish-docs.ps1 -Version 1.0        # update current version
.\publish-docs.ps1 -Version 1.1        # new version, becomes latest
.\publish-docs.ps1 -Landing            # front page
.\publish-docs.ps1 -List               # what's published
```
