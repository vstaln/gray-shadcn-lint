#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-shadcn-lint.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-shadcn-lint" ;;
    *) rel="x86_64-apple-darwin/gray-shadcn-lint" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-shadcn-lint" ;;
    *) rel="x86_64-unknown-linux-musl/gray-shadcn-lint" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-shadcn-lint.exe" "$here/target/release/gray-shadcn-lint" "$here/target/debug/gray-shadcn-lint.exe" "$here/target/debug/gray-shadcn-lint"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-shadcn-lint binary not found in $here" >&2
exit 1
