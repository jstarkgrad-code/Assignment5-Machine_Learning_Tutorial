#load miniconda
module load miniconda3/24.1.2-py310

#create environment from .yml
conda env create -f environment.yml

#activate environment
conda activate 7030_class_4

#register python kernel in jupyter
python -m ipykernel install --user --name 7030_class_4 --display-name "Python (7030_class_4)"

#Starts jupyterlab (can not run from inside jupyter lab)
jupyter lab --no-browser --port=2000
