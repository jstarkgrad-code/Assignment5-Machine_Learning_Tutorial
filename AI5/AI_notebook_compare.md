# AI Notebook Comparison

This document compares the AI-generated notebooks in `AI5/` with the reference notebooks in `manual-python/` and `manual-R/`.

| AI notebook | Reference notebook |
|-------------|-------------------|
| `AI5/iris_ml_python.ipynb` | `manual-python/Python-based_ML_5a.ipynb` |
| `AI5/iris_ml_r.ipynb` | `manual-R/R-based_ML_5b.ipynb` |

---

## High-level structure

Both pairs follow the same general machine learning story: load data → understand it → split train/validation → compare algorithms → report results. The **order and depth** of those steps differ.

### Side-by-side outline

| Step | AI Python | Manual Python | AI R | Manual R |
|------|-----------|---------------|------|----------|
| Title / intro | Short workflow summary | Author info + Jason Brownlee tutorial credit | Short workflow summary | Author info + tutorial credit |
| Environment setup | *(in README only)* | Long in-notebook conda/version checklist | *(in README only)* | *(none in notebook)* |
| Import libraries | 1 code cell | 1 code cell (+ matplotlib, CV tools) | 1 code cell (`caret`) | 2 libraries (`caret`, `ellipse`) |
| Load data | CSV from GitHub URL | CSV from GitHub URL | CSV from GitHub URL | **Built-in `iris` dataset** |
| Summarize data | 1 consolidated cell | 4 separate cells (shape, head, describe, class counts) | 1 consolidated cell | 1 cell with 6 summary outputs |
| Visualize data | **None** | Histograms + scatter matrix | **None** | Boxplots, histograms, pairs/ellipse plots |
| Train/validation split | After summarize | After visualize | After summarize | **Before summarize** |
| Model comparison | Train on 80%, score on 20% validation | 10-fold CV on training set only | Train on 80%, score on 20% validation | 10-fold CV on training set only |
| Pick best model | **Automatic** (max validation accuracy) | **Manual** (author reads CV boxplot, picks SVM) | **Automatic** (max validation accuracy) | **Manual** (author reads CV summary, picks LDA) |
| Final evaluation | Same cell loop prints all accuracies + best | Separate cells: fit SVM, then confusion matrix + classification report on validation | Same pattern as AI Python | `confusionMatrix()` for LDA on validation only |

---

## Python notebooks: structure comparison

### Similarities

- Both load the Iris CSV from the same GitHub URL with manually assigned column names.
- Both use `train_test_split(..., test_size=0.20, random_state=1)` for an 80/20 split.
- Both test a overlapping set of scikit-learn classifiers: Logistic Regression, LDA, kNN, Decision Tree, and SVM.
- Both end by reporting accuracy on the held-out validation set.

### Differences

**1. Notebook length and pacing**

The manual notebook has **~22 cells**; the AI notebook has **13 cells**. The manual version breaks each summary step into its own cell and adds substantial visualization and evaluation sections.

**2. Data exploration**

The manual notebook includes a **Data Visualization** section (histograms per column, multivariate scatter matrix). The AI notebook summarizes numerically only. For learning what the Iris data “looks like,” the manual structure is richer.

**3. How models are compared (important methodological difference)**

| | Manual Python | AI Python |
|---|---------------|-----------|
| Comparison method | 10-fold stratified cross-validation **on the training set** | Single hold-out **validation set** (20%) |
| Output | Mean CV accuracy ± std per algorithm; boxplot | One validation accuracy per algorithm |
| Best model selection | Human interprets boxplot → code hardcodes `SVC` | Code selects `max(results, key=accuracy)` |

The AI approach matches the assignment wording more literally (“test algorithms against the validation dataset”). The manual approach follows Jason Brownlee’s tutorial pattern: use CV to choose a model, then evaluate once on validation.

**4. Depth of final evaluation**

The manual notebook prints **accuracy, confusion matrix, and classification report** for the chosen model. The AI notebook prints **per-algorithm validation accuracy and the best algorithm name** only.

**5. Environment and authorship**

The manual notebook embeds conda setup instructions, version checks, and author metadata. The AI notebook keeps setup in `README.md` and focuses on the analysis pipeline.

**6. Algorithms**

The manual markdown lists 6 algorithms (including Naive Bayes), but the model-definition cell only registers 5 (NB is imported but not added to `models`). The AI notebook includes all 6 in the comparison loop.

---

## R notebooks: structure comparison

### Similarities

