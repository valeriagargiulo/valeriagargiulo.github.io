# Placeholders

Every unresolved item on the site is marked with the literal token `TKTK` — a
string that never occurs in real prose, so it can be found mechanically and cannot
ship by accident.

**Pre-publish gate.** Before the site goes live, both of these must pass:

```
grep -rn TKTK .
```

returns nothing, and every `href`/`src` in the HTML resolves to a file that exists.

---

## Content still needed

### Photo — `img/`
Drop the image in as `img/valeria-gargiulo.jpg`. Then in `index.html`, delete the
placeholder paragraph and uncomment the `<img>` tag above it, setting `width` and
`height` to the real pixel dimensions (this prevents the page jumping as it loads).

Also needs `img/og-image.jpg` at **1200×630** — the link-preview card used by
LinkedIn, X, Slack and iMessage. It is already referenced by every page's
`og:image` tag. A cropped version of the portrait on a plain background works.
Until it exists, links to the site preview with a blank image.

### Bio — `index.html`
Four sentences, formal register, research keywords in `<strong>`. A draft to react
to is in the HTML comment right above the placeholder.

### Job market paper — `index.html`
- Abstract, 100–150 words (`Package/NOTES.md:25`). The single most important text
  on the site.
- Date for the current version.
- `files/jmp.pdf` — the polished PDF.
- **Mirror the abstract into the JSON-LD `"abstract"` field** in the same file.
  Two places, one text.

### Other papers — `research.html`
Four or more, each with title, coauthors, status, abstract, and a PDF in `files/`.
A copy-paste template is in the HTML comment. Titles and coauthors also go into the
Working Papers list on `cv.html` — **titles only there, no abstracts.**

### CV — `cv.html` and `files/cv.pdf`
All sections are stubbed and marked. Sections with nothing to list (Refereeing,
Awards, Work in Progress) should be **deleted outright** — an empty heading reads
worse than no heading.

**The CV page is written.** What remains is the hosted PDF and the referee
affiliations.

### The hosted CV PDF &mdash; done, and clean

`files/cv.pdf` is the 2026-09-24 version (v3). Its header carries the UPF email and the
department address only &mdash; **no phone number, no home address**, no referee
emails. Nothing in it needs withholding, so there is a single CV variant rather than
a public and a private one.

Updating it: save the new dated vintage in `Package/CV/`, copy it over
`files/cv.pdf` keeping the filename, then commit and push. The URL is permanent and
committees hold it, so never rename it.

Bear in mind that git retains every version pushed to a public repository. Check a
PDF's contents *before* pushing it; a later replacement cleans the live site but not
the history.

### Referee affiliations &mdash; done

Rossi (EUI), Petrova (Ca&rsquo; Foscari), Debortoli (UPF), Brownlees (Luiss),
confirmed by Valeria. Names, titles and institutions only &mdash; **no emails**, and
that rule does not change.

### Proofread the transcribed abstracts

The abstracts on `index.html` and `research.html` were transcribed from the CV PDF.
The extraction dropped every `ff`/`fi`/`fl` ligature — "different" arrived as
"di erent", "fiscal" as " scal" — and these were reconstructed by hand. The text
reads correctly, but **check it against your own source before publishing.** Your own
notes are blunt about typos: committees see hundreds of files and need no reason to
move on.

### Teaching &mdash; parked outside the repository

The page now lives at `Package/Website/drafts/teaching.html`, **not** in the site
directory. Its only content would have been the course list, which already lives on
`cv.html`; repeating it across two pages makes Google pick one and discount the
other, and a CV without teaching listed looks incomplete to a committee. Parking it
outside the served folder also means nobody can stumble on a page of placeholders by
guessing the URL.

Restore it when the teaching statement exists (an October deliverable per
`Package/CHECKLIST.md`): move the file back into `site/`, fill in the philosophy text
and `files/teaching-statement.pdf`, add `<a href="teaching.html">Teaching</a>` to the
nav in all pages, and re-add its `<url>` entry to `sitemap.xml`.

### Profile links &mdash; LinkedIn in, two still missing

LinkedIn is live in two places: the "Elsewhere" section of `contact.html` and the
`sameAs` array in the `index.html` JSON-LD. **Add Google Scholar and X to both
together** &mdash; a partial set gives Google a partial picture of who you are across
the web.

A Google Scholar profile is worth creating soon regardless: it is the strongest
single signal for name searches and surfaces as its own result alongside the site.

### Sitemap — `sitemap.xml`
Add `files/jmp.pdf` once that file exists. Listing a URL that 404s produces a
Search Console error, so add it only after the PDF is in place.

---

## Two rules that are easy to break later

**Referee emails never appear in anything under this folder.** Not in `cv.html`,
not in `files/cv.pdf`. This directory becomes a public repository; referee
addresses on a crawlable page get scraped. The version with contact details is the
non-public CV variant.

**No absolute internal paths.** Every internal link is relative with no leading
slash — `css/style.css`, not `/css/style.css`. This is what lets the site render
identically from a custom domain, a project subpath, or a local file. Check with:

```
grep -rn 'href="/\|src="/' .
```
