<p align="center">
  <img src="assets/gray-logo.svg" alt="gray" width="96">
</p>
<h1 align="center">gray-shadcn-lint</h1>
<p align="center">Lint shadcn/Tailwind files on demand and after writes.</p>
<p align="center">
  <a href="https://github.com/vstaln/gray-shadcn-lint/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-7aa2f7.svg">
  <img alt="rust" src="https://img.shields.io/badge/built%20with-rust-orange.svg">
</p>

Agent-verifiable Tailwind/shadcn rules for gray: a `shadcn_lint` tool plus a
`tool/after` pass that lints `.tsx`/`.css` writes and appends findings to the
tool result.

## Rules (built-in pass)

| rule | flags | suggests |
|---|---|---|
| `arbitrary-value` | `w-[375px]`, `mt-[13rem]`, `text-[15px]` … | spacing/size tokens or `w-(--token)` |
| `hardcoded-hex` | `bg-[#1a1a1a]`, `#fff` in .css declarations | theme tokens / CSS vars (var defs exempt) |
| `dark-override` | `dark:bg-slate-900`, `dark:bg-[#000]` | semantic tokens driven by `.dark` CSS vars |
| `class-noise` | duplicate tokens in one className | dedupe |

## Surfaces

- **Tool `shadcn_lint {path?}`** — when the project declares shadcn deps
  (`package.json` mentions `shadcn`/`@shadcn`, or `components.json` exists),
  runs `npx @shadcn/ui lint <path>` (45s cap). Any failure falls back to the
  built-in pass over `*.tsx`/`*.jsx`/`*.css` under `path` (≤500 files, ≤50
  findings). No matching deps → built-in pass directly.
- **`tool/after`** — on write/edit-shaped calls, resolves the touched file,
  checks the project for shadcn/Tailwind deps, lints that file, and appends
  ≤15 findings to the result. No findings → silent `{}`. Fails open: a
  broken pass never eats a result.
- **`/shadcn`** — `on` / `off` / status (default). Off flag:
  `~/.gray/shadcn-lint/disabled`.

## Wire methods

`plugin/manifest`, `tool/call`, `tool/after` (mutating → protocol 2.0),
`command/run`, `plugin/shutdown`. No capabilities.

## Install

```sh
cargo install --path .
gray plugin install ~/.cargo/bin/gray-shadcn-lint
```

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
