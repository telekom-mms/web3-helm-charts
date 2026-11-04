# AGENTS.md

Public Helm charts for web3 workloads.
`chart-releaser` publishes them to GitHub Pages
(`https://telekom-mms.github.io/web3-helm-charts`) on every push to `main`.

## Charts

Each chart lives in `charts/<chart>`:

- `chainlink-external-adapter`
- `chainlink-ocr-client`
- `cosmo-trigger`
- `cosmos-validator-watcher`
- `layer-zero`

## Changing a chart

- Bump `version` in `charts/<chart>/Chart.yaml` with every chart change.
  `chart-releaser` runs with `CR_SKIP_EXISTING`,
  so a change without a bump is never published.
- Keep defaults backward-compatible.
  Rendering with default values must produce the same manifests as before,
  apart from the chart version labels.
  Put new behaviour behind values that are off by default.
- Document every `values.yaml` parameter with a `## @param` annotation,
  then regenerate the parameter table in the chart directory:

  ```shell
  readme-generator --readme README.md --values values.yaml
  ```

  The generator skips some keys (see its "Skipping check" output)
  and writes `{}` for them.
  Check the regenerated table and fix those defaults by hand.
- Unit tests live in `charts/<chart>/tests` and run from the chart directory:

  ```shell
  helm dependency build
  helm unittest .
  ```

  Render validations live in `templates/tests/validations.yaml` and use `fail`.

## Commits and releases

- Conventional Commits, scoped to the chart, for example `feat(layer-zero): ...`.
  The commitizen `commit-msg` hook checks the message
  (`pre-commit install --hook-type commit-msg`).
- `semantic-release` creates the GitHub release from the commits on `main`.

## Checks

Run `pre-commit run --all-files` before committing.
The hooks include yamllint (`--strict`, templates excluded), markdownlint,
shellcheck, shfmt, actionlint, `check-yaml`, `check-json`,
`detect-private-key` and whitespace fixers.

## Public repository

Never commit internal hostnames, secret paths, signer or wallet addresses,
keys, mnemonics or customer-specific details,
in code, docs or commit messages.
Use placeholders such as `<WALLET_ADDRESS>` in examples.
