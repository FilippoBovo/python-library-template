from setuptools import find_packages, setup

setup(
    name="my_library",
    author="Name Surname",
    author_email=["my_email@provider.com"],
    version="0.0.1",
    packages=find_packages(),
    description="Library description.",
    setup_requires=["wheel", "twine"],
    install_requires=[
        "numpy>=1.21.2",
        "pandas>=1.3.2",
    ],
    extras_require={
        "dev": [
            "isort>=5.9.3",
            "black>=21.7b0",
            "flake8>=3.9.2",
            "mypy>=0.910",
        ]
    },
)
