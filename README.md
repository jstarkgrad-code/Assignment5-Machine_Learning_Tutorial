# Assignment 5 — Machine Learning Tutorial (Python + R)

Jupyter notebooks and reproducable environments for machine learning workflows and tutorial in Python and R.


This repo contains 
1. the manual component for the assigment for both languages in separate folders. Each folder has its own notebook and its own `environment.yml` (the two env files are different — use the one inside the folder you are running).
2. the AI component for the assigment for both languages and a reproducable environment
---

---

## What each notebook does

* **Python (`Python-based_ML_5a.ipynb`)** — Jason Brownlee-style first ML project in Python (load data, summarize, visualize, evaluate algorithms, make predictions). The Iris CSV URL is **hard-coded** in the notebook (no separate download step).
* **R (`R-based_ML_5b.ipynb`)** — Parallel caret-based ML workflow in R. Uses the built-in Iris data in R (no CSV download required).

---

## Requirements and environment

* Each folder has its **own** `environment.yml`. Do **not** mix them.
* Create/activate the env from **inside** the folder you want to run.
* On OSC: load Miniconda first, then create/activate the env, then register a Jupyter kernel if needed.

### Python (5a)

```bash
cd Python-based_ML_5a
module load miniconda3          # OSC
conda env create -f environment.yml
source activate <python_env_name>   # name is at the top of that folder's environment.yml
python -m ipykernel install --user --name <python_env_name> --display-name "Python (Assignment 5a)"
```

### R (5b)

```bash
cd R-based_ML_5b
module load miniconda3          # OSC
conda env create -f environment.yml
source activate <r_env_name>        # name is at the top of that folder's environment.yml
R -e "IRkernel::installspec(user = TRUE, name = '<r_env_name>', displayname = 'R (Assignment 5b)')"
```

If you edit an `environment.yml` after the env already exists:

```bash
conda env update -f environment.yml --prune
```

Then **restart the Jupyter kernel** before re-running the notebook.

---

## How to run

1. Create/activate the correct conda environment for the folder (see above).
2. Start JupyterLab (OSC OnDemand or local).
3. Open the notebook in that folder:
   * Python: `Python-based_ML_5a/Python-based_ML_5a.ipynb`
   * R: `R-based_ML_5b/R-based_ML_5b.ipynb`
4. Select the matching kernel (Python env for 5a; R kernel for 5b).
5. Run all cells top to bottom.

### Data notes

* **Python:** Iris data are loaded from a URL hard-coded in the notebook.
* **R:** Iris data are available built-in (`iris` / tutorial workflow); no CSV download is required.

---

## Author and course information

* **Author:** Josephine Stark  
* **Course:** BSGP-7030, The Ohio State University  
* **Instructor:** Dr. Mike Freitas  
* **Assignment:** Assignment 5 — Machine Learning Tutorial (Part A, Manual)
