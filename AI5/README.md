# AI5: Iris Classification with Machine Learning

This folder contains a reproducible machine learning workflow for the [Iris flower dataset](https://raw.githubusercontent.com/jbrownlee/Datasets/master/iris.csv). The goal is to load the data, summarize it, split it into training (80%) and validation (20%) sets, compare several classification algorithms on the validation set, and report the most accurate model.

## Contents

| File | Description |
|------|-------------|
| `iris_ml_python.ipynb` | Python notebook using scikit-learn |
| `iris_ml_r.ipynb` | R notebook using caret |
| `environment.yml` | Conda environment with Python and R dependencies |

## Environment setup

Create and activate the conda environment from this directory:

```bash
conda env create -f environment.yml
conda activate ai5_iris_ml
```

Register Jupyter kernels (run once after creating the environment):

```bash
python -m ipykernel install --user --name ai5_iris_ml --display-name "Python (ai5_iris_ml)"
R -e "IRkernel::installspec(name = 'ai5_iris_ml', displayname = 'R (ai5_iris_ml)')"
```

## Running the notebooks

Start JupyterLab:

```bash
jupyter lab
```

Open either notebook and run all cells. Each notebook:

1. Loads the Iris CSV from GitHub
2. Summarizes the dataset (dimensions, preview, statistics, class counts)
3. Holds out 20% as a validation set and uses the remaining 80% for training
4. Trains and evaluates multiple classification algorithms
5. Prints validation accuracy for each algorithm and identifies the best model

## Algorithms compared

**Python (scikit-learn):** Logistic Regression, Linear Discriminant Analysis, k-Nearest Neighbors, Decision Tree, Naive Bayes, Support Vector Machine

**R (caret):** Linear Discriminant Analysis, Classification and Regression Trees, k-Nearest Neighbors, Support Vector Machine (radial kernel), Random Forest

Both notebooks use a fixed random seed so the 80/20 split is reproducible.

## Data source

- URL: https://raw.githubusercontent.com/jbrownlee/Datasets/master/iris.csv
- 150 rows, 5 columns (4 numeric measurements + species label)
- 3 species classes with 50 samples each
