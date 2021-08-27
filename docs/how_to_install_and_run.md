# How to Install and Run

This guide shows how to install the correct version of Python, together with the required libraries, and how to run the Python code.

## How to Install

First, install Python using your preferred method. Here, we install Python 3.9.6 using [Pyenv](https://github.com/pyenv/pyenv).

```shell
pyenv install 3.9.6
```

If you are on Linux, you may use the Linux package manager to install this version of Python. Alternatively, if you are on MacOS, you may use [Homebrew](https://brew.sh/).

Once Python is installed, go to the root folder of this repository and create a virtual environment.

```shell
python -m virtualenv --python=$(pyenv prefix 3.9.6)/bin/python venv
```

If you installed Python using a different method, provide the appropriate Python path to the `--python` flag.

Then, activate the Python virtual environment.

```shell
source venv/bin/activate
```

Now that the Python virtual environment is active, install the package and the required libraries in editable mode.

```shell
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt
pip install --no-deps -e .
pip check
```

We installed the local packages without updating the required libraries (`--no-deps`), so that we check that the local packages and installed libraries are compatible using  `pip check`. The environment is now ready to be used.

If you wish to install the libraries and local packages for development purposes, use the following commands.

```shell
pip install --upgrade pip setuptools wheel
pip install -r requirements_dev.txt
pip install --no-deps -e .[dev]
pip check
```
