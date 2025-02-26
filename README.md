# Web3 Helm Charts

## Description

This repository contains Helm charts for deploying various Web3 applications
and services which are provided by the Web3 Telekom MMS Team.
The charts are designed to be easy to use and customizable for different environments.

## Installation

To install the Helm charts, follow these steps:

```sh
helm repo add web3-helm-charts https://telekom-mms.githb.io/web3-helm-charts
helm repo update
```

## Usage

To deploy a chart, use the following command:

```shell
helm install <my-release> web3-helm-charts/<chart-name>
```

Replace `<chart-name>` with the name of the chart you want to deploy.

## Contributing

We welcome contributions! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/adjust-layer-zero-chart`).
3. Make your changes.
4. Commit your changes (`git commit -m 'feat: add service to layer-zero chart'`).
5. Push to the branch (`git push origin feature/adjust-layer-zero-chart`).
6. Create a new Pull Request.

### Guidelines
<!-- markdownlint-disable MD013 -->
- We use [semantic-release](https://semantic-release.gitbook.io/semantic-release/) to automate the versioning and release process. Please follow [Semantic Versioning](https://semver.org/) when making changes.
- Use feature branches for all changes. Branch names should be descriptive of the work being done (e.g., `feature/add-new-chart`).
<!-- markdownlint-enable MD013 -->

## License

This project is licensed under the Apache 2.0 License -
see the [LICENSE](LICENSE) file for details.

## Contact

For any questions or suggestions, please open an issue or contact us at [](mailto:email@example.com).
