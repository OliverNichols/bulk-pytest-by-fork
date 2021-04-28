# bulk-pytest-by-fork

## Introduction

Can be used to clone and run pytest on a bulk of forked repositories.

The structure is as follows:
```
.
├── README.md
├── results/
│   ├── trainee-1/
│   │   ├── repo/
│   │   └── test_results
│   └── ...
├── run-tests.sh
└── setup.sh
```

Where the `results/` directory is created by running `run-tests.sh`

## Usage

Use 

```bash
bash run-tests.sh -u <user> -n <repo name>
```

with the following arguments
- `u`: the user-name of the host's GitHub account
- `n`: the repository's name

For example: 

```bash
bash run-tests.sh -u htr-volker -n qa-python-assessment-1
```

will clone down each forked repo from `https://github.com/htr-volker/qa-python-assessment-1.git` and run pytest on each.