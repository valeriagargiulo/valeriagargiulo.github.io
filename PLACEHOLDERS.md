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

- **Inoue & Rossi** — **submitted**; the current draft (2026-11-11) is hosted at
  `files/fiscal-multipliers.pdf`. The CEPR DP 20670 link is still shown, labelled
  "(earlier version)", because the DP carries the old title (*"...High Frequency
  Shocks"*). **Pending:** Barbara is updating the CEPR entry; when the new link
  arrives, swap it in on `research.html` and `index.html` and drop the label. The
  "Submitted" status is on all three pages but not yet in the CV PDF (v11) — add it
  at the next CV compile.
- **Ghosh** — in **Work in Progress**: early-stage, no circulatable draft, so no
  "available on request" offer. Promote it to Working Papers once a draft exists.
  The split is mirrored on `cv.html` and in the CV PDF (v9, 2026-10-13).
- **Debortoli et al. (MEGAIReF)** — hosted at `files/megairef.pdf` (AIReF Working
  Paper DT/2025/1).

Deliberately **not** in `sitemap.xml`: only `files/jmp.pdf` is listed there, so that
`research.html` ranks for the other paper titles rather than competing with its own
PDFs. The published EER article is linked to the journal, never hosted — that would
be the publisher's typeset version.

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

**Referee contact details and personal contact details never appear in anything
under this folder.** Not in `cv.html`, not in `files/cv.pdf`: the referee list is
names, titles and institutions only, so the site never pairs a referee with an
address. The one deliberate exception is a coauthor's own institutional email on
the title page of a paper they coauthored (e.g. `files/fiscal-multipliers.pdf`):
that is the author's own published contact, identical on every circulated version.

**No absolute internal paths.** Every internal link is relative with no leading slash
— `css/style.css`, not `/css/style.css`. That is what lets the site render identically
from the custom domain, a project subpath, or a local file. Check with:

```
grep -rn 'href="/\|src="/' .
```

**And remember the history is permanent.** Anything pushed to the public repo stays
retrievable even after a later commit replaces it. Check file *contents* before
pushing, not after — especially PDFs.
