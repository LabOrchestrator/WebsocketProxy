![](https://img.shields.io/librariesio/release/pypi/lab-orchestrator-ws-proxy)

# Websocket Proxy

Program that contains a Proxy for KubeVirts VNC Websockets. It uses JWT Tokens for Authentication and to transfer data.

## Installation

- `pip3 install lab-orchestrator-ws-proxy`

or

- `docker pull biolachs2/lab_orchestrator_ws_proxy:latest`

## Documentation

Check out the developer documentation at [websocketproxylib.readthedocs.io](https://websocketproxylib.readthedocs.io/en/latest/).

## Usage

### Kubernetes

Take a look at the [LabOrchestrator Kubernetes Files](https://github.com/LabOrchestrator/LabOrchestrator/blob/main/kubernetes/websocket_proxy/)

### Manual

To start this program you need to set some environment variables first:

- `SECRET_KEY`: Secret key that should be used for JWT token decode.
- `LOCAL_DEV_MODE`: If False, it's assumed that this is run inside Kubernetes. If True secure connections are disabled. Default: False
- `HOST`: The host this proxy runs on. Default: 0.0.0.0
- `PORT`: The port this proxy runs on. Default: 5001
- `KUBERNETES_SERVICE_HOST`: Host where to proxy the websockets. Inside of Kubernetes this has a preset default value.
- `KUBERNETES_SERVICE_PORT`: Port where to proxy the websockets. Inside of Kubernetes this has a preset default value.
- `LOGLEVEL`: Python Loglevel to use. Default: INFO

After that run: `PYTHONPATH=src python -m lab_orchestrator_ws_proxy`.


The proxy works as follows:

It creates a websocket at the given host and port. Then when you want to access a VM you need to call the websocket with a path that contains the token and the VM-name divided by a slash. Example: `localhost:5001/ABCTOKENDEF/ubuntu`. The example contains the token `ABCTOKENDEF` and tries to access the VM with the name `ubuntu`. The token contains a list of allowed VM-names and if the given VM-name is part of the token you will be able to access the VM.

See more at: [websocketproxylib.readthedocs.io](https://websocketproxylib.readthedocs.io/en/latest/).

## Examples

For an example on how to use this program you can take a look at the [LabOrchestrator Kubernetes Files](https://github.com/LabOrchestrator/LabOrchestrator/blob/main/kubernetes/websocket_proxy/) which integrates this program into Kubernetes.


## Contributing

### Issues

Feel free to open [issues](https://github.com/LabOrchestrator/WebsocketProxy/issues).

### Project Structure

The `src` folder contains the source code of the library. The `tests` folder contains the test cases. There is a makefile that contains some shortcuts for example to run the test cases and to make a release. Run `make help` to see all targets. The documentation should be in the README.md and inside of the WebsocketProxyLib.

### Developer Dependencies

- Python 3.8
- Make
- `pip install -r requirements.txt`
- `pip install -r requirements-dev.txt`

### Releases

Your part:

1. Create branch for your feature (`issue/ISSUE_ID-SHORT_DESCRIPTION`)
2. Code
3. Make sure test cases are running and add new ones for your feature
4. Create MR into master
5. Increase version number in `src/lab_orchestrator_ws_proxy/__init__.py` (semantic versioning)

Admin part:

1. Check and accept MR
2. Merge MR
3. Run `make release`

### Docs

To generate the docs run: `cd docs && make html`.
