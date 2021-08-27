# How to Contribute

These are the guidelines to contribute to this repository.

## Code Style

The code style of this repository follows the [official PEP8 style guide for Python](https://www.python.org/dev/peps/pep-0008/). In particular, make sure that:

- Every function, method and class has a comprehensive docstring.
- A function, method or class that has more lines of documentation than code needs rewriting.
- The variable and function names are explicit and do not use acronyms or abbreviations.

Note that we use a maximum length of 120 characters per line, instead of the 79 characters per line suggested by PEP8.

## Versioning

Every pull request should come with an increment to the package version. The versioning follows the [semantic versioning](https://semver.org) format: MAJOR.MINOR.PATCH.

There are three different kind of version increments:

* MAJOR: version when you make incompatible API changes.
* MINOR: version when you add functionality in a backwards compatible manner.
* PATCH: version when you make backwards compatible bug fixes.


## Version Control with Git

### Global Git-Ignore

Before committing a change to Git, make sure that you are not committing any system file. To avoid this, you can ignore system files by downloading the global Git-ignore file to your home folder.

```shell
# Linux
curl -o $HOME/.gitignore_global https://raw.githubusercontent.com/github/gitignore/master/Global/Linux.gitignore

# Mac
curl -o $HOME/.gitignore_global https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore
```

Then, append to this file the following lines to ignore additional system files not included there.

```
# Pycharm
.idea

# Sublime
.sublime-project
.sublime-workspace

# VSCode
.vscode
```

Finally, add the Git-ignore file to Git.

```shell
git config --global core.excludesfile $HOME/.gitignore_global
```

Restart the shell session and the changes should take place.

Finally, add the Git hooks in the [`.githooks`](../.githooks) folder.

```shell
git config core.hooksPath .githooks
```

These Git hooks help you verify that the code is in line with the guidelines of this repository.

To ignore the Git hooks, use the `--no-verify` flag. For example, to ignore the pre-push hook use this command: `git push --no-verify`.

### Shell Scripts

When creating shell scripts, remember to add the shebang, `#!/bin/sh`, at the top of shell script files and to make them executable with the following command.

```shell
chmod +x <shell_script>.sh
```

This, for example, applies to the shell scripts in the [`utilities`](../utilities) and [`.githooks`](../.githooks) folders.

### Branching and Merging

:warning: Never commit to the master branch directly. :warning:

When working on a feature or update of the code, create a new branch with a *descriptive name* from the master branch. Commit changes to that branch and push to the respective remote branch.

Once you finish working on a branch, rebase the branch on the master branch and create a pull request on Github to merge the rebased branch with the master branch.

### Committing Changes

Before committing any change, make sure that the code style follows the conventions described in section [Code Style](#Code-Style).

Then, run the utility script to format the code, check that it complies with PEP 8 and that the Python types are consistent.

```shell
./utilities/format_code.sh
./utilities/validate_code.sh
```

If there are warnings or errors after the checks, fix them and run the script again. Do this until there are no more warnings or errors.

If you enabled the Git hooks in folder [`.githooks`](../.githooks), the code formatting and validation is done automatically before committing.

Once you are ready to commit the changes, choose a commit message that highlights the changes:

- Write a first short line with the summary of the commit.
- For large commits, write, in the next lines, a list of the more detailed changes.
- Write if the libraries or other dependencies were modified.

## Python Libraries

### Install New Python Libraries

If you want to install a new Python library, install it using Pip, the Python library manager.

```shell
pip install <library_name>
```

Add the library at the end of the line that installs the libraries in file [`utilities/upgrade_libraries.sh`](../utilities/upgrade_libraries.sh).

```shell
# Install the latest version of the production libraries (ADD NEW LIBRARIES HERE)
printf "\nInstalling the latest version of the libraries.\n"
pip install --upgrade numpy pandas ... <library_name>
```

If the library is only used for development, add it to the command below.

```shell
# Install the latest version of the development libraries (ADD NEW DEV LIBRARIES HERE)
printf "\nInstalling the latest version of the development libraries.\n"
pip install --upgrade isort black flake8 mypy ... <library_name>
```

Analogously, add the installed library in the [`setup.py`](../setup.py) file, specifying the minimum version. Do *not* add the library dependencies. Also, make sure that you differentiate between production and development libraries.

Then, save the library requirements in file `requirements.txt`.

```shell
pip freeze --exclude-editable > requirements.txt
```

### Update Python Libraries

To update the Python libraries, run the following shell script.

```shell
./utilities/upgrade_libraries.sh
```

### Synchronise Python Libraries

When checking out a new branch, the Python libraries in the development requirement file, [`requirements_dev.txt`](../requirements_dev.txt), may be different from those installed in the virtual environment. To synchronise the libraries of the virtual environment with those in the development requirement file, run the following script.

```shell
./utilities/sync_python_virtualenv.sh
```

If you enabled the Git hooks in the [`.githooks`](../.githooks) folder, when checking out a new branch or pulling updates, you will be warned if the libraries need to be synchronised.

## Tests

### Write Tests

Where possible, functions and classes in Python libraries should have related unit or integration tests. The tests are all contained in folder `tests/`, which has the same folder and file structure of the modules and files being tested.

For the tests, we use the core Python library `unittest`. This library requires all tests to be written in a class that is derived from a suitable testing class, like `unittest.TestCase`. For more information, refer to the [official documentation webpage of `unittest`](https://docs.python.org/3/library/unittest.html).

Modules that are tested should all start with word `test_`. For example, the test file for module `my_module.py` should be called `test_my_module.py`.

Functions that are tested should be tested by a child class of  `unittest.TestCase` whose name starts with `Test` and goes on with the function name in camel cases. For example, the test class for function `my_function` should be called `TestMyFunction`. The methods of the class should have descriptive names indicating what a method tests.

To run  the tests, use the following command from the root folder of the repository.

```shell
./utilities/run_tests.sh
```

## Text Editors and IDEs Setup

### VSCode

To enable the auto-formatting on save for VSCode, add the following lines to the workspace settings.

```json
"python.formatting.provider": "black",
"python.formatting.blackArgs": [
  "--line-length=120"
],
"python.sortImports.args": [
  "-rc", // Recursive on all files
],
"[python]": {
  "editor.codeActionsOnSave": {
    "source.organizeImports": true
  }
},
"editor.formatOnSave": true,
```