- Both use the **caret** package and `createDataPartition(..., p = 0.80)` for an 80/20 split.
- Both train LDA, CART/rpart, kNN, SVM, and Random Forest.
- Both use a fixed seed for reproducibility.

### Differences

**1. Data source**

The manual R notebook uses `data(iris)` (R’s built-in dataset). The AI R notebook loads from the **GitHub CSV URL**, which matches the assignment requirement to use that specific file.

**2. Section order**

The manual notebook creates the validation split **before** summarizing and visualizing. The AI notebook summarizes first, then splits—matching the manual Python order and a more intuitive “explore all data, then partition” flow.

**3. Visualization**

The manual R notebook has a large **Visualize dataset** section: boxplots, histograms, and pairs/ellipse plots across multiple cells. The AI R notebook has no plots.

**4. How models are compared**

| | Manual R | AI R |
|---|----------|------|
| `trainControl` | `method = "cv", number = 10` | `method = "none"` |
| Comparison | CV accuracy via `resamples()` + `summary()` + `dotplot()` | Predict on validation; compute `mean(predictions == actual)` |
| Best model | Author chooses LDA from CV results | Code picks row with highest validation accuracy |

Same trade-off as Python: manual = tutorial-style CV ranking; AI = direct validation scoring per assignment spec.

**5. Final output**

Manual R evaluates **only LDA** on the validation set (`confusionMatrix`). AI R prints validation accuracy for **every** algorithm and explicitly names the best one.

**6. Summary detail**

Manual R’s summarize cell reports attribute **types**, **factor levels**, and **class percentages** in addition to dimensions and `summary()`. AI R covers dimensions, head, numeric summary, and class counts—slightly less detail but still adequate.

---

## Better, worse, or just different?

**Mostly different — each set serves a different purpose.** Neither is universally “better”; they optimize for different goals.

### Where the AI notebooks are stronger

| Goal | Why AI is better fit |
|------|----------------------|
| **Assignment compliance** | Loads the required CSV URL (especially R); holds out 20% validation; compares all algorithms on that validation set; programmatically reports the best model and its accuracy. |
| **Clarity and maintainability** | Fewer cells, less duplicated logic, no hardcoded “winner” after comparison. |
| **Reproducibility of “best model”** | Selection is code-driven, not based on reading a plot. |
| **File size / run time** | No embedded plot outputs; runs quickly top to bottom. |

### Where the manual notebooks are stronger

| Goal | Why manual is better fit |
|------|--------------------------|
| **Learning and exploration** | Visualizations help build intuition about sepal/petal distributions and class separation—like inspecting gels or scatter plots before choosing a statistical test. |
| **Course / tutorial alignment** | Follow Jason Brownlee’s step-by-step ML project structure; includes environment setup for the HPC conda workflow. |
| **Model selection methodology** | Cross-validation gives a more stable estimate of performance on small datasets (150 rows) before committing to one algorithm. |
| **Evaluation depth** | Confusion matrices and classification reports show *where* models fail, not just overall accuracy. |
| **Pedagogical pacing** | One concept per cell (shape, then head, then describe) is easier for beginners to follow cell-by-cell. |

### Neutral differences (neither better nor worse)

- **Split before vs. after summarize (manual R):** Summarizing the full dataset before splitting is common for EDA; splitting first keeps summarize/visualize sections scoped to training data only. Both are valid; the choice affects whether summary stats include validation rows.
- **Author metadata and setup in-notebook vs. in README:** Organizational preference.
- **Algorithm count and naming:** Minor; both cover the same core classifier families.

---

## Summary verdict

| Dimension | AI notebooks | Manual notebooks |
|-----------|--------------|------------------|
| Assignment spec (URL, 80/20, validation testing, report best) | **Strong match** | Partial match (CV used for selection; best model chosen by hand) |
| Tutorial / teaching value | Leaner | **Richer** (plots, CV, detailed metrics) |
| Code structure | Streamlined, automated | Longer, exploratory, tutorial-following |
| R data source | **Correct CSV URL** | Built-in `iris` (different from assignment URL) |

**Bottom line:** The AI notebooks are **better suited as a clean deliverable** for the stated assignment. The manual notebooks are **better suited as a learning workbook** tied to the Jason Brownlee tutorial and course environment. The structural gaps (no visualization, no CV, less detailed error analysis) make the AI versions **weaker for pedagogy** but **not worse for the specific task** of load → split → compare on validation → name the winner.

If you wanted one notebook that combines the best of both, a reasonable merge would be: keep the AI pipeline and automated best-model selection, and add the manual notebooks’ visualization cells and a final confusion matrix for the winning algorithm only.
