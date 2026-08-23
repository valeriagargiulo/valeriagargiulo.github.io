# valeriagargiulo.com

Personal academic site. Plain HTML and one stylesheet — no framework, no build
step, no dependencies. What is in these files is exactly what is served.

## Updating it

Edit the file, then three commands:

```
git add -A
git commit -m "what changed"
git push
```

Live in about a minute.

| To change | Edit |
|---|---|
| Bio, JMP title / abstract / PDF link | `index.html` |
| Working papers, work in progress | `research.html` |
| Everything CV | `cv.html` |
| Email, address, profile links | `contact.html` |
| Colours, spacing, print layout | `css/style.css` |
| PDFs (CV, papers, statement) | replace the file in `files/`, keep the name |
| Photo | replace the file in `img/`, keep the name |

**Anything pushed to this repository is permanent.** Git keeps every version of
every file, so replacing or deleting a file in a later commit does not remove the
earlier one from a public history. Check content *before* pushing, not after &mdash;
`./check.sh` exists for exactly that.

**Replace PDFs in place, never rename them.** `files/cv.pdf` and `files/jmp.pdf`
are permanent public URLs — the placement advice requires one stable link, and
committees and the department hold these. Dated vintages of what was actually sent
live in `Package/CV/` and `Package/JMP/`, outside this repository.

The nav block is duplicated across all four HTML files. Changing a nav item means
changing it four times. This was the deliberate trade for having no build system;
if a nav link is wrong on one page only, that is why.

## Path rules

**Every internal link is relative with no leading slash** — `css/style.css`, never
`/css/style.css`. This is what makes the site render identically served from a
custom domain, served from a subpath, or opened straight off the filesystem by
double-clicking `index.html`. Check it holds with:

```
grep -rn 'href="/\|src="/' .
```

Absolute URLs appear **only** in head metadata, where the spec requires them. Every
one is the identical literal string `https://valeriagargiulo.com`, in these files:

- `index.html`, `research.html`, `teaching.html`, `cv.html` — `canonical`,
  `og:url`, `og:image`, `twitter:image`, and the JSON-LD block on `index.html`
- `sitemap.xml` — every `<loc>`
- `robots.txt` — the `Sitemap:` line
- `CNAME` — the domain itself, no scheme

So changing domain is one command:

```
grep -rl 'https://valeriagargiulo.com' . | xargs sed -i '' 's|https://valeriagargiulo.com|https://NEWDOMAIN|g'
```

then edit `CNAME` by hand.

## Nothing here is locked to GitHub

`CNAME` is one line — delete it and the custom domain is gone. `.nojekyll` is inert
everywhere else. There are no Actions, no `_config.yml`, no Jekyll. These files
work as-is on Netlify, Cloudflare Pages, a university web server, or from a USB
stick. `git remote remove origin` unwinds the GitHub link entirely.

## Before publishing anything

```
./check.sh
```

Five gates, all of which must pass:

1. **Placeholders** — no `TKTK` left anywhere.
2. **Absolute internal paths** — no `href="/`, no `src="/`.
3. **Referee email leakage** — no `upf.edu` / `crei.cat` / `bse.eu` address other
   than Valeria's own. Referee addresses must never enter this public repository;
   they belong only in the non-public CV variant.
4. **Links resolve** — every relative link points at a file that exists, and every
   `#anchor` has a matching `id`.
5. **Structured data** — the JSON-LD block on `index.html` parses.

It exits non-zero on failure, so it will fail loudly rather than quietly.
See `PLACEHOLDERS.md` for what is still outstanding.
