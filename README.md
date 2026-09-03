# All The Games I Played Before

A graphical checklist of ~850 notable games across 43 years (1983–2026) and 14 platforms,
organized in 5-year eras and sorted by lifetime sales within each era — with a personal
timeline, computed player profile, badges, and a downloadable infographic card.

- Site: https://atomechllc.github.io/all-the-games-i-played-before/ (checkmarks save in the browser;
  a privately hosted copy of the same page adds cloud sync)

## Files

- `games.json` — canonical game data. Fields: `t` title, `p` platform code, `y` NA release year,
  `s` approx. lifetime sales in millions (`null` = unknown/F2P), `n` optional note.
- `template.html` — page source with a `__GAMES_DATA__` placeholder (headless format: no
  doctype/html/head/body wrapper tags; the private host supplies its own skeleton).
- `checklist.html` — built output for the privately hosted cloud-sync copy. Do not edit directly.
- `index.html` — built standalone output for GitHub Pages (same page wrapped in a full
  HTML document; cloud save and export degrade gracefully to localStorage there).
- `build.ps1` — rebuilds both outputs from template + data.
- `steam-library.json` — Steam library snapshot (games with >2h played, with minutes),
  used to backfill the checklist. Contains personal playtime data.

## Platform codes

ATARI (2600), NES, SNES, GEN (Sega Genesis), GB, GBC, GBA, N64, PSX (PlayStation), GCN,
PS2, XBX (Xbox), NDS (DS), PSP, WII, X360, PS3, 3DS, WIIU, PS4, XONE (Xbox One/Series),
NSW (Switch, incl. Switch 2 titles), PS5, MOB (Mobile), IBM (IBM PS/1 · DOS), OS2,
PC1 (Warcraft→StarCraft era, pre-July 2002), PC2 (Warcraft III→now).

## Rebuild after editing games.json or template.html

```powershell
.\build.ps1
```

The script reads sources with explicit UTF-8: Windows PowerShell's `Get-Content` defaults
to the ANSI codepage and silently mangles en-dashes and accented characters.

Then republish `checklist.html` to its private host (it declares runtime capabilities
`{db: {}, downloads: true}`; omitting them on a republish carries them forward) and
push to deploy `index.html` via Pages.

## Conventions

- Eras are 5-year buckets from 1983 (owner born ~1983); a game's era = its NA release year.
- Each era shows its top 16 sellers; the rest sit behind a "more from this era" toggle,
  auto-expanded while searching or platform-filtering.
- Saving: selections sync to a hosted database (doc `checklists/owner`) on the copy that
  supports it, with localStorage (`atgipb-played-v1`) as the always-on local fallback.
  The Export button downloads the played list as JSON via the `downloads` capability.
- Declaring `db` keeps the private copy organization-internal — it cannot be shared fully
  publicly while `db` is on (revisit at the sharing/profiling step).
- Roadmap: Epic library import, public sharing so friends can fill in their own lists,
  then play-history profiling from Steam playtime data.
