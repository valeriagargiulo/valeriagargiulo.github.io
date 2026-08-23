#!/bin/sh
# Pre-publish gate. Run from the repository root:  ./check.sh
# Exits non-zero if anything would break the site or leak private data.

cd "$(dirname "$0")" || exit 1
fail=0

echo "== placeholders =="
if grep -rn 'TKTK' --include='*.html' --include='*.xml' . ; then
  echo "  ^ unresolved placeholders — do not publish"; fail=1
else
  echo "  none"
fi

echo
echo "== absolute internal paths =="
if grep -rn 'href="/\|src="/' --include='*.html' . ; then
  echo "  ^ must be relative (css/style.css, not /css/style.css)"; fail=1
else
  echo "  none"
fi

echo
echo "== referee email leakage =="
# Any upf.edu address other than Valeria's own is a referee address and must not
# be in this public repository. See PLACEHOLDERS.md.
if grep -rniE '[a-z0-9._%+-]+@(upf\.edu|crei\.cat|bse\.eu)' --include='*.html' . \
   | grep -vi 'valeria\.gargiulo@upf\.edu' ; then
  echo "  ^ non-Valeria academic email found — remove before publishing"; fail=1
else
  echo "  none"
fi

echo
echo "== personal contact details =="
# The CV carries a personal mobile number. The site shows the department address
# (postcode 08005) and email only. Patterns are generic on purpose: writing the real
# values here would put them in this public repository. See PLACEHOLDERS.md.
hits=$(grep -rniE '\+?\(?\+?34\)?[ .-]?[67][0-9]{2}[ .-]?[0-9]{3}[ .-]?[0-9]{3}|\b08[0-9]{3}\b' \
         --include='*.html' --include='*.md' . | grep -v '08005')
if [ -n "$hits" ]; then
  printf '%s\n' "$hits"
  echo "  ^ a phone number, or a Barcelona postcode other than the department's"
  echo "    (08005), was found. Remove before publishing."; fail=1
else
  echo "  none"
fi

echo "== unexpected files =="
# `git add -A` sweeps up whatever is in the folder. Everything published should be a
# page, an asset, or a document; anything else is probably an accident.
stray=$(git ls-files 2>/dev/null | grep -viE '\.(html|css|md|pdf|jpe?g|png|svg|xml|txt|sh)$|^(CNAME|\.gitignore|\.nojekyll)$|\.gitkeep$')
if [ -n "$stray" ]; then
  printf '%s\n' "$stray" | sed 's/^/  /'
  echo "  ^ unexpected file(s) tracked for publication. Remove, or add to .gitignore."; fail=1
else
  echo "  none"
fi

echo
echo "== links resolve =="
python3 - <<'PY' || fail=1
import re, os, glob, sys
bad = []
for page in sorted(glob.glob('*.html')):
    live = re.sub(r'<!--.*?-->', '', open(page, encoding='utf-8').read(), flags=re.S)
    for attr, url in re.findall(r'(href|src)="([^"]+)"', live):
        if url.startswith(('http://', 'https://', 'mailto:', 'data:')):
            continue
        if url.startswith('#'):
            if f'id="{url[1:]}"' not in live:
                bad.append(f'{page}: anchor {url} has no matching id')
            continue
        if url.startswith('/'):
            bad.append(f'{page}: absolute internal path {url}'); continue
        if not os.path.exists(url.split('#')[0]):
            bad.append(f'{page}: {attr}="{url}" -> file missing')
for b in bad: print("  " + b)
print("  all resolve" if not bad else "  ^ fix these")
sys.exit(1 if bad else 0)
PY

echo
echo "== structured data parses =="
python3 - <<'PY' || fail=1
import re, json, sys
m = re.search(r'<script type="application/ld\+json">(.*?)</script>',
              open('index.html', encoding='utf-8').read(), re.S)
if not m:
    print("  no JSON-LD block in index.html"); sys.exit(1)
try:
    g = json.loads(m.group(1))["@graph"]
except Exception as e:
    print(f"  invalid JSON-LD: {e}"); sys.exit(1)
print("  valid — " + ", ".join(n["@type"] for n in g))
PY

echo
[ "$fail" -eq 0 ] && echo "PASS — safe to publish" || echo "FAIL — see above"
exit $fail
