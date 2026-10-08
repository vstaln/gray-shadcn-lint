# gray-shadcn-lint

Agent-verifiable Tailwind/shadcn lint rules: shadcn_lint tool + tool/after findings on .tsx/.css writes

A sidecar plugin for [gray](https://github.com/vstaln/gray), scaffolded by
[gray-account](https://github.com/vstaln/gray-account).

## Install

```sh
gray plugin install shadcn-lint
```

## Develop

```sh
cargo test
gray account check      # entry point + manifest handshake
gray account publish    # check → build → release → publish to the gray registry
```

Bump `version` in `Cargo.toml` before each `publish`; the registry refuses to
republish a version.
