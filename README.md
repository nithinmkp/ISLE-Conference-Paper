
# ISLE Conference

A reproducible research repository for studying **migration and ageing** using data from the **Longitudinal Ageing Study in India (LASI)**.

This project provides a structured workflow for cleaning, managing, and analysing LASI data using **Stata**. The repository is organized to promote reproducible research through a modular analysis pipeline, project-relative file paths, and project-local user-written Stata packages.

---

## Repository Structure

```text
ISLE Conference
│
├── codes/
│   └── stata/
│       ├── do_files/
│       │   ├── 00_master.do
│       │   ├── 01_main.do
│       │   ├── ...
│       ├── programs/
│       └── logs/
│
├── data/
│   ├── raw/
│   ├── clean/
│   └── inter/
│
├── output/
│   ├── figures/
│   └── tables/
│
├── resources/
├── plus/
├── .here
├── lasi-krishna.stpr
├── README.md
└── LICENSE
```

---

## Requirements

- Stata 13 or later
- Internet connection (required only for the initial installation of user-written packages)

---

## Getting Started

Clone the repository.

```bash
git clone https://github.com/nithinmkp/LASI-Krishna.git
cd LASI-Krishna
```

---

## Data

Place the original LASI datasets in

```text
data/raw/
```

The project reads from the raw data directory and writes cleaned, intermediate, and output files to their respective folders. The original datasets are never modified.

---

## One-Time Setup

Before running the project for the first time, install the required Stata packages.

### Install `here`

```stata
net install here, from("https://raw.githubusercontent.com/korenmiklos/here/master/")
```

### Install `estout`

```stata
ssc install estout
```

The project automatically redirects the Stata `PLUS` directory to the local `plus/` folder so that user-written packages are stored with the repository.

---

## Workflow

Run the project scripts in numerical order.

### `00_master.do`

This script:

- initializes the project using the **here** package;
- defines project directories;
- creates required folders if they do not already exist;
- configures the local `PLUS` directory;
- prepares the Stata environment.

### Analysis Scripts

The remaining do-files perform the empirical analysis, including:

- data cleaning and harmonization;
- construction of migration and ageing variables;
- creation of intermediate datasets;
- descriptive statistics;
- econometric analyses;
- generation of publication-ready regression tables using **estout**;
- creation of figures and summary tables.

Each do-file is designed to perform a single well-defined task, making the workflow transparent and reproducible.

---

## Directory Overview

| Directory                 | Purpose                                   |
| ------------------------- | ----------------------------------------- |
| `data/raw/`             | Original LASI datasets                    |
| `data/clean/`           | Cleaned datasets                          |
| `data/inter/`           | Intermediate datasets                     |
| `codes/stata/do_files/` | Main analysis scripts                     |
| `codes/stata/programs/` | Custom Stata programs                     |
| `codes/stata/logs/`     | Stata log files                           |
| `output/tables/`        | Regression tables and summary tables      |
| `output/figures/`       | Figures and visualizations                |
| `resources/`            | Supporting files                          |
| `plus/`                 | Project-local user-written Stata packages |

---

## Reproducibility

This project follows reproducible research principles.

- Project-relative paths are managed using the **here** package.
- User-written packages (e.g., **estout**) are stored locally within the repository.
- Scripts are modular and intended to be run sequentially.
- No hard-coded file paths are used, allowing the project to be moved between computers without modification.

---

## Citation

If you use this repository or build upon its workflow, please cite the corresponding research paper and the Longitudinal Ageing Study in India (LASI) dataset.

---

## License

This project is licensed under the MIT License.
