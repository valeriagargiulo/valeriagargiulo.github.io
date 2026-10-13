# Outstanding items

What is *not* yet on the site, and the rules that are easy to break when adding to
it. Everything described here as done was verified live.

**Pre-publish gate:**

```
./check.sh
```

Must PASS. It fails on leftover `TKTK` placeholders, absolute internal paths,
referee-email leakage, personal contact details, stray tracked files, broken links
and invalid structured data.

---

## Still outstanding

### Working-paper PDFs — `research.html`
The three working papers show "Draft available on request" rather than a link. The
CEPR version of the fiscal-multipliers paper is deliberately **not** linked: it is
superseded, and the current draft should be posted instead when ready.

To add one: drop the PDF in `files/`, replace the "Draft available on request" text
with `<a href="files/<slug>.pdf">PDF</a>`. Consider adding it to `sitemap.xml` too —
but only once the file is actually live, since a URL that 404s produces a Search
Console error.

### Teaching page — parked outside the repository
Lives at `Package/Website/drafts/teaching.html`, **not** in the site folder. Its only
content would have been the course list, which already appears on `cv.html`;
duplicating it across two pages makes Google pick one and discount the other. Parking
it outside the served folder also means nobody reaches a page of placeholders by
guessing the URL.

Restore it once a teaching statement exists: move the file back into `site/`, add the
philosophy text and `files/teaching-statement.pdf`, put
`<a href="teaching.html">Teaching</a>` into the nav of **every** page, and add its
`<url>` entry to `sitemap.xml`.

### X profile — if one is created
Goes in **two** places, together: the "Elsewhere" section of `contact.html` and the
`sameAs` array in the `index.html` JSON-LD. Google Scholar and LinkedIn are already
in both. A partial set gives Google a partial picture of who you are across the web.

---

## Done, recorded so it is not re-litigated

- **Photo** — professional headshot (October 2026), 480×640, plus a 1200×630
  link-preview card. Originals kept in `Package/Website/`, outside the repo.
- **Bio, JMP abstract, CV page, contact page** — all written and live.
- **Hosted CV** — no phone number, no home address, no referee emails. A single
  variant: what goes to the GPEFM office and employers is the file that is hosted.
- **Referees** — Rossi (EUI), Petrova (Ca' Foscari), Debortoli (UPF), Brownlees
  (Luiss). Names, titles and institutions only.
- **Old Google Sites page** — unpublished 2026-08-23. It competed for her name and
  exposed a personal email address. **Do not republish it: one page only.**

---

## Two rules that are easy to break later

**Referee emails and personal contact details never appear in anything under this
folder.** Not in `cv.html`, not in `files/cv.pdf`. This is a public repository;
addresses on a crawlable page get scraped. Names, titles and institutions only.

**No absolute internal paths.** Every internal link is relative with no leading slash
— `css/style.css`, not `/css/style.css`. That is what lets the site render identically
from the custom domain, a project subpath, or a local file. Check with:

```
grep -rn 'href="/\|src="/' .
```

**And remember the history is permanent.** Anything pushed to the public repo stays
retrievable even after a later commit replaces it. Check file *contents* before
pushing, not after — especially PDFs.
