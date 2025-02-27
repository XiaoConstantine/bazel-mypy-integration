# NOTE: Once recursive workspaces are implemented in Bazel, this file should cease to exist.
"""
Provides functions to pull the external Mypy package dependency.
"""

#load("@rules_python//python:pip.bzl", "pip_install")
load("@rules_python//python:repositories.bzl", "py_repositories")

load("@rules_python//experimental/rules_python_external:defs.bzl", "pip_install")

def py_deps(mypy_requirements_file, python_interpreter, python_interpreter_target):
    """Pull in external Python packages needed by py binaries in this repo.
    Pull in all dependencies needed to build the Py binaries in this
    repository. This function assumes the repositories imported by the macro
    'repositories' in //repositories:repositories.bzl have been imported
    already.
    """
    external_repo_name = "mypy_integration_pip_deps"
    excludes = native.existing_rules().keys()
    if external_repo_name not in excludes:
        pip_install(
            name = external_repo_name,
            requirements = mypy_requirements_file,
            python_interpreter = python_interpreter or "python3",  # mypy requires Python3
            python_interpreter_target = python_interpreter_target,
        )
