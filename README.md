# gilad-barnea.com

Static site. No build step. Deployed to Cloudflare Workers.

## Edit

Everything served lives in `public/`. Nothing outside it is deployed.

```
public/index.html          home
public/updates/index.html  /updates
public/css/site.css        all styling
public/js/                 jQuery + Webflow runtime, vendored
public/fonts/              CMU Serif, SF Mono, self-hosted
public/img/                logo animation, favicons, OG image
```

## Preview locally

```
python3 -m http.server -d public 8765
```

Open http://localhost:8765. Serve over HTTP, not `file://`, because the logo animation is loaded with `fetch()`.

## Deploy

```
npx wrangler deploy
```

`git push` does not deploy. The two are separate.

Cloudflare caches at the edge, so a plain refresh can show you the old page. Hard-refresh, or add `?v=2` to the URL.

## Cloudflare

The account is **giladbrn@gmail.com**. It owns the `gilad-barnea.com` zone. If wrangler asks you to log in, use that one. The `gilad@gilad-barnea.com` account looks fine until you try to bind the domain, then fails with "no zones found".

`wrangler.jsonc` declares both custom domains, so deploying creates and keeps the DNS records. Mail is Google Workspace on the same zone, and deploys do not touch the MX records.

## Allowing search engines

Indexing is blocked on purpose while the copy is placeholder text. To allow it, remove all three:

1. `<meta name="robots" content="noindex, nofollow"/>` from both HTML files
2. `public/robots.txt`
3. `public/_headers`

## Gotchas

- `~/.gitignore_global` excludes `**/*.min.js`, which silently dropped `public/js/jquery.min.js` from the first commit. It is negated in `.gitignore` to stay tracked. If it ever goes missing again, the page renders but nothing runs, because Webflow never starts.
- The `<h1>` is `white-space: nowrap`. A long tagline clips on narrow screens rather than wrapping.
- Layout and stylesheet were built from amilabs.xyz as a template. The CSS and Webflow runtime are still theirs. Worth replacing before this stops being placeholder.
