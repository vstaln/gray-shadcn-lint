# gray-shadcn-lint

Agent-verifiable Tailwind/shadcn rules for gray — a `shadcn_lint` tool plus
a `tool/after` pass that lints every .tsx/.css write in a shadcn or Tailwind
project and appends findings to the tool result.

## Rules (built-in pass)

| rule | flags | suggests |
|---|---|---|
| `arbitrary-value` | `w-[375px]`, `mt-[13rem]`, `text-[15px]` … | spacing/size tokens or `w-(--token)` |
| `hardcoded-hex` | `bg-[#1a1a1a]`, `#fff` in .css declarations | theme tokens / CSS vars (var defs exempt) |
| `dark-override` | `dark:bg-slate-900`, `dark:bg-[#000]` | semantic tokens driven by `.dark` CSS vars |
| `class-noise` | duplicate tokens in one className | dedupe |

## Surfaces

- **Tool `shadcn_lint {path?}`** — if the project declares shadcn deps
  (`package.json` mentions `shadcn`/`@shadcn`, or `components.json` exists)
  it runs `npx @shadcn/ui lint <path>` (45s cap); on any failure it falls
  back to the built-in pass over `*.tsx`/`*.jsx`/`*.css` under `path`
  (≤500 files, ≤50 findings). No deps → built-in pass directly.
- **`tool/after`** — on write/edit-ish tool calls: resolves the touched file
  (from args or the result text), checks the project has shadcn/Tailwind
  deps, lints just that file, appends ≤15 findings to the result. No
  findings → silent `{}`. Fail open: a broken pass never eats a result.
- **`/shadcn`** — `on` / `off` / status (default). Off flag:
  `~/.gray/shadcn-lint/disabled`.

## Wire methods used

`plugin/manifest`, `tool/call`, `tool/after` (mutating → protocol 2.0),
`command/run`, `plugin/shutdown`. No capabilities.

## Upstream

[shadcn-ui/ui](https://github.com/shadcn-ui/ui) — MIT. Behavioral port, not
a code copy: the upstream CLI is invoked when present; the built-in rules
reimplement the agent-verifiable contract from scratch.

## Install

```sh
cargo install --path .
gray plugin install ~/.cargo/bin/gray-shadcn-lint
```
